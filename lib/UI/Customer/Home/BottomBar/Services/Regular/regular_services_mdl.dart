class RegularServicesMdl {
  String? status;
  String? message;
  Data? data;

  RegularServicesMdl({required this.status, required this.message, this.data});

  RegularServicesMdl.fromJson(Map<String, dynamic> json) {
    data = (json['data'] != null ? Data.fromJson(json['data']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = this.data!.toJson();
    return data;
  }
}

class Data {
  RegularList? emergencyList;

  Data(this.emergencyList);

  Data.fromJson(Map<String, dynamic> json) {
    emergencyList = json['emergencyList'] != null
        ? new RegularList.fromJson(json['emergencyList'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.emergencyList != null) {
      data['emergencyList'] = this.emergencyList!.toJson();
    }
    return data;
  }
}

class RegularList {
  int? totalItems;
  int? totalPages;
  int? currentPage;
  List<RegularData>? regularData;
  RegularList.fromJson(Map<String, dynamic> json) {
    totalItems = json['totalItems'];
    totalPages = json['totalPages'];
    currentPage = json['currentPage'];
    if (json['data'] != null) {
      regularData = <RegularData>[];
      json['data'].forEach((v) {
        regularData!.add(new RegularData.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalItems'] = this.totalItems;
    data['totalPages'] = this.totalPages;
    data['currentPage'] = this.currentPage;
    if (this.regularData != null) {
      data['data'] = this.regularData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RegularData {
  int? id;
  String? serviceName;
  String? description;
  String? icon;
  String? fee;
  String? type;
  int? status;
  RegularData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceName = json['serviceName'];
    description = json['description'];
    icon = json['icon'];
    fee = json['fee'];
    type = json['type'];
    status = json['status'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['serviceName'] = this.serviceName;
    data['description'] = this.description;
    data['icon'] = this.icon;
    data['fee'] = this.fee;
    data['type'] = this.type;
    data['status'] = this.status;
    return data;
  }
}
