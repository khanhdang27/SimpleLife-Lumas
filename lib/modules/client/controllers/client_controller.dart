import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:lumas/controllers/controller.dart';
import 'package:lumas/general/general.dart';
import 'package:lumas/main.dart';

class ClientController extends Controller with StateMixin<Client> {
  ClientRepository clientRepository = ClientRepository();
  AppointmentController appointmentController = Get.find<AppointmentController>();
  dynamic client = <Client>[].obs;
  dynamic services = [].obs;
  dynamic service = null.obs;
  dynamic courses = [].obs;
  dynamic course = null.obs;
  final error = "".obs;
  final errors = Validate().obs;
  final errorsForgot = ValidateForgot().obs;
  RxBool isObscure = true.obs;
  RxBool isObscureFg = true.obs;
  RxBool isObscureConfirm = true.obs;
  RxBool isObscureFgConfirm = true.obs;
  final FirebaseAuth auth = FirebaseAuth.instance;
  dynamic isServiceLoading = false.obs;
  final cfPassError =''.obs;

  void onInit() async {
    if (isLoggedIn(AppConfig.clientRole)) {
      if (client.isEmpty && Get.currentRoute == AppRoute.CLIENT_HOME) {
        getDataProfile();
        await AndroidAlarmManager.initialize();
        await AndroidAlarmManager.periodic(Duration(minutes: 1), 1, getNotificationClient);
      }
    }
    getPhoneHelper();
  }

  static void getNotificationClient() async {
    Map result;
    NotificationRepository notificationRepository = NotificationRepository();
    result = await notificationRepository.notiNext(type: 'client');
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
    await flutterLocalNotificationsPlugin.show(0, title, body, notificationDetails,
        payload: "Redirect to notifications tab");
  }

  login({String? phone, String? password}) async {
    showLoading();
    final response = await clientRepository.login(phone: phone, password: password);
    hideLoading();

    if (response != null) {
      if (response['status'] == 200) {
        Client clientModel = response['client'];
        Storage.setToken(response['token']);
        Storage.setId(clientModel.id ?? 0);
        Storage.setRole(AppConfig.clientRole);
        getDataProfile();
        error("");
        await AndroidAlarmManager.initialize();
        await AndroidAlarmManager.periodic(Duration(minutes: 1), 1, getNotificationClient);
        Get.offAllNamed(AppRoute.CLIENT_HOME);
      } else if (response['status'] == 402) {
        error('pleaseVerifyEmail'.tr);
      } else {
        error('clientLoginFaildMessage'.tr);
      }
    }
  }

  signUpValidate({name, username, email, phone, password, confirm}) async {
    showLoading();
    final response = await clientRepository.signUpValidate(
      name: name,
      username: username,
      email: email,
      phone: phone,
      password: password,
      confirm: confirm,
    );
    hideLoading();
    Validate validate = Validate.fromJson(response['errors']);
    errors(validate);
    if (response['status'] == 200) {
      Storage.setEmailSignup(email);
      signUp(
        name: name,
        username: username,
        email: email,
        phone: phone,
        password: password,
      );
      // Get.toNamed(AppRoute.CLIENT_PIN_CODE, arguments: {
      //   'name': name,
      //   'username': username,
      //   'email': email,
      //   'phone': phone,
      //   'password': password,
      //   'signup': true,
      // });
    }
  }

  signUp({name, username, email, phone, password}) async {
    showLoading();
    final response = await clientRepository.signUp(
      name: name,
      username: username,
      email: email,
      phone: phone,
      password: password,
    );
    hideLoading();

    if (response == 200) {
      return Get.offAllNamed(AppRoute.CLIENT_LOGIN);
    }
  }

  forgotValidate({phone, password, confirm})async{
    showLoading();
    final response = await clientRepository.forgotValidate(
      phone: phone,
      password: password,
      confirm: confirm,
    );
    hideLoading();
    ValidateForgot validate = ValidateForgot.fromJson(response['errors']);
    errorsForgot(validate);
    if (response['status'] == 200) {
      forgotPass(
        phone: phone,
        password: password,
        confirm: confirm,
      );
      // Get.toNamed(AppRoute.CLIENT_PIN_CODE, arguments: {
      //   'phone': phone,
      //   'password': password,
      //   'confirm': confirm,
      //   'signup': false,
      // });
    }
  }

  forgotPass({phone, password, confirm}) async {
    showLoading();
    final response = await clientRepository.forgotPass(
      phone: phone,
      password: password,
      confirm: confirm,
    );
    hideLoading();

    if (response == 200) {
      return Get.offAllNamed(AppRoute.CLIENT_LOGIN);
    }
  }

  // forgotPass({String? email}) async {
  //   showLoading();
  //   final response = await clientRepository.forgotPass(email: email);
  //   hideLoading();
  //
  //   if (response['status'] == 200) {
  //     Get.defaultDialog(
  //         title: "sentEmailSuccessfully".tr,
  //         middleText: "pleaseLoginAgain".tr,
  //         backgroundColor: AppColor.pinkPrimary,
  //         titleStyle: TextStyle(color: Colors.white),
  //         middleTextStyle: TextStyle(color: Colors.white),
  //         barrierDismissible: false,
  //         confirm: AppBtn(
  //           child: Text('OK'),
  //           callback: () => Get.offNamed(AppRoute.CLIENT_LOGIN),
  //         ));
  //   } else {
  //     var middleText;
  //     var title;
  //     if (response['status'] == 400) {
  //       title = "cannotSendEmail".tr;
  //       middleText = 'emailDoesNotExist'.tr;
  //     } else {
  //       title = "sendEmailFailed".tr;
  //       middleText = 'cannotSendEmailContactAd'.tr;
  //     }
  //     Get.defaultDialog(
  //         title: title,
  //         middleText: middleText,
  //         backgroundColor: AppColor.pinkPrimary,
  //         titleStyle: TextStyle(color: Colors.white),
  //         middleTextStyle: TextStyle(color: Colors.white),
  //         barrierDismissible: false,
  //         confirm: AppBtn(
  //           child: Text('OK'),
  //           callback: () => Get.back(),
  //         ));
  //   }
  // }

