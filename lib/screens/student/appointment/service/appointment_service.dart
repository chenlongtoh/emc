import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emc/screens/student/appointment/model/entity/appointment.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class AppointmentService {
  static Future fetchAllAppointments(String studentId) async {
    try {
      CollectionReference appointment = FirebaseFirestore.instance.collection("appointment");
      QuerySnapshot snapshot = await appointment.where("student.sid", isEqualTo: studentId).get();
      return snapshot.docs.map((doc) => Appointment.fromJson(doc.data())).toList();
    } on FirebaseException catch (error) {
      log("FirebaseException @ fetchAllAppointments => ${error.message}");
      EasyLoading.showError("Error: ${error.message}");
    } catch (error) {
      log("Error @ fetchAllAppointments => $error");
      EasyLoading.showError("Error: $error");
    }
  }

  static Future fetchAllConnectedCounsellor(String studentId) async {
    try {
      CollectionReference connection = FirebaseFirestore.instance.collection("connection");
      QuerySnapshot snapshot = await connection.where("student.sid", isEqualTo: studentId).where("status", isEqualTo: "connected").get();
      log("studentId => $studentId");
      log("snapshot.docs => ${snapshot.docs.length}");
      return snapshot.docs.map((doc) => Counsellor.fromJson((doc.data() ?? const {})["counsellor"])).toList();
    } on FirebaseException catch (error) {
      log("FirebaseException @ fetchAllConnectedCounsellor => ${error.message}");
      EasyLoading.showError("Error: ${error.message}");
    } catch (error) {
      log("Error @ fetchAllConnectedCounsellor => $error");
      EasyLoading.showError("Error: $error");
    }
  }

  static Future insertAppointment(Map<String, dynamic> data) async {
    bool success = false;
    try {
      CollectionReference appointment = FirebaseFirestore.instance.collection("appointment");
      await appointment.add(data);
      success = true;
    } on FirebaseException catch (error) {
      log("FirebaseException @ insertAppointment => ${error.message}");
      EasyLoading.showError("Error: ${error.message}");
    } catch (error) {
      log("Error @ insertAppointment => $error");
      EasyLoading.showError("Error: $error");
    }
    return success;
  }
}
