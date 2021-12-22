
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
  MechanicSignInData mechanicSignInData;

  MechanicSignIn.fromJson(Map<String, dynamic> json) {

    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // data[''] = this.id;
    data['token'] = this.token;
    return data;
  }

}
class MechanicSignInData{

  MechanicSignInData.fromJson(Map<String, dynamic> json){

  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // data[''] = this.id;
    //data['token'] = this.token;
    return data;
  }
}