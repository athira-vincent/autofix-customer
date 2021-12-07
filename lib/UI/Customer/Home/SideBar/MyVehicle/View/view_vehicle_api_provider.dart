import 'package:auto_fix/QueryProvider/query_provider.dart';
import 'package:auto_fix/UI/Customer/Home/SideBar/MyVehicle/View/view_vehilce_mdl.dart';

class ViewVehicleApiProvider {
  final QueryProvider _queryProvider = QueryProvider();
  Future<ViewVehicleMdl> getViewVehicleRequest(String token) async {
    Map<String, dynamic> _resp = await _queryProvider.viewVehicle(token);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg =
            ViewVehicleMdl(status: "error", message: _resp['message']);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return ViewVehicleMdl.fromJson(data);
      }
    } else {
      final errorMsg =
          ViewVehicleMdl(status: "error", message: "No Internet connection");
      return errorMsg;
    }
  }
}
