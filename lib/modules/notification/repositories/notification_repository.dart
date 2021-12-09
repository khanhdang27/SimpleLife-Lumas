import 'package:lumas/general/general.dart';
import 'package:lumas/general/models.dart';
import 'package:lumas/general/repositories.dart';

class NotificationRepository extends Repository {
  getList({required int id, required String typeId}) async {
    Map response = await httpManager.get(url: '/notification/list', params: {
      typeId: id,
    });
    if (response['status'] == 200 && response['data'] != null) {
      List responseData = response['data'];
      List<Notify> data = responseData.map((e) {
        return Notify.fromJson(e);
      }).toList();

      return data;
    }
    return {};
  }

  Future<int> getNotiNotRead({int? id, String? typeId}) async {
    Map response = await httpManager.get(url: '/notification/list', params: {
      typeId!: id,
    });
    if (response['status'] == 200) {
      if (typeId == 'user_id') {
        return response['not_read_user'];
      } else {
        return response['not_read_client'];
      }
    }
    return 0;
  }

  Future<Map> notiNext({required String type}) async {
    Map response = await httpManager.get(url: '/notification/$type-next');
    if (response['status'] == 200) {
      if(response['data'] != null){
        Notify data = Notify.fromJson(response['data']);
        return {
          'data': data,
          'status': response['status'],
        };
      }else{
        return {
          'status': 404,
          'error': 'Not data'
        };
      }
    }
    return {
      'status': response['status'],
      'error': response['error'],
    };
  }

  readNoti({required int appointmentId, required int userId,required String role}) async {
    Map response = await httpManager.post(url: '/notification/read-notification/$appointmentId/$userId/$role');
    return response['status'];
  }

  Future<Map> getDetail(id) async {
    Map response = await httpManager.get(
      url: '/appointment/detail/' + id.toString(),
    );

    if (response['status'] == 200) {
      Appointment data = Appointment.fromJson(response['data']);

      return {
        'data': data,
        'status': response['status'],
      };
    }

    return {
      'status': response['status'],
      'error': response['error'],
    };
  }
}
