// To parse this JSON data, do
//
//     final serviceSearchListAllMdl = serviceSearchListAllMdlFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ServiceSearchListAllMdl serviceSearchListAllMdlFromJson(String str) => ServiceSearchListAllMdl.fromJson(json.decode(str));

String serviceSearchListAllMdlToJson(ServiceSearchListAllMdl data) => json.encode(data.toJson());

class ServiceSearchListAllMdl {
  ServiceSearchListAllMdl({
    required this.message,
    required this.status,
    required this.data,
  });

  String message;
  String status;
  Data? data;

  factory ServiceSearchListAllMdl.fromJson(Map<String, dynamic> json) => ServiceSearchListAllMdl(
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
    required this.category,
  });

  String id;
  String serviceName;
  dynamic description;
  dynamic icon;
  String minPrice;
  String maxPrice;
  int categoryId;
  int status;
  List<Category>? category;

  factory ServiceListAll.fromJson(Map<String, dynamic> json) => ServiceListAll(
    id: json["id"] == null ? null : json["id"],
    serviceName: json["serviceName"] == null ? null : json["serviceName"],
    description: json["description"],
    icon: json["icon"],
    minPrice: json["minPrice"] == null ? null : json["minPrice"],
    maxPrice: json["maxPrice"] == null ? null : json["maxPrice"],
    categoryId: json["categoryId"] == null ? null : json["categoryId"],
    status: json["status"] == null ? null : json["status"],
    category: json["category"] == null ? null : List<Category>.from(json["category"].map((x) => Category.fromJson(x))),
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
    "category": category == null ? null : List<dynamic>.from(category!.map((x) => x.toJson())),
  };
}

class Category {
  Category({
    required this.id,
    required this.catType,
    required this.catName,
    required this.icon,
    required this.status,
    required this.service,
  });

  String id;
  int catType;
  String catName;
  dynamic icon;
  int status;
  dynamic service;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"] == null ? null : json["id"],
    catType: json["catType"] == null ? null : json["catType"],
    catName: json["catName"] == null ? null : json["catName"],
    icon: json["icon"],
    status: json["status"] == null ? null : json["status"],
    service: json["service"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "catType": catType == null ? null : catType,
    "catName": catName == null ? null : catName,
    "icon": icon,
    "status": status == null ? null : status,
    "service": service,
  };
}
