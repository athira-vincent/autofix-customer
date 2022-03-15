// To parse this JSON data, do
//
//     final mechaniclistForServicesMdl = mechaniclistForServicesMdlFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MechaniclistForServicesMdl mechaniclistForServicesMdlFromJson(String str) => MechaniclistForServicesMdl.fromJson(json.decode(str));

String mechaniclistForServicesMdlToJson(MechaniclistForServicesMdl data) => json.encode(data.toJson());

class MechaniclistForServicesMdl {
  MechaniclistForServicesMdl({
    required this.message,
    required this.status,
    required this.data,
  });

  String message;
  String status;
  Data? data;

  factory MechaniclistForServicesMdl.fromJson(Map<String, dynamic> json) => MechaniclistForServicesMdl(
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
    required this.mechaniclistForServices,
  });

  List<MechaniclistForService>? mechaniclistForServices;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    mechaniclistForServices: json["mechaniclist_for_services"] == null ? null : List<MechaniclistForService>.from(json["mechaniclist_for_services"].map((x) => MechaniclistForService.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "mechaniclist_for_services": mechaniclistForServices == null ? null : List<dynamic>.from(mechaniclistForServices!.map((x) => x.toJson())),
  };
}

class MechaniclistForService {
  MechaniclistForService({
    required this.id,
    required this.userCode,
    required this.firstName,
    required this.lastName,
    required this.emailId,
    required this.phoneNo,
    required this.state,
    required this.userType,
    required this.accountType,
    required this.profilePic,
    required this.isProfileCompleted,
    required this.status,
    required this.mechanicService,
    required this.mechanicVehicle,
  });

  String id;
  String userCode;
  String firstName;
  String lastName;
  String emailId;
  String phoneNo;
  String state;
  int userType;
  int accountType;
  dynamic profilePic;
  int isProfileCompleted;
  int status;
  List<MechanicService>? mechanicService;
  List<MechanicVehicle>? mechanicVehicle;

  factory MechaniclistForService.fromJson(Map<String, dynamic> json) => MechaniclistForService(
    id: json["id"] == null ? null : json["id"],
    userCode: json["userCode"] == null ? null : json["userCode"],
    firstName: json["firstName"] == null ? null : json["firstName"],
    lastName: json["lastName"] == null ? null : json["lastName"],
    emailId: json["emailId"] == null ? null : json["emailId"],
    phoneNo: json["phoneNo"] == null ? null : json["phoneNo"],
    state: json["state"] == null ? null : json["state"],
    userType: json["userType"] == null ? null : json["userType"],
    accountType: json["accountType"] == null ? null : json["accountType"],
    profilePic: json["profilePic"],
    isProfileCompleted: json["isProfile_Completed"] == null ? null : json["isProfile_Completed"],
    status: json["status"] == null ? null : json["status"],
    mechanicService: json["mechanicService"] == null ? null : List<MechanicService>.from(json["mechanicService"].map((x) => MechanicService.fromJson(x))),
    mechanicVehicle: json["mechanicVehicle"] == null ? null : List<MechanicVehicle>.from(json["mechanicVehicle"].map((x) => MechanicVehicle.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "userCode": userCode == null ? null : userCode,
    "firstName": firstName == null ? null : firstName,
    "lastName": lastName == null ? null : lastName,
    "emailId": emailId == null ? null : emailId,
    "phoneNo": phoneNo == null ? null : phoneNo,
    "state": state == null ? null : state,
    "userType": userType == null ? null : userType,
    "accountType": accountType == null ? null : accountType,
    "profilePic": profilePic,
    "isProfile_Completed": isProfileCompleted == null ? null : isProfileCompleted,
    "status": status == null ? null : status,
    "mechanicService": mechanicService == null ? null : List<dynamic>.from(mechanicService!.map((x) => x.toJson())),
    "mechanicVehicle": mechanicVehicle == null ? null : List<dynamic>.from(mechanicVehicle!.map((x) => x.toJson())),
  };
}

class MechanicService {
  MechanicService({
    required this.id,
    required this.fee,
    required this.serviceId,
    required this.status,
    required this.userId,
  });

  String id;
  String fee;
  int serviceId;
  int status;
  int userId;

  factory MechanicService.fromJson(Map<String, dynamic> json) => MechanicService(
    id: json["id"] == null ? null : json["id"],
    fee: json["fee"] == null ? null : json["fee"],
    serviceId: json["serviceId"] == null ? null : json["serviceId"],
    status: json["status"] == null ? null : json["status"],
    userId: json["userId"] == null ? null : json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "fee": fee == null ? null : fee,
    "serviceId": serviceId == null ? null : serviceId,
    "status": status == null ? null : status,
    "userId": userId == null ? null : userId,
  };
}

class MechanicVehicle {
  MechanicVehicle({
    required this.id,
    required this.status,
    required this.makeId,
  });

  String id;
  int status;
  int makeId;

  factory MechanicVehicle.fromJson(Map<String, dynamic> json) => MechanicVehicle(
    id: json["id"] == null ? null : json["id"],
    status: json["status"] == null ? null : json["status"],
    makeId: json["makeId"] == null ? null : json["makeId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "status": status == null ? null : status,
    "makeId": makeId == null ? null : makeId,
  };
}
