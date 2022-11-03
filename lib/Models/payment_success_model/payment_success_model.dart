// To parse this JSON data, do
//
//     final paymentSuccessModel = paymentSuccessModelFromMap(jsonString);

import 'dart:convert';

PaymentSuccessModel paymentSuccessModelFromMap(String str) =>
    PaymentSuccessModel.fromMap(json.decode(str));

String paymentSuccessModelToMap(PaymentSuccessModel data) =>
    json.encode(data.toMap());

class PaymentSuccessModel {
  PaymentSuccessModel({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  Data? data;

  factory PaymentSuccessModel.fromMap(Map<String, dynamic> json) =>
      PaymentSuccessModel(
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
    required this.paymentCreate,
  });

  PaymentCreate paymentCreate;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        paymentCreate: PaymentCreate.fromMap(json["paymentCreate"]),
      );

  Map<String, dynamic> toMap() => {
        "paymentCreate": paymentCreate.toMap(),
      };
}

class PaymentCreate {
  PaymentCreate({
    required this.id,
    required this.transType,
    required this.amount,
    required this.paymentType,
    required this.transId,
    required this.transData,
    required this.status,
    required this.userId,
    this.user,
  });

  int id;
  int transType;
  int amount;
  int paymentType;
  String transId;
  String transData;
  int status;
  int userId;
  dynamic user;

  factory PaymentCreate.fromMap(Map<String, dynamic> json) => PaymentCreate(
        id: json["id"],
        transType: json["transType"],
        amount: json["amount"],
        paymentType: json["paymentType"],
        transId: json["transId"],
        transData: json["transData"],
        status: json["status"],
        userId: json["userId"],
        user: json["user"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "transType": transType,
        "amount": amount,
        "paymentType": paymentType,
        "transId": transId,
        "transData": transData,
        "status": status,
        "userId": userId,
        "user": user,
      };
}
