
import 'dart:convert';

CategoryListMdl categoryListMdlFromJson(String str) => CategoryListMdl.fromJson(json.decode(str));

String categoryListMdlToJson(CategoryListMdl data) => json.encode(data.toJson());

class CategoryListMdl {
  CategoryListMdl({
    required this.data,
    required this.message,
    required this.status,
  });

  Data? data;
  String message;
  String status;

  factory CategoryListMdl.fromJson(Map<String, dynamic> json) => CategoryListMdl(
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
  });

  String id;
  int catType;
  String catName;
  dynamic icon;
  int status;

  factory CategoryList.fromJson(Map<String, dynamic> json) => CategoryList(
    id: json["id"] == null ? null : json["id"],
    catType: json["catType"] == null ? null : json["catType"],
    catName: json["catName"] == null ? null : json["catName"],
    icon: json["icon"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "catType": catType == null ? null : catType,
    "catName": catName == null ? null : catName,
    "icon": icon,
    "status": status == null ? null : status,
  };
}
