import 'package:lumas/general/configs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lumas/general/validatetion/validation.dart';

class Input extends StatefulWidget {
  final TextEditingController txtController;
  final String label;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? errorText;
  final ValueChanged<String>? onSubmitted;

  Input({
    this.obscureText = false,
    required this.txtController,
    required this.label,
    this.keyboardType,
    this.errorText,
    this.onSubmitted,
  });

  @override
  State<StatefulWidget> createState() {
    return _InputState();
  }
}

class _InputState extends State<Input> {
  late FocusNode _focusNode;
  bool _isFocussing = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus != _isFocussing) {
        setState(() {
          _isFocussing = _focusNode.hasFocus;
        });
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.txtController,
      obscureText: widget.obscureText,
      focusNode: _focusNode,
      keyboardType: widget.keyboardType,
      style: TextStyle(
        color: AppColor.blackMain,
        fontWeight: AppFont.wMedium,
        fontSize: 25,
      ),
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: TextStyle(
          fontWeight: AppFont.wLight,
          fontSize: 20,
          color: _isFocussing ? AppColor.pinkPrimary : AppColor.blackMain,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.pinkPrimary,

          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.pinkPrimary,
          ),
        ),
        errorText: widget.errorText ?? null,
      ),
      onSubmitted: widget.onSubmitted,
    );
  }
}



class InputFormLogin extends StatelessWidget{
  final bool obscureText;
  final String label;
  final TextEditingController txtController;
  final rules;
  final TextInputType keyboardType;
  final errorText;
  final suffixIcon;

  InputFormLogin({
    Key? key,
    this.obscureText = false,
    required this.label,
    required this.txtController,
    required this.rules,
    this.keyboardType = TextInputType.text,
    this.errorText,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    Validation validate = Validation();

    return TextFormField(
      key: key,
      controller: txtController,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: TextStyle(
        color: AppColor.blackPrimary,
        fontWeight: AppFont.wMedium,
        fontSize: 24,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          fontWeight: AppFont.wMedium,
          fontSize: 20,
          color: AppColor.pinkPrimary,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.pinkPrimary,
          ),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.blackPrimary,
          ),
        ),
        errorText: errorText,
        errorStyle: TextStyle(
          fontSize: 14.0,
        ),
        suffixIcon: suffixIcon,
      ),
      validator: (value){
        return validate.validator(rules, value);
      },
    );
  }


}