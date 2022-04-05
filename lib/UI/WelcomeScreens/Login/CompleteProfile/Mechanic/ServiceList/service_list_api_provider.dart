
import 'package:auto_fix/QueryProvider/query_provider.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/ServiceList/service_list_mdl.dart';

class ServiceListApiProvider {

  final QueryProvider _queryProvider = QueryProvider();

  Future<ServiceListMdl> getServiceListRequest(
      String token, searchText, count, categoryId) async {
    Map<String, dynamic> _resp = await _queryProvider.serviceList(token, searchText, count, categoryId);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = ServiceListMdl(status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return ServiceListMdl.fromJson(data);
      }
    } else {
      final errorMsg = ServiceListMdl(status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }


}