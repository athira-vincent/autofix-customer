class AllMakeMdl {
  String? status;
  String? message;
  Data? data;

  AllMakeMdl({required this.status, required this.message, this.data});

  AllMakeMdl.fromJson(Map<String, dynamic> json) {
    data = (json['data'] != null ? Data.fromJson(json['data']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = this.data!.toJson();
    return data;
  }
}

class Data {
  List<MakeDetails>? makeDetails;

  Data();

  Data.fromJson(Map<String, dynamic> json) {
    if (json['makeDetails'] != null) {
      makeDetails = <MakeDetails>[];
      json['makeDetails'].forEach((v) {
        makeDetails!.add(new MakeDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.makeDetails != null) {
      data['makeDetails'] = this.makeDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }

}

class MakeDetails {

  String? id;
  String? makeName;
  String? description;
  int? status;

  MakeDetails.fromJson(Map<String, dynamic> json) {
    //make = json['make'] != null ? new Make.fromJson(json['make']) : null;
    id = json['id'];
    makeName = json['makeName'];
    description = json['description'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    /*if (this.make != null) {
      data['make'] = this.make!.toJson();
    }*/
    data['id'] = this.id;
    data['makeName'] = this.makeName;
    data['description'] = this.description;
    data['status'] = this.status;

    return data;
  }

}
