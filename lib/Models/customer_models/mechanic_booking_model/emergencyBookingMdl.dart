// To parse this JSON data, do
//
//     final emergencyBookingMdl = emergencyBookingMdlFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

EmergencyBookingMdl emergencyBookingMdlFromJson(String str) => EmergencyBookingMdl.fromJson(json.decode(str));

String emergencyBookingMdlToJson(EmergencyBookingMdl data) => json.encode(data.toJson());

class EmergencyBookingMdl {
  EmergencyBookingMdl({
    required this.message,
    required this.status,
    required this.data,
  });

  String message;
  String status;
  Data? data;

  factory EmergencyBookingMdl.fromJson(Map<String, dynamic> json) => EmergencyBookingMdl(
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
    required this.emergencyBooking,
  });

  EmergencyBooking? emergencyBooking;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    emergencyBooking: json["emergencyBooking"] == null ? null : EmergencyBooking.fromJson(json["emergencyBooking"]),
  );

  Map<String, dynamic> toJson() => {
    "emergencyBooking": emergencyBooking == null ? null : emergencyBooking?.toJson(),
  };
}

class EmergencyBooking {
  EmergencyBooking({
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
    required this.mechLatitude,
    required this.mechLongitude,
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
  var tax;
  var commission;
  var serviceCharge;
  dynamic totalTime;
  String serviceTime;
  double latitude;
  double longitude;
  double mechLatitude;
  double mechLongitude;
  dynamic extend;
  dynamic totalExt;
  dynamic extendTime;
  DateTime? bookedDate;
  int isRated;
  int status;
  int customerId;
  int mechanicId;
  int vehicleId;
  dynamic mechanic;
  dynamic customer;
  dynamic vehicle;
  dynamic bookService;

  factory EmergencyBooking.fromJson(Map<String, dynamic> json) => EmergencyBooking(
    id: json["id"] == null ? null : json["id"],
    bookingCode: json["bookingCode"] == null ? null : json["bookingCode"],
    reqType: json["reqType"] == null ? null : json["reqType"],
    bookStatus: json["bookStatus"] == null ? null : json["bookStatus"],
    totalPrice: json["totalPrice"] == null ? null : json["totalPrice"],
    tax: json["tax"] == null ? null : json["tax"],
    commission: json["commission"] == null ? null : json["commission"],
    serviceCharge: json["serviceCharge"] == null ? null : json["serviceCharge"],
    totalTime: json["totalTime"],
    serviceTime: json["serviceTime"] == null ? null : json["serviceTime"],
    latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
    longitude: json["longitude"] == null ? null : json["longitude"].toDouble(),
    mechLatitude: json["mechLatitude"] == null ? null : json["mechLatitude"].toDouble(),
    mechLongitude: json["mechLongitude"] == null ? null : json["mechLongitude"].toDouble(),
    extend: json["extend"],
    totalExt: json["totalExt"],
    extendTime: json["extendTime"],
    bookedDate: json["bookedDate"] == null ? null : DateTime.parse(json["bookedDate"]),
    isRated: json["isRated"] == null ? null : json["isRated"],
    status: json["status"] == null ? null : json["status"],
    customerId: json["customerId"] == null ? null : json["customerId"],
    mechanicId: json["mechanicId"] == null ? null : json["mechanicId"],
    vehicleId: json["vehicleId"] == null ? null : json["vehicleId"],
    mechanic: json["mechanic"],
    customer: json["customer"],
    vehicle: json["vehicle"],
    bookService: json["bookService"],
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
    "mechLatitude": mechLatitude == null ? null : mechLatitude,
    "mechLongitude": mechLongitude == null ? null : mechLongitude,
    "extend": extend,
    "totalExt": totalExt,
    "extendTime": extendTime,
    "bookedDate": bookedDate == null ? null : bookedDate?.toIso8601String(),
    "isRated": isRated == null ? null : isRated,
    "status": status == null ? null : status,
    "customerId": customerId == null ? null : customerId,
    "mechanicId": mechanicId == null ? null : mechanicId,
    "vehicleId": vehicleId == null ? null : vehicleId,
    "mechanic": mechanic,
    "customer": customer,
    "vehicle": vehicle,
    "bookService": bookService,
  };
}
