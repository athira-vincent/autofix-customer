import 'package:meta/meta.dart';
import 'dart:convert';

EnrgRegAddPriceMdl enrgRegAddPriceMdlFromJson(String str) => EnrgRegAddPriceMdl.fromJson(json.decode(str));

String enrgRegAddPriceMdlToJson(EnrgRegAddPriceMdl data) => json.encode(data.toJson());

class EnrgRegAddPriceMdl {
  EnrgRegAddPriceMdl({
    required this.data,
  });

  Data? data;

  factory EnrgRegAddPriceMdl.fromJson(Map<String, dynamic> json) => EnrgRegAddPriceMdl(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? null : data!.toJson(),
  };
}

class Data {
  Data({
    required this.addPriceServiceList,
  });

  AddPriceServiceList? addPriceServiceList;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    addPriceServiceList: json["addPriceServiceList"] == null ? null : AddPriceServiceList.fromJson(json["addPriceServiceList"]),
  );

  Map<String, dynamic> toJson() => {
    "addPriceServiceList": addPriceServiceList == null ? null : addPriceServiceList!.toJson(),
  };
}

class AddPriceServiceList {
  AddPriceServiceList({
    required this.totalItems,
    required this.data,
    required this.totalPages,
    required this.currentPage,
  });

  int totalItems;
  List<Datum>? data;
  int totalPages;
  int currentPage;

  factory AddPriceServiceList.fromJson(Map<String, dynamic> json) => AddPriceServiceList(
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
    required this.serviceCode,
    required this.serviceName,
    required this.minPrice,
    required this.maxPrice,
    required this.icon,
    required this.status,
    required this.categoryId,
    required this.category,
    required this.mechanicService,
  });

  int id;
  String serviceCode;
  String serviceName;
  String minPrice;
  String maxPrice;
  String icon;
  int status;
  int categoryId;
  Category? category;
  List<MechanicService>? mechanicService;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    serviceCode: json["serviceCode"] == null ? null : json["serviceCode"],
    serviceName: json["serviceName"] == null ? null : json["serviceName"],
    minPrice: json["minPrice"] == null ? null : json["minPrice"],
    maxPrice: json["maxPrice"] == null ? null : json["maxPrice"],
    icon: json["icon"] == null ? null : json["icon"],
    status: json["status"] == null ? null : json["status"],
    categoryId: json["categoryId"] == null ? null : json["categoryId"],
    category: json["category"] == null ? null : Category.fromJson(json["category"]),
    mechanicService: json["mechanicService"] == null ? null : List<MechanicService>.from(json["mechanicService"].map((x) => MechanicService.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "serviceCode": serviceCode == null ? null : serviceCode,
    "serviceName": serviceName == null ? null : serviceName,
    "minPrice": minPrice == null ? null : minPrice,
    "maxPrice": maxPrice == null ? null : maxPrice,
    "icon": icon == null ? null : icon,
    "status": status == null ? null : status,
    "categoryId": categoryId == null ? null : categoryId,
    "category": category == null ? null : category!.toJson(),
    "mechanicService": mechanicService == null ? null : List<dynamic>.from(mechanicService!.map((x) => x.toJson())),
  };
}

class Category {
  Category({
    required this.id,
  });

  String id;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"] == null ? null : json["id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
  };
}

class MechanicService {
  MechanicService({
    required this.id,
    required this.time,
    required this.fee,
  });

  String id;
  String time;
  String fee;

  factory MechanicService.fromJson(Map<String, dynamic> json) => MechanicService(
    id: json["id"] == null ? null : json["id"],
    time: json["time"] == null ? null : json["time"],
    fee: json["fee"] == null ? null : json["fee"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "time": time == null ? null : time,
    "fee": fee == null ? null : fee,
  };
}
