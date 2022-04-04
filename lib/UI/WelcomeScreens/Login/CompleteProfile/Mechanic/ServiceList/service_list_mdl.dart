// To parse this JSON data, do
//
//     final serviceListMdl = serviceListMdlFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ServiceListMdl serviceListMdlFromJson(String str) => ServiceListMdl.fromJson(json.decode(str));

String serviceListMdlToJson(ServiceListMdl data) => json.encode(data.toJson());

class ServiceListMdl {
  ServiceListMdl({
    required this.data,
    required this.message,
    required this.status,
  });

  Data? data;
  String message;
  String status;

  factory ServiceListMdl.fromJson(Map<String, dynamic> json) => ServiceListMdl(
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
