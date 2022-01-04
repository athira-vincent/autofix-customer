
class MechanicWorkSelectionMdl {
  String? status;
  String? message;
  Data? data;

  MechanicWorkSelectionMdl({required this.status, required this.message, this.data});

  MechanicWorkSelectionMdl.fromJson(Map<String, dynamic> json) {
    data = (json['data'] != null ? Data.fromJson(json['data']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = this.data!.toJson();
    return data;
  }
}

class Data {

  MechanicSignUpWorkSelection? mechanicSignUpWorkSelection;
  Data();

  Data.fromJson(Map<String, dynamic> json) {
    mechanicSignUpWorkSelection = json['skillsAdd'] != null

    ? new MechanicSignUpWorkSelection.fromJson(json['skillsAdd'])
      : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.mechanicSignUpWorkSelection != null) {
      data['skillsAdd'] = this.mechanicSignUpWorkSelection!.toJson();
    }

    return data;
  }
}

class MechanicSignUpWorkSelection {

  String? id;
  String? mechanicCode;
  String? mechanicName;
  String? emailId;
  String? phoneNo;
  String? address;
  double? latitude;
  double? longitude;
  String? walletData;
  int? verified;
  int? enable;
  int? isEmailverified;
  String? jobType;
  String? startTime;
  String? endTime;
  int? status;

  MechanicSignUpWorkSelection.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mechanicCode = json['mechanicCode'];
    mechanicName = json['mechanicName'];
    emailId = json['emailId'];
    phoneNo = json['phoneNo'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    walletData = json['walletId'];
    verified = json['verified'];
    enable = json['enable'];
    isEmailverified = json['isEmailverified'];
    jobType = json['jobType'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    status = json['status'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['mechanicCode'] = this.mechanicCode;
    data['mechanicName'] = this.mechanicName;
    data['emailId'] = this.emailId;
    data['phoneNo'] = this.phoneNo;
    data['address'] = this.address;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['walletId'] = this.walletData;
    data['verified'] = this.verified;
    data['enable'] = this.enable;
    data['isEmailverified'] = this.isEmailverified;
    data['jobType'] = this.jobType;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['status'] = this.status;

    return data;
  }

  }
