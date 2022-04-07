// To parse this JSON data, do
//
//     final mechanicProfileMdl = mechanicProfileMdlFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MechanicProfileMdl mechanicProfileMdlFromJson(String str) => MechanicProfileMdl.fromJson(json.decode(str));

String mechanicProfileMdlToJson(MechanicProfileMdl data) => json.encode(data.toJson());

class MechanicProfileMdl {
  MechanicProfileMdl({
    required this.message,
    required this.status,
    required this.data,
  });

  String message;
  String status;
  Data? data;

  factory MechanicProfileMdl.fromJson(Map<String, dynamic> json) => MechanicProfileMdl(
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
    required this.mechanicDetails,
  });

  MechanicDetails? mechanicDetails;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    mechanicDetails: json["mechanic_Details"] == null ? null : MechanicDetails.fromJson(json["mechanic_Details"]),
  );

  Map<String, dynamic> toJson() => {
    "mechanic_Details": mechanicDetails == null ? null : mechanicDetails!.toJson(),
  };
}

class MechanicDetails {
  MechanicDetails({
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
    required this.mechanic,
    required this.mechanicService,
  });

  int id;
  String userCode;
  String firstName;
  String lastName;
  String emailId;
  String phoneNo;
  int userTypeId;
  dynamic accountType;
  String jwtToken;
  int status;
  List<Mechanic>? mechanic;
  List<MechanicService>? mechanicService;

  factory MechanicDetails.fromJson(Map<String, dynamic> json) => MechanicDetails(
    id: json["id"] == null ? null : json["id"],
    userCode: json["userCode"] == null ? null : json["userCode"],
    firstName: json["firstName"] == null ? null : json["firstName"],
    lastName: json["lastName"] == null ? null : json["lastName"],
    emailId: json["emailId"] == null ? null : json["emailId"],
    phoneNo: json["phoneNo"] == null ? null : json["phoneNo"],
    userTypeId: json["userTypeId"] == null ? null : json["userTypeId"],
    accountType: json["accountType"],
    jwtToken: json["jwtToken"] == null ? null : json["jwtToken"],
    status: json["status"] == null ? null : json["status"],
    mechanic: json["mechanic"] == null ? null : List<Mechanic>.from(json["mechanic"].map((x) => Mechanic.fromJson(x))),
    mechanicService: json["mechanicService"] == null ? null : List<MechanicService>.from(json["mechanicService"].map((x) => MechanicService.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "userCode": userCode == null ? null : userCode,
    "firstName": firstName == null ? null : firstName,
    "lastName": lastName == null ? null : lastName,
    "emailId": emailId == null ? null : emailId,
    "phoneNo": phoneNo == null ? null : phoneNo,
    "userTypeId": userTypeId == null ? null : userTypeId,
    "accountType": accountType,
    "jwtToken": jwtToken == null ? null : jwtToken,
    "status": status == null ? null : status,
    "mechanic": mechanic == null ? null : List<dynamic>.from(mechanic!.map((x) => x.toJson())),
    "mechanicService": mechanicService == null ? null : List<dynamic>.from(mechanicService!.map((x) => x.toJson())),
  };
}

class Mechanic {
  Mechanic({
    required this.id,
    required this.orgName,
    required this.orgType,
    required this.yearExp,
    required this.mechType,
    required this.userId,
    required this.profilePic,
    required this.state,
    required this.status,
  });

  String id;
  String orgName;
  String orgType;
  String yearExp;
  String mechType;
  int userId;
  String profilePic;
  String state;
  int status;

  factory Mechanic.fromJson(Map<String, dynamic> json) => Mechanic(
    id: json["id"] == null ? null : json["id"],
    orgName: json["orgName"] == null ? null : json["orgName"],
    orgType: json["orgType"] == null ? null : json["orgType"],
    yearExp: json["yearExp"] == null ? null : json["yearExp"],
    mechType: json["mechType"] == null ? null : json["mechType"],
    userId: json["userId"] == null ? null : json["userId"],
    profilePic: json["profilePic"] == null ? null : json["profilePic"],
    state: json["state"] == null ? null : json["state"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "orgName": orgName == null ? null : orgName,
    "orgType": orgType == null ? null : orgType,
    "yearExp": yearExp == null ? null : yearExp,
    "mechType": mechType == null ? null : mechType,
    "userId": userId == null ? null : userId,
    "profilePic": profilePic == null ? null : profilePic,
    "state": state == null ? null : state,
    "status": status == null ? null : status,
  };
}

class MechanicService {
  MechanicService({
    required this.id,
    required this.fee,
    required this.status,
    required this.userId,
  });

  String id;
  String fee;
  int status;
  int userId;

  factory MechanicService.fromJson(Map<String, dynamic> json) => MechanicService(
    id: json["id"] == null ? null : json["id"],
    fee: json["fee"] == null ? null : json["fee"],
    status: json["status"] == null ? null : json["status"],
    userId: json["userId"] == null ? null : json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "fee": fee == null ? null : fee,
    "status": status == null ? null : status,
    "userId": userId == null ? null : userId,
  };
}
