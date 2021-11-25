class AddVehicleMdl {
  String? status;
  String? message;
  Data? data;

  AddVehicleMdl({required this.status, required this.message, this.data});

  AddVehicleMdl.fromJson(Map<String, dynamic> json) {
    data = (json['data'] != null ? Data.fromJson(json['data']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = this.data!.toJson();
    return data;
  }
}

class Data {
  VehicleCreate? vehicleCreate;

  Data();

  Data.fromJson(Map<String, dynamic> json) {
    vehicleCreate = json['vehicleCreate'] != null
        ? new VehicleCreate.fromJson(json['vehicleCreate'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.vehicleCreate != null) {
      data['vehicleCreate'] = this.vehicleCreate!.toJson();
    }
    return data;
  }
}

class VehicleCreate {

  dynamic id;
  String? year;
  String? latitude;
  String? longitude;
  String? milege;
  String? lastMaintenance;
  String? interval;
  String? customerId;
  int? makeId;
  int? vehicleModelId;
  int? engineId;
  int? status;

  VehicleCreate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    year = json['year'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    milege = json['milege'];
    lastMaintenance = json['lastMaintenance'];
    interval = json['interval'];
    customerId = json['customerId'];
    makeId = json['makeId'];
    vehicleModelId = json['vehicleModelId'];
    engineId = json['engineId'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['year'] = this.year;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['milege'] = this.milege;
    data['lastMaintenance'] = this.lastMaintenance;
    data['interval'] = this.interval;
    data['customerId'] = this.customerId;
    data['makeId'] = this.makeId;
    data['vehicleModelId'] = this.vehicleModelId;
    data['engineId'] = this.engineId;
    data['status'] = this.status;
    return data;
  }
}
