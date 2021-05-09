import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emc/screens/counsellor/connection/model/entity/connection.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ConnectionService {
  static Future fetchAllConnections(String cid) async {
    try {
      CollectionReference connection = FirebaseFirestore.instance.collection("connection");
      final QuerySnapshot snapshot = await connection.where("counsellor.cid", isEqualTo: cid).get();
      return snapshot.docs.map((doc) => Connection.fromJson({
        ...doc.data(),
        "connectionId": doc.id,
      })).toList();
    } on FirebaseException catch (e) {
      EasyLoading.showError("Error => ${e.message}");
    } catch (e) {
      log("General Error @ fetchAllConnections => $e");
    }
    return [];
  }

  static Future confirmConnection(String connectionId) async {
    bool success = false;
    try {
      CollectionReference connection = FirebaseFirestore.instance.collection("connection");
      await connection.doc(connectionId).update({"status": "connected"});
      success = true;
    } on FirebaseException catch (e) {
      EasyLoading.showError("Error => ${e.message}");
    } catch (e) {
      log("General Error @ confirmConnection => $e");
    }
    return success;
  }

  static Future declineConnection(String connectionId) async {
    bool success = false;
    try {
      CollectionReference connection = FirebaseFirestore.instance.collection("connection");
      await connection.doc(connectionId).update({"status": "declined"});
      success = true;
    } on FirebaseException catch (e) {
      EasyLoading.showError("Error => ${e.message}");
    } catch (e) {
      log("General Error @ declineConnection => $e");
    }
    return success;
  }
}
