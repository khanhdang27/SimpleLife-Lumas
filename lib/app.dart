import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lumas/general/configs.dart';
import 'package:lumas/general/services.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'LUMAS',
      theme: AppTheme().generateTheme(),
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      locale: Storage.getLanguage() == 'zh' ? Locale('zh') : Locale('en','US'),
      fallbackLocale: LocalizationService.fallbackLocale,
      translations: LocalizationService(),
      initialRoute: AuthService().setInitialRoute(),
      routes: AppRoute.routes,
      initialBinding: AppBinding(),
    );
  }
}
class IgnoreCertificateErrorOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = ((X509Certificate cert, String host, int port) {
        return true;
      });
  }
}
