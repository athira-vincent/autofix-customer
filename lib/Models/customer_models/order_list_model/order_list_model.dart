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
    required this.commision,
    required this.tax,
    required this.paymentType,
    required this.deliverDate,
    required this.status,
    required this.vendorId,
    required this.customerId,
    required this.product,
    required this.review,
  });

  int id;
  String oderCode;
  int qty;
  double totalPrice;
  double commision;
  double tax;
  int paymentType;
  DateTime? deliverDate;
  int status;
  int vendorId;
  int customerId;

  Product product;
  List<dynamic> review;

  factory OrderList.fromMap(Map<String, dynamic> json) => OrderList(
        id: json["id"],
        oderCode: json["oderCode"],
        qty: json["qty"],
        totalPrice: json["totalPrice"].toDouble(),
        commision: json["commision"].toDouble(),
        tax: json["tax"].toDouble(),
        paymentType: json["paymentType"] == null ? null : json["paymentType"],
    deliverDate: json["deliverDate"] == null ? null : DateTime.parse(json["deliverDate"]),

    status: json["status"],
        vendorId: json["vendorId"],
        customerId: json["customerId"],
        product: Product.fromMap(json["product"]),
        review: List<dynamic>.from(json["review"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "oderCode": oderCode,
        "qty": qty,
        "totalPrice": totalPrice,
        "commision": commision,
        "tax": tax,
        "paymentType": paymentType == null ? null : paymentType,
    "deliverDate": deliverDate == null ? null : "${deliverDate!.year.toString().padLeft(4, '0')}-${deliverDate!.month.toString().padLeft(2, '0')}-${deliverDate!.day.toString().padLeft(2, '0')}",

    "status": status,
        "vendorId": vendorId,
        "customerId": customerId,
        "product": product.toMap(),
        "review": List<dynamic>.from(review.map((x) => x)),
      };
}

class Product {
  Product({
    required this.id,
    required this.productCode,
    required this.productName,
    required this.price,
    required this.shippingCharge,
    required this.productImage,
    required this.description,
    required this.quantity,
    required this.status,
    required this.vehicleModelId,
    required this.vendorId,
    required this.user,
    required this.vehicleModel,
    required this.reviewCount,
    required this.avgRate,
    required this.salesCount,
    required this.reviewData,
  });

  int id;
  String productCode;
  String productName;
  int price;
  int shippingCharge;
  dynamic productImage;
  String description;
  int quantity;
  int status;
  int vehicleModelId;
  int vendorId;
  dynamic user;
  dynamic vehicleModel;
  int reviewCount;
  double avgRate;
  dynamic salesCount;
  dynamic reviewData;

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        id: json["id"],
        productCode: json["productCode"],
        productName: json["productName"],
        price: json["price"],
        shippingCharge: json["shippingCharge"],
        productImage: json["productImage"],
        description: json["description"],
        quantity: json["quantity"],
        status: json["status"],
        vehicleModelId: json["vehicleModelId"],
        vendorId: json["vendorId"],
        user: json["user"],
        vehicleModel: json["vehicleModel"],
        reviewCount: json["reviewCount"],
        avgRate: json["avgRate"].toDouble(),
        salesCount: json["salesCount"],
        reviewData: json["reviewData"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "productCode": productCode,
        "productName": productName,
        "price": price,
        "shippingCharge": shippingCharge,
        "productImage": productImage,
        "description": description,
        "quantity": quantity,
        "status": status,
        "vehicleModelId": vehicleModelId,
        "vendorId": vendorId,
        "user": user,
        "vehicleModel": vehicleModel,
        "reviewCount": reviewCount,
        "avgRate": avgRate,
        "salesCount": salesCount,
        "reviewData": reviewData,
      };
}
