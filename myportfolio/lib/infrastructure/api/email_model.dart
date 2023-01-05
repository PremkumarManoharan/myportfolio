import 'dart:convert';

EmailModel emailModelFromJson(String str) =>
    EmailModel.fromJson(json.decode(str));

String emailModelToJson(EmailModel data) => json.encode(data.toJson());

class EmailModel {
  EmailModel({
    required this.status,
  });

  String status;

  factory EmailModel.fromJson(Map<String, dynamic> json) => EmailModel(
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
      };
}
