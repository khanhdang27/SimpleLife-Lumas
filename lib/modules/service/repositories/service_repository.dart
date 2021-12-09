import 'package:lumas/general/models.dart';
import 'package:lumas/general/repositories.dart';
import 'package:lumas/modules/service/models/service_type.dart';

class ServiceRepository extends Repository {

  Future<Map> getList({int? page, int? typeId, String? name, String? priceSort}) async {
    Map response = await httpManager.get(
      url: '/service/list',
      params: {
        "item_qty": 20,
        "page": page,
        "type_id": typeId,
        "name": name,
        "price_sort": priceSort
      }
    );

    if (response['status'] == 200) {
      List responseData = response['data']['data'];
      List<Service> data = responseData.map((e) {
        return Service.fromJson(e);
      }).toList();

      return {
        'data': data,
        'status': response['status'],
      };
    } else {
      return {
        'status': response['status'],
        'error': response['error'],
      };
    }
  }

  Future<Map> getTypeList({int? page, int? typeId}) async {
    Map response = await httpManager.get(url: '/service/type/list');

    if (response['status'] == 200) {
      List responseData = response['data'];
      List<ServiceType> data = responseData.map((e) {
        return ServiceType.fromJson(e);
      }).toList();

      return {
        'data': data,
        'status': response['status'],
      };
    } else {
      return {
        'status': response['status'],
        'error': response['error'],
      };
    }
  }

  Future<Map> getDetail(id) async{
    Map response = await httpManager.get(
      url: '/service/detail/'+id.toString(),
    );

    if (response['status'] == 200) {
      Service data = Service.fromJson(response['data']);

      return {
        'data' : data,
        'status': response['status'],
      };
    }

    return {
      'status': response['status'],
      'error': response['error'],
    };
  }
}
