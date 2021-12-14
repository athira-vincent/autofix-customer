
class MechanicSignupRegistrationMdl {
  String? status;
  String? message;
  Data? data;

  MechanicSignupRegistrationMdl({required this.status, required this.message, this.data});

  MechanicSignupRegistrationMdl.fromJson(Map<String, dynamic> json) {
    data = (json['data'] != null ? Data.fromJson(json['data']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = this.data!.toJson();
    return data;
  }
}

class Data {

  MechanicSignUp? mechanicSignUp;

  Data();

  Data.fromJson(Map<String, dynamic> json) {
    mechanicSignUp = json['signUp'] != null
        ? new MechanicSignUp.fromJson(json['signUp'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.mechanicSignUp != null) {
      data['signUp'] = this.mechanicSignUp!.toJson();
    }
    return data;
  }
}

class MechanicSignUp {

  String? token;
  MechanicSignUpData? mechanicSignUpData;

  MechanicSignUp.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    mechanicSignUpData = json['mechanic'] != null ?
        new MechanicSignUpData.fromJson(json['mechanic'])
        : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['token'] = this.token;
    data['mechanic'] = this.mechanicSignUpData!.toJson();

    return data;
  }

  }

class MechanicSignUpData {
  //SignUpScreen1 signUp;
  String? id;
  String? mechanicCode;
  String? mechanicName;
  String? emailId;
  String? phoneNo;
  String? address;
  double? latitude;
  double? longitude;
  String? walletId;
  int? verified;
  int? isEmailverified;
  int? status;


  MechanicSignUpData();

  MechanicSignUpData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mechanicCode = json['mechanicCode'];
    mechanicName = json['mechanicName'];
    emailId = json['emailId'];
    phoneNo = json['phoneNo'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    walletId = json['walletId'];
    verified = json['verified'];
    isEmailverified = json['isEmailverified'];
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
    data['walletId'] = this.walletId;
    data['verified'] = this.verified;
    data['isEmailverified'] = this.isEmailverified;
    data['status'] = this.status;

    return data;
  }
}

