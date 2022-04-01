// To parse this JSON data, do
//
//     final createPasswordMdl = createPasswordMdlFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ChangePasswordMdl changePasswordMdlFromJson(String str) => ChangePasswordMdl.fromJson(json.decode(str));

String changePasswordMdlToJson(ChangePasswordMdl data) => json.encode(data.toJson());

class ChangePasswordMdl {
  ChangePasswordMdl({
    required this.data,
    required this.status,
    required this.message
  });

  Data? data;
  String? status;
  String? message;

  factory ChangePasswordMdl.fromJson(Map<String, dynamic> json) => ChangePasswordMdl(
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
    required this.resetPassword,
  });

  ResetPassword? resetPassword;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    resetPassword: json["ResetPassword"] == null ? null : ResetPassword.fromJson(json["ResetPassword"]),
  );

  Map<String, dynamic> toJson() => {
    "ResetPassword": resetPassword == null ? null : resetPassword!.toJson(),
  };
}

class ResetPassword {
  ResetPassword({
    required this.status,
    required this.code,
    required this.message,
  });

  String? status;
  String? code;
  String? message;

  factory ResetPassword.fromJson(Map<String, dynamic> json) => ResetPassword(
    status: json["status"] == null ? null : json["status"],
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "code": code == null ? null : code,
    "message": message == null ? null : message,
  };
}
