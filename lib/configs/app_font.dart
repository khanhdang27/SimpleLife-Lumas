import 'dart:ui';

class AppFont {
  //Font Family
  static String inter = "Inter";

  //Font weight
  static FontWeight wThin = FontWeight.w100;
  static FontWeight wExtraLight = FontWeight.w200;
  static FontWeight wLight = FontWeight.w300;
  static FontWeight wRegular = FontWeight.w400;
  static FontWeight wMedium = FontWeight.w500;
  static FontWeight wSemiBold = FontWeight.w600;
  static FontWeight wBold = FontWeight.w700;
  static FontWeight wExtraBold = FontWeight.w800;
  static FontWeight wBlack = FontWeight.w900;

  static final AppFont _instance = AppFont._internal();

  factory AppFont() {
    return _instance;
  }

  AppFont._internal();
}
