import 'dart:developer';
import 'dart:io';

import 'package:emc/auth/model/view_model/auth_model.dart';
import 'package:emc/common_widget/emc_button.dart';
import 'package:emc/common_widget/emc_scaffold.dart';
import 'package:emc/screens/student/profile/service/student_profile_service.dart';
import 'package:emc/util/form_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../constant.dart';

class UpdateProfilePage extends StatefulWidget {
  static const routeName = "/studentUpdateProfilePage";

  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  GlobalKey<FormBuilderState> _fbKey;
  AuthModel authModel;
  File _image;

  @override
  void initState() {
    super.initState();
    _fbKey = new GlobalKey<FormBuilderState>();
    authModel = Provider.of<AuthModel>(context, listen: false);
  }

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
    }).catchError((_) {
      log("_ => $_");
      EasyLoading.dismiss();
    });
    EasyLoading.dismiss();
    return image;
  }

  void _onUpdatePressed() async {
    if (_fbKey.currentState.saveAndValidate()) {
      EasyLoading.show();
      bool success = await StudentProfileService.updateProfile(
        authModel,
        FormUtil.getFormValue(_fbKey, ProfileUpdateForm.NAME).toString().trim(),
        FormUtil.getFormValue(_fbKey, ProfileUpdateForm.MATRIC_NO).toString().trim(),
        FormUtil.getFormValue(_fbKey, ProfileUpdateForm.PROFILE_PICTURE),
      );
      if (success) {
        EasyLoading.showSuccess("Your account has been updated");
        Navigator.popUntil(context, (route) => route.isFirst);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return EmcScaffold(
      appBar: AppBar(
        title: Text("Update Profile"),
      ),
      maskBackground: false,
      body: FormBuilder(
        key: _fbKey,
        initialValue: {
          ProfileUpdateForm.NAME: authModel?.emcUser?.name,
          ProfileUpdateForm.MATRIC_NO: authModel?.emcUser?.matric,
        },
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: TOP_PADDING + AVATAR_RADIUS),
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: TOP_PADDING),
                child: ListView(
                  physics: new BouncingScrollPhysics(),
                  children: [
                    SizedBox(height: AVATAR_RADIUS),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: CONTENT_HORIZONTAL_PADDING,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text("Name:"),
                              ),
                              Expanded(
                                flex: 2,
                                child: FormBuilderTextField(
                                  name: ProfileUpdateForm.NAME,
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(context),
                                  ]),
                                  decoration: InputDecoration(
                                    hintText: "Eg: Karl Simpson",
                                    isDense: true,
                                    border: new OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: BorderSide(color: Colors.black),
                                    ),
                                    fillColor: Colors.white,
                                    filled: true,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text("Matric No:"),
                              ),
                              Expanded(
                                flex: 2,
                                child: FormBuilderTextField(
                                  name: ProfileUpdateForm.MATRIC_NO,
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(context),
                                  ]),
                                  decoration: InputDecoration(
                                    hintText: "Eg: A19CS1999",
                                    isDense: true,
                                    border: new OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: BorderSide(color: Colors.black),
                                    ),
                                    fillColor: Colors.white,
                                    filled: true,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: EmcButton(
                        onPressed: _onUpdatePressed,
                        text: "Update",
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: TOP_PADDING),
                child: CircleAvatar(
                  radius: AVATAR_RADIUS + 3,
                  backgroundColor: Colors.white,
                  child: FormBuilderField(
                    name: ProfileUpdateForm.PROFILE_PICTURE,
                    builder: (FormFieldState<dynamic> field) {
                      return Stack(
                        children: [
                          GestureDetector(
                            onTap: () => _onUploadImage(field),
                            child: CircleAvatar(
                              radius: AVATAR_RADIUS,
                              backgroundImage: _image != null
                                  ? FileImage(_image)
                                  : (authModel.emcUser.profilePicture?.isNotEmpty ?? false)
                                      ? NetworkImage(authModel.emcUser.profilePicture)
                                      : AssetImage('assets/images/default_avatar.png'),
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
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
