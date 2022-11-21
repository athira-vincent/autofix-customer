// To parse this JSON data, do
//
//     final newCheckoutModel = newCheckoutModelFromMap(jsonString);

import 'dart:convert';

NewCheckoutModel newCheckoutModelFromMap(String str) => NewCheckoutModel.fromMap(json.decode(str));

String newCheckoutModelToMap(NewCheckoutModel data) => json.encode(data.toMap());

class NewCheckoutModel {
  NewCheckoutModel({
    required this.message,
    required this.status,
    this.data,
  });
  String message;
  String status;
  Data? data;

  factory NewCheckoutModel.fromMap(Map<String, dynamic> json) => NewCheckoutModel(
    message: json["message"],
    status: json["status"],
    data: Data.fromMap(json["data"]),
  );

  Map<String, dynamic> toMap() => {
    "message": message,
    "status": status,
    "data": data!.toMap(),
  };
}

class Data {
  Data({
    required this.checkout,
  });

  List<List<Checkout>> checkout;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    checkout: List<List<Checkout>>.from(json["checkout"].map((x) => List<Checkout>.from(x.map((x) => Checkout.fromMap(x))))),
  );

  Map<String, dynamic> toMap() => {
    "checkout": List<dynamic>.from(checkout.map((x) => List<dynamic>.from(x.map((x) => x.toMap())))),
  };
}

class Checkout {
  Checkout({
    required this.mode,
    required  this.cost,
    required this.duration,
    required  this.currency,
    required  this.pricingTier,
  });

  String mode;
  double cost;
  String duration;
  String currency;
  String pricingTier;
  String deliverycharge="";
  String expecteddate="";

  factory Checkout.fromMap(Map<String, dynamic> json) => Checkout(
    mode: json["mode"],
    cost: json["cost"].toDouble(),
    duration: json["duration"],
    currency: json["currency"],
    pricingTier: json["pricingTier"],
  );

  Map<String, dynamic> toMap() => {
    "mode": mode,
    "cost": cost,
    "duration": duration,
    "currency": currency,
    "pricingTier": pricingTier,
  };
}
