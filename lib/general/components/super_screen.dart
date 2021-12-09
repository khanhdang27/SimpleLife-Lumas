import 'package:flutter/material.dart';

class SuperScreen extends StatelessWidget {
  final Widget child;

  SuperScreen({required this.child});

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
