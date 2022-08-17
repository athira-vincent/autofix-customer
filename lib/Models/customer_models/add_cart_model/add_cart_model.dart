import 'package:meta/meta.dart';
import 'dart:convert';

AddCartModel addCartModelFromMap(String str) =>
    AddCartModel.fromMap(json.decode(str));

String addCartModelToMap(AddCartModel data) => json.encode(data.toMap());

class AddCartModel {
  AddCartModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  Data? data;

  factory AddCartModel.fromMap(Map<String, dynamic> json) => AddCartModel(
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
    required this.addCart,
  });

  AddCart addCart;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        addCart: AddCart.fromMap(json["addCart"]),
      );

  Map<String, dynamic> toMap() => {
        "addCart": addCart.toMap(),
      };
}

class AddCart {
  AddCart({
    required this.status,
    required this.code,
    required this.message,
  });

  String status;
  String code;
  String message;

  factory AddCart.fromMap(Map<String, dynamic> json) => AddCart(
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
