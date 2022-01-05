import 'package:auto_fix/QueryProvider/query_provider.dart';
import 'package:auto_fix/UI/Mechanic/Home/BottomBar/UpcomingService/upcoming_service_mdl.dart';


class UpcomingServicesApiProvider {
  final QueryProvider _queryProvider = QueryProvider();
  Future<UpcomingServicesMdl> getUpcomingServicesRequest(String token) async {
    Map<String, dynamic> _resp = await _queryProvider.mechanicUpcomingServicesList(token);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg =
        UpcomingServicesMdl(status: "error", message: _resp['message']);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return UpcomingServicesMdl.fromJson(data);
      }
    } else {
      final errorMsg =
      UpcomingServicesMdl(status: "error", message: "No Internet connection");
      return errorMsg;
    }
  }
}
