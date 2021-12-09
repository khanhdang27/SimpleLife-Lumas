import 'package:lumas/general/models.dart';
import 'package:lumas/general/repositories.dart';

class CourseRepository extends Repository{
  Future<Map> getList({String? name, int? page, int? categoryId, String? priceSort}) async {
    Map response = await httpManager.get(
        url: '/course/list',
        params: {
          "item_qty": 20,
          "page": page,
          "category_id": categoryId,
          "name": name,
          "price_sort": priceSort
        }
    );

    if (response['status'] == 200) {
      List responseData = response['data']['data'];
      List<Course> data = responseData.map((e) {
        return Course.fromJson(e);
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

  Future<Map> getCategoryList({int? page, int? typeId}) async {
    Map response = await httpManager.get(url: '/course/category/list');

    if (response['status'] == 200) {
      List responseData = response['data'];
      List<CourseCategory> data = responseData.map((e) {
        return CourseCategory.fromJson(e);
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
      url: '/course/detail/'+id.toString(),
    );

    if (response['status'] == 200) {
      Course data = Course.fromJson(response['data']);

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