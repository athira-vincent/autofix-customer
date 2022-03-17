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
    required this.customerSocialLogin,
  });

  CustomerSocialLogin? customerSocialLogin;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    customerSocialLogin: json["customerSocialLogin"] == null ? null : CustomerSocialLogin.fromJson(json["customerSocialLogin"]),
  );

  Map<String, dynamic> toJson() => {
    "customerSocialLogin": customerSocialLogin == null ? null : customerSocialLogin!.toJson(),
  };
}

class CustomerSocialLogin {
  CustomerSocialLogin({
    required this.token,
    required this.customer,
  });

  String token;
  Customer? customer;

  factory CustomerSocialLogin.fromJson(Map<String, dynamic> json) => CustomerSocialLogin(
    token: json["token"] == null ? null : json["token"],
    customer: json["customer"] == null ? null : Customer.fromJson(json["customer"]),
  );

  Map<String, dynamic> toJson() => {
    "token": token == null ? null : token,
    "customer": customer == null ? null : customer!.toJson(),
  };
}

class Customer {
  Customer({
    required this.id,
    required this.userCode,
    required this.firstName,
    required this.lastName,
    required this.emailId,
    required this.phoneNo,
    required this.state,
    required this.resetToken,
    required this.userType,
    required this.accountType,
    required this.profilePic,
    required this.isProfileCompleted,
    required this.otpVerified,
    required this.status,
  });

  int id;
  String userCode;
  String firstName;
  String lastName;
  String emailId;
  String phoneNo;
  String state;
  String resetToken;
  int userType;
  int accountType;
  dynamic profilePic;
  int isProfileCompleted;
  int otpVerified;
  int status;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    id: json["id"] == null ? null : json["id"],
    userCode: json["userCode"] == null ? null : json["userCode"],
    firstName: json["firstName"] == null ? null : json["firstName"],
    lastName: json["lastName"] == null ? null : json["lastName"],
    emailId: json["emailId"] == null ? null : json["emailId"],
    phoneNo: json["phoneNo"] == null ? null : json["phoneNo"],
    state: json["state"] == null ? null : json["state"],
    resetToken: json["resetToken"] == null ? null : json["resetToken"],
    userType: json["userType"] == null ? null : json["userType"],
    accountType: json["accountType"] == null ? null : json["accountType"],
    profilePic: json["profilePic"],
    isProfileCompleted: json["isProfile_Completed"] == null ? null : json["isProfile_Completed"],
    otpVerified: json["otp_verified"] == null ? null : json["otp_verified"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "userCode": userCode == null ? null : userCode,
    "firstName": firstName == null ? null : firstName,
    "lastName": lastName == null ? null : lastName,
    "emailId": emailId == null ? null : emailId,
    "phoneNo": phoneNo == null ? null : phoneNo,
    "state": state == null ? null : state,
    "resetToken": resetToken == null ? null : resetToken,
    "userType": userType == null ? null : userType,
    "accountType": accountType == null ? null : accountType,
    "profilePic": profilePic,
    "isProfile_Completed": isProfileCompleted == null ? null : isProfileCompleted,
    "otp_verified": otpVerified == null ? null : otpVerified,
    "status": status == null ? null : status,
  };
}
