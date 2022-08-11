// To parse this JSON data, do
//
//     final mechanicActiveServiceUpdateMdl = mechanicActiveServiceUpdateMdlFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MechanicActiveServiceUpdateMdl mechanicActiveServiceUpdateMdlFromJson(String str) => MechanicActiveServiceUpdateMdl.fromJson(json.decode(str));

String mechanicActiveServiceUpdateMdlToJson(MechanicActiveServiceUpdateMdl data) => json.encode(data.toJson());

class MechanicActiveServiceUpdateMdl {
  MechanicActiveServiceUpdateMdl({
    required this.data,
    required this.message,
    required this.status,
  });

  String message;
  String status;
  Data? data;

  factory MechanicActiveServiceUpdateMdl.fromJson(Map<String, dynamic> json) => MechanicActiveServiceUpdateMdl(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    message: json["message"] == null ? null : json["message"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
    "status": status == null ? null : status,
    "data": data == null ? null : data!.toJson(),
  };
}

class Data {
  Data({
    required this.currentlyWorkingService,
  });

  List<CurrentlyWorkingService>? currentlyWorkingService;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    currentlyWorkingService: json["currentlyWorkingService"] == null ? null : List<CurrentlyWorkingService>.from(json["currentlyWorkingService"].map((x) => CurrentlyWorkingService.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "currentlyWorkingService": currentlyWorkingService == null ? null : List<dynamic>.from(currentlyWorkingService!.map((x) => x.toJson())),
  };
}

class CurrentlyWorkingService {
  CurrentlyWorkingService({
    required this.id,
    required this.bookingCode,
    required this.reqType,
    required this.bookStatus,
    required this.totalPrice,
    required this.tax,
    required this.commission,
    required this.serviceCharge,
    required this.totalTime,
    required this.serviceTime,
    required this.latitude,
    required this.longitude,
    required this.extend,
    required this.totalExt,
    required this.extendTime,
    required this.bookedDate,
    required this.isRated,
    required this.status,
    required this.customerId,
    required this.mechanicId,
    required this.vehicleId,
    required this.mechanic,
    required this.customer,
    required this.vehicle,
    required this.bookService,
  });

  int id;
  String bookingCode;
  int reqType;
  int bookStatus;
  int totalPrice;
  double tax;
  double commission;
  int serviceCharge;
  dynamic totalTime;
  dynamic serviceTime;
  double latitude;
  double longitude;
  double extend;
  double totalExt;
  String extendTime;
  DateTime? bookedDate;
  int isRated;
  int status;
  int customerId;
  int mechanicId;
  int vehicleId;
  Customer? mechanic;
  Customer? customer;
  Vehicle? vehicle;
  List<BookService>? bookService;

