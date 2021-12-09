import 'package:flutter/material.dart';
import 'package:lumas/general/general.dart';
import 'package:get/get.dart';

class NotConnectScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Layout(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.9,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text('noInternet'.tr, style: TextStyle(fontSize: 50.0)),
            ),
            Center(child: Image.asset(AppAsset.noInternet, width: 500))
          ]
        ),
      )
    );
  }

}
