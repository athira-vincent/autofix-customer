// To parse this JSON data, do
//
//     final mechanicProfileMdl = mechanicProfileMdlFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MechanicProfileMdl mechanicProfileMdlFromJson(String str) => MechanicProfileMdl.fromJson(json.decode(str));

String mechanicProfileMdlToJson(MechanicProfileMdl data) => json.encode(data.toJson());

class MechanicProfileMdl {
  String? status;
  String? message;
  Data? data;

  MechanicProfileMdl({required this.status, required this.message, this.data});

  MechanicProfileMdl.fromJson(Map<String, dynamic> json) {
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
    required this.mechanicDetails,
  });

  MechanicDetails? mechanicDetails;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    mechanicDetails: json["mechanicDetails"] == null ? null : MechanicDetails.fromJson(json["mechanicDetails"]),
  );

  Map<String, dynamic> toJson() => {
    "mechanicDetails": mechanicDetails == null ? null : mechanicDetails!.toJson(),
  };
}

class MechanicDetails {
  MechanicDetails({
    required this.mechanicData,
    required this.serviceData,
    required this.vehicleData,
    required this.totalAmount,
  });

  MechanicData? mechanicData;
  List<ServiceData>? serviceData;
  List<VehicleDatum>? vehicleData;
  int? totalAmount;

  factory MechanicDetails.fromJson(Map<String, dynamic> json) => MechanicDetails(
    mechanicData: json["mechanicData"] == null ? null : MechanicData.fromJson(json["mechanicData"]),
    serviceData: json["serviceData"] == null ? null : List<ServiceData>.from(json["serviceData"].map((x) => ServiceData.fromJson(x))),
    vehicleData: json["vehicleData"] == null ? null : List<VehicleDatum>.from(json["vehicleData"].map((x) => VehicleDatum.fromJson(x))),
    totalAmount: json["totalAmount"] == null ? null : json["totalAmount"],
  );

  Map<String, dynamic> toJson() => {
    "mechanicData": mechanicData == null ? null : mechanicData!.toJson(),
    "serviceData": serviceData == null ? null : List<dynamic>.from(serviceData!.map((x) => x.toJson())),
    "vehicleData": vehicleData == null ? null : List<dynamic>.from(vehicleData!.map((x) => x.toJson())),
    "totalAmount": totalAmount == null ? null : totalAmount,
  };
}

class MechanicData {
  MechanicData({
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
  });

  String id;
  String mechanicCode;
  String mechanicName;
  String emailId;
  String phoneNo;
  String address;
  double latitude;
  double longitude;
  String walletId;
  int verified;
  int enable;
  int isEmailverified;
  String jobType;
  String startTime;
  String endTime;
  int status;

  factory MechanicData.fromJson(Map<String, dynamic> json) => MechanicData(
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
  };
}

class ServiceData {
  ServiceData({
    required this.id,
    required this.status,
    required this.fee,
    required this.serviceId,
    required this.demoMechanicId,
    required this.service,
  });

  String? id;
  int? status;
  String? fee;
  int? serviceId;
  int? demoMechanicId;
  Service? service;

  factory ServiceData.fromJson(Map<String, dynamic> json) => ServiceData(
    id: json["id"] == null ? null : json["id"],
    status: json["status"] == null ? null : json["status"],
    fee: json["fee"] == null ? null : json["fee"],
    serviceId: json["serviceId"] == null ? null : json["serviceId"],
    demoMechanicId: json["demoMechanicId"] == null ? null : json["demoMechanicId"],
    service: json["service"] == null ? null : Service.fromJson(json["service"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "status": status == null ? null : status,
    "fee": fee == null ? null : fee,
    "serviceId": serviceId == null ? null : serviceId,
    "demoMechanicId": demoMechanicId == null ? null : demoMechanicId,
    "service": service == null ? null : service!.toJson(),
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

class VehicleDatum {
  VehicleDatum({
    required this.id,
    required this.status,
    required this.make,
  });

  String? id;
  int? status;
  Make? make;

  factory VehicleDatum.fromJson(Map<String, dynamic> json) => VehicleDatum(
    id: json["id"] == null ? null : json["id"],
    status: json["status"] == null ? null : json["status"],
    make: json["make"] == null ? null : Make.fromJson(json["make"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "status": status == null ? null : status,
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
