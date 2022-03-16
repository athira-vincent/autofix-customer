// To parse this JSON data, do
//
//     final mechanicsBookingMdl = mechanicsBookingMdlFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MechanicsBookingMdl mechanicsBookingMdlFromJson(String str) => MechanicsBookingMdl.fromJson(json.decode(str));

String mechanicsBookingMdlToJson(MechanicsBookingMdl data) => json.encode(data.toJson());

class MechanicsBookingMdl {
  MechanicsBookingMdl({
    required this.message,
    required this.status,
    required this.data,
  });

  String message;
  String status;
  Data? data;

  factory MechanicsBookingMdl.fromJson(Map<String, dynamic> json) => MechanicsBookingMdl(
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
    required this.mechanicsBooking,
  });

  MechanicsBooking? mechanicsBooking;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    mechanicsBooking: json["mechanics_Booking"] == null ? null : MechanicsBooking.fromJson(json["mechanics_Booking"]),
  );

  Map<String, dynamic> toJson() => {
    "mechanics_Booking": mechanicsBooking == null ? null : mechanicsBooking!.toJson(),
  };
}

class MechanicsBooking {
  MechanicsBooking({
    required this.id,
    required this.date,
    required this.time,
    required this.latitude,
    required this.longitude,
    required this.paymentMethod,
    required this.userId,
    required this.status,
    required this.isAccepted,
    required this.vehicleId,
    required this.serviceId,
  });

  String id;
  String date;
  String time;
  double latitude;
  double longitude;
  dynamic paymentMethod;
  int userId;
  int status;
  int isAccepted;
  int vehicleId;
  dynamic serviceId;

  factory MechanicsBooking.fromJson(Map<String, dynamic> json) => MechanicsBooking(
    id: json["id"] == null ? null : json["id"],
    date: json["date"] == null ? null : json["date"],
    time: json["time"] == null ? null : json["time"],
    latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
    longitude: json["longitude"] == null ? null : json["longitude"].toDouble(),
    paymentMethod: json["paymentMethod"],
    userId: json["userId"] == null ? null : json["userId"],
    status: json["status"] == null ? null : json["status"],
    isAccepted: json["isAccepted"] == null ? null : json["isAccepted"],
    vehicleId: json["vehicleId"] == null ? null : json["vehicleId"],
    serviceId: json["serviceId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "date": date == null ? null : date,
    "time": time == null ? null : time,
    "latitude": latitude == null ? null : latitude,
    "longitude": longitude == null ? null : longitude,
    "paymentMethod": paymentMethod,
    "userId": userId == null ? null : userId,
    "status": status == null ? null : status,
    "isAccepted": isAccepted == null ? null : isAccepted,
    "vehicleId": vehicleId == null ? null : vehicleId,
    "serviceId": serviceId,
  };
}
