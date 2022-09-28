// To parse this JSON data, do
//
//     final codmodel = codmodelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Codmodel codmodelFromMap(String str) => Codmodel.fromMap(json.decode(str));

String codmodelToMap(Codmodel data) => json.encode(data.toMap());

class Codmodel {
  Codmodel({
    required this.status,
    required this.message,
    required this.data,
  });
  String status;
  String message;
  Data? data;

  factory Codmodel.fromMap(Map<String, dynamic> json) => Codmodel(
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
    required this.cashOnDelivery,
  });

  CashOnDelivery cashOnDelivery;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    cashOnDelivery: CashOnDelivery.fromMap(json["cashOnDelivery"]),
  );

  Map<String, dynamic> toMap() => {
    "cashOnDelivery": cashOnDelivery.toMap(),
  };
}

class CashOnDelivery {
  CashOnDelivery({
    required this.message,
  });

  String message;

  factory CashOnDelivery.fromMap(Map<String, dynamic> json) => CashOnDelivery(
    message: json["message"],
  );

  Map<String, dynamic> toMap() => {
    "message": message,
  };
}
