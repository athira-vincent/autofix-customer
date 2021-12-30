// To parse this JSON data, do
//
//     final mechanicListMdl = mechanicListMdlFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MechanicListMdl mechanicListMdlFromJson(String str) => MechanicListMdl.fromJson(json.decode(str));

String mechanicListMdlToJson(MechanicListMdl data) => json.encode(data.toJson());

class MechanicListMdl {
  String? status;
  String? message;
  Data? data;

  MechanicListMdl({required this.status, required this.message, this.data});

  MechanicListMdl.fromJson(Map<String, dynamic> json) {
    data = (json['data'] != null ? Data.fromJson(json['data']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = this.data!.toJson();
    return data;
  }
}


class Data {
  Data({
    required this.mechanicList,
  });

  MechanicList mechanicList;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    mechanicList: MechanicList.fromJson(json["mechanicList"]),
  );

  Map<String, dynamic> toJson() => {
    "mechanicList": mechanicList == null ? null : mechanicList.toJson(),
  };
}

class MechanicList {
  MechanicList({
    required this.totalItems,
    required this.data,
    required this.totalPages,
    required this.currentPage,
  });

  int totalItems;
  List<Datum> data;
  int totalPages;
  int currentPage;

  factory MechanicList.fromJson(Map<String, dynamic> json) => MechanicList(
    totalItems: json["totalItems"] == null ? null : json["totalItems"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    totalPages: json["totalPages"] == null ? null : json["totalPages"],
    currentPage: json["currentPage"] == null ? null : json["currentPage"],
  );

  Map<String, dynamic> toJson() => {
    "totalItems": totalItems == null ? null : totalItems,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
    "totalPages": totalPages == null ? null : totalPages,
    "currentPage": currentPage == null ? null : currentPage,
  };
}

class Datum {
  Datum({
    required this.id,
    required this.mechanicCode,
    required this.mechanicName,
    required this.emailId,
    required this.phoneNo,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.walletId,
    required this.verified,
    required this.enable,
    required this.isEmailverified,
    required this.jobType,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.demoMechanicService,
    required this.demoMechanicVehicle,
  });

  String? id;
  String? mechanicCode;
  String? mechanicName;
  String? emailId;
  String? phoneNo;
  String? address;
  double? latitude;
  double? longitude;
  String? walletId;
  int? verified;
  int? enable;
  int? isEmailverified;
  String? jobType;
  String? startTime;
  String? endTime;
  int? status;
  List<DemoMechanicService>? demoMechanicService;
  List<DemoMechanicVehicle>? demoMechanicVehicle;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    mechanicCode: json["mechanicCode"] == null ? null : json["mechanicCode"],
    mechanicName: json["mechanicName"] == null ? null : json["mechanicName"],
    emailId: json["emailId"] == null ? null : json["emailId"],
    phoneNo: json["phoneNo"] == null ? null : json["phoneNo"],
    address: json["address"] == null ? null : json["address"],
    latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
    longitude: json["longitude"] == null ? null : json["longitude"].toDouble(),
    walletId: json["walletId"] == null ? null : json["walletId"],
    verified: json["verified"] == null ? null : json["verified"],
    enable: json["enable"] == null ? null : json["enable"],
    isEmailverified: json["isEmailverified"] == null ? null : json["isEmailverified"],
    jobType: json["jobType"] == null ? null : json["jobType"],
    startTime: json["startTime"] == null ? null : json["startTime"],
    endTime: json["endTime"] == null ? null : json["endTime"],
    status: json["status"] == null ? null : json["status"],
    demoMechanicService: List<DemoMechanicService>.from(json["demoMechanicService"].map((x) => DemoMechanicService.fromJson(x))),
    demoMechanicVehicle: List<DemoMechanicVehicle>.from(json["demoMechanicVehicle"].map((x) => DemoMechanicVehicle.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "mechanicCode": mechanicCode == null ? null : mechanicCode,
    "mechanicName": mechanicName == null ? null : mechanicName,
    "emailId": emailId == null ? null : emailId,
    "phoneNo": phoneNo == null ? null : phoneNo,
    "address": address == null ? null : address,
    "latitude": latitude == null ? null : latitude,
    "longitude": longitude == null ? null : longitude,
    "walletId": walletId == null ? null : walletId,
    "verified": verified == null ? null : verified,
    "enable": enable == null ? null : enable,
    "isEmailverified": isEmailverified == null ? null : isEmailverified,
    "jobType": jobType == null ? null : jobType,
    "startTime": startTime == null ? null : startTime,
    "endTime": endTime == null ? null : endTime,
    "status": status == null ? null : status,
    "demoMechanicService": demoMechanicService == null ? null : List<dynamic>.from(demoMechanicService!.map((x) => x.toJson())),
    "demoMechanicVehicle": demoMechanicVehicle == null ? null : List<dynamic>.from(demoMechanicVehicle!.map((x) => x.toJson())),
  };
}

class DemoMechanicService {
  DemoMechanicService({
    required this.id,
    required this.fee,
    required this.status,
    required this.serviceId,
    required this.demoMechanicId,
    required this.service,
  });

