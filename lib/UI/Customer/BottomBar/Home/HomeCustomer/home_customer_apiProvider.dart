// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:auto_fix/QueryProvider/query_provider.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/HomeCustomer/ModelsCustomerHome/mechanics_Booking_Mdl.dart';

class HomeCustomerApiProvider {

  final QueryProvider _queryProvider = QueryProvider();

  Future<MechanicsBookingMdl> postMechanicsBookingIDRequest(
      token,
      date,
      time,
      latitude,
      longitude,
      serviceId) async {
    Map<String, dynamic> _resp = await _queryProvider.postMechanicsBookingIDRequest(
        token,
        date,
        time,
        latitude,
        longitude,
        serviceId);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = MechanicsBookingMdl(status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return MechanicsBookingMdl.fromJson(data);
      }
    } else {
      final errorMsg = MechanicsBookingMdl(status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }
}
