import 'package:lumas/general/general.dart';
import 'package:lumas/general/models.dart';
import 'package:lumas/general/repositories.dart';

class StoreRepository extends Repository {
  getList() async {
    Map response = await httpManager.get(url: '/store');
    if (response['status'] == 200 && response['data'] != null) {
      List responseData = response['data'];
      List<Stores> data = responseData.map((e) {
        return Stores.fromJson(e);
      }).toList();

      return data;
    }
    return {};
  }
  search({required String key}) async {
    Map response = await httpManager.get(url: '/store', params: {
      'key': key,
    });
    if (response['status'] == 200 && response['data'] != null) {
      List responseData = response['data'];
      List<Stores> data = responseData.map((e) {
        return Stores.fromJson(e);
      }).toList();

      return data;
    }
    return {};
  }
}
