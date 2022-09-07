// To parse this JSON data, do
//
//     final cancelOrder = cancelOrderFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CancelOrder cancelOrderFromMap(String str) => CancelOrder.fromMap(json.decode(str));

String cancelOrderToMap(CancelOrder data) => json.encode(data.toMap());

class CancelOrder {
  CancelOrder({
    required this.status,
    required this.message,
    required this.data,
  });
  String status;
  String message;
  Data? data;

  factory CancelOrder.fromMap(Map<String, dynamic> json) => CancelOrder(
    status: json["status"],
    message: json["message"],
    data: Data.fromMap(json["data"]),
  );

  Map<String, dynamic> toMap() => {
    "status": status,
    "message": message,
    "data": data!.toMap(),
  };
}

class Data {
  Data({
    required this.orderCancel,
  });

  OrderCancel orderCancel;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    orderCancel: OrderCancel.fromMap(json["orderCancel"]),
  );

  Map<String, dynamic> toMap() => {
    "orderCancel": orderCancel.toMap(),
  };
}

class OrderCancel {
  OrderCancel({
    required this.message,
  });

  String message;

  factory OrderCancel.fromMap(Map<String, dynamic> json) => OrderCancel(
    message: json["message"],
  );

  Map<String, dynamic> toMap() => {
    "message": message,
  };
}
