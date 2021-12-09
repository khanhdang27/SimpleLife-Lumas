import 'package:get/get.dart';
import 'package:lumas/controllers/controller.dart';
import 'package:lumas/general/repositories.dart';
import 'package:lumas/general/models.dart';
import 'package:lumas/general/services.dart';

class StoreController extends Controller {
  StoreRepository storeRepository = StoreRepository();
  dynamic stores = <List<Stores>>[].obs;
  RxInt notiNotRead = 0.obs;

  getList() async {
    showLoading();
    stores = await storeRepository.getList();
    hideLoading();
  }

  search(String key) async {
    showLoading();
    print(key);
    stores = await storeRepository.search(key: key);
    hideLoading();
  }
}
