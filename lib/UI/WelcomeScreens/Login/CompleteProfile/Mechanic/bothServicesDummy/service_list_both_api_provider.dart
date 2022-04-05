
import 'package:auto_fix/QueryProvider/query_provider.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/ServiceList/service_list_mdl.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/bothServicesDummy/serviceListAllBothMdl.dart';

import 'categoryListMdl.dart';

class ServiceListApiBothProvider {

  final QueryProvider _queryProvider = QueryProvider();

  Future<ServiceListAllBothMdl> postserviceListAllBothRequest(
      String token,type) async {
    Map<String, dynamic> _resp = await _queryProvider.postserviceListAllBothRequest(token,type);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = ServiceListAllBothMdl(status: "error", message: _resp['message'].toString(), data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return ServiceListAllBothMdl.fromJson(data);
      }
    } else {
      final errorMsg = ServiceListAllBothMdl(status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }

  Future<CategoryListMdl> postCatListBothRequest(
      String token,type) async {
    Map<String, dynamic> _resp = await _queryProvider.postCatListBothRequest(token,type);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = CategoryListMdl(status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return CategoryListMdl.fromJson(data);
      }
    } else {
      final errorMsg = CategoryListMdl(status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }


}