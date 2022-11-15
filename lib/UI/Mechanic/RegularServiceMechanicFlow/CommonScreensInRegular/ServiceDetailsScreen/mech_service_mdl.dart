// To parse this JSON data, do
//
//     final mechServiceDetailsMdl = mechServiceDetailsMdlFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MechServiceDetailsMdl mechServiceDetailsMdlFromJson(String str) => MechServiceDetailsMdl.fromJson(json.decode(str));

String mechServiceDetailsMdlToJson(MechServiceDetailsMdl data) => json.encode(data.toJson());

class MechServiceDetailsMdl {
  MechServiceDetailsMdl({
    required this.data,
    required this.status,
    required this.message
  });

  Data? data;
  String? status;
  String? message;

  factory MechServiceDetailsMdl.fromJson(Map<String, dynamic> json) => MechServiceDetailsMdl(
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
    required this.bookingDetails,
  });

  BookingDetails? bookingDetails;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    bookingDetails: json["bookingDetails"] == null ? null : BookingDetails.fromJson(json["bookingDetails"]),
  );

  Map<String, dynamic> toJson() => {
    "bookingDetails": bookingDetails == null ? null : bookingDetails!.toJson(),
  };
}

class BookingDetails {
  BookingDetails({
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
    required this.bookedTime,
    required this.isRated,
    required this.status,
    required this.regularType,
    required this.mechLatitude,
    required this.mechLongitude,
    required this.customerId,
    required this.vehicleId,
    required this.serviceId,
    required this.bookService,
    required this.vehicle,
    required this.mechanic,
    required this.customer,
    required this.review,
    required this.isRate,
    required this.mechanicService,
  });

  String id;
  String bookingCode;
  int reqType;
  int bookStatus;
  String totalPrice;
  dynamic tax;
  var commission;
  dynamic serviceCharge;
  String totalTime;
  dynamic serviceTime;
  double latitude;
  double longitude;
  dynamic extend;
  dynamic totalExt;
  dynamic extendTime;
  DateTime? bookedDate;
  dynamic bookedTime;
  int isRated;
  int status;
  dynamic regularType;
  dynamic mechLatitude;
  dynamic mechLongitude;
  dynamic demoMechanicId;
  int customerId;
  int vehicleId;
  dynamic serviceId;
  List<BookService>? bookService;
  Vehicle? vehicle;
  Customer? mechanic;
  Customer? customer;
  List<dynamic>? review;
  bool isRate;
  List<MechanicService>? mechanicService;

  factory BookingDetails.fromJson(Map<String, dynamic> json) => BookingDetails(
    id: json["id"] == null ? null : json["id"],
    bookingCode: json["bookingCode"] == null ? null : json["bookingCode"],
    reqType: json["reqType"] == null ? null : json["reqType"],
    bookStatus: json["bookStatus"] == null ? null : json["bookStatus"],
    totalPrice: json["totalPrice"] == null ? null : json["totalPrice"],
    tax: json["tax"] == null ? null : json["tax"].toDouble(),
    commission: json["commission"] == null ? null : json["commission"].toDouble(),
    serviceCharge: json["serviceCharge"] == null ? null : json["serviceCharge"].toDouble(),
    totalTime: json["totalTime"],
    serviceTime: json["serviceTime"] == null ? null : json["serviceTime"],
    latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
    longitude: json["longitude"] == null ? null : json["longitude"].toDouble(),
    extend: json["extend"],
    totalExt: json["totalExt"],
    extendTime: json["extendTime"],
    bookedDate: json["bookedDate"] == null ? null : DateTime.parse(json["bookedDate"]),
    bookedTime: json["bookedTime"] == null ? null : json["bookedTime"],
    isRated: json["isRated"] == null ? null : json["isRated"],
    status: json["status"] == null ? null : json["status"],
    regularType: json["regularType"] == null ? null : json["regularType"],
    mechLatitude: json["mechLatitude"] == null ? null : json["mechLatitude"].toDouble(),
    mechLongitude: json["mechLongitude"] == null ? null : json["mechLongitude"].toDouble(),
    customerId: json["customerId"] == null ? null : json["customerId"],
    vehicleId: json["vehicleId"] == null ? null : json["vehicleId"],
    serviceId: json["serviceId"],
    bookService: json["bookService"] == null ? null : List<BookService>.from(json["bookService"].map((x) => BookService.fromJson(x))),
    vehicle: json["vehicle"] == null ? null : Vehicle.fromJson(json["vehicle"]),
    mechanic: json["mechanic"] == null ? null : Customer.fromJson(json["mechanic"]),
    customer: json["customer"] == null ? null : Customer.fromJson(json["customer"]),
    review: json["review"] == null ? null : List<dynamic>.from(json["review"].map((x) => x)),
    isRate: json["isRate"] == null ? null : json["isRate"],
    mechanicService: json["mechanicService"] == null ? null : List<MechanicService>.from(json["mechanicService"].map((x) => MechanicService.fromJson(x))),
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
    "serviceTime": serviceTime == null ? null : serviceTime,
    "latitude": latitude == null ? null : latitude,
    "longitude": longitude == null ? null : longitude,
    "extend": extend,
    "totalExt": totalExt,
    "extendTime": extendTime,
    "bookedDate": bookedDate == null ? null : bookedDate!.toIso8601String(),
    "bookedTime": bookedTime == null ? null : bookedTime,
    "isRated": isRated == null ? null : isRated,
    "status": status == null ? null : status,
    "regularType": regularType == null ? null : regularType,
    "mechLatitude": mechLatitude == null ? null : mechLatitude,
    "mechLongitude": mechLongitude == null ? null : mechLongitude,
    "customerId": customerId == null ? null : customerId,
    "vehicleId": vehicleId == null ? null : vehicleId,
    "serviceId": serviceId,
    "bookService": bookService == null ? null : List<dynamic>.from(bookService!.map((x) => x.toJson())),
    "vehicle": vehicle == null ? null : vehicle!.toJson(),
    "mechanic": mechanic == null ? null : mechanic!.toJson(),
    "customer": customer == null ? null : customer!.toJson(),
    "review": review == null ? null : List<dynamic>.from(review!.map((x) => x)),
    "isRate": isRate == null ? null : isRate,
    "mechanicService": mechanicService == null ? null : List<dynamic>.from(mechanicService!.map((x) => x.toJson())),
  };
}

