import 'package:emc/screens/student/registration/constant.dart';
import 'package:emc/screens/student/registration/model/view_model/registration_model.dart';
import 'package:emc/util/form_util.dart';
import 'package:flutter/material.dart';
import '../widgets/profile_form.dart';
import '../widgets/account_form.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:emc/common_widget/emc_scaffold.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormBuilderState> _accountFormKey = GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> _profileFormKey = GlobalKey<FormBuilderState>();
  RegistrationModel registrationModel;
  bool isInit = true;
  bool _accountFormAutovalidate = false;
  bool _profileFormAutovalidate = false;
  int _currentStep = 0;

  @override
  void initState(){
    super.initState();
    registrationModel = new RegistrationModel();
  }

  void _onStepContinue() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    setState(() {
      if (_currentStep == 0) {
        if (_accountFormKey.currentState?.saveAndValidate() ?? false) {
          _currentStep = 1;
        } else {
          _accountFormAutovalidate = true;
        }
      } else if (_currentStep == 1) {
        if (_profileFormKey.currentState?.saveAndValidate() ?? false) {
          if (_accountFormKey.currentState?.saveAndValidate() ?? false) {
            print("_accountFormKey => ${_accountFormKey?.currentState?.value}");
            print("_profileFormKey => ${_profileFormKey?.currentState?.value}");
            registrationModel.register(
              email: FormUtil.getFormValue(_accountFormKey, AccountFormField.EMAIL),
              password : FormUtil.getFormValue(_accountFormKey, AccountFormField.PASSWORD),
              matric : FormUtil.getFormValue(_profileFormKey, ProfileFormField.MATRIC),
              name : FormUtil.getFormValue(_profileFormKey, ProfileFormField.NAME),
            );
          } else {
            _currentStep = 0;
          }
        } else {
          _profileFormAutovalidate = true;
        }
      }
      isInit = false;
    });
  }

  StepState _getStepState(formKey) {
    return isInit
        ? StepState.indexed
        : formKey?.currentState?.saveAndValidate() ?? false
            ? StepState.complete
            : StepState.indexed;
  }

  @override
  Widget build(BuildContext context) {
    return EmcScaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
        child: Stepper(
          physics: ScrollPhysics(),
          currentStep: _currentStep,
          controlsBuilder: (BuildContext context, {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
            return Container(
              margin: const EdgeInsets.only(top: 16.0),
              child: ConstrainedBox(
                constraints: const BoxConstraints.tightFor(height: 48.0),
                child: ElevatedButton(
                  onPressed: _onStepContinue,
                  child: Text(
                    "Continue",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  ),
                ),
              ),
            );
          },
          onStepTapped: (step) => setState(() => _currentStep = step),
          steps: [
            Step(
              content: AccountForm(
                formKey: _accountFormKey,
                shouldAutovalidate: _accountFormAutovalidate,
              ),
              isActive: true,
              title: Text("Step 1"),
              subtitle: Text("Create An Account"),
              state: _getStepState(_accountFormKey),
            ),
            Step(
              content: ProfileForm(
                formKey: _profileFormKey,
                shouldAutovalidate: _profileFormAutovalidate,
                registrationModel: registrationModel,
              ),
              isActive: true,
              title: Text("Step 2"),
              subtitle: Text("Create Your Profile"),
              state: _getStepState(_profileFormKey),
            ),
          ],
        ),
      ),
    );
  }
}
