import 'package:flutter/cupertino.dart';

class FormGroup extends StatelessWidget{
  final Text label;
  final Widget value;

  FormGroup({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(child: label),
        Container(child: value),
      ],
    );
  }

}