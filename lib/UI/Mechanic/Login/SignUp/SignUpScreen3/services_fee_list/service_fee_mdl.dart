class AllServiceFeeMdl {
  String? status;
  String? message;
  Data? data;

  AllServiceFeeMdl({required this.status, required this.message, this.data});

  AllServiceFeeMdl.fromJson(Map<String, dynamic> json) {
    data = (json['data'] != null ? Data.fromJson(json['data']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = this.data!.toJson();
    return data;
  }
}

class Data {
  ServiceList? serviceList;

  Data();

  Data.fromJson(Map<String, dynamic> json) {
    serviceList = (json['serviceList'] != null ? ServiceList.fromJson(json['serviceList']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['serviceList'] = this.serviceList!.toJson();
    return data;
  }
}


class ServiceList {
  int? totalItems;
  int? totalPages;
  int? currentPage;
  List<AllServiceFeeData>? allServiceFeeData;

  ServiceList();
  ServiceList.fromJson(Map<String, dynamic> json) {
    //allServiceFeeData = (json['data'] != null ? AllServiceFeeData.fromJson(json['data']) : null)!;
    if (json['data'] != null) {
      allServiceFeeData = <AllServiceFeeData>[];
      json['data'].forEach((v) {
        allServiceFeeData!.add(new AllServiceFeeData.fromJson(v));
      });
    }
    totalItems = json['totalItems'];
    totalPages = json['totalPages'];
    currentPage = json['currentPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (this.allServiceFeeData != null) {
      data['data'] =
          this.allServiceFeeData!.map((v) => v.toJson()).toList();
    }

    data['totalItems'] = this.totalItems;
    data['totalPages'] = this.totalPages;
    data['currentPage'] = this.currentPage;
    return data;
  }
}

class AllServiceFeeData {

  String? id;
  String? serviceName;
  String? description;
  String? icon;
  String? fee;
  String? type;
  String? minAmount;
  String? maxAmount;
  int? status;

  AllServiceFeeData();

  AllServiceFeeData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceName = json['serviceName'];
    description = json['description'];
    icon = json['icon'];
    fee = json['fee'];
    type = json['type'];
    minAmount = json['minAmount'];
    maxAmount = json['maxAmount'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['serviceName'] = this.serviceName;
    data['description'] = this.description;
    data['icon'] = this.icon;
    data['fee'] = this.fee;
    data['type'] = this.type;
    data['minAmount'] = this.minAmount;
    data['maxAmount'] = this.maxAmount;
    data['status'] = this.status;
    return data;
  }
}

