import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppTabController extends GetxController with SingleGetTickerProviderMixin {
  final List<Tab> tabs = <Tab>[
    Tab(text: 'LEFT'),
    Tab(text: 'RIGHT'),
  ];

  late TabController controller;

  @override
  void onInit() {
    super.onInit();
    controller = TabController(vsync: this, length: tabs.length);
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
}