class BookService {
  BookService({
    required this.id,
    required this.status,
    required this.serviceId,
    required this.bookMechanicId,
    required this.service,
  });

  String id;
  int status;
  int serviceId;
  dynamic bookMechanicId;
  BookServiceService? service;

  factory BookService.fromJson(Map<String, dynamic> json) => BookService(
    id: json["id"] == null ? null : json["id"],
    status: json["status"] == null ? null : json["status"],
    serviceId: json["serviceId"] == null ? null : json["serviceId"],
    bookMechanicId: json["bookMechanicId"],
    service: json["service"] == null ? null : BookServiceService.fromJson(json["service"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "status": status == null ? null : status,
    "serviceId": serviceId == null ? null : serviceId,
    "bookMechanicId": bookMechanicId,
    "service": service == null ? null : service!.toJson(),
  };
}

class BookServiceService {
  BookServiceService({
    required this.id,
    required this.serviceName,
    required this.minPrice,
  });

  String id;
  String serviceName;
  String minPrice;

  factory BookServiceService.fromJson(Map<String, dynamic> json) => BookServiceService(
    id: json["id"] == null ? null : json["id"],
    serviceName: json["serviceName"] == null ? null : json["serviceName"],
    minPrice: json["minPrice"] == null ? null : json["minPrice"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "serviceName": serviceName == null ? null : serviceName,
    "minPrice": minPrice == null ? null : minPrice,
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
    required this.fcmToken,
    required this.otpCode,
    required this.customer,
    required this.userTypeId,
    required this.mechanic,
    required this.mechanicService,
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
  String fcmToken;
  String otpCode;
  dynamic customer;
  int userTypeId;
  dynamic mechanic;
  dynamic mechanicService;

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
    fcmToken: json["fcmToken"] == null ? null : json["fcmToken"],
    otpCode: json["otpCode"] == null ? null : json["otpCode"],
    customer: json["customer"],
    userTypeId: json["userTypeId"] == null ? null : json["userTypeId"],
    mechanic: json["mechanic"],
    mechanicService: json["mechanicService"],
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
    "fcmToken": fcmToken == null ? null : fcmToken,
    "otpCode": otpCode == null ? null : otpCode,
    "customer": customer,
    "userTypeId": userTypeId == null ? null : userTypeId,
    "mechanic": mechanic,
    "mechanicService": mechanicService,
  };
}

class MechanicService {
  MechanicService({
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
  MechanicServiceService? service;
  int status;
  int userId;
  int serviceId;

  factory MechanicService.fromJson(Map<String, dynamic> json) => MechanicService(
    id: json["id"] == null ? null : json["id"],
    fee: json["fee"] == null ? null : json["fee"],
    time: json["time"] == null ? null : json["time"],
    service: json["service"] == null ? null : MechanicServiceService.fromJson(json["service"]),
    status: json["status"] == null ? null : json["status"],
    userId: json["userId"] == null ? null : json["userId"],
    serviceId: json["serviceId"] == null ? null : json["serviceId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "fee": fee == null ? null : fee,
    "time": time == null ? null : time,
    "service": service == null ? null : service!.toJson(),
    "status": status == null ? null : status,
    "userId": userId == null ? null : userId,
    "serviceId": serviceId == null ? null : serviceId,
  };
}

class MechanicServiceService {
  MechanicServiceService({
    required this.categoryId,
    required this.serviceName,
  });

  int categoryId;
  String serviceName;

  factory MechanicServiceService.fromJson(Map<String, dynamic> json) => MechanicServiceService(
    categoryId: json["categoryId"] == null ? null : json["categoryId"],
    serviceName: json["serviceName"] == null ? null : json["serviceName"],
  );

  Map<String, dynamic> toJson() => {
    "categoryId": categoryId == null ? null : categoryId,
    "serviceName": serviceName == null ? null : serviceName,
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
    required this.color,
    required this.latitude,
    required this.longitude,
    required this.defaultVehicle,
    required this.status,
    required this.userId,
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
  String color;
  double latitude;
  double longitude;
  int defaultVehicle;
  int status;
  int userId;

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
    color: json["color"] == null ? null : json["color"],
    latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
    longitude: json["longitude"] == null ? null : json["longitude"].toDouble(),
    defaultVehicle: json["defaultVehicle"] == null ? null : json["defaultVehicle"],
    status: json["status"] == null ? null : json["status"],
    userId: json["userId"] == null ? null : json["userId"],
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
    "color": color == null ? null : color,
    "latitude": latitude == null ? null : latitude,
    "longitude": longitude == null ? null : longitude,
    "defaultVehicle": defaultVehicle == null ? null : defaultVehicle,
    "status": status == null ? null : status,
    "userId": userId == null ? null : userId,
  };
}
