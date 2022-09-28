// To parse this JSON data, do
//
//     final deleteCartModel = deleteCartModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

DeleteCartModel deleteCartModelFromMap(String str) =>
    DeleteCartModel.fromMap(json.decode(str));

String deleteCartModelToMap(DeleteCartModel data) => json.encode(data.toMap());

class DeleteCartModel {
  DeleteCartModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  Data? data;

  factory DeleteCartModel.fromMap(Map<String, dynamic> json) => DeleteCartModel(
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
    required this.updateCart,
  });

  UpdateCart updateCart;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        updateCart: UpdateCart.fromMap(json["updateCart"]),
      );

  Map<String, dynamic> toMap() => {
        "updateCart": updateCart.toMap(),
      };
}

class UpdateCart {
  UpdateCart({
    required this.status,
    required this.code,
    required this.message,
  });

  String status;
  String code;
  String message;

  factory UpdateCart.fromMap(Map<String, dynamic> json) => UpdateCart(
        status: json["status"],
        code: json["code"],
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "code": code,
        "message": message,
      };
}