  factory CurrentlyWorkingService.fromJson(Map<String, dynamic> json) => CurrentlyWorkingService(
    id: json["id"] == null ? null : json["id"],
    bookingCode: json["bookingCode"] == null ? null : json["bookingCode"],
    reqType: json["reqType"] == null ? null : json["reqType"],
    bookStatus: json["bookStatus"] == null ? null : json["bookStatus"],
    totalPrice: json["totalPrice"] == null ? null : json["totalPrice"],
    tax: json["tax"] == null ? null : json["tax"].toDouble(),
    commission: json["commission"] == null ? null : json["commission"].toDouble(),
    serviceCharge: json["serviceCharge"] == null ? null : json["serviceCharge"],
    totalTime: json["totalTime"],
    serviceTime: json["serviceTime"],
    latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
    longitude: json["longitude"] == null ? null : json["longitude"].toDouble(),
    extend: json["extend"] == null ? null : json["extend"].toDouble(),
    totalExt: json["totalExt"] == null ? null : json["totalExt"].toDouble(),
    extendTime: json["extendTime"] == null ? null : json["extendTime"],
    bookedDate: json["bookedDate"] == null ? null : DateTime.parse(json["bookedDate"]),
    isRated: json["isRated"] == null ? null : json["isRated"],
    status: json["status"] == null ? null : json["status"],
    customerId: json["customerId"] == null ? null : json["customerId"],
    mechanicId: json["mechanicId"] == null ? null : json["mechanicId"],
    vehicleId: json["vehicleId"] == null ? null : json["vehicleId"],
    mechanic: json["mechanic"] == null ? null : Customer.fromJson(json["mechanic"]),
    customer: json["customer"] == null ? null : Customer.fromJson(json["customer"]),
    vehicle: json["vehicle"] == null ? null : Vehicle.fromJson(json["vehicle"]),
    bookService: json["bookService"] == null ? null : List<BookService>.from(json["bookService"].map((x) => BookService.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "bookingCode": bookingCode == null ? null : bookingCode,
    "reqType": reqType == null ? null : reqType,
    "bookStatus": bookStatus == null ? null : bookStatus,
    "totalPrice": totalPrice == null ? null : totalPrice,
    "tax": tax == null ? null : tax,
    "commission": commission == null ? null : commission,
    "serviceCharge": serviceCharge == null ? null : serviceCharge,
    "totalTime": totalTime,
    "serviceTime": serviceTime,
    "latitude": latitude == null ? null : latitude,
    "longitude": longitude == null ? null : longitude,
    "extend": extend == null ? null : extend,
    "totalExt": totalExt == null ? null : totalExt,
    "extendTime": extendTime == null ? null : extendTime,
    "bookedDate": bookedDate == null ? null : bookedDate!.toIso8601String(),
    "isRated": isRated == null ? null : isRated,
    "status": status == null ? null : status,
    "customerId": customerId == null ? null : customerId,
    "mechanicId": mechanicId == null ? null : mechanicId,
    "vehicleId": vehicleId == null ? null : vehicleId,
    "mechanic": mechanic == null ? null : mechanic!.toJson(),
    "customer": customer == null ? null : customer!.toJson(),
    "vehicle": vehicle == null ? null : vehicle!.toJson(),
    "bookService": bookService == null ? null : List<dynamic>.from(bookService!.map((x) => x.toJson())),
  };
}

class BookService {
  BookService({
    required this.id,
    required this.status,
    required this.service,
  });

  int id;
  int status;
  Service? service;

  factory BookService.fromJson(Map<String, dynamic> json) => BookService(
    id: json["id"] == null ? null : json["id"],
    status: json["status"] == null ? null : json["status"],
    service: json["service"] == null ? null : Service.fromJson(json["service"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "status": status == null ? null : status,
    "service": service == null ? null : service!.toJson(),
  };
}

class Service {
  Service({
    required this.id,
    required this.serviceName,
  });

  String id;
  String serviceName;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
    id: json["id"] == null ? null : json["id"],
    serviceName: json["serviceName"] == null ? null : json["serviceName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "serviceName": serviceName == null ? null : serviceName,
  };
}

class Customer {
  Customer({
    required this.id,
    required this.userCode,
    required this.firstName,
    required this.lastName,
    required this.emailId,
    required this.phoneNo,
    required this.status,
    required this.userTypeId,
    required this.jwtToken,
    required this.fcmToken,
    required this.otpCode,
    required this.isProfile,
    required this.otpVerified,
    required this.mechanic,
    required this.customer,
  });

  int id;
  String userCode;
  String firstName;
  String lastName;
  String emailId;
  String phoneNo;
  int status;
  int userTypeId;
  String jwtToken;
  String fcmToken;
  String otpCode;
  int isProfile;
  int otpVerified;
  List<Service>? mechanic;
  List<Service>? customer;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    id: json["id"] == null ? null : json["id"],
    userCode: json["userCode"] == null ? null : json["userCode"],
    firstName: json["firstName"] == null ? null : json["firstName"],
    lastName: json["lastName"] == null ? null : json["lastName"],
    emailId: json["emailId"] == null ? null : json["emailId"],
    phoneNo: json["phoneNo"] == null ? null : json["phoneNo"],
    status: json["status"] == null ? null : json["status"],
    userTypeId: json["userTypeId"] == null ? null : json["userTypeId"],
    jwtToken: json["jwtToken"] == null ? null : json["jwtToken"],
    fcmToken: json["fcmToken"] == null ? null : json["fcmToken"],
    otpCode: json["otpCode"] == null ? null : json["otpCode"],
    isProfile: json["isProfile"] == null ? null : json["isProfile"],
    otpVerified: json["otpVerified"] == null ? null : json["otpVerified"],
    mechanic: json["mechanic"] == null ? null : List<Service>.from(json["mechanic"].map((x) => Service.fromJson(x))),
    customer: json["customer"] == null ? null : List<Service>.from(json["customer"].map((x) => Service.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "userCode": userCode == null ? null : userCode,
    "firstName": firstName == null ? null : firstName,
    "lastName": lastName == null ? null : lastName,
    "emailId": emailId == null ? null : emailId,
    "phoneNo": phoneNo == null ? null : phoneNo,
    "status": status == null ? null : status,
    "userTypeId": userTypeId == null ? null : userTypeId,
    "jwtToken": jwtToken == null ? null : jwtToken,
    "fcmToken": fcmToken == null ? null : fcmToken,
    "otpCode": otpCode == null ? null : otpCode,
    "isProfile": isProfile == null ? null : isProfile,
    "otpVerified": otpVerified == null ? null : otpVerified,
    "mechanic": mechanic == null ? null : List<dynamic>.from(mechanic!.map((x) => x.toJson())),
    "customer": customer == null ? null : List<dynamic>.from(customer!.map((x) => x.toJson())),
  };
}

class Vehicle {
  Vehicle({
    required this.id,
    required this.brand,
    required this.model,
    required this.engine,
    required this.year,
    required this.plateNo,
    required this.lastMaintenance,
    required this.milege,
    required this.vehiclePic,
    required this.latitude,
    required this.longitude,
    required this.defaultVehicle,
    required this.status,
  });

  String id;
  String brand;
  String model;
  String engine;
  String year;
  String plateNo;
  String lastMaintenance;
  String milege;
  String vehiclePic;
  double latitude;
  double longitude;
  int defaultVehicle;
  int status;

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
    id: json["id"] == null ? null : json["id"],
    brand: json["brand"] == null ? null : json["brand"],
    model: json["model"] == null ? null : json["model"],
    engine: json["engine"] == null ? null : json["engine"],
    year: json["year"] == null ? null : json["year"],
    plateNo: json["plateNo"] == null ? null : json["plateNo"],
    lastMaintenance: json["lastMaintenance"] == null ? null : json["lastMaintenance"],
    milege: json["milege"] == null ? null : json["milege"],
    vehiclePic: json["vehiclePic"] == null ? null : json["vehiclePic"],
    latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
    longitude: json["longitude"] == null ? null : json["longitude"].toDouble(),
    defaultVehicle: json["defaultVehicle"] == null ? null : json["defaultVehicle"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "brand": brand == null ? null : brand,
    "model": model == null ? null : model,
    "engine": engine == null ? null : engine,
    "year": year == null ? null : year,
    "plateNo": plateNo == null ? null : plateNo,
    "lastMaintenance": lastMaintenance == null ? null : lastMaintenance,
    "milege": milege == null ? null : milege,
    "vehiclePic": vehiclePic == null ? null : vehiclePic,
    "latitude": latitude == null ? null : latitude,
    "longitude": longitude == null ? null : longitude,
    "defaultVehicle": defaultVehicle == null ? null : defaultVehicle,
    "status": status == null ? null : status,
  };
}
