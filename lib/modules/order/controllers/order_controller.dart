import 'package:get/get.dart';
import 'package:lumas/controllers/controller.dart';
import 'package:lumas/general/repositories.dart';
import 'package:lumas/general/controllers.dart';
import 'package:lumas/general/models.dart';
import 'package:lumas/general/configs.dart';
import 'package:lumas/general/services.dart';

class OrderController extends Controller {
  OrderRepository orderRepo = OrderRepository();
  dynamic orders = <List<Order>>[].obs;
  RxInt status = 3.obs;
  RxString statusName = "status".tr.obs;
  dynamic order = <Order>[].obs;
  RxInt page = 1.obs;
  RxBool endPage = false.obs;

  getList({dynamic? status, dynamic? pageData}) async {
    var clientId;

    ClientController clientController = Get.find<ClientController>();
    clientId = clientController.client.id;

    if (status == null) {
      this.status(3);
      this.statusName("status".tr);
    }
    if (pageData == null) {
      page(1);
      endPage(false);

      showLoading();
      orders = await orderRepo.getList(clientId: clientId);
      hideLoading();
    } else {
      addLoading();
      var data = await orderRepo.getList(clientId: clientId, page: pageData);
      doneAddLoading();

      if (data.isNotEmpty) {
        orders = orders + data;
      } else {
        endPage(true);
      }
    }
  }

  addList() async {
    if (!endPage.value) {
      page++;
      if (status.value == 3) {
        getList(pageData: page.value);
      } else {
        getList(pageData: page.value, status: status.value);
      }
    }
  }

  getDetail(id) async {
    showLoading();
    var response = await orderRepo.getDetail(id);
    hideLoading();

    if (response != null) {
      if (response['status'] == 200) {
        order = response['data'];
      }
    }
    Get.toNamed(AppRoute.CLIENT_ORDER_DETAIL);
  }

  filterByStatus() {
    page(1);
    Order order = Order();
    if (status.value == 3) {
      status(0);
      statusName(order.getStatus(status));
      getList(status: status.value);
    } else {
      if (status.value < 2) {
        status++;
        statusName(order.getStatus(status));
        getList(status: status.value);
      } else {
        status(3);
        statusName("status".tr);
        getList();
      }
    }
  }

  comment(id, comment) async {
    showLoading();
    var response = await orderRepo.comment(id, comment);
    hideLoading();

    if (response != null) {
      if (response['status'] == 200) {
        getDetail(id);
        Get.back();
      }
    }
  }

  remark(id, remark) async {
    showLoading();
    var response = await orderRepo.remark(id, remark);
    hideLoading();

    if (response != null) {
      if (response['status'] == 200) {
        getDetail(id);
        Get.back();
      }
    }
  }
}
