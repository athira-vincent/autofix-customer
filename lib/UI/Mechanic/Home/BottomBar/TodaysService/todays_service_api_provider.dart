import 'package:auto_fix/QueryProvider/query_provider.dart';
import 'package:auto_fix/UI/Mechanic/Home/BottomBar/TodaysService/todays_service_mdl.dart';


class TodaysServicesApiProvider {
  final QueryProvider _queryProvider = QueryProvider();
  Future<TodaysServicesMdl> getTodaysServicesRequest(String token) async {
    Map<String, dynamic> _resp = await _queryProvider.mechanicTodaysServicesList(token);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg =
        TodaysServicesMdl(status: "error", message: _resp['message']);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return TodaysServicesMdl.fromJson(data);
      }
    } else {
      final errorMsg =
      TodaysServicesMdl(status: "error", message: "No Internet connection");
      return errorMsg;
    }
  }
}
