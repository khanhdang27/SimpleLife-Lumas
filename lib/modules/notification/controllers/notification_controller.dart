import 'package:get/get.dart';
import 'package:lumas/controllers/controller.dart';
import 'package:lumas/general/repositories.dart';
import 'package:lumas/general/models.dart';
import 'package:lumas/general/services.dart';

class NotificationController extends Controller {
  NotificationRepository notificationRepository = NotificationRepository();
  dynamic notifications = <List<Notify>>[].obs;
  RxInt notiNotRead = 0.obs;

  getList() async {
    var storageRole = Storage.getRole();
    var id = Storage.getId();
    showLoading();
    if (storageRole == 1) {
      notifications = await notificationRepository.getList(id: id, typeId: 'member_id');
    } else {
      notifications = await notificationRepository.getList(id: id, typeId: 'user_id');
    }
    hideLoading();
  }

  readNoti({
    int? appointmentId,
    int? userId,
  }) async {
    String role = Storage.getRole() == 1 ? 'client' : 'user';
    await notificationRepository.readNoti(
        appointmentId: appointmentId ?? 0, userId: userId ?? 0, role: role);
    getList();
    notRead();
  }

  notRead() async {
    var storageRole = Storage.getRole();
    var id = Storage.getId();
    if (storageRole == 1) {
      notiNotRead(await notificationRepository.getNotiNotRead(id: id, typeId: 'member_id'));
    } else {
      notiNotRead(await notificationRepository.getNotiNotRead(id: id, typeId: 'user_id'));
    }
  }
}
