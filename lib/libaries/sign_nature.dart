import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:lumas/general/general.dart';
import 'package:signature/signature.dart';
import 'package:get/get.dart';

class SignNature extends StatelessWidget{
  dynamic _controller = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  ).obs;

  UserController userController = Get.find<UserController>();
  final String type;

  SignNature({required this.type});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Signature(
          controller: _controller.value,
          backgroundColor: Colors.white,
        ),
        Container(
          decoration: const BoxDecoration(color: Colors.black),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              //SHOW EXPORTED IMAGE IN NEW ROUTE
              IconButton(
                icon: const Icon(Icons.check),
                color: Colors.green,
                onPressed: () async {
                  if (_controller.value.isNotEmpty) {
                    final Uint8List? data = await exportSignature();
                    if (data != null) {
                      await Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) {
                            return Scaffold(
                              appBar: AppBar(
                                actions: [
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: GestureDetector(
                                      child: Text('done'.tr, style: TextStyle(fontSize: 20)),
                                      onTap: (){
                                        userController.postESignProductUsing(
                                          type: type,
                                          code: userController.codeProduct.value,
                                          userId: userController.user.id,
                                          signature: data
                                        );
                                      },
                                    ),
                                  )
                                ],
                              ),
                              body: Center(
                                child: Container(
                                  color: Colors.grey[300],
                                  child: Image.memory(data),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                  }
                },
              ),
              //CLEAR CANVAS
              IconButton(
                icon: const Icon(Icons.clear),
                color: Colors.red,
                onPressed: () {
                  _controller..value.clear();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<Uint8List?> exportSignature() async {
    final exportController = SignatureController(
      penStrokeWidth: 5,
      penColor: Colors.black,
      exportBackgroundColor: Colors.white,
      points: _controller.value.points,
    );

    final signature = await exportController.toPngBytes();
    exportController.dispose();

    return signature;
  }
}