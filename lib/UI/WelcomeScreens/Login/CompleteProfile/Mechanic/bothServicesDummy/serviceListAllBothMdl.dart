// To parse this JSON data, do
//
//     final serviceListAllBothMdl = serviceListAllBothMdlFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ServiceListAllBothMdl serviceListAllBothMdlFromJson(String str) => ServiceListAllBothMdl.fromJson(json.decode(str));

String serviceListAllBothMdlToJson(ServiceListAllBothMdl data) => json.encode(data.toJson());

class ServiceListAllBothMdl {
  ServiceListAllBothMdl({
    required this.message,
    required this.status,
    required this.data,
  });

  String message;
  String status;
  Data? data;

  factory ServiceListAllBothMdl.fromJson(Map<String, dynamic> json) => ServiceListAllBothMdl(
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
    required this.serviceListAll,
  });

  List<ServiceListAll>? serviceListAll;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    serviceListAll: json["serviceListAll"] == null ? null : List<ServiceListAll>.from(json["serviceListAll"].map((x) => ServiceListAll.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "serviceListAll": serviceListAll == null ? null : List<dynamic>.from(serviceListAll!.map((x) => x.toJson())),
  };
}

class ServiceListAll {
  ServiceListAll({
    required this.id,
    required this.serviceName,
    required this.description,
    required this.icon,
    required this.minPrice,
    required this.maxPrice,
    required this.categoryId,
    required this.status,
  });

  String id;
  String serviceName;
  dynamic description;
  dynamic icon;
  String minPrice;
  String maxPrice;
  int categoryId;
  int status;

  factory ServiceListAll.fromJson(Map<String, dynamic> json) => ServiceListAll(
    id: json["id"] == null ? null : json["id"],
    serviceName: json["serviceName"] == null ? null : json["serviceName"],
    description: json["description"],
    icon: json["icon"],
    minPrice: json["minPrice"] == null ? null : json["minPrice"],
    maxPrice: json["maxPrice"] == null ? null : json["maxPrice"],
    categoryId: json["categoryId"] == null ? null : json["categoryId"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "serviceName": serviceName == null ? null : serviceName,
    "description": description,
    "icon": icon,
    "minPrice": minPrice == null ? null : minPrice,
    "maxPrice": maxPrice == null ? null : maxPrice,
    "categoryId": categoryId == null ? null : categoryId,
    "status": status == null ? null : status,
  };
}
