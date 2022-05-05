// To parse this JSON data, do
//
//     final mechanicsBookingMdl = mechanicsBookingMdlFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MechanicsBookingMdl mechanicsBookingMdlFromJson(String str) => MechanicsBookingMdl.fromJson(json.decode(str));

String mechanicsBookingMdlToJson(MechanicsBookingMdl data) => json.encode(data.toJson());

class MechanicsBookingMdl {
  MechanicsBookingMdl({
    required this.data,
    required this.message,
    required this.status,
  });

  String message;
  String status;
  Data? data;

  factory MechanicsBookingMdl.fromJson(Map<String, dynamic> json) => MechanicsBookingMdl(
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
    required this.mechanicBooking,
  });

  MechanicBooking? mechanicBooking;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    mechanicBooking: json["mechanicBooking"] == null ? null : MechanicBooking.fromJson(json["mechanicBooking"]),
  );

  Map<String, dynamic> toJson() => {
    "mechanicBooking": mechanicBooking == null ? null : mechanicBooking!.toJson(),
  };
}

class MechanicBooking {
  MechanicBooking({
    required this.id,
    required this.bookedDate,
    required this.bookedTime,
    required this.latitude,
    required this.longitude,
    required this.customerId,
    required this.mechanicId,
    required this.status,
    required this.isAccepted,
    required this.isCompleted,
    required this.vehicleId,
    required this.totalPrice,
    required this.tax,
    required this.commission,
    required this.serviceCharge,
    required this.totalTime,
  });

  int id;
  String bookedDate;
  String bookedTime;
  double latitude;
  double longitude;
  int customerId;
  dynamic mechanicId;
  int status;
  dynamic isAccepted;
  dynamic isCompleted;
  int vehicleId;
  dynamic totalPrice;
  int tax;
  int commission;
  int serviceCharge;
  dynamic totalTime;

  factory MechanicBooking.fromJson(Map<String, dynamic> json) => MechanicBooking(
    id: json["id"] == null ? null : json["id"],
    bookedDate: json["bookedDate"] == null ? null : json["bookedDate"],
    bookedTime: json["bookedTime"] == null ? null : json["bookedTime"],
    latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
    longitude: json["longitude"] == null ? null : json["longitude"].toDouble(),
    customerId: json["customerId"] == null ? null : json["customerId"],
    mechanicId: json["mechanicId"],
    status: json["status"] == null ? null : json["status"],
    isAccepted: json["isAccepted"],
    isCompleted: json["isCompleted"],
    vehicleId: json["vehicleId"] == null ? null : json["vehicleId"],
    totalPrice: json["totalPrice"],
    tax: json["tax"] == null ? null : json["tax"],
    commission: json["commission"] == null ? null : json["commission"],
    serviceCharge: json["serviceCharge"] == null ? null : json["serviceCharge"],
    totalTime: json["totalTime"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "bookedDate": bookedDate == null ? null : bookedDate,
    "bookedTime": bookedTime == null ? null : bookedTime,
    "latitude": latitude == null ? null : latitude,
    "longitude": longitude == null ? null : longitude,
    "customerId": customerId == null ? null : customerId,
    "mechanicId": mechanicId,
    "status": status == null ? null : status,
    "isAccepted": isAccepted,
    "isCompleted": isCompleted,
    "vehicleId": vehicleId == null ? null : vehicleId,
    "totalPrice": totalPrice,
    "tax": tax == null ? null : tax,
    "commission": commission == null ? null : commission,
    "serviceCharge": serviceCharge == null ? null : serviceCharge,
    "totalTime": totalTime,
  };
}
