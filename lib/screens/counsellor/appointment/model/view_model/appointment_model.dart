import 'dart:developer';

import 'package:emc/auth/model/view_model/auth_model.dart';
import 'package:emc/screens/counsellor/appointment/model/entity/appointment.dart';
import 'package:emc/screens/counsellor/appointment/service/appointment_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class AppointmentModel with ChangeNotifier {
  final AuthModel authModel;
  AppointmentModel({this.authModel});

  bool isLoading = false;

  List<Appointment> upcomingAppointmentList = [];
  List<Appointment> pendingAppointmentList = [];

  init() async {
    setLoading();
    upcomingAppointmentList.clear();
    pendingAppointmentList.clear();

    List<Appointment> appointmentList = await AppointmentService.fetchAllAppointments(authModel?.user?.uid);
    appointmentList.forEach((appointment) {
      switch (appointment.status ?? "") {
        case "accepted":
          upcomingAppointmentList.add(appointment);
          break;
        case "pending":
          pendingAppointmentList.add(appointment);
          break;
        default:
          break;
      }
    });
    setIdle();
  }

  Future acceptAppointment(String appointmentId) async {
    EasyLoading.show();
    bool success = await AppointmentService.updateAppointmentStatus(appointmentId, {"status": "accepted"});
    if (success) {
      EasyLoading.dismiss();
      init();
    }
  }

  Future declineAppointment(String appointmentId) async {
    EasyLoading.show();
    bool success = await AppointmentService.updateAppointmentStatus(appointmentId, {"status": "declined"});
    if (success) {
      EasyLoading.dismiss();
      init();
    }
  }

  setLoading() {
    isLoading = true;
    notifyListeners();
  }

  setIdle() {
    isLoading = false;
    notifyListeners();
  }
}
