import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/widgets.dart';
import 'package:lumas/general/general.dart';

class ClientAvatar extends GetWidget<ClientController> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Center(
        child: SizedBox(
          width: 140.0,
          height: 140.0,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Obx(() {
                if (controller.isLoading.value) {}
                var avatar = (controller.client.avatar == null)
                    ? "https://cdn.icon-icons.com/icons2/2506/PNG/512/user_icon_150670.png"
                    : AppConfig.baseUrl + "/storage/" + controller.client.avatar;
                return CircleAvatar(
                  backgroundColor: AppColor.whiteMain,
                  backgroundImage: NetworkImage('$avatar'),
                );
              }),
              Positioned(
                  bottom: 0,
                  right: 6,
                  child: Container(
                    width: 40,
                    height: 40,
                    child: FloatingActionButton(
                        backgroundColor: AppColor.pinkPrimary,
                        child: ClipOval(
                          child: Container(
                              padding: EdgeInsets.all(9),
                              color: AppColor.whiteMain,
                              child: Icon(Icons.edit, size: 18, color: AppColor.pinkPrimary)
                          ),
                        ),
                        onPressed: () async {
                          File? file = await PickCropImage.getFile();
                          if (file != null)
                            return controller.updateAvatar(file);
                          // getImage(imageSource.value);
                        }
                    ),
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}