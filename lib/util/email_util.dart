import 'dart:developer';

import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class EmailUtil {
  static const String username = 'banadody25@gmail.com';
  static const String password = 'LV7}vGx&t4UD8sa`';

  static Future<bool> sendEmail({String targetEmail, String html, String subject}) async {
    final SmtpServer smtpServer = gmail(username, password);
    final email = Message()
      ..from = Address(username, 'Emotion Chatbot Analyzer')
      ..recipients.add(targetEmail)
      ..subject = subject
      ..html = html;

    try {
      final sendReport = await send(email, smtpServer);
      log('Message sent: ' + sendReport.toString());
      return true;
    } on MailerException catch (e) {
      log('Message not sent. $e');
      for (var p in e.problems) {
        log('Problem: ${p.code}: ${p.msg}');
      }
    }
    return false;
  }
}
