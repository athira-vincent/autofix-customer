
class MechanicSigninMdl {
  String? status;
  String? message;
  Data? data;

  MechanicSigninMdl({required this.status, required this.message, this.data});

  MechanicSigninMdl.fromJson(Map<String, dynamic> json) {
    data = (json['data'] != null ? Data.fromJson(json['data']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = this.data!.toJson();
    return data;
  }
}

class Data {

  MechanicSignIn? mechanicSignIn;
  Data();

  Data.fromJson(Map<String, dynamic> json) {
    mechanicSignIn = json['signIn'] != null
        ? new MechanicSignIn.fromJson(json['signIn'])
        : null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.mechanicSignIn != null) {
      data['signIn'] = this.mechanicSignIn!.toJson();
    }

    return data;
  }
}

class MechanicSignIn {

  String? token;
  MechanicSignInData? mechanicSignInData;
  MechanicSignIn();

  MechanicSignIn.fromJson(Map<String, dynamic> json) {
    mechanicSignInData = json['mechanic'] != null
        ? new MechanicSignInData.fromJson(json['mechanic'])
        : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.mechanicSignInData != null) {
      data['mechanic'] = this.mechanicSignInData!.toJson();
    }
    data['token'] = this.token;
    return data;
  }

}
class MechanicSignInData{

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

  MechanicSignInData();
  MechanicSignInData.fromJson(Map<String, dynamic> json){
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
    status =json['status'];
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

