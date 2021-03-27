import 'dart:io';

import 'package:emc/screens/student/registration/model/entity/account.dart';
import 'package:emc/screens/student/registration/service/registration_service.dart';

class RegistrationModel{
  File profilePic;

  void setProfilePicture(File image){
    profilePic = image;
  }

  void register({String email, String password, String name, String matric}){

  }
  
  Future registerAccount() async {
    await RegistrationService.registerAccount({});
  }
}