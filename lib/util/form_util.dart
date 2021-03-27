import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormUtil {
  static dynamic getFormValue(GlobalKey<FormBuilderState> formKey, String key) {
    return (formKey?.currentState?.value ?? const {})[key];
  }
}
