import 'package:auto_fix/QueryProvider/query_provider.dart';
import 'package:auto_fix/UI/Customer/BottomBar/MyProfile/customer_profile_mdl.dart';

class CustomerProfileApiProvider {
  final QueryProvider _queryProvider = QueryProvider();
  Future<CustomerProfileMdl> postCustFetchProfileRequest(
      token,id)async {
    Map<String, dynamic> _resp = await _queryProvider. postCustFetchProfileRequest(
        token,id);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = CustomerProfileMdl(status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return CustomerProfileMdl.fromJson(data);
      }
    } else {
      final errorMsg = CustomerProfileMdl(status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }
}
