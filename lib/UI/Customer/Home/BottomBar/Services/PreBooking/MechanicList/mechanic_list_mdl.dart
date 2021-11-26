
class MechanicListMdl {
  String? status;
  String? message;
  Data? data;

  MechanicListMdl({required this.status, required this.message, this.data});

  MechanicListMdl.fromJson(Map<String, dynamic> json) {
    data = (json['data'] != null ? Data.fromJson(json['data']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = this.data!.toJson();
    return data;
  }
}

class Data {
  MechanicList? mechanicList;
  Data();

  Data.fromJson(Map<String, dynamic> json) {
    mechanicList = (json['mechanicList'] != null ? MechanicList.fromJson(json['mechanicList']) : null)!;

  }

  Map<String, dynamic> toJson() {
    // if (this.signUp != null) {
    //   data['agentSignUp'] = this.signUp.toJson();
    // }
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mechanicList'] = this.mechanicList!.toJson();
    return data;
  }
}

class MechanicList {

  int? totalItems;
  int? totalPages;
  int? currentPage;
  List<MechanicListData>? mechanicListData;

  MechanicList();

  MechanicList.fromJson(Map<String, dynamic> json){
    totalItems = json['totalItems'];
    totalPages = json['totalPages'];
    currentPage = json['currentPage'];

    if(json['data'] != null){
      mechanicListData = <MechanicListData>[];
      json['data'].forEach((v){
        mechanicListData!.add(new MechanicListData.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalItems'] = this.totalItems;
    data['totalPages'] = this.totalPages;
    if (this.mechanicListData != null) {
      data['data'] =
          this.mechanicListData!.map((v) => v.toJson()).toList();
    }
    return data;
  }

}

class MechanicListData {
  String? id;
  String? displayName;
  String? password;
  String? userName;
  String? firstName;
  String? lastName;
  String? emailId;
  String? phoneNo;
  String? address;
  String? startTime;
  String? endTime;
  String? city;
  String? licenseNo;
  String? state;
  String? licenseDate;
  String? latitude;
  String? longitude;
  int? serviceId;
  String? profilePic;
  String? licenseProof;
  int? status;
  List<MechanicServiceListData>? serviceListData;
  List<MechanicVehicleListData>? vehicleListData;

  MechanicListData();

  MechanicListData.fromJson(Map<String, dynamic> json){
    id = json['id'];
    displayName = json['displayName'];
    password = json['password'];
    userName = json['userName'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    emailId = json['emailId'];
    phoneNo = json['phoneNo'];
    address = json['address'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    city = json['city'];
    licenseNo = json['licenseNo'];
    state = json['state'];
    licenseDate = json['licenseDate'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    serviceId = json['serviceId'];
    profilePic = json['profilePic'];
    licenseProof = json['licenseProof'];
    status = json['status'];

    if(json['serviceData'] != null){
      serviceListData = <MechanicServiceListData>[];
      json['serviceData'].forEach((v){
        serviceListData!.add(new MechanicServiceListData.fromJson(v));
      });
    }
    if(json['vehicleData'] != null){
      vehicleListData = <MechanicVehicleListData>[];
      json['vehicleData'].forEach((v){
        vehicleListData!.add(new MechanicVehicleListData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['displayName'] = this.displayName;
    data['userName'] = this.userName;
    data['password'] = this.password;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['emailId'] = this.emailId;
    data['phoneNo'] = this.phoneNo;
    data['address'] = this.address;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['city'] = this.city;
    data['licenseNo'] = this.licenseNo;
    data['state'] = this.state;
    data['licenseDate'] = this.licenseDate;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['serviceId'] = this.serviceId;
    data['profilePic'] = this.profilePic;
    data['licenseProof'] = this.licenseProof;
    data['status'] = this.status;

    if (this.serviceListData != null) {
      data['serviceData'] =
          this.serviceListData!.map((v) => v.toJson()).toList();
    }

    if (this.vehicleListData != null) {
      data['vehicleData'] =
          this.vehicleListData!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class MechanicServiceListData {
  String? id;
  int? status;
  int? serviceId;
  int? mechanicId;
  ServiceData? service;

  MechanicServiceListData();

  MechanicServiceListData.fromJson(Map<String, dynamic> json){
    id = json['id'];
    status = json['status'];
    serviceId = json['serviceId'];
    mechanicId = json['mechanicId'];
    service = (json['service'] != null ? ServiceData.fromJson(json['service']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['status'] = this.status;
    data['serviceId'] = this.serviceId;
    data['mechanicId'] = this.mechanicId;
    data['service'] = this.service!.toJson();

    return data;
  }

}

class ServiceData {

  String? id;
  String? serviceName;
  String? description;
  String? icon;
  String? fee;
  String? type;
  int? status;

  ServiceData();

  ServiceData.fromJson(Map<String, dynamic> json){
    id = json['id'];
    serviceName = json['serviceName'];
    description = json['description'];
    icon = json['icon'];
    fee = json['fee'];
    type = json['type'];
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
    data['status'] = this.status;

    return data;
  }

}

class MechanicVehicleListData {
 String? id;
 int? status;
 int? makeId;
 int? mechanicId;
 VehicleMakeData? vehicleMakeData;

  MechanicVehicleListData();

  MechanicVehicleListData.fromJson(Map<String, dynamic> json){
    id = json['id'];
    status = json['status'];
    makeId = json['makeId'];
    mechanicId = json['mechanicId'];
    vehicleMakeData = (json['make'] != null ? VehicleMakeData.fromJson(json['make']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['id'] = this.id;
    data['status'] = this.status;
    data['makeId'] = this.makeId;
    data['mechanicId'] = this.mechanicId;
    data['make'] = this.vehicleMakeData!.toJson();

    return data;
  }

}

class VehicleMakeData {

  String? id;
  String? makeName;
  String? description;
  int? status;

  VehicleMakeData();

  VehicleMakeData.fromJson(Map<String, dynamic> json){
    id = json['id'];
    makeName = json['makeName'];
    description = json['description'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['makeName'] = this.makeName;
    data['description'] = this.description;
    data['status'] = this.status;

    return data;
  }

}