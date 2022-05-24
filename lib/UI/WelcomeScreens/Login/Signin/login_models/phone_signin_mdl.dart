// To parse this JSON data, do
//
//     final phoneSignInMdl = phoneSignInMdlFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

PhoneSignInMdl phoneSignInMdlFromJson(String str) => PhoneSignInMdl.fromJson(json.decode(str));

String phoneSignInMdlToJson(PhoneSignInMdl data) => json.encode(data.toJson());

class PhoneSignInMdl {
  PhoneSignInMdl({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  Data? data;

  factory PhoneSignInMdl.fromJson(Map<String, dynamic> json) => PhoneSignInMdl(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : data?.toJson(),
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
    "signIn_phoneNo": signInPhoneNo == null ? null : signInPhoneNo?.toJson(),
  };
}

class SignInPhoneNo {
  SignInPhoneNo({
    required this.otp,
    required this.phoneNo,
    required this.id,
    required this.lastName,
    required this.fcmToken,
    required this.firstName,
    required this.emailId,
    required this.status,
    required this.userTypeId,
    required this.jwtToken,
  });

  String otp;
  String phoneNo;
  int id;
  String lastName;
  String fcmToken;
  String firstName;
  String emailId;
  int status;
  int userTypeId;
  String jwtToken;

  factory SignInPhoneNo.fromJson(Map<String, dynamic> json) => SignInPhoneNo(
    otp: json["otp"] == null ? null : json["otp"],
    phoneNo: json["phoneNo"] == null ? null : json["phoneNo"],
    id: json["id"] == null ? null : json["id"],
    lastName: json["lastName"] == null ? null : json["lastName"],
    fcmToken: json["fcmToken"] == null ? null : json["fcmToken"],
    firstName: json["firstName"] == null ? null : json["firstName"],
    emailId: json["emailId"] == null ? null : json["emailId"],
    status: json["status"] == null ? null : json["status"],
    userTypeId: json["userTypeId"] == null ? null : json["userTypeId"],
    jwtToken: json["jwtToken"] == null ? null : json["jwtToken"],
  );

  Map<String, dynamic> toJson() => {
    "otp": otp == null ? null : otp,
    "phoneNo": phoneNo == null ? null : phoneNo,
    "id": id == null ? null : id,
    "lastName": lastName == null ? null : lastName,
    "fcmToken": fcmToken == null ? null : fcmToken,
    "firstName": firstName == null ? null : firstName,
    "emailId": emailId == null ? null : emailId,
    "status": status == null ? null : status,
    "userTypeId": userTypeId == null ? null : userTypeId,
    "jwtToken": jwtToken == null ? null : jwtToken,
  };
}
