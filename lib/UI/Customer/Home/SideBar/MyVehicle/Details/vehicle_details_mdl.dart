class VehicleDetailsMdl {
  String? status;
  String? message;
  Data? data;

  VehicleDetailsMdl({required this.status, required this.message, this.data});

  VehicleDetailsMdl.fromJson(Map<String, dynamic> json) {
    data = (json['data'] != null ? Data.fromJson(json['data']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = this.data!.toJson();
    return data;
  }
}

class Data {
  List<VehicleDetails>? vehicleDetailsList;
  Data();

  Data.fromJson(Map<String, dynamic> json) {
    if (json['vehicleDetails'] != null) {
      vehicleDetailsList = <VehicleDetails>[];
      json['vehicleDetails'].forEach((v) {
        vehicleDetailsList!.add(new VehicleDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.vehicleDetailsList != null) {
      data['vehicleDetails'] =
          this.vehicleDetailsList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VehicleDetails {
  String? id;
  String? year;
  String? latitude;
  String? longitude;
  String? milege;
  String? lastMaintenance;
  String? interval;
  int? customerId;
  int? makeId;
  int? vehicleModelId;
  int? engineId;
  int? status;
  Make? make;
  Vehiclemodel? vehiclemodel;
  Engine? engine;
  VehicleDetails.fromJson(Map<String, dynamic> json) {
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
    make = json['make'] != null ? new Make.fromJson(json['make']) : null;
    vehiclemodel = json['vehiclemodel'] != null
        ? new Vehiclemodel.fromJson(json['vehiclemodel'])
        : null;
    engine =
        json['engine'] != null ? new Engine.fromJson(json['engine']) : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    if (this.make != null) {
      data['make'] = this.make!.toJson();
    }
    if (this.vehiclemodel != null) {
      data['vehiclemodel'] = this.vehiclemodel!.toJson();
    }
    if (this.engine != null) {
      data['engine'] = this.engine!.toJson();
    }
    return data;
  }
}

class Customer {
  int? id;
  String? firstName;
  String? lastName;
  String? address;
  String? emailId;
  String? phoneNo;
  String? profilePic;
  int? isProfileCompleted;
  int? status;
  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    address = json['address'];
    emailId = json['emailId'];
    phoneNo = json['phoneNo'];
    profilePic = json['profilePic'];
    isProfileCompleted = json['isProfileCompleted'];
    status = json['status'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['address'] = this.address;
    data['emailId'] = this.emailId;
    data['phoneNo'] = this.phoneNo;
    data['profilePic'] = this.id;
    data['isProfileCompleted'] = this.isProfileCompleted;
    data['status'] = this.status;
    return data;
  }
}

class Make {
  String? id;
  String? makeName;
  String? description;
  int? status;
  Make.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    makeName = json['makeName'];
    description = json['description'];
    status = json['status'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['makeName'] = this.makeName;
    data['description'] = this.description;
    data['status'] = this.status;
    return data;
  }
}

class Vehiclemodel {
  String? id;
  String? modelName;
  String? description;
  int? makeId;
  int? status;
  Vehiclemodel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    modelName = json['modelName'];
    description = json['description'];
    makeId = json['makeId'];
    status = json['status'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['modelName'] = this.modelName;
    data['description'] = this.description;
    data['makeId'] = this.makeId;
    data['status'] = this.status;
    return data;
  }
}

class Engine {
  String? id;
  String? engineName;
  String? description;
  int? vehicleModelId;
  int? status;
  Engine.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    engineName = json['engineName'];
    description = json['description'];
    vehicleModelId = json['vehicleModelId'];
    status = json['status'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['engineName'] = this.engineName;
    data['description'] = this.description;
    data['vehicleModelId'] = this.vehicleModelId;
    data['status'] = this.status;
    return data;
  }
}
