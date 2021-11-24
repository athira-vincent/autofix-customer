import 'package:auto_fix/QueryProvider/query_provider.dart';
import 'package:auto_fix/UI/Customer/Home/BottomBar/Services/Emergency/emergency_services_mdl.dart';

class EmergencyServicesApiProvider {
  final QueryProvider _queryProvider = QueryProvider();
  Future<EmergencyServicesMdl> getEmergencyServicesRequest(
      int page, int size) async {
    Map<String, dynamic> _resp =
        await _queryProvider.getEmeregencyServices(page, size);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg =
            EmergencyServicesMdl(status: "error", message: _resp['message']);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return EmergencyServicesMdl.fromJson(data);
      }
    } else {
      final errorMsg = EmergencyServicesMdl(
          status: "error", message: "No Internet connection");
      return errorMsg;
    }
  }
}
