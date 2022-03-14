// To parse this JSON data, do
//
//     final mechanicSignUpCorporateMdl = mechanicSignUpCorporateMdlFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MechanicSignUpCorporateMdl mechanicSignUpCorporateMdlFromJson(String str) => MechanicSignUpCorporateMdl.fromJson(json.decode(str));

String mechanicSignUpCorporateMdlToJson(MechanicSignUpCorporateMdl data) => json.encode(data.toJson());

class MechanicSignUpCorporateMdl {
  MechanicSignUpCorporateMdl({
    required this.message,
    required this.status,
    required this.data,
  });

  String message;
  String status;
  Data? data;

  factory MechanicSignUpCorporateMdl.fromJson(Map<String, dynamic> json) => MechanicSignUpCorporateMdl(
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
    required this.mechanicSignUpCorporate,
  });

  MechanicSignUpCorporate? mechanicSignUpCorporate;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    mechanicSignUpCorporate: json["mechanic_signUp_Corporate"] == null ? null : MechanicSignUpCorporate.fromJson(json["mechanic_signUp_Corporate"]),
  );

  Map<String, dynamic> toJson() => {
    "mechanic_signUp_Corporate": mechanicSignUpCorporate == null ? null : mechanicSignUpCorporate?.toJson(),
  };
}

class MechanicSignUpCorporate {
  MechanicSignUpCorporate({
    required this.token,
    required this.mechanic,
    required this.genMechanic,
  });

  String? token;
  Mechanic? mechanic;
  GenMechanic? genMechanic;

  factory MechanicSignUpCorporate.fromJson(Map<String, dynamic> json) => MechanicSignUpCorporate(
    token: json["token"] == null ? null : json["token"],
    mechanic: json["mechanic"] == null ? null : Mechanic.fromJson(json["mechanic"]),
    genMechanic: json["genMechanic"] == null ? null : GenMechanic.fromJson(json["genMechanic"]),
  );

  Map<String, dynamic> toJson() => {
    "token": token == null ? null : token,
    "mechanic": mechanic == null ? null : mechanic?.toJson(),
    "genMechanic": genMechanic == null ? null : genMechanic?.toJson(),
  };
}

class GenMechanic {
  GenMechanic({
    required this.id,
    required this.orgName,
    required this.orgType,
    required this.yearExp,
    required this.userId,
    required this.status,
  });

  String id;
  String orgName;
  String orgType;
  String yearExp;
  int userId;
  int status;

  factory GenMechanic.fromJson(Map<String, dynamic> json) => GenMechanic(
    id: json["id"] == null ? null : json["id"],
    orgName: json["org_name"] == null ? null : json["org_name"],
    orgType: json["org_type"] == null ? null : json["org_type"],
    yearExp: json["year_exp"] == null ? null : json["year_exp"],
    userId: json["userId"] == null ? null : json["userId"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "org_name": orgName == null ? null : orgName,
    "org_type": orgType == null ? null : orgType,
    "year_exp": yearExp == null ? null : yearExp,
    "userId": userId == null ? null : userId,
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
    required this.state,
    required this.latitude,
    required this.longitude,
    required this.resetToken,
    required this.userType,
    required this.accountType,
    required this.profilepic,
    required this.otpVerified,
    required this.status,
  });

  String id;
  String userCode;
  String firstName;
  String lastName;
  String emailId;
  String phoneNo;
  String state;
  double latitude;
  double longitude;
  String resetToken;
  int userType;
  int accountType;
  String profilepic;
  int otpVerified;
  int status;

  factory Mechanic.fromJson(Map<String, dynamic> json) => Mechanic(
    id: json["id"] == null ? null : json["id"],
    userCode: json["userCode"] == null ? null : json["userCode"],
    firstName: json["firstName"] == null ? null : json["firstName"],
    lastName: json["lastName"] == null ? null : json["lastName"],
    emailId: json["emailId"] == null ? null : json["emailId"],
    phoneNo: json["phoneNo"] == null ? null : json["phoneNo"],
    state: json["state"] == null ? null : json["state"],
    latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
    longitude: json["longitude"] == null ? null : json["longitude"].toDouble(),
    resetToken: json["resetToken"] == null ? null : json["resetToken"],
    userType: json["userType"] == null ? null : json["userType"],
    accountType: json["accountType"] == null ? null : json["accountType"],
    profilepic: json["profilepic"] == null ? null : json["profilepic"],
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
    "latitude": latitude == null ? null : latitude,
    "longitude": longitude == null ? null : longitude,
    "resetToken": resetToken == null ? null : resetToken,
    "userType": userType == null ? null : userType,
    "accountType": accountType == null ? null : accountType,
    "profilepic": profilepic == null ? null : profilepic,
    "otp_verified": otpVerified == null ? null : otpVerified,
    "status": status == null ? null : status,
  };
}
