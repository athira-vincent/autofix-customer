// To parse this JSON data, do
//
//     final walletistoryModel = walletistoryModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

WalletistoryModel walletistoryModelFromMap(String str) =>
    WalletistoryModel.fromMap(json.decode(str));

String walletistoryModelToMap(WalletistoryModel data) =>
    json.encode(data.toMap());

class WalletistoryModel {
  WalletistoryModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  Data? data;

  factory WalletistoryModel.fromMap(Map<String, dynamic> json) =>
      WalletistoryModel(
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
    required this.walletHistory,
  });

  List<WalletHistory> walletHistory;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        walletHistory: List<WalletHistory>.from(
            json["walletHistory"].map((x) => WalletHistory.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "walletHistory":
            List<dynamic>.from(walletHistory.map((x) => x.toMap())),
      };
}

class WalletHistory {
  WalletHistory({
    required this.id,
    required this.type,
    required this.amount,
    required this.balance,
    required this.recordDate,
    required this.reference,
    required this.paymentMode,
    required this.status,
    required this.customerId,
  });

  int id;
  int type;
  int amount;
  int balance;
  DateTime recordDate;
  dynamic reference;
  int paymentMode;
  int status;
  int customerId;

  factory WalletHistory.fromMap(Map<String, dynamic> json) => WalletHistory(
        id: json["id"],
        type: json["type"],
        amount: json["amount"],
        balance: json["balance"],
        recordDate: DateTime.parse(json["recordDate"]),
        reference: json["reference"],
        paymentMode: json["paymentMode"],
        status: json["status"],
        customerId: json["customerId"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "type": type,
        "amount": amount,
        "balance": balance,
        "recordDate": recordDate.toIso8601String(),
        "reference": reference,
        "paymentMode": paymentMode,
        "status": status,
        "customerId": customerId,
      };
}
