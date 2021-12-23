
import 'dart:ffi';

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
    "mechanicList": mechanicList.toJson(),
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
    totalItems: json["totalItems"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    totalPages: json["totalPages"],
    currentPage: json["currentPage"],
  );

  Map<String, dynamic> toJson() => {
    "totalItems": totalItems,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "totalPages": totalPages,
    "currentPage": currentPage,
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
  List<DemoMechanicService> demoMechanicService;
  List<DemoMechanicVehicle> demoMechanicVehicle;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    mechanicCode: json["mechanicCode"],
    mechanicName: json["mechanicName"],
    emailId: json["emailId"],
    phoneNo: json["phoneNo"],
    address: json["address"],
    latitude: json["latitude"].toDouble(),
    longitude: json["longitude"].toDouble(),
    walletId: json["walletId"],
    verified: json["verified"],
    enable: json["enable"],
    isEmailverified: json["isEmailverified"],
    jobType: json["jobType"],
    startTime: json["startTime"],
    endTime: json["endTime"],
    status: json["status"],
    demoMechanicService: List<DemoMechanicService>.from(json["demoMechanicService"].map((x) => DemoMechanicService.fromJson(x))),
    demoMechanicVehicle: List<DemoMechanicVehicle>.from(json["demoMechanicVehicle"].map((x) => DemoMechanicVehicle.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "mechanicCode": mechanicCode,
    "mechanicName": mechanicName,
    "emailId": emailId,
    "phoneNo": phoneNo,
    "address": address,
    "latitude": latitude,
    "longitude": longitude,
    "walletId": walletId,
    "verified": verified,
    "enable": enable,
    "isEmailverified": isEmailverified,
    "jobType": jobType,
    "startTime": startTime,
    "endTime": endTime,
    "status": status,
    "demoMechanicService": List<dynamic>.from(demoMechanicService.map((x) => x.toJson())),
    "demoMechanicVehicle": List<dynamic>.from(demoMechanicVehicle.map((x) => x.toJson())),
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
    id: json["id"],
    fee: json["fee"],
    status: json["status"],
    serviceId: json["serviceId"],
    demoMechanicId: json["demoMechanicId"],
    service: Service.fromJson(json["service"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fee": fee,
    "status": status,
    "serviceId": serviceId,
    "demoMechanicId": demoMechanicId,
    "service": service.toJson(),
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
    id: json["id"],
    serviceName: json["serviceName"],
    icon: json["icon"],
    type: json["type"],
    fee: json["fee"],
    minAmount: json["minAmount"],
    maxAmount: json["maxAmount"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "serviceName": serviceName,
    "icon": icon,
    "type": type,
    "fee": fee,
    "minAmount": minAmount,
    "maxAmount": maxAmount,
    "status": status,
  };
}

class DemoMechanicVehicle {
  DemoMechanicVehicle({
    required this.id,
    required this.status,
    required this.makeId,
    required this.mechanicId,
    required this.make,
  });

  String id;
  int status;
  int makeId;
  dynamic mechanicId;
  Make make;

  factory DemoMechanicVehicle.fromJson(Map<String, dynamic> json) => DemoMechanicVehicle(
    id: json["id"],
    status: json["status"],
    makeId: json["makeId"],
    mechanicId: json["mechanicId"],
    make: Make.fromJson(json["make"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "status": status,
    "makeId": makeId,
    "mechanicId": mechanicId,
    "make": make.toJson(),
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
    id: json["id"],
    makeName: json["makeName"],
    description: json["description"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "makeName": makeName,
    "description": description,
    "status": status,
  };
}

