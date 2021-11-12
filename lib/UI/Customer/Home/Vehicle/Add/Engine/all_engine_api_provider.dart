import 'package:auto_fix/QueryProvider/query_provider.dart';
import 'package:auto_fix/UI/Customer/Home/Vehicle/Add/Engine/all_engine_mdl.dart';

class AllEngineApiProvider {
  final QueryProvider _queryProvider = QueryProvider();
  Future<AllEngineMdl> getAllEngineRequest() async {
    Map<String, dynamic> _resp = await _queryProvider.allEngine();
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg =
            AllEngineMdl(status: "error", message: _resp['message']);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return AllEngineMdl.fromJson(data);
      }
    } else {
      final errorMsg =
          AllEngineMdl(status: "error", message: "No Internet connection");
      return errorMsg;
    }
  }
}
