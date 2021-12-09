import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lumas/general/general.dart';

class ChangeLocale extends GetWidget<SettingController> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      icon: Icon(Icons.arrow_drop_down, color: AppColor.pinkPrimary),
      value: Storage.getLanguage() ?? "en",
      items: _buildDropdownMenuItems(),
      onChanged: (value) {
        Storage.setLanguage(value!);
        LocalizationService.changeLocale(value);
      },
    );
  }

  List<DropdownMenuItem<String>> _buildDropdownMenuItems() {
    var list = <DropdownMenuItem<String>>[];
    LocalizationService.langs.forEach((key, value) {
      list.add(DropdownMenuItem<String>(
        value: key,
        child: Text(value, style: TextStyle(color: AppColor.pinkPrimary)),
      ));
    });
    return list;
  }
}
