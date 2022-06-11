
import 'dart:convert';

BrandListMdl brandListMdlFromJson(String str) => BrandListMdl.fromJson(json.decode(str));

String brandListMdlToJson(BrandListMdl data) => json.encode(data.toJson());

class BrandListMdl {
  BrandListMdl({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  Data? data;

  factory BrandListMdl.fromJson(Map<String, dynamic> json) => BrandListMdl(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : data?.toJson(),
  };
}

class Data {
  Data({
    required this.brandList,
  });

  BrandList? brandList;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    brandList: json["brandList"] == null ? null : BrandList.fromJson(json["brandList"]),
  );

  Map<String, dynamic> toJson() => {
    "brandList": brandList == null ? null : brandList?.toJson(),
  };
}

class BrandList {
  BrandList({
    required this.totalItems,
    required this.data,
    required this.totalPages,
    required this.currentPage,
  });

  int totalItems;
  List<Datum>? data;
  int totalPages;
  int currentPage;

  factory BrandList.fromJson(Map<String, dynamic> json) => BrandList(
    totalItems: json["totalItems"] == null ? null : json["totalItems"],
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    totalPages: json["totalPages"] == null ? null : json["totalPages"],
    currentPage: json["currentPage"] == null ? null : json["currentPage"],
  );

  Map<String, dynamic> toJson() => {
    "totalItems": totalItems == null ? null : totalItems,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
    "totalPages": totalPages == null ? null : totalPages,
    "currentPage": currentPage == null ? null : currentPage,
  };
}

class Datum {
  Datum({
    required this.id,
    required this.brandName,
    required this.icon,
    required this.status,
    required this.value,

  });

  String id;
  String brandName;
  String icon;
  int status;
  String value;


  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    brandName: json["brandName"] == null ? null : json["brandName"],
    icon: json["icon"] == null ? null : json["icon"],
    status: json["status"] == null ? null : json["status"],
    value: json["value"] == null ? null : json["value"],

  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "brandName": brandName == null ? null : brandName,
    "icon": icon == null ? null : icon,
    "status": status == null ? null : status,
    "value": value == null ? null : value,

  };
}
