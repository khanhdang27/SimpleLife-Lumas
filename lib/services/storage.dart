import 'package:get_storage/get_storage.dart';

class Storage {
  static GetStorage? storage = GetStorage();

  static const _keyToken = 'token';
  static const _keyId = 'id';
  static const _keyRole = 'role';
  static const _keyEmail = 'email';
  static const _keyEmailSignup = 'emailSignup';
  static const _keyLanguage = 'language';
  static const _keyPhoneHelper = 'phoneHelper';

  static setToken(String token) => storage!.write(_keyToken, token);

  static getToken() => storage!.read(_keyToken);

  static removeToken() => storage!.remove(_keyToken);

  static setId(int id) => storage!.write(_keyId, id);

  static getId() => storage!.read(_keyId);

  static removeId() => storage!.remove(_keyId);

  static setRole(int role) => storage!.write(_keyRole, role);

  static getRole() => storage!.read(_keyRole);

  static removeRole() => storage!.remove(_keyRole);

  static setEmail(String email) => storage!.write(_keyEmail, email);

  static getEmail() => storage!.read(_keyEmail);

  static removeEmail() => storage!.remove(_keyEmail);

  static setEmailSignup(String email) => storage!.write(_keyEmailSignup, email);

  static getEmailSignup() => storage!.read(_keyEmailSignup);

  static removeEmailSignup() => storage!.remove(_keyEmailSignup);

  static setLanguage(String language) => storage!.write(_keyLanguage, language);

  static getLanguage() => storage!.read(_keyLanguage);

  static removeLanguage() => storage!.remove(_keyLanguage);

  static setPhoneHelper(String phoneHelper) => storage!.write(_keyPhoneHelper, phoneHelper);

  static getPhoneHelper() => storage!.read(_keyPhoneHelper);

  static removePhoneHelper() => storage!.remove(_keyPhoneHelper);
}
