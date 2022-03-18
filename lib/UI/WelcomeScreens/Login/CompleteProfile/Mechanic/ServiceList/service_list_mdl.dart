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
    required this.emeregencyOrRegularServiceList,
  });

  List<EmeregencyOrRegularServiceList>? emeregencyOrRegularServiceList;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    emeregencyOrRegularServiceList: json["emeregency_or_regular_serviceList"] == null ? null : List<EmeregencyOrRegularServiceList>.from(json["emeregency_or_regular_serviceList"].map((x) => EmeregencyOrRegularServiceList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "emeregency_or_regular_serviceList": emeregencyOrRegularServiceList == null ? null : List<dynamic>.from(emeregencyOrRegularServiceList!.map((x) => x.toJson())),
  };
}

class EmeregencyOrRegularServiceList {
  EmeregencyOrRegularServiceList({
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

  factory EmeregencyOrRegularServiceList.fromJson(Map<String, dynamic> json) => EmeregencyOrRegularServiceList(
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
