// To parse this JSON data, do
//
//     final brandSpecializationMdl = brandSpecializationMdlFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

BrandSpecializationMdl brandSpecializationMdlFromJson(String str) => BrandSpecializationMdl.fromJson(json.decode(str));

String brandSpecializationMdlToJson(BrandSpecializationMdl data) => json.encode(data.toJson());

class BrandSpecializationMdl {
  BrandSpecializationMdl({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  Data? data;

  factory BrandSpecializationMdl.fromJson(Map<String, dynamic> json) => BrandSpecializationMdl(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : data!.toJson(),
  };
}

class Data {
  Data({
    required this.mechanicBrandList,
  });

  List<MechanicBrandList>? mechanicBrandList;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    mechanicBrandList: json["mechanicBrandList"] == null ? null : List<MechanicBrandList>.from(json["mechanicBrandList"].map((x) => MechanicBrandList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "mechanicBrandList": mechanicBrandList == null ? null : List<dynamic>.from(mechanicBrandList!.map((x) => x.toJson())),
  };
}

class MechanicBrandList {
  MechanicBrandList({
    required this.id,
    required this.brandName,
    required this.icon,
    required this.status,
    required this.inBrand,
  });

  int id;
  String brandName;
  String icon;
  int status;
  dynamic inBrand;

  factory MechanicBrandList.fromJson(Map<String, dynamic> json) => MechanicBrandList(
    id: json["id"] == null ? null : json["id"],
    brandName: json["brandName"] == null ? null : json["brandName"],
    icon: json["icon"] == null ? null : json["icon"],
    status: json["status"] == null ? null : json["status"],
    inBrand: json["inBrand"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "brandName": brandName == null ? null : brandName,
    "icon": icon == null ? null : icon,
    "status": status == null ? null : status,
    "inBrand": inBrand,
  };
}
