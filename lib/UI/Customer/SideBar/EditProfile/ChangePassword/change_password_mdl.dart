// To parse this JSON data, do
//
//     final changePasswordMdl = changePasswordMdlFromJson(jsonString);

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
    required this.changePassword,
  });

  ChangePassword? changePassword;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    changePassword: json["ChangePassword"] == null ? null : ChangePassword.fromJson(json["ChangePassword"]),
  );

  Map<String, dynamic> toJson() => {
    "ChangePassword": changePassword == null ? null : changePassword!.toJson(),
  };
}

class ChangePassword {
  ChangePassword({
    required this.status,
    required this.code,
    required this.message,
  });

  String status;
  String code;
  String message;

  factory ChangePassword.fromJson(Map<String, dynamic> json) => ChangePassword(
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
