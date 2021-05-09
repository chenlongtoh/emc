import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emc/screens/counsellor/appointment/model/entity/appointment.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class AppointmentService {
  static Future fetchAllAppointments(String cid) async {
    try {
      CollectionReference appointment = FirebaseFirestore.instance.collection("appointment");
      DateTime now = DateTime.now();
      QuerySnapshot snapshot = await appointment
          .where("counsellor.cid", isEqualTo: cid)
          .where("startTime", isGreaterThanOrEqualTo: DateTime(now.year, now.month, now.day).millisecondsSinceEpoch)
          .get();
      return snapshot?.docs
              ?.map((doc) => Appointment.fromJson({
                    ...doc.data(),
                    "appointmentId": doc.id,
                  }))
              ?.toList() ??
          [];
    } on FirebaseException catch (error) {
      EasyLoading.showError("Error => ${error.message}");
      log("Error @ fetchAllAppointments => ${error.message}");
    } catch (error) {
      log("Error @ fetchAllAppointments => $error");
    }
    return [];
  }

  static Future updateAppointmentStatus(String appointmentId, Map<String, dynamic> data) async {
    bool success = false;
    try {
      CollectionReference appointment = FirebaseFirestore.instance.collection("appointment");
      await appointment.doc(appointmentId).update(data);
      success = true;
    } on FirebaseException catch (error) {
      EasyLoading.showError("Error => ${error.message}");
      log("Error @ updateAppointmentStatus => ${error.message}");
    } catch (error) {
      log("Error @ updateAppointmentStatus => $error");
    }
    return success;
  }
}
