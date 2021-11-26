import 'package:auto_fix/QueryProvider/query_provider.dart';
import 'package:auto_fix/UI/Customer/Home/BottomBar/Services/Regular/regular_services_mdl.dart';

class RegularServicesApiProvider {
  final QueryProvider _queryProvider = QueryProvider();
  Future<RegularServicesMdl> getRegularServicesRequest(
      int page, int size, String token) async {
    Map<String, dynamic> _resp =
        await _queryProvider.getRegularServices(page, size, token);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg =
            RegularServicesMdl(status: "error", message: _resp['message']);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return RegularServicesMdl.fromJson(data);
      }
    } else {
      final errorMsg = RegularServicesMdl(
          status: "error", message: "No Internet connection");
      return errorMsg;
    }
  }
}
