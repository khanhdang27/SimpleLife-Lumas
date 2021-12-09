import 'package:lumas/controllers/controller.dart';
import 'package:lumas/general/general.dart';
import 'package:get/get.dart';

class SettingController extends Controller{
  dynamic selectedLang = "en".obs;

  void onInit(){
    var locale = LocalizationService.locale!.languageCode;
    if(locale =='zh'){
      selectedLang("zh");
    }
  }

  changeLocale(locale){
    selectedLang(locale);
  }
}