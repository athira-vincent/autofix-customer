// To parse this JSON data, do
//
//     final paymentSuccessModel = paymentSuccessModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

PaymentSuccessModel paymentSuccessModelFromMap(String str) => PaymentSuccessModel.fromMap(json.decode(str));

String paymentSuccessModelToMap(PaymentSuccessModel data) => json.encode(data.toMap());

class PaymentSuccessModel {
  PaymentSuccessModel({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  Data? data;

  factory PaymentSuccessModel.fromMap(Map<String, dynamic> json) => PaymentSuccessModel(
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
    required this.paymentData,
    required this.msg,
  });

  PaymentData? paymentData;
  Msg? msg;

  factory PaymentCreate.fromMap(Map<String, dynamic> json) => PaymentCreate(
    paymentData: json["paymentData"] == null ? null : PaymentData.fromMap(json["paymentData"]),
    msg: json["msg"] == null ? null : Msg.fromJson(json["msg"]),
  );

  Map<String, dynamic> toMap() => {
    "paymentData": paymentData == null ? null : paymentData!.toMap(),
    "msg": msg == null ? null : msg!.toJson(),
  };
}

class PaymentData {
  PaymentData({
    required this.id,
    required this.transType,
    required this.amount,
    required this.paymentType,
    required this.transId,
    required this.transData,
    required this.status,
    required this.userId,

  });

  int id;
  int transType;
  int amount;
  int paymentType;
  String transId;
  String transData;
  int status;
  int userId;


  factory PaymentData.fromMap(Map<String, dynamic> json) => PaymentData(
    id: json["id"] == null ? null : json["id"],
    transType: json["transType"] == null ? null : json["transType"],
    amount: json["amount"] == null ? null : json["amount"],
    paymentType: json["paymentType"] == null ? null : json["paymentType"],
    transId: json["transId"] == null ? null : json["transId"],
    transData: json["transData"] == null ? null : json["transData"],
    status: json["status"] == null ? null : json["status"],
    userId: json["userId"] == null ? null : json["userId"],

  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "transType": transType == null ? null : transType,
    "amount": amount == null ? null : amount,
    "paymentType": paymentType == null ? null : paymentType,
    "transId": transId == null ? null : transId,
    "transData": transData == null ? null : transData,
    "status": status == null ? null : status,
    "userId": userId == null ? null : userId,

  };
}

class Msg {
  Msg({
    required this.message,
  });

  String message;

  factory Msg.fromJson(Map<String, dynamic> json) => Msg(
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
  };
}

