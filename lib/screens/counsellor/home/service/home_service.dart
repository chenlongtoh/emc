import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emc/screens/counsellor/appointment/model/entity/appointment.dart';
import 'package:emc/screens/counsellor/connection/model/entity/connection.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class HomeService {
  static Future getConnectionsAndAppointments(String cid) async {
    List<Connection> connectionList = [];
    List<Appointment> appointmentList = [];
    try {
      CollectionReference connection = FirebaseFirestore.instance.collection("connection");
      QuerySnapshot snapshot = await connection.where("counsellor.cid", isEqualTo: cid).get();
      connectionList = snapshot.docs.map((doc) => Connection.fromJson(doc.data())).toList();

      CollectionReference appointment = FirebaseFirestore.instance.collection("appointment");
      snapshot = await appointment.where("counsellor.cid", isEqualTo: cid).get();
      appointmentList = snapshot.docs.map((doc) => Appointment.fromJson(doc.data())).toList();
    } on FirebaseException catch (error) {
      EasyLoading.showError("Error => ${error.message}");
      log("Error @ getConnectionsAndAppointments => ${error.message}");
    } catch (error) {
      EasyLoading.showError("Error => $error");
      log("Error @ getConnectionsAndAppointments => $error");

    }

    return [connectionList, appointmentList];
  }
}
