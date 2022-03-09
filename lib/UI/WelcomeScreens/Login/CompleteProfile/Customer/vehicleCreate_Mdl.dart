// To parse this JSON data, do
//
//     final vehicleCreateMdl = vehicleCreateMdlFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

VehicleCreateMdl vehicleCreateMdlFromJson(String str) => VehicleCreateMdl.fromJson(json.decode(str));

String vehicleCreateMdlToJson(VehicleCreateMdl data) => json.encode(data.toJson());

class VehicleCreateMdl {
  VehicleCreateMdl({
    required this.message,
    required this.status,
    required this.data,
  });

  String? message;
  String? status;
  Data? data;

  factory VehicleCreateMdl.fromJson(Map<String, dynamic> json) => VehicleCreateMdl(
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
    required this.vehicleCreate,
  });

  VehicleCreate? vehicleCreate;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    vehicleCreate: json["vehicleCreate"] == null ? null : VehicleCreate.fromJson(json["vehicleCreate"]),
  );

  Map<String, dynamic> toJson() => {
    "vehicleCreate": vehicleCreate == null ? null : vehicleCreate?.toJson(),
  };
}

class VehicleCreate {
  VehicleCreate({
    required this.id,
    required this.year,
    required this.plateNo,
    required this.engineName,
    required this.milege,
    required this.lastMaintenance,
    required this.defaultVehicle,
    required this.userId,
    required this.makeId,
    required this.vehicleModelId,
    required this.status,
  });

  String id;
  String year;
  String plateNo;
  String engineName;
  String milege;
  String lastMaintenance;
  int defaultVehicle;
  String userId;
  int makeId;
  int vehicleModelId;
  int status;

  factory VehicleCreate.fromJson(Map<String, dynamic> json) => VehicleCreate(
    id: json["id"] == null ? null : json["id"],
    year: json["year"] == null ? null : json["year"],
    plateNo: json["plateNo"] == null ? null : json["plateNo"],
    engineName: json["engineName"] == null ? null : json["engineName"],
    milege: json["milege"] == null ? null : json["milege"],
    lastMaintenance: json["lastMaintenance"] == null ? null : json["lastMaintenance"],
    defaultVehicle: json["defaultVehicle"] == null ? null : json["defaultVehicle"],
    userId: json["userId"] == null ? null : json["userId"],
    makeId: json["makeId"] == null ? null : json["makeId"],
    vehicleModelId: json["vehicleModelId"] == null ? null : json["vehicleModelId"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "year": year == null ? null : year,
    "plateNo": plateNo == null ? null : plateNo,
    "engineName": engineName == null ? null : engineName,
    "milege": milege == null ? null : milege,
    "lastMaintenance": lastMaintenance == null ? null : lastMaintenance,
    "defaultVehicle": defaultVehicle == null ? null : defaultVehicle,
    "userId": userId == null ? null : userId,
    "makeId": makeId == null ? null : makeId,
    "vehicleModelId": vehicleModelId == null ? null : vehicleModelId,
    "status": status == null ? null : status,
  };
}
