// To parse this JSON data, do
//
//     final customerSocialLoginMdl = customerSocialLoginMdlFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CustomerSocialLoginMdl customerSocialLoginMdlFromJson(String str) => CustomerSocialLoginMdl.fromJson(json.decode(str));

String customerSocialLoginMdlToJson(CustomerSocialLoginMdl data) => json.encode(data.toJson());

class CustomerSocialLoginMdl {
  CustomerSocialLoginMdl({
    required this.message,
    required this.status,
    this.data,
  });

  String message;
  String status;
  Data? data;

  factory CustomerSocialLoginMdl.fromJson(Map<String, dynamic> json) => CustomerSocialLoginMdl(
    message: json["message"] == null ? null : json["message"],
    status: json["status"] == null ? null : json["status"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
    "status": status == null ? null : status,
    "data": data == null ? null : data!.toJson(),
  };
}

class Data {
  Data({
    required this.socialLogin,
  });

  SocialLogin? socialLogin;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    socialLogin: json["socialLogin"] == null ? null : SocialLogin.fromJson(json["socialLogin"]),
  );

  Map<String, dynamic> toJson() => {
    "socialLogin": socialLogin == null ? null : socialLogin!.toJson(),
  };
}

class SocialLogin {
  SocialLogin({
    required this.token,
    required this.user,
  });

  String token;
  User? user;

  factory SocialLogin.fromJson(Map<String, dynamic> json) => SocialLogin(
    token: json["token"] == null ? null : json["token"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "token": token == null ? null : token,
    "user": user == null ? null : user!.toJson(),
  };
}

class User {
  User({
    required this.id,
    required this.userCode,
    required this.firstName,
    required this.lastName,
    required this.emailId,
    required this.phoneNo,
    required this.status,
    required this.userTypeId,
    required this.jwtToken,
    required this.fcmToken,
    required this.otpCode,
    required this.isProfile,
    required this.otpVerified,
  });

  int id;
  String userCode;
  String firstName;
  String lastName;
  String emailId;
  String phoneNo;
  int status;
  int userTypeId;
  String jwtToken;
  dynamic fcmToken;
  dynamic otpCode;
  int isProfile;
  int otpVerified;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"] == null ? null : json["id"],
    userCode: json["userCode"] == null ? null : json["userCode"],
    firstName: json["firstName"] == null ? null : json["firstName"],
    lastName: json["lastName"] == null ? null : json["lastName"],
    emailId: json["emailId"] == null ? null : json["emailId"],
    phoneNo: json["phoneNo"] == null ? null : json["phoneNo"],
    status: json["status"] == null ? null : json["status"],
    userTypeId: json["userTypeId"] == null ? null : json["userTypeId"],
    jwtToken: json["jwtToken"] == null ? null : json["jwtToken"],
    fcmToken: json["fcmToken"],
    otpCode: json["otpCode"],
    isProfile: json["isProfile"] == null ? null : json["isProfile"],
    otpVerified: json["otpVerified"] == null ? null : json["otpVerified"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "userCode": userCode == null ? null : userCode,
    "firstName": firstName == null ? null : firstName,
    "lastName": lastName == null ? null : lastName,
    "emailId": emailId == null ? null : emailId,
    "phoneNo": phoneNo == null ? null : phoneNo,
    "status": status == null ? null : status,
    "userTypeId": userTypeId == null ? null : userTypeId,
    "jwtToken": jwtToken == null ? null : jwtToken,
    "fcmToken": fcmToken,
    "otpCode": otpCode,
    "isProfile": isProfile == null ? null : isProfile,
    "otpVerified": otpVerified == null ? null : otpVerified,
  };
}
