import 'package:auto_fix/QueryProvider/query_provider.dart';
import 'package:auto_fix/UI/Home/Vehicle/Delete/delete_vehicle_mdl.dart';

class DeleteVehicleApiProvider {
  final QueryProvider _queryProvider = QueryProvider();
  Future<DeleteVehicleMdl> getDeleteVehicleRequest() async {
    Map<String, dynamic> _resp = await _queryProvider.deleteVehicle();
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg =
            DeleteVehicleMdl(status: "error", message: _resp['message']);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return DeleteVehicleMdl.fromJson(data);
      }
    } else {
      final errorMsg =
          DeleteVehicleMdl(status: "error", message: "No Internet connection");
      return errorMsg;
    }
  }
}
