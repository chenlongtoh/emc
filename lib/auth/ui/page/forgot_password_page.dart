import 'dart:developer';

import 'package:emc/auth/model/view_model/auth_model.dart';
import 'package:emc/common_widget/emc_scaffold.dart';
import 'package:emc/util/form_util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

import '../../constant.dart';

class ForgotPasswordPage extends StatefulWidget {
  static const String routeName = "/forgotPasswordPage";

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  AuthModel authModel;
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;
  GlobalKey<FormBuilderState> _fbKey = new GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
    authModel = Provider.of<AuthModel>(context, listen: false);
  }

  Future _resetPassword() async {
    if (_fbKey.currentState.saveAndValidate()) {
      try {
        EasyLoading.show();
        await FirebaseAuth.instance.sendPasswordResetEmail(email: FormUtil.getFormValue(_fbKey, ForgotPasswordForm.EMAIL)).then((_) {
          Navigator.pop(context);
          EasyLoading.showSuccess("Password has already reset, please check your email");
        });
      } on FirebaseException catch (error) {
        EasyLoading.showError("Error => ${error.message}");
        log("Error @ sendPasswordResetEmail => ${error.message}");
      } catch (error) {
        EasyLoading.showError("Error => $error");
        log("Error @ sendPasswordResetEmail => $error");
      }
    } else {
      setState(() => _autoValidateMode = AutovalidateMode.always);
    }
  }

  @override
  Widget build(BuildContext context) {
    return EmcScaffold(
      appBar: AppBar(title: Text("Reset Password")),
      body: FormBuilder(
        autovalidateMode: _autoValidateMode,
        key: _fbKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          children: [
            Text(
              "Reset Password",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Enter your email address below to reset password",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 15,
              ),
            ),
            SizedBox(height: 20),
            FormBuilderTextField(
              name: ForgotPasswordForm.EMAIL,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(context),
                FormBuilderValidators.email(context),
              ]),
              decoration: InputDecoration(
                hintText: "Email",
                isDense: true,
                border: new OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 25),
            ElevatedButton(
              onPressed: _resetPassword,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(vertical: 15)),
              ),
              child: Text(
                "Reset Password",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
