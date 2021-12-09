import 'package:flutter/material.dart';
import 'package:lumas/general/validatetion/validation.dart';
import 'package:lumas/general/configs.dart';
import 'package:flutter/cupertino.dart';

class InputForm extends StatelessWidget{
  final bool obscureText;
  final TextEditingController? txtController;
  final List? rules;
  final TextInputType keyboardType;
  final errorText;
  final suffixIcon;
  final bool enabled;
  final String? placehoder;

  InputForm({
    Key? key,
    this.obscureText = false,
    this.txtController,
    required this.rules,
    this.keyboardType = TextInputType.text,
    this.errorText,
    this.suffixIcon,
    this.enabled = true,
    this.placehoder,
  });

  @override
  Widget build(BuildContext context) {
    Validation validate = Validation();

    return TextFormField(
      key: key,
      enabled: enabled,
      controller: txtController,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: TextStyle(
        color: AppColor.blackPrimary,
        fontWeight: AppFont.wMedium,
        fontSize: 20,
      ),
      decoration: InputDecoration(
        hintText: placehoder,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.pinkPrimary,
          ),
        ),
        errorText: errorText ?? null,
        errorStyle: TextStyle(
          fontSize: 14.0,
        ),
        suffixIcon: suffixIcon,
      ),
      validator: (value){
        return validate.validator(rules!, value);
      },
    );
  }


}