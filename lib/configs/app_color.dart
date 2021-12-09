import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppColor {
  static Color pinkPrimary = Color.fromRGBO(239, 166, 161, 1.0);
  static Color pinkSecondary = Color.fromRGBO(255, 204, 200, 1.0);
  static Color blackPrimary = Color.fromRGBO(132, 132, 132, 1.0);
  static Color blackMain = Color.fromRGBO(0, 0, 0, 1.0);
  static Color whiteMain = Color.fromRGBO(255, 255, 255, 1);
  static Color danger = Color.fromRGBO(255, 0, 0, 1.0);
  static Color silverMain = Color.fromRGBO(243, 242, 248, 1.0);
  static Color courseColor = Color.fromRGBO(255, 171, 135, 1.0);
  static Color courseTextColor =  Color(0xFFBF360C);
  static Color serviceColor = Color.fromRGBO(252, 140, 132, 1.0);
  static Color serviceTextColor =  Color.fromRGBO(255, 144, 137, 1.0);

  /// Appointment colors
  static Color completedAppointment = Color.fromRGBO(0, 194, 146, 1.0);
  static Color abortAppointment = Color.fromRGBO(255, 0, 0, 1.0);
  static Color waitingAppointment = Color.fromRGBO(23, 162, 184, 1.0);
  static Color progressingAppointment = Color.fromRGBO(255, 193, 7, 1.0);
  /// Status
  static Color paid = Color.fromRGBO(40, 167, 69, 1.0);



  static final AppColor _instance = AppColor._internal();

  factory AppColor() {
    return _instance;
  }

  AppColor._internal();
}
