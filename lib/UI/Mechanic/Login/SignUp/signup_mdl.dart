
class MechanicSignupMdl {
  String? status;
  String? message;
  Data? data;

  MechanicSignupMdl({required this.status, required this.message, this.data});

  MechanicSignupMdl.fromJson(Map<String, dynamic> json) {
    data = (json['data'] != null ? Data.fromJson(json['data']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = this.data!.toJson();
    return data;
  }
}

class Data {
  //SignUp signUp;
  String? token;
  MechanicSignUp? mechanicSignUp;
  Data();

  Data.fromJson(Map<String, dynamic> json) {
    mechanicSignUp = json[' '] != null

    ? new MechanicSignUp.fromJson(json[' '])
      : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.mechanicSignUp != null) {
      data[' '] = this.mechanicSignUp!.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}

class MechanicSignUp {

  /*String? id;
  String? firstName;
  String? lastName;
  String? address;
  String? emailId;
  String? phoneNo;
  int? status;*/

  MechanicSignUp.fromJson(Map<String, dynamic> json) {
    /*id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    address = json['address'];
    emailId = json['emailId'];
    phoneNo = json['phoneNo'];
    status = json['status'];*/

  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    /*data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['address'] = this.address;
    data['emailId'] = this.emailId;
    data['phoneNo'] = this.phoneNo;
    data['status'] = this.status;*/

    return data;
  }




  }
