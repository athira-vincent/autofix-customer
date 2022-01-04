
import 'package:auto_fix/QueryProvider/query_provider.dart';
import 'package:auto_fix/UI/Mechanic/Login/SignUp/SignUpScreen3/services_fee_list/service_fee_mdl.dart';

class AllServiceFeeApiProvider {
  final QueryProvider _queryProvider = QueryProvider();
  Future<AllServiceFeeMdl> getAllServiceFeeRequest(int page, int size, int enable,String token) async {
    Map<String, dynamic> _resp = await _queryProvider.allServiceFee(page,size,enable,token);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg =
        AllServiceFeeMdl(status: "error", message: _resp['message']);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return AllServiceFeeMdl.fromJson(data);
      }
    } else {
      final errorMsg =
      AllServiceFeeMdl(status: "error", message: "No Internet connection");
      return errorMsg;
    }
  }
}
