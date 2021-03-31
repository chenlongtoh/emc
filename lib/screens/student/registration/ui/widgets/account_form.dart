import 'package:emc/util/form_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../../constant.dart';

class AccountForm extends StatelessWidget {
  @required
  final GlobalKey<FormBuilderState> formKey;
  final bool shouldAutovalidate;
  AccountForm({this.formKey, this.shouldAutovalidate = false}) : assert(formKey != null);

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: formKey,
      autovalidateMode: shouldAutovalidate ? AutovalidateMode.always : AutovalidateMode.disabled,
      child: Column(
        children: [
          SizedBox(height: 10),
          FormBuilderTextField(
            name: AccountFormField.EMAIL,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(context),
              FormBuilderValidators.email(context),
            ]),
            decoration: InputDecoration(
              labelText: "Email",
              isDense: true,
              border: new OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 10),
          FormBuilderTextField(
            name: AccountFormField.PASSWORD,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(context),
              FormBuilderValidators.minLength(context, 8),
            ]),
            decoration: InputDecoration(
              labelText: "Password",
              isDense: true,
              border: new OutlineInputBorder(),
            ),
            obscureText: true,
          ),
          SizedBox(height: 10),
          FormBuilderTextField(
            name: AccountFormField.CONFIRM_PASSWORD,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(context),
              FormBuilderValidators.minLength(context, 8),
              (value) {
                if (value == FormUtil.getFormValue(formKey, AccountFormField.PASSWORD)) {
                  return null;
                }
                return "Password mismatched, please try again";
              }
            ]),
            decoration: InputDecoration(
              labelText: "Confirm Password",
              isDense: true,
              border: new OutlineInputBorder(),
            ),
            obscureText: true,
          ),
        ],
      ),
    );
  }
}
