import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emc/auth/model/entity/emc_user.dart';
import 'package:emc/auth/model/view_model/auth_model.dart';
import 'package:emc/screens/counsellor/connection/model/entity/connected_student.dart';
import 'package:emc/screens/counsellor/connection/service/connection_service.dart';
import 'package:emc/screens/counsellor/connection/model/entity/connection.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

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
        QuerySnapshot snapshot = await FirebaseFirestore.instance.collection("users").where("docId", isEqualTo: studentId).limit(1).get();
        String studentEmail = EmcUser.fromJson(snapshot?.docs?.first?.data() ?? const {}).email;

        String username = 'banadody25@gmail.com';
        String password = 'LV7}vGx&t4UD8sa`';

        final smtpServer = gmail(username, password);
        // Use the SmtpServer class to configure an SMTP server:
        // final smtpServer = SmtpServer('smtp.domain.com');
        // See the named arguments of SmtpServer for further configuration
        // options.
        String html = "<h3>Your connection to ${authModel?.emcUser?.name} has been declined</h3>\n";
        if (message?.isNotEmpty ?? false) {
          html = "$html<p>Counsellor's Message: $message</p>";
        }
        
        if (studentEmail == null) html = "<p>Email null fallback for studentId => $studentId, connectionId => $connectionId</p>\n";
        // Create our message.
        final email = Message()
          ..from = Address(username, 'Emotion Chatbot Analyzer')
          ..recipients.add(studentEmail ?? 'chenlongtoh@gmail.com')
          ..subject = 'Declined Connection Request'
          ..html = html;

        try {
          final sendReport = await send(email, smtpServer);
          log('Message sent: ' + sendReport.toString());
        } on MailerException catch (e) {
          log('Message not sent. $e');
          for (var p in e.problems) {
            log('Problem: ${p.code}: ${p.msg}');
          }
        }
      }
      EasyLoading.showSuccess("Connection Declined, an email is sent to notify the student");
    } catch (error) {
      log("Error @declineConnection => $error");
      EasyLoading.showError("Error : $error");  
    }
    return success;
  }
}
