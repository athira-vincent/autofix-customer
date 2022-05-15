// To parse this JSON data, do
//
//     final bookingDetailsMdl = bookingDetailsMdlFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

BookingDetailsMdl bookingDetailsMdlFromJson(String str) => BookingDetailsMdl.fromJson(json.decode(str));

String bookingDetailsMdlToJson(BookingDetailsMdl data) => json.encode(data.toJson());

class BookingDetailsMdl {
  BookingDetailsMdl({
    required this.message,
    required this.status,
    required this.data,
  });

  String message;
  String status;
  Data? data;

  factory BookingDetailsMdl.fromJson(Map<String, dynamic> json) => BookingDetailsMdl(
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
    required this.bookingDetails,
  });

  BookingDetails? bookingDetails;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    bookingDetails: json["bookingDetails"] == null ? null : BookingDetails.fromJson(json["bookingDetails"]),
  );

  Map<String, dynamic> toJson() => {
    "bookingDetails": bookingDetails == null ? null : bookingDetails?.toJson(),
  };
}

class BookingDetails {
  BookingDetails({
    required this.id,
    required this.bookedDate,
    required this.bookedTime,
    required this.latitude,
    required this.longitude,
    required this.paymentMethod,
    required this.demoMechanicId,
    required this.customerId,
    required this.status,
    required this.isAccepted,
    required this.vehicleId,
    required this.serviceId,
    required this.bookService,
    required this.vehicle,
    required this.mechanic,
    required this.customer,
  });

  String id;
  String bookedDate;
  String bookedTime;
  double latitude;
  double longitude;
  dynamic paymentMethod;
  dynamic demoMechanicId;
  int customerId;
  int status;
  dynamic isAccepted;
  int vehicleId;
  dynamic serviceId;
  List<BookService>? bookService;
  Vehicle? vehicle;
  Customer? mechanic;
  Customer? customer;

  factory BookingDetails.fromJson(Map<String, dynamic> json) => BookingDetails(
    id: json["id"] == null ? null : json["id"],
    bookedDate: json["bookedDate"] == null ? null : json["bookedDate"],
    bookedTime: json["bookedTime"] == null ? null : json["bookedTime"],
    latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
    longitude: json["longitude"] == null ? null : json["longitude"].toDouble(),
    paymentMethod: json["paymentMethod"],
    demoMechanicId: json["demoMechanicId"],
    customerId: json["customerId"] == null ? null : json["customerId"],
    status: json["status"] == null ? null : json["status"],
    isAccepted: json["isAccepted"],
    vehicleId: json["vehicleId"] == null ? null : json["vehicleId"],
    serviceId: json["serviceId"],
    bookService: json["bookService"] == null ? null : List<BookService>.from(json["bookService"].map((x) => BookService.fromJson(x))),
    vehicle: json["vehicle"] == null ? null : Vehicle.fromJson(json["vehicle"]),
    mechanic: json["mechanic"] == null ? null : Customer.fromJson(json["mechanic"]),
    customer: json["customer"] == null ? null : Customer.fromJson(json["customer"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "bookedDate": bookedDate == null ? null : bookedDate,
    "bookedTime": bookedTime == null ? null : bookedTime,
    "latitude": latitude == null ? null : latitude,
    "longitude": longitude == null ? null : longitude,
    "paymentMethod": paymentMethod,
    "demoMechanicId": demoMechanicId,
    "customerId": customerId == null ? null : customerId,
    "status": status == null ? null : status,
    "isAccepted": isAccepted,
    "vehicleId": vehicleId == null ? null : vehicleId,
    "serviceId": serviceId,
    "bookService": bookService == null ? null : List<dynamic>.from(bookService!.map((x) => x.toJson())),
    "vehicle": vehicle == null ? null : vehicle?.toJson(),
    "mechanic": mechanic == null ? null : mechanic?.toJson(),
    "customer": customer == null ? null : customer?.toJson(),
  };
}

class BookService {
  BookService({
    required this.id,
    required this.mechanicId,
    required this.customerId,
    required this.status,
    required this.serviceId,
    required this.bookMechanicId,
  });

  String id;
  dynamic mechanicId;
  dynamic customerId;
  int status;
  int serviceId;
  dynamic bookMechanicId;

  factory BookService.fromJson(Map<String, dynamic> json) => BookService(
    id: json["id"] == null ? null : json["id"],
    mechanicId: json["mechanicId"],
    customerId: json["customerId"],
    status: json["status"] == null ? null : json["status"],
    serviceId: json["serviceId"] == null ? null : json["serviceId"],
    bookMechanicId: json["bookMechanicId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "mechanicId": mechanicId,
    "customerId": customerId,
    "status": status == null ? null : status,
    "serviceId": serviceId == null ? null : serviceId,
    "bookMechanicId": bookMechanicId,
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
    required this.accountType,
    required this.status,
    required this.jwtToken,
    required this.fcmToke,
    required this.otpCode,
  });

  int id;
  String userCode;
  String firstName;
  String lastName;
  String emailId;
  String phoneNo;
  dynamic accountType;
  int status;
  String jwtToken;
  dynamic fcmToke;
  String otpCode;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    id: json["id"] == null ? null : json["id"],
    userCode: json["userCode"] == null ? null : json["userCode"],
    firstName: json["firstName"] == null ? null : json["firstName"],
    lastName: json["lastName"] == null ? null : json["lastName"],
    emailId: json["emailId"] == null ? null : json["emailId"],
    phoneNo: json["phoneNo"] == null ? null : json["phoneNo"],
    accountType: json["accountType"],
    status: json["status"] == null ? null : json["status"],
    jwtToken: json["jwtToken"] == null ? null : json["jwtToken"],
    fcmToke: json["fcmToke"],
    otpCode: json["otpCode"] == null ? null : json["otpCode"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "userCode": userCode == null ? null : userCode,
    "firstName": firstName == null ? null : firstName,
    "lastName": lastName == null ? null : lastName,
    "emailId": emailId == null ? null : emailId,
    "phoneNo": phoneNo == null ? null : phoneNo,
    "accountType": accountType,
    "status": status == null ? null : status,
    "jwtToken": jwtToken == null ? null : jwtToken,
    "fcmToke": fcmToke,
    "otpCode": otpCode == null ? null : otpCode,
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
