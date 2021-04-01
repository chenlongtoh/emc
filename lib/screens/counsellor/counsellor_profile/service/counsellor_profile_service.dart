import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emc/auth/model/entity/emc_user.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class CounsellorProfileService {
  static Future getCounsellorById(String uid) async {
    try {
      CollectionReference users = FirebaseFirestore.instance.collection("users");
      DocumentSnapshot snapshot = await users.doc(uid)?.get();
      return snapshot?.data();
    } catch (e) {
      EasyLoading.showError("Error => $e");
    }
    return null;
  }
}
