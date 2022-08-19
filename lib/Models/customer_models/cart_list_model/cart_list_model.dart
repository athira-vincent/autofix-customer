// To parse this JSON data, do
//
//     final cartListModel = cartListModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CartListModel cartListModelFromMap(String str) => CartListModel.fromMap(json.decode(str));

String cartListModelToMap(CartListModel data) => json.encode(data.toMap());

class CartListModel {
  CartListModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  Data? data;

  factory CartListModel.fromMap(Map<String, dynamic> json) => CartListModel(
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
    required this.cartList,
  });

  CartList cartList;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    cartList: CartList.fromMap(json["cartList"]),
  );

  Map<String, dynamic> toMap() => {
    "cartList": cartList.toMap(),
  };
}

class CartList {
  CartList({
    required this.totalItems,
    required this.data,
    required this.totalPages,
    required this.currentPage,
    required this.totalPrice,
    required this.count,
    required this.deliveryCharge,
  });

  int totalItems;
  List<Datum> data;
  int totalPages;
  int currentPage;
  int totalPrice;
  int count;
  int deliveryCharge;

  factory CartList.fromMap(Map<String, dynamic> json) => CartList(
    totalItems: json["totalItems"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
    totalPages: json["totalPages"],
    currentPage: json["currentPage"],
    totalPrice: json["totalPrice"],
    count: json["count"],
    deliveryCharge: json["deliveryCharge"],
  );

  Map<String, dynamic> toMap() => {
    "totalItems": totalItems,
    "data": List<dynamic>.from(data.map((x) => x.toMap())),
    "totalPages": totalPages,
    "currentPage": currentPage,
    "totalPrice": totalPrice,
    "count": count,
    "deliveryCharge": deliveryCharge,
  };
}

class Datum {
  Datum({
    required this.id,
    required this.customerId,
    required this.productId,
    required this.quantity,
    required this.status,
    required this.customer,
    required this.product,
  });

  int id;
  int customerId;
  int productId;
  int quantity;
  int status;
  Customer customer;
  Product product;

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    id: json["id"],
    customerId: json["customerId"],
    productId: json["productId"],
    quantity: json["quantity"],
    status: json["status"],
    customer: Customer.fromMap(json["customer"]),
    product: Product.fromMap(json["product"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "customerId": customerId,
    "productId": productId,
    "quantity": quantity,
    "status": status,
    "customer": customer.toMap(),
    "product": product.toMap(),
  };
}

class Customer {
  Customer({
    required this.id,
    required this.address,
  });

  int id;
  List<Address> address;

  factory Customer.fromMap(Map<String, dynamic> json) => Customer(
    id: json["id"],
    address: List<Address>.from(json["address"].map((x) => Address.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "address": List<dynamic>.from(address.map((x) => x.toMap())),
  };
}

class Address {
  Address({
    required this.fullName,
    required this.phoneNo,
    required this.pincode,
    required this.city,
    required this.state,
  });

  String fullName;
  String phoneNo;
  String pincode;
  String city;
  String state;

  factory Address.fromMap(Map<String, dynamic> json) => Address(
    fullName: json["fullName"],
    phoneNo: json["phoneNo"],
    pincode: json["pincode"],
    city: json["city"],
    state: json["state"],
  );

  Map<String, dynamic> toMap() => {
    "fullName": fullName,
    "phoneNo": phoneNo,
    "pincode": pincode,
    "city": city,
    "state": state,
  };
}

class Product {
  Product({
    required this.vehicleModel,
    required this.id,
    required this.productName,
    required this.productCode,
    required this.price,
    required this.productImage,
  });

  VehicleModel vehicleModel;
  int id;
  String productName;
  String productCode;
  String price;
  String productImage;

  factory Product.fromMap(Map<String, dynamic> json) => Product(
    vehicleModel: VehicleModel.fromMap(json["vehicleModel"]),
    id: json["id"],
    productName: json["productName"],
    productCode: json["productCode"],
    price: json["price"],
    productImage: json["productImage"] ?? "",
  );

  Map<String, dynamic> toMap() => {
    "vehicleModel": vehicleModel.toMap(),
    "id": id,
    "productName": productName,
    "productCode": productCode,
    "price": price,
    "productImage": productImage == null ? null : productImage,
  };
}

class VehicleModel {
  VehicleModel({
    required this.id,
    required this.brandName,
    required this.modelName,
  });

  String id;
  String brandName;
  String modelName;

  factory VehicleModel.fromMap(Map<String, dynamic> json) => VehicleModel(
    id: json["id"],
    brandName: json["brandName"],
    modelName: json["modelName"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "brandName": brandName,
    "modelName": modelName,
  };
}
