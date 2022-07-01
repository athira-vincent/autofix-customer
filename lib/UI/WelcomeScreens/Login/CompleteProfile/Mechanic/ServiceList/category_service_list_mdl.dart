
import 'dart:convert';

CategoryServiceListMdl categoryServiceListMdlFromJson(String str) => CategoryServiceListMdl.fromJson(json.decode(str));

String categoryServiceListMdlToJson(CategoryServiceListMdl data) => json.encode(data.toJson());

class CategoryServiceListMdl {
  CategoryServiceListMdl({
    required this.data,
    required this.message,
    required this.status,
  });

  Data? data;
  String message;
  String status;

  factory CategoryServiceListMdl.fromJson(Map<String, dynamic> json) => CategoryServiceListMdl(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    message: json["message"] == null ? null : json["message"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? null : data!.toJson(),
    "message": message == null ? null : message,
    "status": status == null ? null : status,
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
    required this.service,
  });

  String id;
  int catType;
  String catName;
  dynamic icon;
  int status;
  List<Service>? service;

  factory CategoryList.fromJson(Map<String, dynamic> json) => CategoryList(
    id: json["id"] == null ? null : json["id"],
    catType: json["catType"] == null ? null : json["catType"],
    catName: json["catName"] == null ? null : json["catName"],
    icon: json["icon"],
    status: json["status"] == null ? null : json["status"],
    service: json["service"] == null ? null : List<Service>.from(json["service"].map((x) => Service.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "catType": catType == null ? null : catType,
    "catName": catName == null ? null : catName,
    "icon": icon,
    "status": status == null ? null : status,
    "service": service == null ? null : List<dynamic>.from(service!.map((x) => x.toJson())),
  };
}

class Service {
  Service({
    required this.id,
    required this.serviceName,
    required this.description,
    required this.icon,
    required this.minPrice,
    required this.maxPrice,
    required this.categoryId,
    required this.status,
  });

  String id;
  String serviceName;
  dynamic description;
  dynamic icon;
  String minPrice;
  String maxPrice;
  int categoryId;
  int status;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
    id: json["id"] == null ? null : json["id"],
    serviceName: json["serviceName"] == null ? null : json["serviceName"],
    description: json["description"],
    icon: json["icon"],
    minPrice: json["minPrice"] == null ? null : json["minPrice"],
    maxPrice: json["maxPrice"] == null ? null : json["maxPrice"],
    categoryId: json["categoryId"] == null ? null : json["categoryId"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "serviceName": serviceName == null ? null : serviceName,
    "description": description,
    "icon": icon,
    "minPrice": minPrice == null ? null : minPrice,
    "maxPrice": maxPrice == null ? null : maxPrice,
    "categoryId": categoryId == null ? null : categoryId,
    "status": status == null ? null : status,
  };
}
