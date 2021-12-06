class MechanicProfileMdl {
  String? status;
  String? message;
  Data? data;

  MechanicProfileMdl({required this.status, required this.message, this.data});

  MechanicProfileMdl.fromJson(Map<String, dynamic> json) {
    data = (json['data'] != null ? Data.fromJson(json['data']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = this.data!.toJson();
    return data;
  }
}

class Data {
  MechanicDetails? mechanicDetails;
  Data();

  Data.fromJson(Map<String, dynamic> json) {
    mechanicDetails = (json['mechanicDetails'] != null
        ? MechanicDetails.fromJson(json['mechanicDetails'])
        : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mechanicDetails'] = this.mechanicDetails!.toJson();
    return data;
  }
}

class MechanicDetails {
  MechanicData? mechanicData;
  List<ServiceData>? serviceDataList;
  MechanicDetails();

  MechanicDetails.fromJson(Map<String, dynamic> json) {
    mechanicData = (json['mechanicData'] != null
        ? MechanicData.fromJson(json['mechanicData'])
        : null)!;
    if (json['serviceData'] != null) {
      serviceDataList = <ServiceData>[];
      json['serviceData'].forEach((v) {
        serviceDataList!.add(new ServiceData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mechanicData'] = this.mechanicData!.toJson();
    if (this.serviceDataList != null) {
      data['serviceData'] =
          this.serviceDataList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MechanicData {
  String? id;
  String? displayName;
  String? userName;
  String? password;
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
  double? latitude;
  double? longitude;
  int? serviceId;
  String? profilePic;
  String? licenseProof;
  int? status;

  MechanicData();

  MechanicData.fromJson(Map<String, dynamic> json) {
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
  }

  Map<String, dynamic> toJson() {
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

    return data;
  }
}

class ServiceData {
  String? id;
  int? status;
  int? serviceId;
  int? mechanicId;
  Service? service;
  ServiceData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    serviceId = json['serviceId'];
    mechanicId = json['mechanicId'];
    service =
        (json['service'] != null ? Service.fromJson(json['service']) : null)!;
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

class Service {
  String? id;
  String? serviceName;
  String? description;
  String? icon;
  String? fee;
  String? type;
  int? status;
  Service.fromJson(Map<String, dynamic> json) {
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
