import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emc/auth/model/entity/emc_user.dart';
import 'package:emc/auth/model/view_model/auth_model.dart';
import 'package:emc/screens/counsellor/appointment/model/entity/appointment.dart';
import 'package:emc/screens/counsellor/appointment/service/appointment_service.dart';
import 'package:emc/screens/counsellor/schedule/constant.dart';
import 'package:emc/screens/counsellor/schedule/service/schedule_service.dart';
import 'package:emc/util/email_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';

class AppointmentModel with ChangeNotifier {
  final AuthModel authModel;
  AppointmentModel({this.authModel});
  DateTime now;
  bool isLoading = false;

  List<Appointment> upcomingAppointmentList = [];
  List<Appointment> pendingAppointmentList = [];

  init() async {
    setLoading();
    now = DateTime.now();
    upcomingAppointmentList.clear();
    pendingAppointmentList.clear();

    List<Appointment> appointmentList = await AppointmentService.fetchAllAppointments(authModel?.user?.uid);
    appointmentList.forEach((appointment) {
      switch (appointment.status ?? "") {
        case "accepted":
          if (!_hasExpired(appointment)) upcomingAppointmentList.add(appointment);
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

  Future acceptAppointment(Appointment appointment) async {
    EasyLoading.show();
    bool success = await AppointmentService.updateAppointmentStatus(appointment?.appointmentId, {"status": "accepted"});
    if (success) {
      await ScheduleService.updateBookedSlotStatus(appointment?.scheduleId, "accepted", _getSlotNumber(appointment?.startTime));
      EasyLoading.dismiss();
      init();
    }
  }

  Future declineAppointment(Appointment appointment, String message) async {
    try {
      final String appointmentId = appointment?.appointmentId;
      EasyLoading.show();
      bool success = await AppointmentService.updateAppointmentStatus(appointmentId, {"status": "declined"});
      if (success) {
        await ScheduleService.updateBookedSlotStatus(appointment?.scheduleId, "declined", _getSlotNumber(appointment?.startTime));
        final DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection("users").doc(appointment.student.sid).get();
        final EmcUser student = EmcUser.fromJson(snapshot.data());

        String html = "<h3>Your appointmnet to ${authModel?.emcUser?.name} has been declined</h3>\n";
        if (message != null) {
          html = "$html<p style='color:blue; font-weight: bold;'>$message</p>";
        }
        await EmailUtil.sendEmail(targetEmail: "hugmypants17@gmail.com", html: html, subject: "Appointment Declined Notification");
        EasyLoading.dismiss();
        init();
      }
    } on FirebaseException catch (error) {
      EasyLoading.showError("Error @ declineAppointment => ${error.message}");
      log("Error @ declineAppointment => ${error.message}");
    } catch (error) {
      EasyLoading.showError("Error @ declineAppointment => $error");
      log("Error @ declineAppointment => $error");
    }
  }

  bool _hasExpired(Appointment appointment) {
    DateTime appointmentDateTime = DateTime.fromMillisecondsSinceEpoch(appointment.startTime);
    if (now.difference(appointmentDateTime) < Duration(days: 1) && now.day == appointmentDateTime.day) {
      return now.hour > appointmentDateTime.hour;
    }
    return now.isAfter(appointmentDateTime);
  }

  _getSlotNumber(num startTime) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(startTime);
    String timeString = DateFormat("h: mm").format(date);
    return SCHEDULE_LABELS.indexOf(timeString);
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
