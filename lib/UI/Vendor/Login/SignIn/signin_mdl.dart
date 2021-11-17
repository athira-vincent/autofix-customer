
class VendorSigninMdl {
  String? status;
  String? message;
  Data? data;

  VendorSigninMdl({required this.status, required this.message, this.data});

  VendorSigninMdl.fromJson(Map<String, dynamic> json) {
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
  VendorSignIn? vendorSignIn;
  Data();

  Data.fromJson(Map<String, dynamic> json) {
    vendorSignIn = json[''] != null
        ? new VendorSignIn.fromJson(json[''])
        : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.vendorSignIn != null) {
      data[''] = this.vendorSignIn!.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}

class VendorSignIn {


  VendorSignIn.fromJson(Map<String, dynamic> json) {

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // data[''] = this.id;

    return data;
  }

}
