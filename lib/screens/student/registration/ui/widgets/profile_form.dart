import 'package:emc/screens/student/registration/model/view_model/registration_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import '../../constant.dart';
import 'dart:io';
import 'dart:developer';

class ProfileForm extends StatefulWidget {
  @required
  final GlobalKey<FormBuilderState> formKey;
  final bool shouldAutovalidate;
  final RegistrationModel registrationModel;
  ProfileForm({this.formKey, this.shouldAutovalidate = false, this.registrationModel}) : assert(formKey != null);

  @override
  _ProfileFormState createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  File _image;
  Future getImage(dynamic state) async {
    EasyLoading.show();
    File image;
    await ImagePicker().getImage(source: ImageSource.camera).then((pickedFile) async {
      await ImageCropper.cropImage(
        sourcePath: pickedFile?.path,
        maxHeight: 500,
        maxWidth: 500,
        aspectRatio: CropAspectRatio(
          ratioX: 1,
          ratioY: 1,
        ),
      ).then((croppedImage) {
        print("then called ${croppedImage?.path ?? 'trojan niggahorse'}");
        image = File(croppedImage?.path);
      });
    }).catchError((error) => EasyLoading.showError("Error: $error"));

    if (image != null) {
      setState(() {
        state.didChange(_image);
        _image = image;
      });
    }
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: widget.formKey,
      autovalidateMode: (widget?.shouldAutovalidate ?? false) ? AutovalidateMode.always : AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          FormBuilderField(
            name: ProfileFormField.PROFILE_PICTURE,
            builder: (state) {
              return CircleAvatar(
                radius: 60,
                child: Stack(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await getImage(state);
                      },
                      child: ClipOval(
                        child: _image == null ? Image.asset('assets/images/default_avatar.png') : Image.file(_image),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: -10,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<CircleBorder>(CircleBorder()),
                        ),
                        onPressed: () async {
                          await getImage(state);
                        },
                        child: Icon(Icons.camera_alt),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          SizedBox(height: 20),
          FormBuilderTextField(
            name: ProfileFormField.NAME,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(context),
            ]),
            decoration: InputDecoration(
              isDense: true,
              border: new OutlineInputBorder(),
              labelText: "Name",
            ),
          ),
          SizedBox(height: 8),
          FormBuilderTextField(
            name: ProfileFormField.MATRIC,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(context),
            ]),
            decoration: InputDecoration(
              isDense: true,
              border: OutlineInputBorder(),
              labelText: "Matric",
            ),
          ),
          // FormBuilderDateTimePicker(
            
          // ),
        ],
      ),
    );
  }
}
