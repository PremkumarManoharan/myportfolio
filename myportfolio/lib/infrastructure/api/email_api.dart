import 'dart:convert';

import '/infrastructure/failures/email_failure.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_email_sender/flutter_email_sender.dart';
import '/values/values.dart';

import 'email_model.dart';

abstract class EmailApi {
  ///portfolio-api-chi.vercel.app/api/getintouch
  Future<EmailModel> sendEmail({
    required String name,
    required String email,
    required String subject,
    required String message,
  });
}

class EmailApiImpl implements EmailApi {
  final http.Client client;

  EmailApiImpl({required this.client});

  Future<EmailModel> sendEmail({
    required String name,
    required String email,
    required String subject,
    required String message,
  }) async {
    try {
      final Email send_email = Email(
        body: message,
        subject: subject,
        recipients: [email],
        isHTML: true,
      );
      final response = await FlutterEmailSender.send(send_email);
      return EmailModel(status: "success");
    } catch (e) {
      print("Errorss  ${e.toString()}");
      throw EmailFailure.serverError();
    }
  }
}
