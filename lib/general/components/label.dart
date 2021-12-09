import 'package:flutter/material.dart';

class Label extends StatelessWidget{
  final Widget? icon;
  final String text;
  final TextStyle? style;

  Label({this.icon, required this.text, this.style});

  @override
  Widget build(BuildContext context) {
    if(icon != null){
      return RichText(
        text: TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: [
            WidgetSpan(child: icon!),
            TextSpan(text:  " "+text, style: style)
          ],
        ),
      );
    }

    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: [
          TextSpan(text: text, style: style)
        ],
      ),
    );
  }
}