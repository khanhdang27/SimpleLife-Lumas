import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lumas/general/general.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:get/get.dart';

class ScanQRCode extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<ScanQRCode> {
  UserController userController = Get.find<UserController>();
  dynamic? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutSecond(
      child: Stack(
        children: <Widget>[
          _buildQrView(context),
          FittedBox(
            fit: BoxFit.contain,
            child: Container(
              margin: EdgeInsets.all(8),
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Color(0x59ffffff)),
                  ),
                  onPressed: () async {
                    await controller?.flipCamera();
                    setState(() {});
                  },
                  child: FutureBuilder(
                    future: controller?.getCameraInfo(),
                    builder: (context, snapshot) {
                      if (snapshot.data != null) {
                        // print(describeEnum(snapshot.data!));
                      }

                      return Icon(Icons.autorenew);
                    },
                  )
              ),
            ),
          )
        ],
      )
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
        MediaQuery.of(context).size.height < 400)
        ? 250.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) async {
      if(result == null && scanData != result) {
        setState(() {
          result = scanData;
        });
        if (scanData.code != null) {
          dynamic resultData;
          resultData = await userController.postScanUse(scanData.code);
          if(resultData != null){
            Get.defaultDialog(
                title: "scanFailed".tr,
                middleText: resultData.toString(),
                backgroundColor: AppColor.pinkPrimary,
                titleStyle: TextStyle(color: Colors.white),
                middleTextStyle: TextStyle(color: Colors.white),
                barrierDismissible: false,
                confirm:  AppBtn(
                  child: Text('OK'),
                  callback: () {
                    setState(() {
                      result = null;
                    });
                    Get.back();
                  },
                )
            );
          }
          else {
            Get.defaultDialog(
                title: "scanSuccess".tr,
                middleText: scanData.code,
                backgroundColor: AppColor.pinkPrimary,
                titleStyle: TextStyle(color: Colors.white),
                middleTextStyle: TextStyle(color: Colors.white),
                barrierDismissible: false,
                confirm: AppBtn(
                  child: Text('OK'),
                  callback: () {
                    setState(() {
                      result = null;
                    });
                    controller.stopCamera();
                    userController.getListProductInProgress();
                    Get.to(() => UserHomeScreen(selectedPage: 2));
                  },
                )
            );
          }
        }
      }
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}