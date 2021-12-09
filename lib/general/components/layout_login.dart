import 'package:lumas/general/configs.dart';
import 'package:lumas/general/components/components.dart';
import 'package:lumas/general/components/login/login_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LayoutLogin extends StatelessWidget {
  final Widget child;

  const LayoutLogin({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SuperScreen(
      child: Container(
        child: SafeArea(
          child: Scaffold(
            appBar: HeaderLogin(),
            backgroundColor: AppColor.whiteMain,
            body: SingleChildScrollView(
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
