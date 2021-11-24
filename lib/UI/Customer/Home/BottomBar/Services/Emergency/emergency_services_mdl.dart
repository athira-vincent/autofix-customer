class EmergencyServicesMdl {
  String? status;
  String? message;
  Data? data;

  EmergencyServicesMdl(
      {required this.status, required this.message, this.data});

  EmergencyServicesMdl.fromJson(Map<String, dynamic> json) {
    data = (json['data'] != null ? Data.fromJson(json['data']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = this.data!.toJson();
    return data;
  }
}

class Data {
  List<EmergencyList>? emergencyList;

  Data(this.emergencyList);

  Data.fromJson(Map<String, dynamic> json) {
    if (json['emergencyList'] != null) {
      emergencyList = <EmergencyList>[];
      json['emergencyList'].forEach((v) {
        emergencyList!.add(new EmergencyList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.emergencyList != null) {
      data['emergencyList'] =
          this.emergencyList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EmergencyList {
  int? id;
  String? serviceName;
  String? description;
  String? icon;
  String? fee;
  String? type;
  int? status;
  EmergencyList.fromJson(Map<String, dynamic> json) {
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
