import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emc/auth/model/entity/emc_user.dart';
import 'package:emc/screens/student/connection/model/entity/connection.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ConnectionService {
  static Future fetchConnectionByUid(String uid) async {
    try {
      CollectionReference connection = FirebaseFirestore.instance.collection("connection");
      final QuerySnapshot connectionSnapshot = await connection.where('student.sid', isEqualTo: uid).get();
      return connectionSnapshot.docs.map((doc) => Connection.fromJson(doc?.data() ?? const {})).toList();
    } on FirebaseException catch (e) {
      EasyLoading.showError("Error => $e");
    }
    return [];
  }

  static Future getCounsellorsExcept(List<String> cidList) async {
    try {
      CollectionReference users = FirebaseFirestore.instance.collection("users");
      final QuerySnapshot snapshot = await users.where('isStudent', isEqualTo: false).get();
      if (snapshot.docs.isNotEmpty) {
        if (cidList == null || cidList.isEmpty) {
          return snapshot.docs.map((doc) => EmcUser.fromJson({...doc?.data(), "uid": doc.id} ?? const {})).toList();
        }
        var filteredList = snapshot.docs;
        filteredList.removeWhere((doc) => cidList.contains(doc.id));
        if (filteredList != null || filteredList.isNotEmpty) {
          return filteredList.map((doc) => EmcUser.fromJson(doc?.data() ?? const {})).toList();
        }
      }
    } on FirebaseException catch (e) {
      EasyLoading.showError("Error => $e");
    } catch (err) {
      log("Error @ getCounsellorsExcept => $err");
    }
    return [];
  }

  static Future createConnection(Map<String, dynamic> data) async {
    bool success = false;
    try {
      CollectionReference connection = FirebaseFirestore.instance.collection("connection");
      await connection.add(data);
      success = true;
    } on FirebaseException catch (e) {
      EasyLoading.showError("Error => $e");
    }
    return success;
  }
}
