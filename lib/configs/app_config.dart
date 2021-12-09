class AppConfig {
  static final baseUrl = 'https://project.nironcrm.tk/simplelife/public';
  static final baseApiUrl = AppConfig.baseUrl + '/api';
  static final confirmPayment = AppConfig.baseUrl + '/api/payment/success';
  static final successPayment =
      AppConfig.baseUrl + '/api/payment/confirm-paypal';
  static final failPayment = AppConfig.baseUrl + '/api/payment/fail';

  static final AppConfig _instance = AppConfig._internal();

  static final formatDate = "dd-MM-yyyy HH:mm";

  static final userRole = 0;

  static final clientRole = 1;

  factory AppConfig() {
    return _instance;
  }

  AppConfig._internal();
}
