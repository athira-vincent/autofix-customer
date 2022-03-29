// To parse this JSON data, do
//
//     final signUpMdl = signUpMdlFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SignUpMdl signUpMdlFromJson(String str) => SignUpMdl.fromJson(json.decode(str));

String signUpMdlToJson(SignUpMdl data) => json.encode(data.toJson());

class SignUpMdl {
  SignUpMdl({
    required this.message,
    required this.status,
    required this.data,
  });

  String? message;
  String? status;
  Data? data;

  factory SignUpMdl.fromJson(Map<String, dynamic> json) => SignUpMdl(
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
    required this.signUp,
  });

  SignUp? signUp;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    signUp: json["signUp"] == null ? null : SignUp.fromJson(json["signUp"]),
  );

  Map<String, dynamic> toJson() => {
    "signUp": signUp == null ? null : signUp?.toJson(),
  };
}

class SignUp {
  SignUp({
    required this.token,
    required this.customer,
    required this.mechanic,
    required this.vendor,
    required this.generalCustomer,
    required this.genMechanic,
    required this.genVendor,
    required this.isProfileCompleted,
  });

  String token;
  Customer? customer;
  Mechanic? mechanic;
  dynamic vendor;
  GeneralCustomer? generalCustomer;
  GenMechanic? genMechanic;
  dynamic genVendor;
  int isProfileCompleted;

  factory SignUp.fromJson(Map<String, dynamic> json) => SignUp(
    token: json["token"] == null ? null : json["token"],
    customer: json["customer"] == null ? null : Customer.fromJson(json["customer"]),
    mechanic: json["mechanic"] == null ? null : Mechanic.fromJson(json["mechanic"]),
    vendor: json["vendor"],
    generalCustomer: json["generalCustomer"] == null ? null : GeneralCustomer.fromJson(json["generalCustomer"]),
    genMechanic: json["genMechanic"] == null ? null : GenMechanic.fromJson(json["genMechanic"]),
    genVendor: json["genVendor"],
    isProfileCompleted: json["isProfileCompleted"] == null ? null : json["isProfileCompleted"],
  );

  Map<String, dynamic> toJson() => {
    "token": token == null ? null : token,
    "customer": customer == null ? null : customer?.toJson(),
    "mechanic": mechanic == null ? null : mechanic?.toJson(),
    "vendor": vendor,
    "generalCustomer": generalCustomer == null ? null : generalCustomer?.toJson(),
    "genMechanic": genMechanic == null ? null : genMechanic?.toJson(),
    "genVendor": genVendor,
    "isProfileCompleted": isProfileCompleted == null ? null : isProfileCompleted,
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
    required this.accountType,
    required this.status,
    required this.jwtToken,
  });

  int id;
  String userCode;
  String firstName;
  String lastName;
  String emailId;
  String phoneNo;
  int accountType;
  int status;
  dynamic jwtToken;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    id: json["id"] == null ? null : json["id"],
    userCode: json["userCode"] == null ? null : json["userCode"],
    firstName: json["firstName"] == null ? null : json["firstName"],
    lastName: json["lastName"] == null ? null : json["lastName"],
    emailId: json["emailId"] == null ? null : json["emailId"],
    phoneNo: json["phoneNo"] == null ? null : json["phoneNo"],
    accountType: json["accountType"] == null ? null : json["accountType"],
    status: json["status"] == null ? null : json["status"],
    jwtToken: json["jwtToken"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "userCode": userCode == null ? null : userCode,
    "firstName": firstName == null ? null : firstName,
    "lastName": lastName == null ? null : lastName,
    "emailId": emailId == null ? null : emailId,
    "phoneNo": phoneNo == null ? null : phoneNo,
    "accountType": accountType == null ? null : accountType,
    "status": status == null ? null : status,
    "jwtToken": jwtToken,
  };
}

class GenMechanic {
  GenMechanic({
    required this.id,
    required this.orgName,
    required this.orgType,
    required this.yearExp,
    required this.userId,
    required this.latitude,
    required this.longitude,
    required this.profilePic,
    required this.otpVerified,
    required this.state,
    required this.resetToken,
    required this.isProfileCompleted,
    required this.status,
  });

  String id;
  dynamic orgName;
  dynamic orgType;
  String yearExp;
  int userId;
  double latitude;
  double longitude;
  String profilePic;
  int otpVerified;
  String state;
  dynamic resetToken;
  int isProfileCompleted;
  int status;

