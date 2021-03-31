import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class StudentProfileService {
  static Future getStudentDetailsById(String sid) async {
    try {
      CollectionReference users = FirebaseFirestore.instance.collection("users");
      DocumentSnapshot snapshot = await users.doc(sid).get();
      return snapshot.data();
    } catch (e) {
      log("Error on getStudentDetailsById => $e");
      EasyLoading.showError("Error => $e");
    }
    return null;
  }
}
