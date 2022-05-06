// ignore_for_file: avoid_print

import 'package:auto_fix/QueryProvider/query_provider.dart';
import 'package:auto_fix/UI/Mechanic/BottomBar/Home/mechanic_location_update_mdl.dart';
import 'package:auto_fix/UI/Mechanic/BottomBar/Home/mechanic_online_offline_mdl.dart';


class MechanicApiProvider {

  final QueryProvider _queryProvider = QueryProvider();

  Future<MechanicOnlineOfflineMdl> postMechanicOnlineOfflineRequest(
      token, String status, String mechanicId)async {
    Map<String, dynamic> _resp = await _queryProvider.postMechanicOnlineOfflineRequest(
      token,status, mechanicId);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = MechanicOnlineOfflineMdl(status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return MechanicOnlineOfflineMdl.fromJson(data);
      }
    } else {
      final errorMsg = MechanicOnlineOfflineMdl(status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }

  Future<MechanicLocationUpdateMdl> postMechanicLocationUpdateRequest(
      token, lat, lng )async {
    Map<String, dynamic> _resp = await _queryProvider.postMechanicLocationUpdateRequest(
      token, lat, lng);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = MechanicLocationUpdateMdl(status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return MechanicLocationUpdateMdl.fromJson(data);
      }
    } else {
      final errorMsg = MechanicLocationUpdateMdl(status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }


}