  factory GenMechanic.fromJson(Map<String, dynamic> json) => GenMechanic(
    id: json["id"] == null ? null : json["id"],
    orgName: json["org_name"],
    orgType: json["org_type"],
    yearExp: json["year_exp"] == null ? null : json["year_exp"],
    userId: json["userId"] == null ? null : json["userId"],
    latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
    longitude: json["longitude"] == null ? null : json["longitude"].toDouble(),
    profilePic: json["profilePic"] == null ? null : json["profilePic"],
    otpVerified: json["otp_verified"] == null ? null : json["otp_verified"],
    state: json["state"] == null ? null : json["state"],
    resetToken: json["resetToken"],
    isProfileCompleted: json["isProfileCompleted"] == null ? null : json["isProfileCompleted"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "org_name": orgName,
    "org_type": orgType,
    "year_exp": yearExp == null ? null : yearExp,
    "userId": userId == null ? null : userId,
    "latitude": latitude == null ? null : latitude,
    "longitude": longitude == null ? null : longitude,
    "profilePic": profilePic == null ? null : profilePic,
    "otp_verified": otpVerified == null ? null : otpVerified,
    "state": state == null ? null : state,
    "resetToken": resetToken,
    "isProfileCompleted": isProfileCompleted == null ? null : isProfileCompleted,
    "status": status == null ? null : status,
  };
}

class GeneralCustomer {
  GeneralCustomer({
    required this.id,
    required this.orgName,
    required this.orgType,
    required this.userId,
    required this.profilePic,
    required this.state,
    required this.resetToken,
    required this.isProfileCompleted,
    required this.govtType,
    required this.govtAgency,
    required this.ministryName,
    required this.headOfDept,
    required this.status,
  });

  String id;
  dynamic orgName;
  dynamic orgType;
  int userId;
  String profilePic;
  String state;
  String resetToken;
  int isProfileCompleted;
  dynamic govtType;
  dynamic govtAgency;
  dynamic ministryName;
  dynamic headOfDept;
  int status;

  factory GeneralCustomer.fromJson(Map<String, dynamic> json) => GeneralCustomer(
    id: json["id"] == null ? null : json["id"],
    orgName: json["org_name"],
    orgType: json["org_type"],
    userId: json["userId"] == null ? null : json["userId"],
    profilePic: json["profilePic"] == null ? null : json["profilePic"],
    state: json["state"] == null ? null : json["state"],
    resetToken: json["resetToken"] == null ? null : json["resetToken"],
    isProfileCompleted: json["isProfileCompleted"] == null ? null : json["isProfileCompleted"],
    govtType: json["govt_type"],
    govtAgency: json["govt_agency"],
    ministryName: json["ministry_name"],
    headOfDept: json["head_of_dept"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "org_name": orgName,
    "org_type": orgType,
    "userId": userId == null ? null : userId,
    "profilePic": profilePic == null ? null : profilePic,
    "state": state == null ? null : state,
    "resetToken": resetToken == null ? null : resetToken,
    "isProfileCompleted": isProfileCompleted == null ? null : isProfileCompleted,
    "govt_type": govtType,
    "govt_agency": govtAgency,
    "ministry_name": ministryName,
    "head_of_dept": headOfDept,
    "status": status == null ? null : status,
  };
}

class Mechanic {
  Mechanic({
    required this.id,
    required this.userCode,
    required this.firstName,
    required this.lastName,
    required this.emailId,
    required this.phoneNo,
    required this.userTypeId,
    required this.accountType,
    required this.jwtToken,
    required this.status,
  });

  String id;
  String userCode;
  String firstName;
  String lastName;
  String emailId;
  String phoneNo;
  int userTypeId;
  int accountType;
  dynamic jwtToken;
  int status;

  factory Mechanic.fromJson(Map<String, dynamic> json) => Mechanic(
    id: json["id"] == null ? null : json["id"],
    userCode: json["userCode"] == null ? null : json["userCode"],
    firstName: json["firstName"] == null ? null : json["firstName"],
    lastName: json["lastName"] == null ? null : json["lastName"],
    emailId: json["emailId"] == null ? null : json["emailId"],
    phoneNo: json["phoneNo"] == null ? null : json["phoneNo"],
    userTypeId: json["userTypeId"] == null ? null : json["userTypeId"],
    accountType: json["accountType"] == null ? null : json["accountType"],
    jwtToken: json["jwtToken"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "userCode": userCode == null ? null : userCode,
    "firstName": firstName == null ? null : firstName,
    "lastName": lastName == null ? null : lastName,
    "emailId": emailId == null ? null : emailId,
    "phoneNo": phoneNo == null ? null : phoneNo,
    "userTypeId": userTypeId == null ? null : userTypeId,
    "accountType": accountType == null ? null : accountType,
    "jwtToken": jwtToken,
    "status": status == null ? null : status,
  };
}
