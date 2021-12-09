import 'package:lumas/controllers/controller.dart';
import 'package:get/get.dart';
import 'package:lumas/general/configs.dart';
import 'package:lumas/general/repositories.dart';

class ServiceController extends Controller{
  ServiceRepository serviceRepository = ServiceRepository();
  dynamic services = [].obs;
  dynamic service = null.obs;
  dynamic outstandingServices = [].obs;
  dynamic serviceTypes = [].obs;
  dynamic typeId = null.obs;
  dynamic type = null.obs;
  dynamic page = 1.obs;
  dynamic endPage = false.obs;

  void onInit() {
    getOutStandingList();
  }

  getTypeList() async{
    var response = await serviceRepository.getTypeList();
    serviceTypes = response['data'];
  }

  getList({String? name, int? page, int? typeId, String?  priceSort}) async{
    var response;
    if(page == null){
      this.page = 1;
      endPage(false);
      showLoading();
      response = await serviceRepository.getList(name: name, typeId: typeId, priceSort: priceSort);
      hideLoading();

      services = response['data'];
    }else{
      addLoading();
      response = await serviceRepository.getList(name: name, page: page, typeId: typeId,  priceSort: priceSort);
      doneAddLoading();

      if(response['data'].isNotEmpty){
        services = services + response['data'];
      }else{
        endPage(true);
      }
    }
  }

  getOutStandingList() async {
    showLoading();
    getTypeList();
    var response = await serviceRepository.getList();
    hideLoading();

    outstandingServices = response['data'];
  }

  addList() async{
    if(!endPage.value){
      page++;
      getList(page: page, typeId: typeId);
    }
  }

  getListScreen({int? typeId}){
    this.typeId = typeId;
    getList(typeId: typeId);
    return Get.toNamed(AppRoute.SERVICE_LIST);
  }

  getDetailScreen(id) async {
    showLoading();
    var response = await serviceRepository.getDetail(id);
    hideLoading();

    if (response['status'] == 200) {
      service = response['data'];
    }
    var routeDetail = AppRoute.SERVICE_DETAIL;
    if(Get.currentRoute == AppRoute.SERVICE_DETAIL){
      routeDetail = AppRoute.SERVICE_OTHER_DETAIL;
    }
    return Get.toNamed(routeDetail);
  }

  getTypeListScreen(){
    return Get.toNamed(AppRoute.SERVICE_TYPE_LIST);
  }
}