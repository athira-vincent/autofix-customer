// To parse this JSON data, do
//
//     final forgotPasswordMdl = forgotPasswordMdlFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ForgotPasswordMdl forgotPasswordMdlFromJson(String str) => ForgotPasswordMdl.fromJson(json.decode(str));

String forgotPasswordMdlToJson(ForgotPasswordMdl data) => json.encode(data.toJson());

class ForgotPasswordMdl {
  ForgotPasswordMdl({
    required this.data,
    required this.status,
    required this.message
  });

  Data? data;
  String? status;
  String? message;

  factory ForgotPasswordMdl.fromJson(Map<String, dynamic> json) => ForgotPasswordMdl(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    message: json["message"] == null ? null : json["message"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? null : data!.toJson(),
    "message": message == null ? null : message,
    "status": status == null ? null : status,
  };
}

class Data {
  Data({
    required this.forgotPassword,
  });

  ForgotPassword? forgotPassword;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    forgotPassword: json["ForgotPassword"] == null ? null : ForgotPassword.fromJson(json["ForgotPassword"]),
  );

  Map<String, dynamic> toJson() => {
    "ForgotPassword": forgotPassword == null ? null : forgotPassword!.toJson(),
  };
}

class ForgotPassword {
  ForgotPassword({
    required this.resetToken,
    required this.userId,
    required this.phoneNo,
  });

  String? resetToken;
  int? userId;
  String? phoneNo;

  factory ForgotPassword.fromJson(Map<String, dynamic> json) => ForgotPassword(
    resetToken: json["resetToken"] == null ? null : json["resetToken"],
    userId: json["userId"] == null ? null : json["userId"],
    phoneNo: json["phoneNo"] == null ? null : json["phoneNo"],
  );

  Map<String, dynamic> toJson() => {
    "resetToken": resetToken == null ? null : resetToken,
    "userId": userId == null ? null : userId,
    "phoneNo": phoneNo == null ? null : phoneNo,
  };
}
