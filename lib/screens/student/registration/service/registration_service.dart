import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class RegistrationService {
  static Future registerAccount(Map<String, dynamic> data) async {
    try {
      CollectionReference users = FirebaseFirestore.instance.collection('users');
      await users.add(data);
      return true;
    } on FirebaseException catch (e) {
      EasyLoading.showError("Error => $e");
    }
    return false;
  }
}
