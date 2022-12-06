// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:auto_fix/Models/customer_models/brand_list_model/brandListMdl.dart';
import 'package:auto_fix/QueryProvider/query_provider.dart';
import 'package:auto_fix/UI/Mechanic/SideBar/BrandSpecialization/brand_specialization_mdl.dart';
import 'package:auto_fix/UI/Mechanic/SideBar/BrandSpecialization/brand_specialization_update_mdl.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/vechicleSpecialization/vehicleSpecialization_mdl.dart';


import 'package:flutter/services.dart';

class vehicleSpecializationApiProvider {

  final QueryProvider _queryProvider = QueryProvider();

  Future<BrandListMdl> postBrandDetailsRequest(
      token,search)  async {
    Map<String, dynamic> _resp = await _queryProvider.postBrandDetailsRequest(
        token,search) ;
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = BrandListMdl(status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return BrandListMdl.fromJson(data);
      }
    } else {
      final errorMsg = BrandListMdl(status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }

  Future<BrandSpecializationMdl> postMechBrandDetailsRequest(
      token,userId)  async {
    Map<String, dynamic> _resp = await _queryProvider.postMechBrandDetailsRequest(
        token,userId) ;
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = BrandSpecializationMdl(status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return BrandSpecializationMdl.fromJson(data);
      }
    } else {
      final errorMsg = BrandSpecializationMdl(status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }

  Future<UpdateBrandSpecializationMdl> postMechBrandUpdateRequest(
      token,userId, brandNames)  async {
    Map<String, dynamic> _resp = await _queryProvider.postMechBrandUpdateRequest(
        token,userId, brandNames) ;
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = UpdateBrandSpecializationMdl(status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return UpdateBrandSpecializationMdl.fromJson(data);
      }
    } else {
      final errorMsg = UpdateBrandSpecializationMdl(status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }

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
