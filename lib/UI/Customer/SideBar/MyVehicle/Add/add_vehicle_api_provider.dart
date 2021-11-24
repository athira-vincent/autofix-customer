import 'package:auto_fix/QueryProvider/query_provider.dart';
import 'package:auto_fix/UI/Customer/SideBar/MyVehicle/Add/add_vehicle_mdl.dart';

class AddVehicleApiProvider {
  final QueryProvider _queryProvider = QueryProvider();
  Future<AddVehicleMdl> getAddVehicleRequest(
      String token,
      String year,
      String latitude,
      String longitude,
      String milege,
      String lastMaintenance,
      String interval,
      int makeId,
      int vehicleModelId,
      int engineId) async {
    Map<String, dynamic> _resp = await _queryProvider.addVehicle(
      token,
        year,
        latitude,
        longitude,
        milege,
        lastMaintenance,
        interval,
        makeId,
        vehicleModelId,
        engineId);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg =
            AddVehicleMdl(status: "error", message: _resp['message']);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return AddVehicleMdl.fromJson(data);
      }
    } else {
      final errorMsg =
          AddVehicleMdl(status: "error", message: "No Internet connection");
      return errorMsg;
    }
  }
}
