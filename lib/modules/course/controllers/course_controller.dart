import 'package:lumas/controllers/controller.dart';
import 'package:get/get.dart';
import 'package:lumas/general/general.dart';

class CourseController extends Controller{
  CourseRepository courseRepository = CourseRepository();
  dynamic courses = [].obs;
  dynamic course = null.obs;
  dynamic outstandingCourses = [].obs;
  dynamic courseCategories = [].obs;
  dynamic categoryId = null.obs;
  dynamic category = null.obs;
  dynamic page = 1.obs;
  dynamic endPage = false.obs;

  void onInit() {
    getOutStandingList();
  }

  getCategoryList() async{
    var response = await courseRepository.getCategoryList();
    courseCategories = response['data'];
  }

  getList({String? name, int? page, int? categoryId, String?  priceSort}) async{
    var response;
    if(page == null){
      this.page = 1;
      endPage(false);
      showLoading();
      response = await courseRepository.getList(name: name, categoryId: categoryId, priceSort: priceSort);
      hideLoading();

      courses = response['data'];
    }else{
      addLoading();
      response = await courseRepository.getList(name: name, page: page, categoryId: categoryId, priceSort: priceSort);
      doneAddLoading();

      if(response['data'].isNotEmpty){
        courses = courses + response['data'];
      }else{
        endPage(true);
      }
    }
  }

  getOutStandingList() async {
    showLoading();
    getCategoryList();
    var response = await courseRepository.getList();
    hideLoading();

    outstandingCourses = response['data'];
  }

  addList() async{
    if(!endPage.value){
      page++;
      getList(page: page, categoryId: categoryId);
    }
  }

  getListScreen({int? categoryId}){
    this.categoryId = categoryId;
    getList(categoryId: categoryId);
    Get.toNamed(AppRoute.COURSE_LIST);
  }

  getDetailScreen(id) async {
    showLoading();
    var response = await courseRepository.getDetail(id);
    hideLoading();

    if (response['status'] == 200) {
      course = response['data'];
    }

    var routeDetail = AppRoute.COURSE_DETAIL;
    if(Get.currentRoute == AppRoute.COURSE_DETAIL){
      routeDetail = AppRoute.COURSE_OTHER_DETAIL;
    }

    return Get.toNamed(routeDetail);
  }

  getCategoryListScreen(){
    Get.toNamed(AppRoute.COURSE_CATE_LIST);
  }
}