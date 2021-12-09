import 'package:lumas/general/models.dart';
import 'package:lumas/general/repositories.dart';

class AppointmentRepository extends Repository {
  getList({int? userId, int? clientId, int? today, DateTime? time, int? status, int? page}) async {
    Map response = await httpManager.get(url: '/appointment/list', params: {
      "user_id": userId,
      "member_id": clientId,
      "time": time,
      "status": status,
      "item_qty": 20,
      "page": page,
    });

    if (response['status'] == 200) {
      List responseData = response['data']['data'];
      List<Appointment> data = responseData.map((e) {
        return Appointment.fromJson(e);
      }).toList();

      return data;
    }

    return null;
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

  Future<Map> comment(id, comment) async {
    var response = await httpManager.post(url: '/appointment/comment/$id', data: {
      'comment': comment
    });

    if (response['status'] == 200) {
      return {
        'status': response['status'],
      };
    }

    return {
      'status': response['status'],
      'error': response['error'],
    };
  }

  Future<Map> remark(id, remark) async {
    var response = await httpManager.post(url: '/appointment/remark/$id', data: {
      'remarks': remark
    });

    if (response['status'] == 200) {
      return {
        'status': response['status'],
      };
    }

    return {
      'status': response['status'],
      'error': response['error'],
    };
  }
}
