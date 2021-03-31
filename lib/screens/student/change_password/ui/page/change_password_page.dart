import 'package:emc/auth/model/view_model/auth_model.dart';
import 'package:emc/common_widget/emc_button.dart';
import 'package:emc/common_widget/emc_scaffold.dart';
import 'package:emc/screens/student/change_password/constant.dart';
import 'package:emc/screens/student/change_password/service/change_password_service.dart';
import 'package:emc/util/form_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class ChangePasswordPage extends StatefulWidget {
  static const routeName = "/changePasswordPage";
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final GlobalKey<FormBuilderState> _fbKey = new GlobalKey<FormBuilderState>();
  bool _shouldAutovalidate = false;

  void _onSubmit() async {
    EasyLoading.show();
    if (_fbKey.currentState.saveAndValidate()) {
      final String oldPassword = FormUtil.getFormValue(
        _fbKey,
        ChangePasswordFormField.OLD_PASSWORD,
      );
      final String newPassword = FormUtil.getFormValue(
        _fbKey,
        ChangePasswordFormField.NEW_PASSWORD,
      );
      await ChangePasswordService.changePassword(oldPassword, newPassword).then(
        (success) async {
          if (success) {
            AuthModel authModel = Provider.of<AuthModel>(context, listen: false);
            await authModel.logout().then((_) {
              Navigator.pop(context, (route) => route.isFirst);
              EasyLoading.showSuccess("Your password is changed successfully, please login again");
            });
            return;
          }
        },
      );
      setState(() => _shouldAutovalidate = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return EmcScaffold(
      appBar: AppBar(
        title: Text("Change Password"),
      ),
      body: FormBuilder(
        key: _fbKey,
        autovalidateMode: _shouldAutovalidate ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          children: [
            SizedBox(height: 10),
            FormBuilderTextField(
              name: ChangePasswordFormField.OLD_PASSWORD,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(context),
                FormBuilderValidators.minLength(context, 8),
              ]),
              decoration: InputDecoration(
                hintText: "Current Password",
                isDense: true,
                border: new OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide.none,
                ),
                fillColor: Colors.white,
                filled: true,
              ),
              obscureText: true,
            ),
            SizedBox(height: 10),
            FormBuilderTextField(
              name: ChangePasswordFormField.NEW_PASSWORD,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(context),
                FormBuilderValidators.minLength(context, 8),
              ]),
              decoration: InputDecoration(
                hintText: "New Password",
                isDense: true,
                border: new OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide.none,
                ),
                fillColor: Colors.white,
                filled: true,
              ),
              obscureText: true,
            ),
            SizedBox(height: 10),
            FormBuilderTextField(
              name: ChangePasswordFormField.CONFIRM_PASSWORD,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(context),
                FormBuilderValidators.minLength(context, 8),
                (value) {
                  if (value == FormUtil.getFormValue(_fbKey, ChangePasswordFormField.CONFIRM_PASSWORD)) {
                    return null;
                  }
                  return "Password mismatched, please try again";
                }
              ]),
              decoration: InputDecoration(
                hintText: "Confirm Password",
                isDense: true,
                border: new OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide.none,
                ),
                fillColor: Colors.white,
                filled: true,
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            Center(
              child: EmcButton(
                text: "Submit",
                onPressed: _onSubmit,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
