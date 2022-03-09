// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:auto_fix/QueryProvider/query_provider.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Customer/vehicleCreate_Mdl.dart';

class AddCarApiProvider {

  final QueryProvider _queryProvider = QueryProvider();

  Future<VehicleCreateMdl> postAddCarRequest(
      token,
      year,
      plateNo,
      engineName,
      lastMaintenance,
      milege,
      makeId,
      vehicleModelId,) async {
    Map<String, dynamic> _resp = await _queryProvider.postAddCarRequest(
      token,
      year,
      plateNo,
      engineName,
      lastMaintenance,
      milege,
      makeId,
      vehicleModelId,);
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



}
