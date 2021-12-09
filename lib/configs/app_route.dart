import 'package:lumas/general/screens.dart';

class AppRoute {
  static const NOT_CONNECT_SCREEN = '/not-connect';
  static const SCAN_QR_CODE_SCREEN = '/scan-qr';
  static const CLIENT_HOME = '/client/home';
  static const CLIENT_LOGIN = '/client/login';
  static const CLIENT_SIGNUP = '/client/signup';
  static const CLIENT_FORGOT = '/client/forgot';
  static const CLIENT_PROFILE = '/client/profile';
  static const USER_LOGIN = '/user/login';
  static const USER_HOME = '/user/home';
  static const USER_PROFILE = '/user/profile';
  static const USER_FORGOT = '/user/forgot';
  static const APPOINTMENT_DETAIL = '/appointment/detail';
  static const CLIENT_SIGNUP_SUCCESS = '/client/signupSuccess';
  static const SERVICE_LIST = '/client/service/list';
  static const SERVICE_DETAIL = '/client/service/detail';
  static const SERVICE_OTHER_DETAIL = '/client/service/order-detail';
  static const SERVICE_TYPE_LIST = '/client/service/type/list';
  static const COURSE_LIST = '/client/course/list';
  static const COURSE_DETAIL = '/client/course/detail';
  static const COURSE_OTHER_DETAIL = '/client/course/order-detail';
  static const COURSE_CATE_LIST = '/client/course/category/list';
  static const SETTING = '/client/setting';
  static const CLIENT_PAID_PRODUCT = '/client/paid-product';
  static const CLIENT_SERVICE_LIST = '/client/paid-service/list';
  static const CLIENT_SERVICE_DETAIL = '/client/paid-service/detail';
  static const CLIENT_COURSE_LIST = '/client/paid_course/list';
  static const CLIENT_COURSE_DETAIL = '/client/paid-course/detail';
  static const CLIENT_ORDER = '/client/order';
  static const CLIENT_ORDER_DETAIL = '/client/order/detail';
  static const CLIENT_PIN_CODE = '/client/pin-code';

  static const INITIAL = CLIENT_HOME;

  static final routes = {
    NOT_CONNECT_SCREEN: (context) => NotConnectScreen(),
    SCAN_QR_CODE_SCREEN: (context) => ScanQRCodeScreen(),
    CLIENT_HOME: (context) => ClientHomeScreen(),
    CLIENT_LOGIN: (context) => ClientLoginScreen(),
    CLIENT_SIGNUP: (context) => ClientSignupScreen(),
    CLIENT_FORGOT: (context) => ClientForgotPwScreen(),
    CLIENT_PROFILE: (context) => ClientProfileScreen(),
    USER_LOGIN: (context) => UserLoginScreen(),
    USER_HOME: (context) => UserHomeScreen(),
    USER_PROFILE: (context) => UserProfileScreen(),
    USER_FORGOT: (context) => UserForgotPwScreen(),
    APPOINTMENT_DETAIL: (context) => AppointmentDetailScreen(),
    CLIENT_SIGNUP_SUCCESS: (context) => ClientSignupSuccessScreen(),
    SERVICE_LIST: (context) => ServiceListScreen(),
    SERVICE_DETAIL: (context) => ServiceDetailScreen(),
    SERVICE_OTHER_DETAIL: (context) => ServiceDetailScreen(),
    SERVICE_TYPE_LIST: (context) => ServiceTypeListScreen(),
    COURSE_LIST: (context) => CourseListScreen(),
    COURSE_DETAIL: (context) => CourseDetailScreen(),
    COURSE_OTHER_DETAIL: (context) => CourseDetailScreen(),
    COURSE_CATE_LIST: (context) => CourseCategoryListScreen(),
    SETTING: (context) => SettingIndexScreen(),
    CLIENT_PAID_PRODUCT: (context) => PaidProductScreen(),
    CLIENT_SERVICE_LIST: (context) => PaidServiceListScreen(),
    CLIENT_SERVICE_DETAIL: (context) => PaidServiceDetailScreen(),
    CLIENT_COURSE_LIST: (context) => PaidCourseListScreen(),
    CLIENT_COURSE_DETAIL: (context) => PaidCourseDetailScreen(),
    CLIENT_ORDER: (context) => OrderScreen(),
    CLIENT_ORDER_DETAIL: (context) => OrderDetailScreen(),
    CLIENT_PIN_CODE: (context) => ClientPinCodeScreen(),
  };
  static final AppRoute _instance = AppRoute._internal();

  factory AppRoute() {
    return _instance;
  }

  AppRoute._internal();
}
