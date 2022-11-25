class GenerateAutorizationMdl {
  String? status;
  String? message;
  Data? data;

  GenerateAutorizationMdl(
      {required this.status, required this.message, this.data});

  GenerateAutorizationMdl.fromJson(Map<String, dynamic> json) {
    data = (json['data'] != null ? Data.fromJson(json['data']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = this.data!.toJson();
    return data;
  }
}

class Data {
  GenerateAuthorization? generateAuthorization;
  Data();

  Data.fromJson(Map<String, dynamic> json) {
    generateAuthorization = json['generateAuthorization'] != null
        ? new GenerateAuthorization.fromJson(json['generateAuthorization'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.generateAuthorization != null) {
      data['generateAuthorization'] = this.generateAuthorization!.toJson();
    }

    return data;
  }
}

class GenerateAuthorization {
  String? token;
  GenerateAuthorization.fromJson(Map<String, dynamic> json) {
    token = json['token'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = this.token;
    return data;
  }
}
