class AllModelMdl {
  String? status;
  String? message;
  Data? data;

  AllModelMdl({required this.status, required this.message, this.data});

  AllModelMdl.fromJson(Map<String, dynamic> json) {
    data = (json['data'] != null ? Data.fromJson(json['data']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = this.data!.toJson();
    return data;
  }
}

class Data {
  List<ModelDetails>? modelDetails;

  Data();

  Data.fromJson(Map<String, dynamic> json) {
    if (json['modelDetails'] != null) {
      modelDetails = <ModelDetails>[];
      json['modelDetails'].forEach((v) {
        modelDetails!.add(new ModelDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.modelDetails != null) {
      data['modelDetails'] = this.modelDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ModelDetails {
  String? id;
  String? modelName;
  String? description;
  int? makeId;
  int? status;
  Make? make;

  ModelDetails.fromJson(Map<String, dynamic> json) {
    make = json['make'] != null ? new Make.fromJson(json['make']) : null;
    modelName = json['modelName'];
    description = json['description'];
    makeId = json['makeId'];
    status = json['status'];
    id = json['id'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.make != null) {
      data['make'] = this.make!.toJson();
    }
    data['id'] = this.id;
    data['modelName'] = this.modelName;
    data['description'] = this.description;
    data['makeId'] = this.makeId;
    data['status'] = this.status;
    return data;
  }
}

class Make {
  String? id;
  String? makeName;
  String? description;
  int? status;
  Make.fromJson(Map<String, dynamic> json) {
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
