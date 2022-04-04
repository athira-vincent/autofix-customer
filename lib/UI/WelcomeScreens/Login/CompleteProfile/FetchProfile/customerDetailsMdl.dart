// To parse this JSON data, do
//
//     final customerDetailsMdl = customerDetailsMdlFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CustomerDetailsMdl customerDetailsMdlFromJson(String str) => CustomerDetailsMdl.fromJson(json.decode(str));

String customerDetailsMdlToJson(CustomerDetailsMdl data) => json.encode(data.toJson());

class CustomerDetailsMdl {
  CustomerDetailsMdl({
    required this.message,
    required this.status,
    required this.data,
  });

  String message;
  String status;
  Data? data;

  factory CustomerDetailsMdl.fromJson(Map<String, dynamic> json) => CustomerDetailsMdl(
    message: json["message"] == null ? null : json["message"],
    status: json["status"] == null ? null : json["status"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
    "status": status == null ? null : status,
    "data": data == null ? null : data?.toJson(),
  };
}

class Data {
  Data({
    required this.customerDetails,
  });

  CustomerDetails? customerDetails;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    customerDetails: json["customer_Details"] == null ? null : CustomerDetails.fromJson(json["customer_Details"]),
  );

  Map<String, dynamic> toJson() => {
    "customer_Details": customerDetails == null ? null : customerDetails?.toJson(),
  };
}

class CustomerDetails {
  CustomerDetails({
    required this.id,
    required this.userCode,
    required this.firstName,
    required this.lastName,
    required this.emailId,
    required this.phoneNo,
    required this.accountType,
    required this.status,
    required this.jwtToken,
    required this.fcmToke,
    required this.otpCode,
    required this.customer,
  });

  int id;
  String userCode;
  String firstName;
  String lastName;
  String emailId;
  String phoneNo;
  dynamic accountType;
  int status;
  String jwtToken;
  dynamic fcmToke;
  dynamic otpCode;
  List<Customer>? customer;

  factory CustomerDetails.fromJson(Map<String, dynamic> json) => CustomerDetails(
    id: json["id"] == null ? null : json["id"],
    userCode: json["userCode"] == null ? null : json["userCode"],
    firstName: json["firstName"] == null ? null : json["firstName"],
    lastName: json["lastName"] == null ? null : json["lastName"],
    emailId: json["emailId"] == null ? null : json["emailId"],
    phoneNo: json["phoneNo"] == null ? null : json["phoneNo"],
    accountType: json["accountType"],
    status: json["status"] == null ? null : json["status"],
    jwtToken: json["jwtToken"] == null ? null : json["jwtToken"],
    fcmToke: json["fcmToke"],
    otpCode: json["otpCode"],
    customer: json["customer"] == null ? null : List<Customer>.from(json["customer"].map((x) => Customer.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "userCode": userCode == null ? null : userCode,
    "firstName": firstName == null ? null : firstName,
    "lastName": lastName == null ? null : lastName,
    "emailId": emailId == null ? null : emailId,
    "phoneNo": phoneNo == null ? null : phoneNo,
    "accountType": accountType,
    "status": status == null ? null : status,
    "jwtToken": jwtToken == null ? null : jwtToken,
    "fcmToke": fcmToke,
    "otpCode": otpCode,
    "customer": customer == null ? null : List<dynamic>.from(customer!.map((x) => x.toJson())),
  };
}

class Customer {
  Customer({
    required this.id,
    required this.custType,
    required this.orgName,
    required this.orgType,
    required this.userId,
    required this.profilePic,
    required this.state,
    required this.ministryName,
    required this.hod,
    required this.status,
  });

  String id;
  String custType;
  dynamic orgName;
  dynamic orgType;
  int userId;
  String profilePic;
  String state;
  dynamic ministryName;
  dynamic hod;
  int status;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    id: json["id"] == null ? null : json["id"],
    custType: json["custType"] == null ? null : json["custType"],
    orgName: json["orgName"],
    orgType: json["orgType"],
    userId: json["userId"] == null ? null : json["userId"],
    profilePic: json["profilePic"] == null ? null : json["profilePic"],
    state: json["state"] == null ? null : json["state"],
    ministryName: json["ministryName"],
    hod: json["hod"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "custType": custType == null ? null : custType,
    "orgName": orgName,
    "orgType": orgType,
    "userId": userId == null ? null : userId,
    "profilePic": profilePic == null ? null : profilePic,
    "state": state == null ? null : state,
    "ministryName": ministryName,
    "hod": hod,
    "status": status == null ? null : status,
  };
}
