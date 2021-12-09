import 'package:get/get.dart';
import 'package:lumas/general/services.dart';

class Controller extends GetxController{
  RxBool isLoading = false.obs;
  RxBool isAddLoading = false.obs;

  validator(loginFormKey){
    return loginFormKey.currentState!.validate();
  }

  showLoading() {
    isLoading.value = true;
  }

  hideLoading() {
    isLoading.value = false;
  }

  addLoading() {
    isAddLoading.value = true;
  }

  doneAddLoading() {
    isAddLoading.value = false;
  }

  isLoggedIn(int role){
    if(Storage.getToken() != null && Storage.getRole() == role){
      return true;
    }

    return false;
  }
}