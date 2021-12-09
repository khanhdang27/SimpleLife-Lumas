import 'dart:io';

import 'package:lumas/general/models.dart';
import 'package:lumas/general/repositories.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

class UserRepository extends Repository {
  Future<Map> login({String? email, String? password}) async {
    FormData formData = FormData.fromMap({
      'email': email,
      'password': password,
    });
    Map response = await httpManager.post(
      url: '/user/login',
      data: formData,
    );
    if (response['status'] == 200) {
      User user = User.fromJson(response['user']);
      return {
        'token': response['access_token'],
        'user' : user,
        'status': response['status'],
      };
    } else {
      return {
        'status': response['status'],
        'error': response['error'],
      };
    }
  }

  Future<Map> profile() async {
    Map response = await httpManager.get(url: '/user/profile');
    if (response['status'] == 200) {
      User user = User.fromJson(response['user']);
      return {
        'user' : user,
        'status': response['status'],
      };
    } else {
      return {
        'status': response['status'],
        'error': response['error'],
      };
    }
  }

  Future<Map> logout() async {
    Map response = await httpManager.post(url: '/user/logout');
    if (response['status'] == 200) {
      return {
        'status': response['status'],
      };
    } else {
      return {
        'status': response['status'],
        'error': response['error'],
      };
    }
  }

  forgotPassword({String? email}) async {
    Map response = await httpManager.post(
      url: '/user/forgot-password',
      data: FormData.fromMap({
        'email': email
      })
    );

    if (response['status'] == 200) {
      return {
        'status': response['status'],
      };
    } else {
      return {
        'status': response['status'],
        'error': response['error'],
      };
    }
  }

  postScanUse({dynamic code}) async {
    Map response = await httpManager.post(
        url: '/service/scan-use',
        data: FormData.fromMap({
          'code': code
        })
    );

    if(response['status'] == 200){
      return {
        "status": response['status']
      };
    }

    if(response['status'] == 404){
      Map responseCourse = await httpManager.post(
          url: '/course/scan-use',
          data: FormData.fromMap({
            'code': code
          })
      );

      if(responseCourse['status'] == 200){
        return {
          "status": responseCourse['status']
        };
      }

      return {
        "status": responseCourse['status'],
        "error": responseCourse['error']
      };
    }


    return {
      "status": response['status'],
      "error": response['error']
    };
  }

  getServiceInProgress({dynamic userId, String? key}) async {
    Map response = await httpManager.get(
        url: '/service/using/'+userId,
        params: {
          "key": key,
        }
    );

    if (response['status'] == 200) {
      List responseData = response['data'];
      List<ClientService> data = responseData.map((e) {
        return ClientService.fromJson(e);
      }).toList();

      return {
        'status': 200,
        'data': data
      };
    }

    return {};
  }

  getCourseInProgress({dynamic userId, String? key}) async {
    Map response = await httpManager.get(
        url: '/course/using/'+userId,
        params: {
          "key": key,
        }
    );

    if (response['status'] == 200) {
      List responseData = response['data'];
      List<ClientCourse> data = responseData.map((e) {
        return ClientCourse.fromJson(e);
      }).toList();

      return {
        'status': 200,
        'data': data
      };
    }

    return {};
  }

  postAbortServiceUsing({dynamic userId, dynamic code}) async {
    Map responseFirst = await httpManager.post(
        url: '/service/stop-use',
        data: FormData.fromMap({
          'code': code
        })
    );

    if(responseFirst['status'] == 200){
      Map responseSecond = await httpManager.get(url: '/service/using/'+userId.toString());

      if(responseFirst['status'] == 200) {
        List responseData = responseSecond['data'];
        List<ClientService> data = responseData.map((e) {
          return ClientService.fromJson(e);
        }).toList();

        return {
          'status': 200,
          'data': data
        };
      }
      return {
        "status": responseSecond['status'],
        "error": responseSecond['error']
      };
    }

    return {
      "status": responseFirst['status'],
      "error": responseFirst['error']
    };
  }

  postAbortCourseUsing({dynamic userId, dynamic code}) async {
    Map responseFirst = await httpManager.post(
        url: '/course/stop-use',
        data: FormData.fromMap({
          'code': code
        })
    );

    if(responseFirst['status'] == 200){
      Map responseSecond = await httpManager.get(url: '/course/using/'+userId.toString());

      if(responseFirst['status'] == 200) {
        List responseData = responseSecond['data'];
        List<ClientCourse> data = responseData.map((e) {
          return ClientCourse.fromJson(e);
        }).toList();

        return {
          'status': 200,
          'data': data
        };
      }
      return {
        "status": responseSecond['status'],
        "error": responseSecond['error']
      };
    }

    return {
      "status": responseFirst['status'],
      "error": responseFirst['error']
    };
  }

  postESignServiceUsing({dynamic userId, dynamic code, dynamic signature}) async{
    var file = await MultipartFile.fromBytes(signature, filename: "signature.png");

    FormData formData = FormData.fromMap({
      "signature":  file,
      "code": code,
      "user_id": userId,
    });
    Map response = await httpManager.post(
      url: '/service/e-sign',
      data: formData,
    );

    if (response['status'] != 200) {
      return {
        'status': response['status'],
        'errors': response['error'],
      };
    }

    return {
      'status': 200
    };
  }

  postESignCourseUsing({dynamic userId, dynamic code, dynamic signature}) async{
    var file = await MultipartFile.fromBytes(signature, filename: "signature.png");

    FormData formData = FormData.fromMap({
      "signature":  file,
      "code": code,
      "user_id": userId,
    });

    Map response = await httpManager.post(
      url: '/course/e-sign',
      data: formData,
    );

    if (response['status'] != 200) {
      return {
        'status': response['status'],
        'errors': response['error'],
      };
    }

    return {
      'status': 200
    };
  }
}
