import 'package:emc/auth/model/view_model/auth_model.dart';
import 'package:emc/util/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:emc/auth/constant.dart';
import 'package:provider/provider.dart';
import 'package:emc/common_widget/emc_scaffold.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  Future _login() async {
    if (_fbKey?.currentState?.saveAndValidate() ?? false) {
      final String email = _fbKey?.currentState?.value[LoginForm.EMAIL] ?? "";
      final String password = _fbKey?.currentState?.value[LoginForm.PASSWORD] ?? "";
      final AuthModel authModel = Provider.of<AuthModel>(context, listen: false);
      await authModel.login(
        email: email,
        password: password,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return EmcScaffold(
      maskBackground: false,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
        child: FormBuilder(
          key: _fbKey,
          autovalidateMode: AutovalidateMode.disabled,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(60, 80, 60, 20),
            children: [
              Image.asset(
                "assets/images/logo.png",
                height: 110,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  bottom: 40,
                ),
                child: Text(
                  "Emotion Chatbot Analyzer",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
              ),
              FormBuilderTextField(
                name: LoginForm.EMAIL,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(context),
                  FormBuilderValidators.email(context),
                ]),
                decoration: InputDecoration(
                  hintText: "Email",
                  isDense: true,
                  border: new OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
              SizedBox(height: 10),
              FormBuilderTextField(
                name: LoginForm.PASSWORD,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(context),
                  FormBuilderValidators.minLength(context, 7),
                ]),
                decoration: InputDecoration(
                  hintText: "Password",
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
              SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: _login,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  child: Text(
                    "Login",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: TextButton(
                  child: Text(
                    "Forgot Password",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                  ),
                  onPressed: () => Navigator.pushNamed(context, EmcRoutes.registerScreen),
                ),
              ),
              Center(
                child: TextButton(
                  child: Text(
                    "Create an account",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                  ),
                  onPressed: () => Navigator.pushNamed(context, EmcRoutes.registerScreen),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
