// To parse this JSON data, do
//
//     final customerRatingModel = customerRatingModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CustomerRatingModel customerRatingModelFromMap(String str) =>
    CustomerRatingModel.fromMap(json.decode(str));

String customerRatingModelToMap(CustomerRatingModel data) =>
    json.encode(data.toMap());

class CustomerRatingModel {
  CustomerRatingModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  Data? data;

  factory CustomerRatingModel.fromMap(Map<String, dynamic> json) =>
      CustomerRatingModel(
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
    required this.reviewCreate,
  });

  ReviewCreate reviewCreate;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        reviewCreate: ReviewCreate.fromMap(json["review_Create"]),
      );

  Map<String, dynamic> toMap() => {
        "review_Create": reviewCreate.toMap(),
      };
}

class ReviewCreate {
  ReviewCreate({
    required this.message,
  });

  String message;

  factory ReviewCreate.fromMap(Map<String, dynamic> json) => ReviewCreate(
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "message": message,
      };
}
