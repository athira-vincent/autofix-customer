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
    "signIn_phoneNo": signInPhoneNo == null ? null : signInPhoneNo!.toJson(),
  };
}

class SignInPhoneNo {
  SignInPhoneNo({
    required this.token,
    required this.userData,
    required this.message,
  });

  String token;
  UserData? userData;
  String message;

  factory SignInPhoneNo.fromJson(Map<String, dynamic> json) => SignInPhoneNo(
    token: json["token"] == null ? null : json["token"],
    userData: json["userData"] == null ? null : UserData.fromJson(json["userData"]),
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "token": token == null ? null : token,
    "userData": userData == null ? null : userData!.toJson(),
    "message": message == null ? null : message,
  };
}

class UserData {
  UserData({
    required this.otp,
    required this.phoneNo,
    required this.id,
    required this.userTypeId,
    required this.jwtToken,
    required this.firstName,
    required this.lastName,
    required this.emailId,
    required this.fcmToken,
    required this.status,
    required this.isProfile,
    required this.otpVerified,
  });

  dynamic otp;
  String phoneNo;
  int id;
  int userTypeId;
  String jwtToken;
  String firstName;
  String lastName;
  String emailId;
  String fcmToken;
  int status;
  int isProfile;
  int otpVerified;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    otp: json["otp"],
    phoneNo: json["phoneNo"] == null ? null : json["phoneNo"],
    id: json["id"] == null ? null : json["id"],
    userTypeId: json["userTypeId"] == null ? null : json["userTypeId"],
    jwtToken: json["jwtToken"] == null ? null : json["jwtToken"],
    firstName: json["firstName"] == null ? null : json["firstName"],
    lastName: json["lastName"] == null ? null : json["lastName"],
    emailId: json["emailId"] == null ? null : json["emailId"],
    fcmToken: json["fcmToken"] == null ? null : json["fcmToken"],
    status: json["status"] == null ? null : json["status"],
    isProfile: json["isProfile"] == null ? null : json["isProfile"],
    otpVerified: json["otpVerified"] == null ? null : json["otpVerified"],
  );

  Map<String, dynamic> toJson() => {
    "otp": otp,
    "phoneNo": phoneNo == null ? null : phoneNo,
    "id": id == null ? null : id,
    "userTypeId": userTypeId == null ? null : userTypeId,
    "jwtToken": jwtToken == null ? null : jwtToken,
    "firstName": firstName == null ? null : firstName,
    "lastName": lastName == null ? null : lastName,
    "emailId": emailId == null ? null : emailId,
    "fcmToken": fcmToken == null ? null : fcmToken,
    "status": status == null ? null : status,
    "isProfile": isProfile == null ? null : isProfile,
    "otpVerified": otpVerified == null ? null : otpVerified,
  };
}
