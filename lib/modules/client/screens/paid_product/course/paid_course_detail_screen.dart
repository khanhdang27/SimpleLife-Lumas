import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lumas/general/general.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PaidCourseDetailScreen extends GetWidget<ClientController>{
  @override
  Widget build(BuildContext context) {
    var maxHeight = MediaQuery.of(context).size.height * 0.9;
    print(controller.course.code);
    return Layout(
      header: AppBar(
        title: Text('${controller.course.course.name}'),
      ),
      child: Container(
        height: maxHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Label(
                text: "${controller.course.code}",
                style: TextStyle(fontSize: 30),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: QrImage(
                data: "${controller.course.code}",
                version: QrVersions.auto,
                size: 320,
                gapless: false,
              ),
            ),
          ],
        ),
      )
    );
  }

}