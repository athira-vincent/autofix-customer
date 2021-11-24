class AllEngineMdl {
  String? status;
  String? message;
  Data? data;

  AllEngineMdl({required this.status, required this.message, this.data});

  AllEngineMdl.fromJson(Map<String, dynamic> json) {
    data = (json['data'] != null ? Data.fromJson(json['data']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = this.data!.toJson();
    return data;
  }
}

class Data {
  List<EngineDetails>? engineDetails;

  Data();

  Data.fromJson(Map<String, dynamic> json) {
    if (json['engineDetails'] != null) {
      engineDetails = <EngineDetails>[];
      json['engineDetails'].forEach((v) {
        engineDetails!.add(new EngineDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.engineDetails != null) {
      data['engineDetails'] =
          this.engineDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EngineDetails {
  String? id;
  String? engineName;
  String? description;
  int? vehicleModelId;
  int? status;
  VehicleModel? vehicleModel;

  EngineDetails.fromJson(Map<String, dynamic> json) {
    vehicleModel = json['vehicleModel'] != null
        ? new VehicleModel.fromJson(json['vehicleModel'])
        : null;
    id = json['id'];
    engineName = json['engineName'];
    description = json['description'];
    vehicleModelId = json['vehicleModelId'];
    status = json['status'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.vehicleModel != null) {
      data['vehicleModel'] = this.vehicleModel!.toJson();
    }
    data['id'] = this.id;
    data['engineName'] = this.engineName;
    data['description'] = this.description;
    data['vehicleModelId'] = this.vehicleModelId;
    data['status'] = this.status;
    return data;
  }
}

class VehicleModel {
  String? id;
  String? modelName;
  String? description;
  int? makeId;
  int? status;
  VehicleModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    modelName = json['modelName'];
    description = json['description'];
    makeId = json['makeId'];
    status = json['status'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['modelName'] = this.modelName;
    data['description'] = this.description;
    data['makeId'] = this.makeId;
    data['status'] = this.status;
    return data;
  }
}
