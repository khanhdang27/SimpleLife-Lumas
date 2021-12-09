import 'dart:io';

import 'package:lumas/general/models.dart';
import 'package:lumas/general/repositories.dart';
import 'package:dio/dio.dart';

class ClientRepository extends Repository {
  Future<Map> login({String? phone, String? password}) async {
    FormData formData = FormData.fromMap({
      'phone': phone,
      'password': password,
    });
    Map response = await httpManager.post(
      url: '/client/login',
      data: formData,
    );
    if (response['status'] == 200) {
      Client client = Client.fromJson(response['client_info']);
      return {
        'token': response['access_token'],
        'client': client,
        'status': response['status'],
      };
    } else {
      return {
        'status': response['status'],
        'error': response['error'],
      };
    }
  }

  Future<Map> signUpValidate({name, username, email, phone, password, confirm}) async {
    FormData formData = FormData.fromMap({
      'name': name,
      'username': username,
      'email': email,
      'phone': phone,
      'password': password,
      'password_re_enter': confirm,
    });
    Map response = await httpManager.post(
      url: '/client/register-validate',
      data: formData,
    );
    if (response['status'] != 200) {
      return {
        'status': response['status'],
        'errors': response['validate'],
      };
    }
    return {
      'status': 200,
      'errors': {'error': null}
    };
  }

  Future<int> signUp({name, username, email, phone, password}) async {
    FormData formData = FormData.fromMap(
        {'name': name, 'username': username, 'email': email, 'phone': phone, 'password': password});

    Map response = await httpManager.post(
      url: '/client/register',
      data: formData,
    );
    return response['status'];
  }

  Future<Map> forgotValidate({phone, password, confirm}) async {
    FormData formData = FormData.fromMap({
      'phone': phone,
      'password': password,
      'confirm_password': confirm,
    });
    Map response = await httpManager.post(
      url: '/client/forgot-password-validate',
      data: formData,
    );
    if (response['status'] != 200) {
      return {
        'status': response['status'],
        'errors': response['validate'],
      };
    }
    return {
      'status': 200,
      'errors': {'error': null}
    };
  }

  Future<int> forgotPass({phone, password, confirm}) async {
    FormData formData = FormData.fromMap({
      'phone': phone,
      'password': password,
      'confirm_password': confirm,
    });
    Map response = await httpManager.post(
      url: '/client/forgot-password',
      data: formData,
    );
    return response['status'];
  }

  Future<Map> profile() async {
    Map response = await httpManager.get(url: '/client/profile');
    if (response['status'] == 200) {
      Client client = Client.fromJson(response['client_info']);
      return {
        'client': client,
        'status': response['status'],
      };
    } else {
      return {
        'status': response['status'],
        'error': response['error'],
      };
    }
  }

  Future<Map> updateProfile(formData) async {
    Map response = await httpManager.post(
      url: '/client/profile-update',
      data: formData,
    );
    if (response['status'] != 200) {
      return {
        'status': response['status'],
        'errors': response['validate'],
      };
    }
    return {
      'status': 200,
      'errors': {'error': null}
    };
  }

  Future<Map> updateAvatar(File avatar) async {
    FormData formData = FormData.fromMap({
      "avatar": await MultipartFile.fromFile(avatar.path),
    });
    Map response = await httpManager.post(
      url: '/client/update-avatar',
      data: formData,
    );
    if (response['status'] != 200) {
      return {
        'status': response['status'],
        'errors': response['validate'],
      };
    }
    return {
      'status': 200,
      'errors': {'error': null}
    };
  }

  Future<Map> logout() async {
    Map response = await httpManager.post(url: '/client/logout');
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

  Future<Map> getPaidServiceList({dynamic clientId, String? key}) async {
    Map response =
        await httpManager.get(url: '/client/service/list/' + clientId.toString(), params: {
      "key": key,
    });

    if (response['status'] == 200) {
      List responseData = response['data'];
      List<ClientService> data = responseData.map((e) {
        return ClientService.fromJson(e);
      }).toList();

      return {'status': 200, 'data': data};
    }

    return {};
  }

  Future<Map> getPaidServiceDetail({dynamic id}) async {
    Map response = await httpManager.get(url: '/client/service/detail/' + id.toString());

    if (response['status'] == 200) {
      ClientService data = ClientService.fromJson(response['data']);

      return {'status': 200, 'data': data};
    }

    return {};
  }

  Future<Map> getPaidCourseList({dynamic clientId, String? key}) async {
    Map response =
        await httpManager.get(url: '/client/course/list/' + clientId.toString(), params: {
      "key": key,
    });

    if (response['status'] == 200) {
      List responseData = response['data'];
      List<ClientCourse> data = responseData.map((e) {
        return ClientCourse.fromJson(e);
      }).toList();

      return {'status': 200, 'data': data};
    }

    return {};
  }

  Future<Map> getPaidCourseDetail({dynamic id}) async {
    Map response = await httpManager.get(url: '/client/course/detail/' + id.toString());

    if (response['status'] == 200) {
      ClientCourse data = ClientCourse.fromJson(response['data']);

      return {'status': 200, 'data': data};
    }

    return {};
  }

  Future<Map> getPhoneHelper() async {
    Map response = await httpManager.get(url: '/helper-center');

    if (response['status'] == 200) {
      return {'status': 200, 'data': response['data']};
    }

    return {'status': 400, 'data': '37056391'};
  }
}
