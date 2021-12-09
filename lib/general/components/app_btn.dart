import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lumas/general/configs.dart';

class AppBtn extends StatelessWidget {
  final Widget? child;
  final VoidCallback? callback;
  final Icon? icon;
  final double? width;
  final double? height;
  final BorderSide? borderSide;
  final double? borderRadius;
  final Color? color;
  final Color? splashColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsets? margin;

  AppBtn({
    Key? key,
    this.child,
    this.callback,
    this.icon,
    this.width,
    this.height,
    this.borderSide,
    this.color,
    this.padding,
    this.splashColor,
    this.borderRadius,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: width ?? 100,
      height: height,
      margin: margin,
      duration: const Duration(seconds: 2),
      curve: Curves.easeIn,
      child: Material(
        color: color,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 20),
          side: borderSide ?? BorderSide(
            color: Colors.transparent
          )
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          splashColor: splashColor ?? AppColor.pinkSecondary,
          child: Padding(
            padding: padding ?? EdgeInsets.all(8.0),
            child: Center(child: child),
          ),
          onTap: callback ?? (){},
        ),
      ),
    );
  }
}
