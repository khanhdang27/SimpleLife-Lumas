import 'package:lumas/general/models.dart';
import 'package:lumas/general/repositories.dart';

class OrderRepository extends Repository {
  getList({int? clientId, int? page}) async {
    Map response = await httpManager.get(url: '/order', params: {
      "member_id": clientId,
      "page": page,
    });

    if (response['status'] == 200) {
      List responseData = response['data'];
      List<Order> data = responseData.map((e) {
        return Order.fromJson(e);
      }).toList();

      return data;
    }

    return null;
  }

  Future<Map> getDetail(id) async {
    Map response = await httpManager.get(
      url: '/order/detail/' + id.toString(),
    );

    if (response['status'] == 200) {
      Order data = Order.fromJson(response['data']);

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
    var response = await httpManager.post(url: '/order/comment/$id', data: {'comment': comment});

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
    var response = await httpManager.post(url: '/order/remark/$id', data: {'remarks': remark});

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
