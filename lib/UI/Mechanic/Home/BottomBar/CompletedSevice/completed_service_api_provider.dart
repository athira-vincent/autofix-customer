import 'package:auto_fix/QueryProvider/query_provider.dart';
import 'package:auto_fix/UI/Mechanic/Home/BottomBar/CompletedSevice/completed_service_mdl.dart';


class CompletedServicesApiProvider {
  final QueryProvider _queryProvider = QueryProvider();
  Future<CompletedServicesMdl> getCompletedServicesRequest(String token) async {
    Map<String, dynamic> _resp = await _queryProvider.mechanicCompletedServicesList(token);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg =
        CompletedServicesMdl(status: "error", message: _resp['message']);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return CompletedServicesMdl.fromJson(data);
      }
    } else {
      final errorMsg =
      CompletedServicesMdl(status: "error", message: "No Internet connection");
      return errorMsg;
    }
  }
}
