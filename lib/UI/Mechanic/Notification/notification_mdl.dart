// To parse this JSON data, do
//
//     final notificationPayloadMdl = notificationPayloadMdlFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

NotificationPayloadMdl notificationPayloadMdlFromJson(String str) => NotificationPayloadMdl.fromJson(json.decode(str));

String notificationPayloadMdlToJson(NotificationPayloadMdl data) => json.encode(data.toJson());

class NotificationPayloadMdl {
  NotificationPayloadMdl({
    required this.data,
  });

  Data? data;

  factory NotificationPayloadMdl.fromJson(Map<String, dynamic> json) => NotificationPayloadMdl(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? null : data!.toJson(),
  };
}

class Data {
  Data({
    required this.clickAction,
    required this.id,
    required this.status,
    required this.screen,
    required this.bookingId,
    required this.serviceName,
    required this.serviceId,
    required this.carPlateNumber,
    required this.customerName,
    required this.customerAddress,
    required this.requestFromApp,
    required this.paymentStatus,
    required this.message,
  });

  String clickAction;
  int id;
  String status;
  String screen;
  String bookingId;
  String serviceName;
  int serviceId;
  String carPlateNumber;
  String customerName;
  String customerAddress;
  String requestFromApp;
  String paymentStatus;
  String message;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    clickAction: json["click_action"] == null ? null : json["click_action"],
    id: json["id"] == null ? null : json["id"],
    status: json["status"] == null ? null : json["status"],
    screen: json["screen"] == null ? null : json["screen"],
    bookingId: json["bookingId"] == null ? null : json["bookingId"],
    serviceName: json["serviceName"] == null ? null : json["serviceName"],
    serviceId: json["serviceId"] == null ? null : json["serviceId"],
    carPlateNumber: json["carPlateNumber"] == null ? null : json["carPlateNumber"],
    customerName: json["customerName"] == null ? null : json["customerName"],
    customerAddress: json["customerAddress"] == null ? null : json["customerAddress"],
    requestFromApp: json["requestFromApp"] == null ? null : json["requestFromApp"],
    paymentStatus: json["paymentStatus"] == null ? null : json["paymentStatus"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "click_action": clickAction == null ? null : clickAction,
    "id": id == null ? null : id,
    "status": status == null ? null : status,
    "screen": screen == null ? null : screen,
    "bookingId": bookingId == null ? null : bookingId,
    "serviceName": serviceName == null ? null : serviceName,
    "serviceId": serviceId == null ? null : serviceId,
    "carPlateNumber": carPlateNumber == null ? null : carPlateNumber,
    "customerName": customerName == null ? null : customerName,
    "customerAddress": customerAddress == null ? null : customerAddress,
    "requestFromApp": requestFromApp == null ? null : requestFromApp,
    "paymentStatus": paymentStatus == null ? null : paymentStatus,
    "message": message == null ? null : message,
  };
}