  String id;
  String fee;
  int status;
  int serviceId;
  int demoMechanicId;
  Service service;

  factory DemoMechanicService.fromJson(Map<String, dynamic> json) => DemoMechanicService(
    id: json["id"] == null ? null : json["id"],
    fee: json["fee"] == null ? null : json["fee"],
    status: json["status"] == null ? null : json["status"],
    serviceId: json["serviceId"] == null ? null : json["serviceId"],
    demoMechanicId: json["demoMechanicId"] == null ? null : json["demoMechanicId"],
    service: Service.fromJson(json["service"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "fee": fee == null ? null : fee,
    "status": status == null ? null : status,
    "serviceId": serviceId == null ? null : serviceId,
    "demoMechanicId": demoMechanicId == null ? null : demoMechanicId,
    "service": service == null ? null : service.toJson(),
  };
}

class Service {
  Service({
    required this.id,
    required this.serviceName,
    required this.icon,
    required this.type,
    required this.fee,
    required this.minAmount,
    required this.maxAmount,
    required this.status,
  });

  String id;
  String serviceName;
  dynamic icon;
  String type;
  String fee;
  String minAmount;
  String maxAmount;
  int status;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
    id: json["id"] == null ? null : json["id"],
    serviceName: json["serviceName"] == null ? null : json["serviceName"],
    icon: json["icon"],
    type: json["type"] == null ? null : json["type"],
    fee: json["fee"] == null ? null : json["fee"],
    minAmount: json["minAmount"] == null ? null : json["minAmount"],
    maxAmount: json["maxAmount"] == null ? null : json["maxAmount"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "serviceName": serviceName == null ? null : serviceName,
    "icon": icon,
    "type": type == null ? null : type,
    "fee": fee == null ? null : fee,
    "minAmount": minAmount == null ? null : minAmount,
    "maxAmount": maxAmount == null ? null : maxAmount,
    "status": status == null ? null : status,
  };
}

class DemoMechanicVehicle {
  DemoMechanicVehicle({
    required this.id,
    required this.status,
    required this.makeId,
    required this.make,
  });

  String? id;
  int? status;
  int? makeId;
  Make? make;

  factory DemoMechanicVehicle.fromJson(Map<String, dynamic> json) => DemoMechanicVehicle(
    id: json["id"] == null ? null : json["id"],
    status: json["status"] == null ? null : json["status"],
    makeId: json["makeId"] == null ? null : json["makeId"],
    make: json["make"] == null ? null : Make.fromJson(json["make"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "status": status == null ? null : status,
    "makeId": makeId == null ? null : makeId,
    "make": make == null ? null : make!.toJson(),
  };
}


class Make {
  Make({
    required this.id,
    required this.makeName,
    required this.description,
    required this.status,
  });

  String id;
  String makeName;
  String description;
  int status;

  factory Make.fromJson(Map<String, dynamic> json) => Make(
    id: json["id"] == null ? null : json["id"],
    makeName: json["makeName"] == null ? null : json["makeName"],
    description: json["description"] == null ? null : json["description"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "makeName": makeName == null ? null : makeName,
    "description": description == null ? null : description,
    "status": status == null ? null : status,
  };
}
