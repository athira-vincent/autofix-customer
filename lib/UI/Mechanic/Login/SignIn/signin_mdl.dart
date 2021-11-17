
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
  String? token;
  MechanicSignIn? mechanicSignIn;
  Data();

  Data.fromJson(Map<String, dynamic> json) {
    mechanicSignIn = json['customerSignIn'] != null
        ? new MechanicSignIn.fromJson(json['customerSignIn'])
        : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.mechanicSignIn != null) {
      data['customerSignIn'] = this.mechanicSignIn!.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}

class MechanicSignIn {



  MechanicSignIn.fromJson(Map<String, dynamic> json) {

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // data[''] = this.id;

    return data;
  }

}
