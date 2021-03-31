import 'package:cloud_firestore/cloud_firestore.dart';
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
}
