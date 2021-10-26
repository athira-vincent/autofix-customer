import 'package:auto_fix/QueryProvider/query_provider.dart';
import 'package:auto_fix/UI/Home/Vehicle/Add/Model/all_model_mdl.dart';

class AllModelApiProvider {
  final QueryProvider _queryProvider = QueryProvider();
  Future<AllModelMdl> getAllModelRequest() async {
    Map<String, dynamic> _resp = await _queryProvider.allModel();
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg =
            AllModelMdl(status: "error", message: _resp['message']);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return AllModelMdl.fromJson(data);
      }
    } else {
      final errorMsg =
          AllModelMdl(status: "error", message: "No Internet connection");
      return errorMsg;
    }
  }
}
