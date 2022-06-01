// To parse this JSON data, do
//
//     final mechanicServicesBasedListMdl = mechanicServicesBasedListMdlFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MechanicServicesBasedListMdl mechanicServicesBasedListMdlFromJson(String str) => MechanicServicesBasedListMdl.fromJson(json.decode(str));

String mechanicServicesBasedListMdlToJson(MechanicServicesBasedListMdl data) => json.encode(data.toJson());

class MechanicServicesBasedListMdl {
  MechanicServicesBasedListMdl({
    required this.message,
    required this.status,
    required this.data,
  });

  String message;
  String status;
  Data? data;

  factory MechanicServicesBasedListMdl.fromJson(Map<String, dynamic> json) => MechanicServicesBasedListMdl(
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
    required this.mechanicServicesList,
  });

  MechanicServicesList? mechanicServicesList;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    mechanicServicesList: json["mechanicServicesList"] == null ? null : MechanicServicesList.fromJson(json["mechanicServicesList"]),
  );

  Map<String, dynamic> toJson() => {
    "mechanicServicesList": mechanicServicesList == null ? null : mechanicServicesList!.toJson(),
  };
}

class MechanicServicesList {
  MechanicServicesList({
    required this.totalItems,
    required this.data,
    required this.totalPages,
    required this.currentPage,
  });

  int totalItems;
  List<Datum>? data;
  int totalPages;
  int currentPage;

  factory MechanicServicesList.fromJson(Map<String, dynamic> json) => MechanicServicesList(
    totalItems: json["totalItems"] == null ? null : json["totalItems"],
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    totalPages: json["totalPages"] == null ? null : json["totalPages"],
    currentPage: json["currentPage"] == null ? null : json["currentPage"],
  );

  Map<String, dynamic> toJson() => {
    "totalItems": totalItems == null ? null : totalItems,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
    "totalPages": totalPages == null ? null : totalPages,
    "currentPage": currentPage == null ? null : currentPage,
  };
}

class Datum {
  Datum({
    required this.id,
    required this.fee,
    required this.time,
    required this.service,
    required this.status,
    required this.userId,
    required this.serviceId,
  });

  String id;
  String fee;
  String time;
  Service? service;
  int status;
  int userId;
  int serviceId;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    fee: json["fee"] == null ? null : json["fee"],
    time: json["time"] == null ? null : json["time"],
    service: json["service"] == null ? null : Service.fromJson(json["service"]),
    status: json["status"] == null ? null : json["status"],
    userId: json["userId"] == null ? null : json["userId"],
    serviceId: json["serviceId"] == null ? null : json["serviceId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "fee": fee == null ? null : fee,
    "time": time == null ? null : time,
    "service": service == null ? null : service?.toJson(),
    "status": status == null ? null : status,
    "userId": userId == null ? null : userId,
    "serviceId": serviceId == null ? null : serviceId,
  };
}

class Service {
  Service({
    required this.id,
    required this.serviceName,
    required this.serviceCode,
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
  String serviceCode;
  dynamic description;
  String icon;
  String minPrice;
  String maxPrice;
  int categoryId;
  int status;
  Category? category;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
    id: json["id"] == null ? null : json["id"],
    serviceName: json["serviceName"] == null ? null : json["serviceName"],
    serviceCode: json["serviceCode"] == null ? null : json["serviceCode"],
    description: json["description"],
    icon: json["icon"] == null ? null : json["icon"],
    minPrice: json["minPrice"] == null ? null : json["minPrice"],
    maxPrice: json["maxPrice"] == null ? null : json["maxPrice"],
    categoryId: json["categoryId"] == null ? null : json["categoryId"],
    status: json["status"] == null ? null : json["status"],
    category: json["category"] == null ? null : Category.fromJson(json["category"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "serviceName": serviceName == null ? null : serviceName,
    "serviceCode": serviceCode == null ? null : serviceCode,
    "description": description,
    "icon": icon == null ? null : icon,
    "minPrice": minPrice == null ? null : minPrice,
    "maxPrice": maxPrice == null ? null : maxPrice,
    "categoryId": categoryId == null ? null : categoryId,
    "status": status == null ? null : status,
    "category": category == null ? null : category?.toJson(),
  };
}

class Category {
  Category({
    required this.id,
    required this.catType,
    required this.catName,
    required this.icon,
    required this.status,
  });

  String id;
  int catType;
  String catName;
  dynamic icon;
  int status;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"] == null ? null : json["id"],
    catType: json["catType"] == null ? null : json["catType"],
    catName: json["catName"] == null ? null : json["catName"],
    icon: json["icon"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "catType": catType == null ? null : catType,
    "catName": catName == null ? null : catName,
    "icon": icon,
    "status": status == null ? null : status,
  };
}
