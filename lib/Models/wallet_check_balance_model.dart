// To parse this JSON data, do
//
//     final walletCheckBalanceModel = walletCheckBalanceModelFromMap(jsonString);

import 'dart:convert';

WalletCheckBalanceModel walletCheckBalanceModelFromMap(String str) => WalletCheckBalanceModel.fromMap(json.decode(str));

String walletCheckBalanceModelToMap(WalletCheckBalanceModel data) => json.encode(data.toMap());

class WalletCheckBalanceModel {
  WalletCheckBalanceModel({
    required this.status,
    required this.message,
    required this.data,
  });
  String status;
  String message;
  WalletCheckBalanceModelData? data;

  factory WalletCheckBalanceModel.fromMap(Map<String, dynamic> json) => WalletCheckBalanceModel(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: WalletCheckBalanceModelData.fromMap(json["data"]),
  );

  Map<String, dynamic> toMap() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data!.toMap(),
  };
}

class WalletCheckBalanceModelData {
  WalletCheckBalanceModelData({
    required this.walletStatus,
  });

  WalletStatus walletStatus;

  factory WalletCheckBalanceModelData.fromMap(Map<String, dynamic> json) => WalletCheckBalanceModelData(
    walletStatus: WalletStatus.fromMap(json["walletStatus"]),
  );

  Map<String, dynamic> toMap() => {
    "walletStatus": walletStatus.toMap(),
  };
}

class WalletStatus {
  WalletStatus({
    required  this.status,
    required  this.data,
  });

  bool status;
  WalletStatusData data;

  factory WalletStatus.fromMap(Map<String, dynamic> json) => WalletStatus(
    status: json["status"],
    data: WalletStatusData.fromMap(json["data"]),
  );

  Map<String, dynamic> toMap() => {
    "status": status,
    "data": data.toMap(),
  };
}

class WalletStatusData {
  WalletStatusData({
    required  this.amount,
    required  this.wallet,
    required  this.remain,
  });

  int amount;
  int wallet;
  int remain;

  factory WalletStatusData.fromMap(Map<String, dynamic> json) => WalletStatusData(
    amount: json["amount"],
    wallet: json["wallet"],
    remain: json["remain"],
  );

  Map<String, dynamic> toMap() => {
    "amount": amount,
    "wallet": wallet,
    "remain": remain,
  };
}
