

import 'package:auto_fix/QueryProvider/query_provider.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/AddServices/add_services_mdl.dart';

class AddServicesApiProvider {

  final QueryProvider _queryProvider = QueryProvider();

// ------------ Complete Profile Mechanic - Individual--------------

  Future<AddServicesMdl> getMechanicAddServiceListRequest(
      String token,String serviceList, String rateList,String timeList) async {
    Map<String, dynamic> _resp = await _queryProvider.mechanicAddServiceList(token, serviceList,rateList,timeList);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = AddServicesMdl(status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return AddServicesMdl.fromJson(data);
      }
    } else {
      final errorMsg = AddServicesMdl(status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }

}