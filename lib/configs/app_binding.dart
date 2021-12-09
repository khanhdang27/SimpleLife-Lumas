import 'package:get/get.dart';
import 'package:lumas/general/controllers.dart';
import 'package:lumas/general/services.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    injectService();
    Get.lazyPut<ClientController>(() => ClientController(), fenix: true);
    Get.lazyPut<UserController>(() => UserController(), fenix: true);
    Get.lazyPut<AppointmentController>(() => AppointmentController(), fenix: true);
    Get.lazyPut<ServiceController>(() => ServiceController(), fenix: true);
    Get.lazyPut<CourseController>(() => CourseController(), fenix: true);
    Get.lazyPut<SettingController>(() => SettingController(), fenix: true);
    Get.lazyPut<NotificationController>(() => NotificationController(), fenix: true);
    Get.lazyPut<StoreController>(() => StoreController(), fenix: true);
    Get.lazyPut<OrderController>(() => OrderController(), fenix: true);
  }

  void injectService() {
    Get.put(AuthService());
  }
}
