import 'package:get/get.dart';
import 'package:lumas/controllers/controller.dart';
import 'package:lumas/general/repositories.dart';
import 'package:lumas/general/controllers.dart';
import 'package:lumas/general/models.dart';
import 'package:lumas/general/configs.dart';
import 'package:lumas/general/services.dart';

class AppointmentController extends Controller{
  AppointmentRepository appointmentRepo = AppointmentRepository();
  dynamic appointments = <List<Appointment>>[].obs;
  RxInt status = 3.obs;
  RxString statusName = "status".tr.obs;
  dynamic appointment = <Appointment>[].obs;
  RxInt page = 1.obs;
  RxBool endPage = false.obs;

  getList({dynamic? time, dynamic? status, dynamic? pageData}) async {
    var userId;
    var clientId;
    var storageRole = Storage.getRole();
    if(storageRole != 1){
      UserController userController = Get.find<UserController>();
      if(userController.user.role.id != 1) {
        userId = userController.user.id;
      }
    }else{
      ClientController clientController = Get.find<ClientController>();
      clientId = clientController.client.id;
    }

    if(status == null){
      this.status(3);
      this.statusName("status".tr);
    }
    if(pageData == null){
      page(1);
      endPage(false);

      showLoading();
      appointments = await appointmentRepo.getList(userId: userId, clientId: clientId, time: time, status: status);
      hideLoading();
    }else{
      addLoading();
      var data = await appointmentRepo.getList(userId: userId, clientId: clientId, time: time, status: status, page: pageData);
      doneAddLoading();

      if(data.isNotEmpty){
        appointments = appointments + data;
      }else{
        endPage(true);
      }
    }
  }

  addList() async {
    if(!endPage.value){
      page++;
      if(status.value == 3){
        getList(pageData: page.value);
      }else{
        getList(pageData: page.value, status: status.value);
      }
    }
  }

  getDetail(id) async {
    showLoading();
    var response = await appointmentRepo.getDetail(id);
    hideLoading();

    if (response != null){
      if (response['status'] == 200) {
        appointment = response['data'];
      }
    }

    Get.toNamed(AppRoute.APPOINTMENT_DETAIL);
  }

  filterByStatus(){
    page(1);
    Appointment appointment = Appointment();
    if(status.value == 3){
      status(0);
      statusName(appointment.getStatus(status));
      getList(status: status.value);
    }else{
      if(status.value < 2){
        status++;
        statusName(appointment.getStatus(status));
        getList(status: status.value);
      }else{
        status(3);
        statusName("status".tr);
        getList();
      }
    }
  }

  comment(id,comment) async {
    showLoading();
    var response = await appointmentRepo.comment(id, comment);
    hideLoading();

    if (response != null){
      if (response['status'] == 200) {
        getDetail(id);
        Get.back();
      }
    }
  }

  remark(id,remark) async {
    showLoading();
    var response = await appointmentRepo.remark(id, remark);
    hideLoading();

    if (response != null){
      if (response['status'] == 200) {
        getDetail(id);
        Get.back();
      }
    }
  }
}