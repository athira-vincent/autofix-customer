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
    "data": data == null ? null : data!.toJson(),
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
    required this.minAmount,
    required this.maxAmount,
    required this.type,
    required this.status,
  });

  String id;
  String serviceName;
  String description;
  dynamic icon;
  String minAmount;
  String maxAmount;
  String type;
  int status;

  factory ServiceListAll.fromJson(Map<String, dynamic> json) => ServiceListAll(
    id: json["id"] == null ? null : json["id"],
    serviceName: json["serviceName"] == null ? null : json["serviceName"],
    description: json["description"] == null ? null : json["description"],
    icon: json["icon"],
    minAmount: json["minAmount"] == null ? null : json["minAmount"],
    maxAmount: json["maxAmount"] == null ? null : json["maxAmount"],
    type: json["type"] == null ? null : json["type"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "serviceName": serviceName == null ? null : serviceName,
    "description": description == null ? null : description,
    "icon": icon,
    "minAmount": minAmount == null ? null : minAmount,
    "maxAmount": maxAmount == null ? null : maxAmount,
    "type": type == null ? null : type,
    "status": status == null ? null : status,
  };
}
