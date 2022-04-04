// To parse this JSON data, do
//
//     final custVehicleListMdl = custVehicleListMdlFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CustVehicleListMdl custVehicleListMdlFromJson(String str) => CustVehicleListMdl.fromJson(json.decode(str));

String custVehicleListMdlToJson(CustVehicleListMdl data) => json.encode(data.toJson());

class CustVehicleListMdl {
  CustVehicleListMdl({
    required this.message,
    required this.status,
    required this.data,
  });

  String message;
  String status;
  Data? data;

  factory CustVehicleListMdl.fromJson(Map<String, dynamic> json) => CustVehicleListMdl(
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
    required this.custVehicleList,
  });

  List<CustVehicleList>? custVehicleList;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    custVehicleList: json["Cust_vehicle_list"] == null ? null : List<CustVehicleList>.from(json["Cust_vehicle_list"].map((x) => CustVehicleList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Cust_vehicle_list": custVehicleList == null ? null : List<dynamic>.from(custVehicleList!.map((x) => x.toJson())),
  };
}

class CustVehicleList {
  CustVehicleList({
    required this.id,
    required this.year,
    required this.brand,
    required this.model,
    required this.engine,
    required this.plateNo,
    required this.milege,
    required this.lastMaintenance,
    required this.latitude,
    required this.longitude,
    required this.vehiclePic,
    required this.userId,
    required this.status,
    required this.defaultVehicle,
  });

  String id;
  String year;
  String brand;
  String model;
  String engine;
  String plateNo;
  String milege;
  String lastMaintenance;
  double latitude;
  double longitude;
  String vehiclePic;
  int userId;
  int status;
  int defaultVehicle;

  factory CustVehicleList.fromJson(Map<String, dynamic> json) => CustVehicleList(
    id: json["id"] == null ? null : json["id"],
    year: json["year"] == null ? null : json["year"],
    brand: json["brand"] == null ? null : json["brand"],
    model: json["model"] == null ? null : json["model"],
    engine: json["engine"] == null ? null : json["engine"],
    plateNo: json["plateNo"] == null ? null : json["plateNo"],
    milege: json["milege"] == null ? null : json["milege"],
    lastMaintenance: json["lastMaintenance"] == null ? null : json["lastMaintenance"],
    latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
    longitude: json["longitude"] == null ? null : json["longitude"].toDouble(),
    vehiclePic: json["vehiclePic"] == null ? null : json["vehiclePic"],
    userId: json["userId"] == null ? null : json["userId"],
    status: json["status"] == null ? null : json["status"],
    defaultVehicle: json["defaultVehicle"] == null ? null : json["defaultVehicle"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "year": year == null ? null : year,
    "brand": brand == null ? null : brand,
    "model": model == null ? null : model,
    "engine": engine == null ? null : engine,
    "plateNo": plateNo == null ? null : plateNo,
    "milege": milege == null ? null : milege,
    "lastMaintenance": lastMaintenance == null ? null : lastMaintenance,
    "latitude": latitude == null ? null : latitude,
    "longitude": longitude == null ? null : longitude,
    "vehiclePic": vehiclePic == null ? null : vehiclePic,
    "userId": userId == null ? null : userId,
    "status": status == null ? null : status,
    "defaultVehicle": defaultVehicle == null ? null : defaultVehicle,
  };
}
