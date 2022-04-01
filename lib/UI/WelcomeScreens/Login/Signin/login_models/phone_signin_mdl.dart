// To parse this JSON data, do
//
//     final phoneSignInMdl = phoneSignInMdlFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

PhoneSignInMdl phoneSignInMdlFromJson(String str) => PhoneSignInMdl.fromJson(json.decode(str));

String phoneSignInMdlToJson(PhoneSignInMdl data) => json.encode(data.toJson());

class PhoneSignInMdl {
  PhoneSignInMdl({
    required this.message,
    required this.status,
    required this.data,
  });

  String message;
  String status;
  Data? data;

  factory PhoneSignInMdl.fromJson(Map<String, dynamic> json) => PhoneSignInMdl(
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
    required this.signInPhoneNo,
  });

  SignInPhoneNo? signInPhoneNo;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    signInPhoneNo: json["signIn_phoneNo"] == null ? null : SignInPhoneNo.fromJson(json["signIn_phoneNo"]),
  );

  Map<String, dynamic> toJson() => {
    "signIn_phoneNo": signInPhoneNo == null ? null : signInPhoneNo!.toJson(),
  };
}

class SignInPhoneNo {
  SignInPhoneNo({
    required this.otp,
    required this.phoneNo,
    required this.id,
    required this.userTypeId,
    required this.jwtToken,
  });

  String otp;
  String phoneNo;
  int id;
  int userTypeId;
  String jwtToken;

  factory SignInPhoneNo.fromJson(Map<String, dynamic> json) => SignInPhoneNo(
    otp: json["otp"] == null ? null : json["otp"],
    phoneNo: json["phoneNo"] == null ? null : json["phoneNo"],
    id: json["id"] == null ? null : json["id"],
    userTypeId: json["userTypeId"] == null ? null : json["userTypeId"],
    jwtToken: json["jwtToken"] == null ? null : json["jwtToken"],
  );

  Map<String, dynamic> toJson() => {
    "otp": otp == null ? null : otp,
    "phoneNo": phoneNo == null ? null : phoneNo,
    "id": id == null ? null : id,
    "userTypeId": userTypeId == null ? null : userTypeId,
    "jwtToken": jwtToken == null ? null : jwtToken,
  };
}
