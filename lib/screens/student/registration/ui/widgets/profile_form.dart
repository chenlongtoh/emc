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

  Future _onUploadImage(FormFieldState<dynamic> field) async {
    return showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        return ListView(
          shrinkWrap: true,
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text("Take a photo"),
              onTap: () async {
                final File image = await getImage(ImageSource.camera);
                if (image != null) {
                  field.didChange(image);
                  setState(() => _image = image);
                }
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.image),
              title: Text("Pick from gallery"),
              onTap: () async {
                final File image = await getImage(ImageSource.gallery);
                if (image != null) {
                  field.didChange(image);
                  setState(() => _image = image);
                }
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future getImage(ImageSource source) async {
    EasyLoading.show();
    File image;
    await ImagePicker().getImage(source: source).then((pickedFile) async {
      await ImageCropper.cropImage(
        sourcePath: pickedFile?.path,
        maxHeight: 500,
        maxWidth: 500,
        aspectRatio: CropAspectRatio(
          ratioX: 1,
          ratioY: 1,
        ),
      ).then((croppedImage) {
        image = File(croppedImage?.path);
      });
    }).catchError((_) => EasyLoading.dismiss());
    EasyLoading.dismiss();
    return image;
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
            builder: (FormFieldState<dynamic> field) {
              return CircleAvatar(
                radius: 60,
                child: Stack(
                  children: [
                    GestureDetector(
                      onTap: () => _onUploadImage(field),
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
                        onPressed: () => _onUploadImage(field),
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
              errorMaxLines: 2,
            ),
          ),
          SizedBox(height: 8),
          FormBuilderTextField(
            name: ProfileFormField.MATRIC,
            textCapitalization: TextCapitalization.characters,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(context),
            ]),
            decoration: InputDecoration(
              isDense: true,
              border: OutlineInputBorder(),
              labelText: "Matric",
              errorMaxLines: 2,
            ),
          ),
          // FormBuilderDateTimePicker(

          // ),
        ],
      ),
    );
  }
}
