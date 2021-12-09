// import 'package:lumas/models/models.dart';
// import 'package:lumas/repositories/repositories.dart';
// import 'package:dio/dio.dart';
//
// class AuthRepository extends Repository {
//   Future<Map> login({String? username, String? password}) async {
//     FormData formData = FormData.fromMap({
//       'username': username,
//       'password': password,
//     });
//     Map response = await httpManager.post(
//       url: '/client/login',
//       data: formData,
//     );
//     if (response['status'] == 200) {
//       UserIdentity userIdentity = UserIdentity(
//         id: response['client_info']['id'],
//         token: response['access_token'],
//       );
//       return {
//         'status': response['status'],
//         'userIdentity': userIdentity,
//       };
//     } else {
//       return {
//         'status': response['status'],
//         'error': response['error'],
//       };
//     }
//   }
//
//   Future<Map> loginStaff({String? email, String? password}) async {
//     FormData formData = FormData.fromMap({
//       'email': email,
//       'password': password,
//     });
//     Map response = await httpManager.post(
//       url: '/user/login',
//       data: formData,
//     );
//     if (response['status'] == 200) {
//       UserIdentity userIdentity = UserIdentity(
//         id: response['user']['id'],
//         token: response['access_token'],
//       );
//       return {
//         'status': response['status'],
//         'userIdentity': userIdentity,
//       };
//     } else {
//       return {
//         'status': response['status'],
//         'error': response['error'],
//       };
//     }
//   }
// }
