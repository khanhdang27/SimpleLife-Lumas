import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Validation {
  static const required = "required";
  static const email = "email";

  /// Validate Handle
  String? validator(List validates, value) {
    if (validates.isNotEmpty) {
      for(final validate in validates){
        /** Required */
        if (validate == required && value.isEmpty) {
            return 'requiredValid'.tr;
        }

        /** Email Format */
        if (validate == email && !GetUtils.isEmail(value)) {
            return 'emailValid'.tr;
        }
      }
    }

    return null;
  }
}