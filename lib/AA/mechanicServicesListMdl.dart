// To parse this JSON data, do
//
//     final mechanicServicesListMdl = mechanicServicesListMdlFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MechanicServicesListMdl mechanicServicesListMdlFromJson(String str) => MechanicServicesListMdl.fromJson(json.decode(str));

String mechanicServicesListMdlToJson(MechanicServicesListMdl data) => json.encode(data.toJson());

class MechanicServicesListMdl {
  MechanicServicesListMdl({
    required this.mechanicService,
  });

  List<MechanicService1>? mechanicService;

  factory MechanicServicesListMdl.fromJson(Map<String, dynamic> json) => MechanicServicesListMdl(
    mechanicService: json["mechanicService"] == null ? null : List<MechanicService1>.from(json["mechanicService"].map((x) => MechanicService1.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "mechanicService": mechanicService == null ? null : List<dynamic>.from(mechanicService!.map((x) => x.toJson())),
  };
}

class MechanicService1 {
  MechanicService1({
    required this.id,
    required this.fee,
    required this.service,
    required this.status,
    required this.userId,
  });

  String id;
  String fee;
  Service? service;
  int status;
  int userId;

  factory MechanicService1.fromJson(Map<String, dynamic> json) => MechanicService1(
    id: json["id"] == null ? null : json["id"],
    fee: json["fee"] == null ? null : json["fee"],
    service: json["service"] == null ? null : Service.fromJson(json["service"]),
    status: json["status"] == null ? null : json["status"],
    userId: json["userId"] == null ? null : json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "fee": fee == null ? null : fee,
    "service": service == null ? null : service?.toJson(),
    "status": status == null ? null : status,
    "userId": userId == null ? null : userId,
  };
}

class Service {
  Service({
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
  String icon;
  String minPrice;
  String maxPrice;
  int categoryId;
  int status;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
    id: json["id"] == null ? null : json["id"],
    serviceName: json["serviceName"] == null ? null : json["serviceName"],
    description: json["description"],
    icon: json["icon"] == null ? null : json["icon"],
    minPrice: json["minPrice"] == null ? null : json["minPrice"],
    maxPrice: json["maxPrice"] == null ? null : json["maxPrice"],
    categoryId: json["categoryId"] == null ? null : json["categoryId"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "serviceName": serviceName == null ? null : serviceName,
    "description": description,
    "icon": icon == null ? null : icon,
    "minPrice": minPrice == null ? null : minPrice,
    "maxPrice": maxPrice == null ? null : maxPrice,
    "categoryId": categoryId == null ? null : categoryId,
    "status": status == null ? null : status,
  };
}
