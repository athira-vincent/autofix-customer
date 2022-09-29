// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

NotificationModel notificationModelFromMap(String str) =>
    NotificationModel.fromMap(json.decode(str));

String notificationModelToMap(NotificationModel data) =>
    json.encode(data.toMap());

class NotificationModel {
  NotificationModel({
    required this.message,
    required this.status,
    required this.data,
  });

  String message;
  String status;
  Data? data;

  factory NotificationModel.fromMap(Map<String, dynamic> json) =>
      NotificationModel(
        message: json["message"] ?? null,
        status: json["status"] ?? null,
        data: Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "message": message,
        "status": status,
        "data": data!.toMap(),
      };
}

class Data {
  Data({
    required this.notificationList,
  });

  List<NotificationList> notificationList;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        notificationList: List<NotificationList>.from(
            json["notificationList"].map((x) => NotificationList.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "notificationList":
            List<dynamic>.from(notificationList.map((x) => x.toMap())),
      };
}

class NotificationList {
  NotificationList({
    required this.id,
    required this.caption,
    required this.message,
    // required this.read,
    // required this.trash,
    // required this.status,
    // required this.toId,
    // required this.bookingId,
  });

  String id;
  String caption;
  String message;
  // int read;
  // int trash;
  // int status;
  // int toId;
  // int bookingId;

  factory NotificationList.fromMap(Map<String, dynamic> json) =>
      NotificationList(
        id: json["id"],
        caption: json["caption"]??"",
        message: json["message"]??"",
        // read: json["read"],
        // trash: json["trash"],
        // status: json["status"],
        // toId: json["toId"],
        // bookingId: json["bookingId"] == null ? null : json["bookingId"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "caption": caption,
        "message": message,
        // "read": read,
        // "trash": trash,
        // "status": status,
        // "toId": toId,
        // "bookingId": bookingId == null ? null : bookingId,
      };
}

class Customer {
  Customer({
    required this.id,
  });

  String id;

  factory Customer.fromMap(Map<String, dynamic> json) => Customer(
        id: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
      };
}
