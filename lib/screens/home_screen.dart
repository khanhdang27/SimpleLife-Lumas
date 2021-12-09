import 'package:flutter/material.dart';
import 'package:lumas/general/configs.dart';
import 'package:get/get.dart';
import 'package:lumas/general/screens.dart';

class HomeScreen1 extends StatefulWidget {
  const HomeScreen1({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen1> {
  String _selectedLang = LocalizationService.locale!.languageCode;

  @override
  Widget build(BuildContext context) {
    return Layout(
      header: AppBar(title: Text('Home'.tr),),
      child: Container(
        child: Center(
          child: DropdownButton<String>(
            icon: Icon(Icons.arrow_drop_down),
            value: _selectedLang,
            items: _buildDropdownMenuItems(),
            onChanged: (value) {
              setState(() => _selectedLang = value!);
              LocalizationService.changeLocale(value!);
            },
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> _buildDropdownMenuItems() {
    var list = <DropdownMenuItem<String>>[];
    LocalizationService.langs.forEach((key, value) {
      list.add(DropdownMenuItem<String>(
        value: key,
        child: Text(key),
      ));
    });
    return list;
  }
}