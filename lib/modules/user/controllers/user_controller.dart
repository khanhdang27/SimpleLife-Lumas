import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:lumas/controllers/controller.dart';
import 'package:lumas/general/general.dart';
import 'package:lumas/main.dart';

class UserController extends Controller with StateMixin<Client> {
  UserRepository userRepository = UserRepository();
  AppointmentController appointmentController = Get.find<AppointmentController>();
  static SettingController settingController = Get.find<SettingController>();
  RxBool isLoading = false.obs;
  dynamic user = <User>[].obs;
  dynamic serviceInProgress = [].obs;
  dynamic courseInProgress = [].obs;
  dynamic codeProduct = "".obs;
  final error = "".obs;

  @override
  void onInit() async{
    if(user.isEmpty && Get.currentRoute == AppRoute.USER_HOME){
      getDataProfile();
      await AndroidAlarmManager.initialize();
      await AndroidAlarmManager.periodic(Duration(minutes: 1), 1, getNotificationUser);
    }
  }

  static void getNotificationUser() async {
    Map result;
    NotificationRepository notificationRepository = NotificationRepository();
    result = await notificationRepository.notiNext(type: 'user');
    if (result['status'] == 200) {
      Notify notiNext = result['data'];
      pushNotification(title: notiNext.title ?? '', body: notiNext.time ?? '');
    } else {
      print(result['error']);
    }
  }

  static Future<void> pushNotification({required String title, required String body}) async {
    const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      'id',
      'name',
      'description',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
      icon: 'noti',
      subText: 'Simple Life',
      largeIcon: DrawableResourceAndroidBitmap('ic_launcher'),
    );
    const NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
        0, title, body, notificationDetails,payload: "Redirect to notifications tab");
  }

  /// niron_staff@gmail.com
  /// 123456
  login({String? email, String? password}) async {
    showLoading();
    final response = await userRepository.login(email: email, password: password);
    hideLoading();

    if (response != null) {
      if (response['status'] == 200) {
        User userModel = response['user'];
        Storage.setToken(response['token']);
        Storage.setId(userModel.id ?? 0);
        Storage.setRole(0);
        getDataProfile();
        await AndroidAlarmManager.initialize();
        await AndroidAlarmManager.periodic(Duration(minutes: 1), 1, getNotificationUser);
        Get.offAllNamed(AppRoute.USER_HOME);
      } else {
        error('userLoginFaildMessage'.tr);
      }
    }
  }

  getDataProfile() async {
    showLoading();
    final response = await userRepository.profile();
    hideLoading();

    if (response != null) {
      if (response['status'] == 200) {
        User userModel = response['user'];
        user = userModel;
        appointmentController.getList();
      }

      if (response['status'] == 401) {
        Storage.removeToken();
        Get.offAllNamed(AppRoute.CLIENT_HOME);
      }
    }
  }

  getProfile(){
   return Get.toNamed(AppRoute.USER_PROFILE);
  }

  logout() async {
    showLoading();
    error("");
    await userRepository.logout();
    hideLoading();
    AndroidAlarmManager.cancel(1);
    Storage.removeToken();
    Storage.removeId();
    Storage.removeRole();
    Get.offAllNamed(AppRoute.CLIENT_HOME);
  }

  forgotPassword({String? email}) async {
    showLoading();
    final response = await userRepository.forgotPassword(email: email);
    hideLoading();

    if(response['status'] == 200){
      Get.defaultDialog(
          title: "sentEmailSuccessfully".tr,
          middleText: "pleaseLoginAgain".tr,
          backgroundColor: AppColor.pinkPrimary,
          titleStyle: TextStyle(color: Colors.white),
          middleTextStyle: TextStyle(color: Colors.white),
          barrierDismissible: false,
          confirm:  AppBtn(
            child: Text('OK'),
            callback: () => Get.offNamed(AppRoute.USER_LOGIN),
          )
      );
    }else{
      var middleText;
      var title;
      if(response['status'] == 400){
        title = "cannotSendEmail".tr;
        middleText = 'emailDoesNotExist'.tr;
      }else{
        title = "sendEmailFailed".tr;
        middleText = 'cannotSendEmailContactAd'.tr;
      }
      Get.defaultDialog(
          title: title,
          middleText: middleText,
          backgroundColor: AppColor.pinkPrimary,
          titleStyle: TextStyle(color: Colors.white),
          middleTextStyle: TextStyle(color: Colors.white),
          barrierDismissible: false,
          confirm:  AppBtn(
            child: Text('OK'),
            callback: () => Get.back(),
          )
      );
    }
  }

  getServiceInProgress() async{
    showLoading();
    var response = await userRepository.getServiceInProgress(userId: user.id.toString());
    getCourseInProgress();
    hideLoading();

    serviceInProgress = response['data'];
  }

  getCourseInProgress() async{
    showLoading();
    var response = await userRepository.getCourseInProgress(userId: user.id.toString());
    hideLoading();

    courseInProgress = response['data'];
  }

  getListProductInProgress() async{
    showLoading();
    var responseService = await userRepository.getServiceInProgress(userId: user.id.toString());
    serviceInProgress = responseService['data'];
    var responseCourse = await userRepository.getCourseInProgress(userId: user.id.toString());
    courseInProgress = responseCourse['data'];
    hideLoading();
  }

  postScanUse(code) async{
    error("");
    showLoading();
    var response = await userRepository.postScanUse(code: code);
    hideLoading();

    if(response['status'] == 404){
      return 'productNotFound'.tr;
    }

    if(response['status'] == 405){
      return 'pleaseCheckInAppointment'.tr;
    }

    return null;
  }

  postAbortServiceUsing(code) async{
    showLoading();
    var response = await userRepository.postAbortServiceUsing(userId: user.id, code: code);
    hideLoading();

    if(response['status'] == 200){
      serviceInProgress = response['data'];
    }
  }

  postAbortCourseUsing(code) async{
    showLoading();
    var response = await userRepository.postAbortCourseUsing(userId: user.id, code: code);
    hideLoading();

    if(response['status'] == 200){
      courseInProgress = response['data'];
    }
  }

  postESignProductUsing({dynamic type, dynamic userId, dynamic code, dynamic signature}) async{
    var response;
    showLoading();
    if(type == "service"){
      response = await userRepository.postESignServiceUsing(userId: user.id, code: code, signature: signature);
    }else{
      response = await userRepository.postESignCourseUsing(userId: user.id, code: code, signature: signature);
    }
    hideLoading();

    if(response['status'] == 200){
      return Get.defaultDialog(
          title: "success".tr + '!',
          middleText: "eSignSuccessfully".tr + '.',
          backgroundColor: AppColor.pinkPrimary,
          titleStyle: TextStyle(color: Colors.white),
          middleTextStyle: TextStyle(color: Colors.white),
          barrierDismissible: false,
          confirm: AppBtn(
            child: Text('OK'),
            callback: () {
              getListProductInProgress();
              Get.to(() => UserHomeScreen(selectedPage: 2));
            },
          )
      );
    }

    return Get.defaultDialog(
        title: "failed".tr + '!',
        middleText: "eSignFailed".tr + '.',
        backgroundColor: AppColor.pinkPrimary,
        titleStyle: TextStyle(color: Colors.white),
        middleTextStyle: TextStyle(color: Colors.white),
        barrierDismissible: false,
        confirm: AppBtn(
          child: Text('OK'),
          callback: () => Get.back(),
        )
    );
  }
}