  getDataProfile() async {
    showLoading();
    final response = await clientRepository.profile();
    hideLoading();

    if (response != null) {
      if (response['status'] == 200) {
        Client clientModel = response['client'];
        client = clientModel;
        appointmentController.getList();
      }

      if (response['status'] == 401) {
        return logout();
      }
    }
  }

  getProfile() async {
    return Get.toNamed(AppRoute.CLIENT_PROFILE);
  }

  postProfile(data) async {
    showLoading();
    final response = await clientRepository.updateProfile(data);
    hideLoading();
    if (response['status'] == 200) {
      getDataProfile();
      errors(Validate());
      Get.defaultDialog(
          title: "updateSuccess".tr,
          middleText: "",
          backgroundColor: AppColor.pinkPrimary,
          titleStyle: TextStyle(color: Colors.white),
          middleTextStyle: TextStyle(color: Colors.white),
          barrierDismissible: false,
          confirm: AppBtn(
            child: Text('OK'),
            callback: () => Get.back(),
          ));
    } else {
      if (response['status'] == 401) {
        return Get.defaultDialog(
            title: "loginEnded".tr,
            middleText: "",
            backgroundColor: AppColor.pinkPrimary,
            titleStyle: TextStyle(color: Colors.white),
            middleTextStyle: TextStyle(color: Colors.white),
            barrierDismissible: false,
            confirm: AppBtn(
              child: Text('OK'),
              callback: () => logout(),
            ));
      }
      Validate validate = Validate.fromJson(response['errors']);
      errors(validate);
    }
  }

  logout() async {
    showLoading();
    error("");
    await clientRepository.logout();
    hideLoading();
    AndroidAlarmManager.cancel(1);
    Storage.removeToken();
    Storage.removeId();
    Storage.removeRole();
    Get.offAllNamed(AppRoute.CLIENT_HOME);
  }

  updateAvatar(data) async {
    showLoading();
    final response = await clientRepository.updateAvatar(data);
    hideLoading();
    if (response['status'] == 200) {
      getDataProfile();
      errors(Validate());
      Get.defaultDialog(
          title: "updateSuccess".tr,
          middleText: "",
          backgroundColor: AppColor.pinkPrimary,
          titleStyle: TextStyle(color: Colors.white),
          middleTextStyle: TextStyle(color: Colors.white),
          barrierDismissible: false,
          confirm: AppBtn(
            child: Text('OK'),
            callback: () => Get.back(),
          ));
    } else {
      if (response['status'] == 401) {
        return Get.defaultDialog(
            title: "loginEnded".tr,
            middleText: "",
            backgroundColor: AppColor.pinkPrimary,
            titleStyle: TextStyle(color: Colors.white),
            middleTextStyle: TextStyle(color: Colors.white),
            barrierDismissible: false,
            confirm: AppBtn(
              child: Text('OK'),
              callback: () => logout(),
            ));
      }
      Validate validate = Validate.fromJson(response['errors']);
      errors(validate);
    }
  }

  getPaidServiceList({dynamic clientId, String? key}) async {
    showLoading();
    final response = await clientRepository.getPaidServiceList(clientId: clientId, key: key);
    hideLoading();

    services = response['data'];
  }

  getPaidServiceDetail(id) async {
    showLoading();
    final response = await clientRepository.getPaidServiceDetail(id: id);
    hideLoading();

    service = response['data'];
    return Get.toNamed(AppRoute.CLIENT_SERVICE_DETAIL);
  }

  getPaidCourseList({dynamic clientId, String? key}) async {
    showLoading();
    final response = await clientRepository.getPaidCourseList(clientId: clientId, key: key);
    hideLoading();

    courses = response['data'];
  }

  getPaidCourseDetail(id) async {
    showLoading();
    final response = await clientRepository.getPaidCourseDetail(id: id);
    hideLoading();

    course = response['data'];
    return Get.toNamed(AppRoute.CLIENT_COURSE_DETAIL);
  }

  getPaidProductScreen() async {
    Get.toNamed(AppRoute.CLIENT_PAID_PRODUCT);
    loadService();
    final responseServices = await clientRepository.getPaidServiceList(clientId: client.id);
    services = responseServices['data'];
    final responseCourses = await clientRepository.getPaidCourseList(clientId: client.id);
    courses = responseCourses['data'];
    loadDoneService();
  }

  loadService() {
    isServiceLoading(true);
  }

  loadDoneService() {
    isServiceLoading(false);
  }

  getPhoneHelper() async {
    showLoading();
    final response = await clientRepository.getPhoneHelper();
    if (response['status'] == 200) Storage.setPhoneHelper(response['data']);
    hideLoading();
  }

  getOrderScreen() async {
    Get.toNamed(AppRoute.CLIENT_ORDER);
  }
}
