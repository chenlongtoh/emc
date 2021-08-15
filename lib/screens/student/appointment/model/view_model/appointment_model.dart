import 'dart:developer';

import 'package:emc/auth/model/view_model/auth_model.dart';
import 'package:emc/screens/student/appointment/model/entity/appointment.dart';
import 'package:emc/screens/student/appointment/service/appointment_service.dart';
import 'package:flutter/foundation.dart';

class AppointmentModel with ChangeNotifier {
  final AuthModel authModel;
  AppointmentModel({this.authModel}) : assert(authModel != null);

  bool isLoading = false;
  DateTime now;

  List<Appointment> acceptedAppointment = [];
  List<Appointment> pendingAppointment = [];
  List<Appointment> declinedAppointment = [];
  List<Counsellor> counsellors = [];

  init() async {
    setLoading();
    now = DateTime.now();
    acceptedAppointment.clear();
    pendingAppointment.clear();
    declinedAppointment.clear();
    List<Appointment> allAppointment = await AppointmentService.fetchAllAppointments(authModel?.user?.uid);
    allAppointment.forEach((appointment) {
      switch (appointment.status) {
        case "accepted":
          if (_hasExpired(appointment))
            declinedAppointment.add(appointment);
          else
            acceptedAppointment.add(appointment);
          break;
        case "pending":
          if (_hasExpired(appointment))
            declinedAppointment.add(appointment);
          else
            pendingAppointment.add(appointment);
          break;
        case "declined":
          declinedAppointment.add(appointment);
          break;
        default:
          return;
      }
    });
    acceptedAppointment.sort((a, b) => b.startTime.compareTo(a.startTime));
    pendingAppointment.sort((a, b) => b.startTime.compareTo(a.startTime));
    declinedAppointment.sort((a, b) => b.startTime.compareTo(a.startTime));
    counsellors = await AppointmentService.fetchAllConnectedCounsellor(authModel?.user?.uid);
    setIdle();
  }

  List<Counsellor> getCounsellorsByCriteria(String criteria) {
    return (criteria?.isEmpty ?? true)
        ? counsellors
        : counsellors.where((counsellor) => counsellor?.name?.toLowerCase()?.contains(criteria) ?? false).toList();
  }

  bool _hasExpired(Appointment appointment) {
    DateTime appointmentDateTime = DateTime.fromMillisecondsSinceEpoch(appointment.startTime);
    if (now.difference(appointmentDateTime) < Duration(days: 1) && now.day == appointmentDateTime.day) {
      return now.hour > appointmentDateTime.hour;
    }
    return now.isAfter(appointmentDateTime);
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
