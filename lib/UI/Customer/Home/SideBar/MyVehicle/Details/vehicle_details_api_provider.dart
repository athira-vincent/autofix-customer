import 'package:auto_fix/QueryProvider/query_provider.dart';
import 'package:auto_fix/UI/Customer/Home/SideBar/MyVehicle/Details/vehicle_details_mdl.dart';

class VehicleDetailsApiProvider {
  final QueryProvider _queryProvider = QueryProvider();
  Future<VehicleDetailsMdl> getVehicleDetailsRequest(String token) async {
    Map<String, dynamic> _resp = await _queryProvider.vehicleDetails(token);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg =
            VehicleDetailsMdl(status: "error", message: _resp['message']);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return VehicleDetailsMdl.fromJson(data);
      }
    } else {
      final errorMsg =
          VehicleDetailsMdl(status: "error", message: "No Internet connection");
      return errorMsg;
    }
  }
}
