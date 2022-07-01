
import 'dart:convert';

VehicleSpecializationMdl vehicleSpecializationMdlFromJson(String str) => VehicleSpecializationMdl.fromJson(json.decode(str));


class VehicleSpecializationMdl {
  VehicleSpecializationMdl({
    required this.vehicleSpecialization,
  });

  List<VehicleSpecialization>? vehicleSpecialization;

  factory VehicleSpecializationMdl.fromJson(Map<String, dynamic> json) {
    var list = json['vehicleSpecialization'] as List;
    List<VehicleSpecialization> _countryList =
    list.map((i) => VehicleSpecialization.fromJson(i)).toList();
    return VehicleSpecializationMdl(vehicleSpecialization: _countryList);
  }


}

class VehicleSpecialization {
  VehicleSpecialization({
    required this.name,
    required this.id,
    required this.image,
    required this.value,
  });

  String name;
  String id;
  String image;
  String value;

  factory VehicleSpecialization.fromJson(Map<String, dynamic> json) => VehicleSpecialization(
    name: json["name"] == null ? null : json["name"],
    id: json["id"] == null ? null : json["id"],
    image: json["image"] == null ? null : json["image"],
    value: json["value"] == null ? null : json["value"],
  );

}
