import 'package:auto_fix/QueryProvider/query_provider.dart';
import 'package:auto_fix/UI/Customer/Home/SelectCar/select_car_mdl.dart';

class SelectCarApiProvider {
  final QueryProvider _queryProvider = QueryProvider();
  Future<SelectCarMdl> getSelectCarRequest() async {
    Map<String, dynamic> _resp = await _queryProvider.selectCar();
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg =
            SelectCarMdl(status: "error", message: _resp['message']);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return SelectCarMdl.fromJson(data);
      }
    } else {
      final errorMsg =
          SelectCarMdl(status: "error", message: "No Internet connection");
      return errorMsg;
    }
  }
}
