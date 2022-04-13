
import 'package:auto_fix/QueryProvider/query_provider.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/ServiceList/category_service_list_mdl.dart';

class ServiceListApiProvider {

  final QueryProvider _queryProvider = QueryProvider();

  Future<CategoryServiceListMdl> getServiceListRequest(
      String token, categoryId) async {
    Map<String, dynamic> _resp = await _queryProvider.serviceListWithCategory(token, categoryId);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = CategoryServiceListMdl(status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return CategoryServiceListMdl.fromJson(data);
      }
    } else {
      final errorMsg = CategoryServiceListMdl(status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }


}