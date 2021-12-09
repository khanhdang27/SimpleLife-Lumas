import 'package:lumas/general/configs.dart';
import 'package:lumas/general/services.dart';
import 'package:connectivity/connectivity.dart';
import 'package:get/get.dart';

class AuthService {
  var token = Storage.getToken();
  var role = Storage.getRole();

  setInitialRoute(){
    _checkInternetConnectivity().then((connectionResult){
      if(!connectionResult){
        return Get.offNamed(AppRoute.NOT_CONNECT_SCREEN);
      }
    });

    if (token != null) {
      if (role == AppConfig.clientRole)
        return AppRoute.CLIENT_HOME;
      else
        return AppRoute.USER_HOME;
    } else {
      return AppRoute.CLIENT_HOME;
    }
  }

  Future<bool> _checkInternetConnectivity() async{
    var result = await Connectivity().checkConnectivity();
    if(result == ConnectivityResult.none){
      return false;
    }

    return true;
  }
}