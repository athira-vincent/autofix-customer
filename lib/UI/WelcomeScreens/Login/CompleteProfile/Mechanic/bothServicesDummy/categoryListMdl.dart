// To parse this JSON data, do
//
//     final categoryListMdl = categoryListMdlFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CategoryListMdl categoryListMdlFromJson(String str) => CategoryListMdl.fromJson(json.decode(str));

String categoryListMdlToJson(CategoryListMdl data) => json.encode(data.toJson());

class CategoryListMdl {
  CategoryListMdl({
    required this.message,
    required this.status,
    required this.data,
  });

  String message;
  String status;
  Data? data;

  factory CategoryListMdl.fromJson(Map<String, dynamic> json) => CategoryListMdl(
    message: json["message"] == null ? null : json["message"],
    status: json["status"] == null ? null : json["status"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
    "status": status == null ? null : status,
    "data": data == null ? null : data?.toJson(),
  };
}

class Data {
  Data({
    required this.categoryList,
  });

  List<CategoryList>? categoryList;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    categoryList: json["category_list"] == null ? null : List<CategoryList>.from(json["category_list"].map((x) => CategoryList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "category_list": categoryList == null ? null : List<dynamic>.from(categoryList!.map((x) => x.toJson())),
  };
}

class CategoryList {
  CategoryList({
    required this.id,
    required this.catType,
    required this.catName,
    required this.icon,
    required this.status,
    required this.minAmount,
    required this.maxAmount,
    required this.type,
  });

  String id;
  int catType;
  String catName;
  dynamic icon;
  int status;
  String minAmount = "200";
  String maxAmount= "200";
  String type="1";

  factory CategoryList.fromJson(Map<String, dynamic> json) => CategoryList(
    id: json["id"] == null ? null : json["id"],
    catType: json["catType"] == null ? null : json["catType"],
    catName: json["catName"] == null ? null : json["catName"],
    icon: json["icon"],
    status: json["status"] == null ? null : json["status"],
    minAmount: json["minAmount"] == null ? null : json["minAmount"],
    maxAmount: json["maxAmount"] == null ? null : json["maxAmount"],
    type: json["type"] == null ? null : json["type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "catType": catType == null ? null : catType,
    "catName": catName == null ? null : catName,
    "icon": icon,
    "status": status == null ? null : status,
    "minAmount": minAmount == null ? null : minAmount,
    "maxAmount": maxAmount == null ? null : maxAmount,
    "type": type == null ? null : type,
  };
}
