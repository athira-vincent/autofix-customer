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

  String message;
  String status;
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
    required this.brand,
    required this.model,
    required this.engine,
    required this.year,
    required this.plateNo,
    required this.lastMaintenance,
    required this.milege,
    required this.vehiclePic,
    required this.color,
    required this.latitude,
    required this.longitude,
    required this.defaultVehicle,
    required this.status,
    required this.userId,
  });

  String id;
  String brand;
  String model;
  String engine;
  String year;
  String plateNo;
  String lastMaintenance;
  String milege;
  String vehiclePic;
  String color;
  double latitude;
  double longitude;
  int defaultVehicle;
  int status;
  int userId;

  factory VehicleCreate.fromJson(Map<String, dynamic> json) => VehicleCreate(
    id: json["id"] == null ? null : json["id"],
    brand: json["brand"] == null ? null : json["brand"],
    model: json["model"] == null ? null : json["model"],
    engine: json["engine"] == null ? null : json["engine"],
    year: json["year"] == null ? null : json["year"],
    plateNo: json["plateNo"] == null ? null : json["plateNo"],
    lastMaintenance: json["lastMaintenance"] == null ? null : json["lastMaintenance"],
    milege: json["milege"] == null ? null : json["milege"],
    vehiclePic: json["vehiclePic"] == null ? null : json["vehiclePic"],
    color: json["color"] == null ? null : json["color"],
    latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
    longitude: json["longitude"] == null ? null : json["longitude"].toDouble(),
    defaultVehicle: json["defaultVehicle"] == null ? null : json["defaultVehicle"],
    status: json["status"] == null ? null : json["status"],
    userId: json["userId"] == null ? null : json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "brand": brand == null ? null : brand,
    "model": model == null ? null : model,
    "engine": engine == null ? null : engine,
    "year": year == null ? null : year,
    "plateNo": plateNo == null ? null : plateNo,
    "lastMaintenance": lastMaintenance == null ? null : lastMaintenance,
    "milege": milege == null ? null : milege,
    "vehiclePic": vehiclePic == null ? null : vehiclePic,
    "color": color == null ? null : color,
    "latitude": latitude == null ? null : latitude,
    "longitude": longitude == null ? null : longitude,
    "defaultVehicle": defaultVehicle == null ? null : defaultVehicle,
    "status": status == null ? null : status,
    "userId": userId == null ? null : userId,
  };
}

