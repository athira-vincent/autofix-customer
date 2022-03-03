// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:auto_fix/QueryProvider/query_provider.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/vechicleSpecialization/vehicleSpecialization_mdl.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signup/signup_mdl.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signup/states_mdl.dart';

import 'package:flutter/services.dart';

class vehicleSpecializationApiProvider {
  final QueryProvider _queryProvider = QueryProvider();

  Future<dynamic> getVehicleSpecialization() async {
    dynamic response = await loadVehicleSpecialization();
    return VehicleSpecializationMdl.fromJson(response);
  }

  Future<dynamic> loadVehicleSpecialization() async {
    print('here');
    String jsonCrossword = await loadVehicleSpecializationAsset();
    final response = json.decode(jsonCrossword);
    return response;
  }

  Future<dynamic> loadVehicleSpecializationAsset() async {
    return await rootBundle.loadString('assets/json/vehicleSpecialization_list.json');
  }
}
