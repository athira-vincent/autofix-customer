// To parse this JSON data, do
//
//     final placeOrderModel = placeOrderModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

PlaceOrderModel placeOrderModelFromMap(String str) =>
    PlaceOrderModel.fromMap(json.decode(str));

String placeOrderModelToMap(PlaceOrderModel data) => json.encode(data.toMap());

class PlaceOrderModel {
  PlaceOrderModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  Data? data;

  factory PlaceOrderModel.fromMap(Map<String, dynamic> json) => PlaceOrderModel(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data!.toMap(),
      };
}

class Data {
  Data({
    required this.placeOrder,
  });

  List<PlaceOrder> placeOrder;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        placeOrder: List<PlaceOrder>.from(
            json["placeOrder"].map((x) => PlaceOrder.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "placeOrder": List<dynamic>.from(placeOrder.map((x) => x.toMap())),
      };
}

class PlaceOrder {
  PlaceOrder({
    required this.id,
    required this.oderCode,

  });

  int id;
  String oderCode;

  factory PlaceOrder.fromMap(Map<String, dynamic> json) => PlaceOrder(
        id: json["id"],
        oderCode: json["oderCode"],

      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "oderCode": oderCode,

      };
}


