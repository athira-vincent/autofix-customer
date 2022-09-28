// To parse this JSON data, do
//
//     final orderDetails = orderDetailsFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

OrderDetails orderDetailsFromMap(String str) =>
    OrderDetails.fromMap(json.decode(str));

String orderDetailsToMap(OrderDetails data) => json.encode(data.toMap());

class OrderDetails {
  OrderDetails({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  Data? data;

  factory OrderDetails.fromMap(Map<String, dynamic> json) => OrderDetails(
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
    required this.orderList,
  });

  List<OrderList> orderList;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        orderList: List<OrderList>.from(
            json["orderList"].map((x) => OrderList.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "orderList": List<dynamic>.from(orderList.map((x) => x.toMap())),
      };
}

class OrderList {
  OrderList({
    required this.id,
    required this.oderCode,
    required this.qty,
    required this.totalPrice,

    required this.paymentType,
    required this.paymentStatus,
    required this.deliverDate,
    required this.status,

    required this.product,
  });

  int id;
  String oderCode;
  int qty;
  double totalPrice;

  int paymentType;
  int paymentStatus;
  DateTime? deliverDate;
  int status;


  Product product;


  factory OrderList.fromMap(Map<String, dynamic> json) => OrderList(
        id: json["id"],
        oderCode: json["oderCode"],
        qty: json["qty"],
        totalPrice: json["totalPrice"].toDouble(),

    paymentType: json["paymentType"] == null ? null : json["paymentType"],

    paymentStatus: json["paymentStatus"],
        deliverDate: json["deliverDate"] == null
            ? null
            : DateTime.parse(json["deliverDate"]),
        status: json["status"],

        product: Product.fromMap(json["product"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "oderCode": oderCode,
        "qty": qty,
        "totalPrice": totalPrice,

        "paymentType":  paymentType == null ? null : paymentType,
        "paymentStatus": paymentStatus,
        "deliverDate": deliverDate == null
            ? null
            : "${deliverDate!.year.toString().padLeft(4, '0')}-${deliverDate!.month.toString().padLeft(2, '0')}-${deliverDate!.day.toString().padLeft(2, '0')}",
        "status": status,

        "product": product.toMap(),
      };
}

class Product {
  Product({
    required this.id,
    required this.productCode,
    required this.productName,
    required this.price,
    required this.shippingCharge,
   // required this.productImage,

    required this.quantity,
    required this.productImage,

  });

  int id;
  String productCode;
  String productName;
  int price;
  int shippingCharge;
  String productImage;
 // dynamic productImage;

  int quantity;

  //double avgRate;


  factory Product.fromMap(Map<String, dynamic> json) => Product(
        id: json["id"],
        productCode: json["productCode"],
        productName: json["productName"],
        price: json["price"],
        shippingCharge: json["shippingCharge"],
       // productImage: json["productImage"],
        quantity: json["quantity"],
        productImage: json["productImage"],
        //avgRate: json["avgRate"].toDouble(),

      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "productCode": productCode,
        "productName": productName,
        "price": price,
        "shippingCharge": shippingCharge,
        //"productImage": productImage,
        "productImage": productImage,
        "quantity": quantity,

      };
}
