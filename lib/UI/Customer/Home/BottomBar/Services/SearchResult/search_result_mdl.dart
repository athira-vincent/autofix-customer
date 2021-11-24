class SearchResultMdl {
  String? status;
  String? message;
  Data? data;

  SearchResultMdl({required this.status, required this.message, this.data});

  SearchResultMdl.fromJson(Map<String, dynamic> json) {
    data = (json['data'] != null ? Data.fromJson(json['data']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = this.data!.toJson();
    return data;
  }
}

class Data {
  ServiceListAll? serviceListAll;

  Data();

  Data.fromJson(Map<String, dynamic> json) {
    serviceListAll = json['serviceListAll'] != null
        ? new ServiceListAll.fromJson(json['serviceListAll'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.serviceListAll != null) {
      data['serviceListAll'] = this.serviceListAll!.toJson();
    }
    return data;
  }
}

class ServiceListAll {
  int? totalItems;
  List<SearchData>? data;
  int? totalPages;
  int? currentPage;
  ServiceListAll.fromJson(Map<String, dynamic> json) {
    totalItems = json['totalItems'];
    if (json['data'] != null) {
      data = <SearchData>[];
      json['data'].forEach((v) {
        data!.add(new SearchData.fromJson(v));
      });
    }
    totalPages = json['totalPages'];
    currentPage = json['currentPage'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalItems'] = this.totalItems;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['totalPages'] = this.totalPages;
    data['currentPage'] = this.currentPage;
    return data;
  }
}

class SearchData {
  String? id;
  String? serviceName;
  String? description;
  String? icon;
  String? fee;
  String? type;
  int? status;
  SearchData();
  SearchData.fromJson(Map<String, dynamic> json) {
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
