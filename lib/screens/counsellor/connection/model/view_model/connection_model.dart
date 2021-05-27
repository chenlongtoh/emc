import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emc/auth/model/entity/emc_user.dart';
import 'package:emc/auth/model/view_model/auth_model.dart';
import 'package:emc/screens/counsellor/connection/service/connection_service.dart';
import 'package:emc/screens/counsellor/connection/model/entity/connection.dart';
import 'package:emc/util/email_util.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ConnectionModel {
  final AuthModel authModel;
  List<Connection> allConnections;

  ConnectionModel({this.authModel});

  Future getConnections() async {
    allConnections = await ConnectionService.fetchAllConnections(authModel?.user?.uid);
    return allConnections;
  }

  Future confirmConection(String connectionId) async {
    return await ConnectionService.confirmConnection(connectionId);
  }

  Future declineConnection(String connectionId, String message, String studentId) async {
    EasyLoading.show();
    bool success = false;
    try {
      success = await ConnectionService.declineConnection(connectionId);
      if (success && studentId != null) {
        final DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection("users").doc(studentId).get();
        final String studentEmail = EmcUser.fromJson(snapshot?.data() ?? const {}).email;

        String html = "<h3>Your connection to ${authModel?.emcUser?.name} has been declined</h3>\n";
        if (message?.isNotEmpty ?? false) {
          html = "$html<p>Counsellor's Message: $message</p>";
        }
        await EmailUtil.sendEmail(
          targetEmail: studentEmail,
          html: html,
          subject: 'Declined Connection Request',
        );
      }
      EasyLoading.showSuccess("Connection Declined, an email is sent to notify the student");
    } catch (error) {
      log("Error @declineConnection => $error");
      EasyLoading.showError("Error : $error");
    }
    return success;
  }
}
