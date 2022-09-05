// To parse this JSON data, do
//
//     final placeOrderModel = placeOrderModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

PlaceOrderModel placeOrderModelFromMap(String str) => PlaceOrderModel.fromMap(json.decode(str));

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
    "data": data!.toMap(),
  };
}

class Data {
  Data({
    required this.placeOrder,
  });

  PlaceOrder placeOrder;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    placeOrder: PlaceOrder.fromMap(json["placeOrder"]),
  );

  Map<String, dynamic> toMap() => {
    "placeOrder": placeOrder.toMap(),
  };
}

class PlaceOrder {
  PlaceOrder({
    required this.message,
  });

  String message;

  factory PlaceOrder.fromMap(Map<String, dynamic> json) => PlaceOrder(
    message: json["message"],
  );

  Map<String, dynamic> toMap() => {
    "message": message,
  };
}
