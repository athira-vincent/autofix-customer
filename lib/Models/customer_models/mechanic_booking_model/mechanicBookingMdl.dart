// To parse this JSON data, do
//
//     final mechanicBookingMdl = mechanicBookingMdlFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MechanicBookingMdl mechanicBookingMdlFromJson(String str) => MechanicBookingMdl.fromJson(json.decode(str));

String mechanicBookingMdlToJson(MechanicBookingMdl data) => json.encode(data.toJson());

class MechanicBookingMdl {
  MechanicBookingMdl({
   required this.message,
   required this.status,
   required this.data,
  });

  String message;
  String status;
  Data? data;

  factory MechanicBookingMdl.fromJson(Map<String, dynamic> json) => MechanicBookingMdl(
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
   required this.mechanicBooking,
  });

  MechanicBooking? mechanicBooking;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    mechanicBooking: json["mechanicBooking"] == null ? null : MechanicBooking.fromJson(json["mechanicBooking"]),
  );

  Map<String, dynamic> toJson() => {
    "mechanicBooking": mechanicBooking == null ? null : mechanicBooking?.toJson(),
  };
}

class MechanicBooking {
  MechanicBooking({
   required this.id,
   required this.bookedDate,
   required this.latitude,
   required this.longitude,
   required this.customerId,
   required this.mechanicId,
   required this.status,
   required this.vehicleId,
   required this.totalPrice,
   required this.tax,
   required this.commission,
   required this.serviceCharge,
   required this.totalTime,
  });

  int id;
  DateTime? bookedDate;
  double latitude;
  double longitude;
  int customerId;
  int mechanicId;
  int status;
  int vehicleId;
  int totalPrice;
  int tax;
  int commission;
  int serviceCharge;
  String totalTime;

  factory MechanicBooking.fromJson(Map<String, dynamic> json) => MechanicBooking(
    id: json["id"] == null ? null : json["id"],
    bookedDate: json["bookedDate"] == null ? null : DateTime.parse(json["bookedDate"]),
    latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
    longitude: json["longitude"] == null ? null : json["longitude"].toDouble(),
    customerId: json["customerId"] == null ? null : json["customerId"],
    mechanicId: json["mechanicId"] == null ? null : json["mechanicId"],
    status: json["status"] == null ? null : json["status"],
    vehicleId: json["vehicleId"] == null ? null : json["vehicleId"],
    totalPrice: json["totalPrice"] == null ? null : json["totalPrice"],
    tax: json["tax"] == null ? null : json["tax"],
    commission: json["commission"] == null ? null : json["commission"],
    serviceCharge: json["serviceCharge"] == null ? null : json["serviceCharge"],
    totalTime: json["totalTime"] == null ? null : json["totalTime"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "bookedDate": bookedDate == null ? null : bookedDate?.toIso8601String(),
    "latitude": latitude == null ? null : latitude,
    "longitude": longitude == null ? null : longitude,
    "customerId": customerId == null ? null : customerId,
    "mechanicId": mechanicId == null ? null : mechanicId,
    "status": status == null ? null : status,
    "vehicleId": vehicleId == null ? null : vehicleId,
    "totalPrice": totalPrice == null ? null : totalPrice,
    "tax": tax == null ? null : tax,
    "commission": commission == null ? null : commission,
    "serviceCharge": serviceCharge == null ? null : serviceCharge,
    "totalTime": totalTime == null ? null : totalTime,
  };
}
