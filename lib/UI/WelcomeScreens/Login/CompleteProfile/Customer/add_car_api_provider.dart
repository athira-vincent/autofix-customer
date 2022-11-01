// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:auto_fix/Models/customer_models/default_vechicle_model/updateDefaultVehicleMdl.dart';
import 'package:auto_fix/Models/customer_models/edit_vechicle_model/editVehicleMdl.dart';
import 'package:auto_fix/Models/customer_models/vehicle_update_model/vehicleUpdateMdl.dart';
import 'package:auto_fix/QueryProvider/query_provider.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Customer/vehicleCreate_Mdl.dart';

import 'brand_model_engine/makeBrandDetails_Mdl.dart';
import 'brand_model_engine/modelDetails_Mdl.dart';

class AddCarApiProvider {

  final QueryProvider _queryProvider = QueryProvider();

  Future<VehicleCreateMdl> postAddCarRequest(
      token, brand, model, engine, year,
      plateNo, lastMaintenance, milege,
      vehiclePic,color, latitude, longitude,) async {
    Map<String, dynamic> _resp = await _queryProvider.postAddCarRequest(
      token, brand, model, engine, year,
      plateNo, lastMaintenance, milege,
      vehiclePic, color, latitude, longitude,);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = VehicleCreateMdl(status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return VehicleCreateMdl.fromJson(data);
      }
    } else {
      final errorMsg = VehicleCreateMdl(status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }

  Future<UpdateDefaultVehicleMdl> postUpdateDefaultVehicle(
      token,vehicleId, customerId)  async {
    Map<String, dynamic> _resp = await _queryProvider.postUpdateDefaultVehicle(
        token,vehicleId, customerId) ;
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = UpdateDefaultVehicleMdl(status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return UpdateDefaultVehicleMdl.fromJson(data);
      }
    } else {
      final errorMsg = UpdateDefaultVehicleMdl(status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }


  Future<MakeBrandDetailsMdl> postMakeBrandRequest(
      token,) async {
    Map<String, dynamic> _resp = await _queryProvider.postMakeBrandRequest(
      token,);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = MakeBrandDetailsMdl(status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return MakeBrandDetailsMdl.fromJson(data);
      }
    } else {
      final errorMsg = MakeBrandDetailsMdl(status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }


  Future<ModelDetailsMdl> postModelDetailRequest(
      token,type) async {
    Map<String, dynamic> _resp = await _queryProvider.postModelDetailRequest(
      token,type);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = ModelDetailsMdl(status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return ModelDetailsMdl.fromJson(data);
      }
    } else {
      final errorMsg = ModelDetailsMdl(status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }

  Future<VehicleUpdateMdl> postVechicleUpdateRequest(
      token, id,
      status)  async {
    Map<String, dynamic> _resp = await _queryProvider.postVechicleUpdateRequest(
        token, id,
        status);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = VehicleUpdateMdl(status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return VehicleUpdateMdl.fromJson(data);
      }
    } else {
      final errorMsg = VehicleUpdateMdl(status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }

  Future<EditVehicleMdl> postEditCarRequest(
      token,
      vehicleId, year,
      lastMaintenance, milege,
      vehiclePic, color,) async {
    Map<String, dynamic> _resp = await _queryProvider.postEditCarRequest(
      token, vehicleId,
      year, lastMaintenance,
      milege, vehiclePic,
      color,);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = EditVehicleMdl(status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return EditVehicleMdl.fromJson(data);
      }
    } else {
      final errorMsg = EditVehicleMdl(status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }

}
