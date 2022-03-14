// To parse this JSON data, do
//
//     final customersSignUpCorporateMdl = customersSignUpCorporateMdlFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CustomersSignUpCorporateMdl customersSignUpCorporateMdlFromJson(String str) => CustomersSignUpCorporateMdl.fromJson(json.decode(str));

String customersSignUpCorporateMdlToJson(CustomersSignUpCorporateMdl data) => json.encode(data.toJson());

class CustomersSignUpCorporateMdl {
  CustomersSignUpCorporateMdl({
    required this.status,
    required this.message,
    required this.data,
  });

  String? status;
  String? message;
  Data? data;

  factory CustomersSignUpCorporateMdl.fromJson(Map<String, dynamic> json) => CustomersSignUpCorporateMdl(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    message: json["message"] ,
    status:  json["status"] ,
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? null : data?.toJson(),
  };
}

class Data {
  Data({
    required this.customersSignUpCorporate,
  });

  CustomersSignUpCorporate? customersSignUpCorporate;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    customersSignUpCorporate: json["customersSignUp_Corporate"] == null ? null : CustomersSignUpCorporate.fromJson(json["customersSignUp_Corporate"]),
  );

  Map<String, dynamic> toJson() => {
    "customersSignUp_Corporate": customersSignUpCorporate == null ? null : customersSignUpCorporate?.toJson(),
  };
}

class CustomersSignUpCorporate {
  CustomersSignUpCorporate({
    required this.token,
    required this.customer,
    required this.isProfileCompleted,
  });

  String? token;
  Customer? customer;
  int? isProfileCompleted;

  factory CustomersSignUpCorporate.fromJson(Map<String, dynamic> json) => CustomersSignUpCorporate(
    token: json["token"] == null ? null : json["token"],
    customer: json["customer"] == null ? null : Customer.fromJson(json["customer"]),
    isProfileCompleted: json["isProfile_Completed"] == null ? null : json["isProfile_Completed"],
  );

  Map<String, dynamic> toJson() => {
    "token": token == null ? null : token,
    "customer": customer == null ? null : customer?.toJson(),
    "isProfile_Completed": isProfileCompleted == null ? null : isProfileCompleted,
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
  String profilePic;
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
    profilePic: json["profilePic"]== null ? null : json["profilePic"],
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
