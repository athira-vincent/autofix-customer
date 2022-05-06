// To parse this JSON data, do
//
//     final mechanicBrandSpecializationMdl = mechanicBrandSpecializationMdlFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MechanicBrandSpecializationMdl mechanicBrandSpecializationMdlFromJson(String str) => MechanicBrandSpecializationMdl.fromJson(json.decode(str));

String mechanicBrandSpecializationMdlToJson(MechanicBrandSpecializationMdl data) => json.encode(data.toJson());

class MechanicBrandSpecializationMdl {
  MechanicBrandSpecializationMdl({
    required this.data,
    required this.message,
    required this.status,
  });

  String message;
  String status;
  Data? data;

  factory MechanicBrandSpecializationMdl.fromJson(Map<String, dynamic> json) => MechanicBrandSpecializationMdl(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    message: json["message"] == null ? null : json["message"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? null : data!.toJson(),
    "message": message == null ? null : message,
    "status": status == null ? null : status,
  };
}

class Data {
  Data({
    required this.brandDetails,
  });

  List<BrandDetail>? brandDetails;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    brandDetails: json["brandDetails"] == null ? null : List<BrandDetail>.from(json["brandDetails"].map((x) => BrandDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "brandDetails": brandDetails == null ? null : List<dynamic>.from(brandDetails!.map((x) => x.toJson())),
  };
}

class BrandDetail {
  BrandDetail({
    required this.id,
    required this.brandName,
    required this.icon,
    required this.status,
  });

  String id;
  String brandName;
  String icon;
  int status;

  factory BrandDetail.fromJson(Map<String, dynamic> json) => BrandDetail(
    id: json["id"] == null ? null : json["id"],
    brandName: json["brandName"] == null ? null : json["brandName"],
    icon: json["icon"] == null ? null : json["icon"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "brandName": brandName == null ? null : brandName,
    "icon": icon == null ? null : icon,
    "status": status == null ? null : status,
  };
}
