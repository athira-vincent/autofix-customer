import 'package:auto_fix/QueryProvider/query_provider.dart';
import 'package:auto_fix/UI/Home/Vehicle/Add/Make/all_make_mdl.dart';

class AllMakeApiProvider {
  final QueryProvider _queryProvider = QueryProvider();
  Future<AllMakeMdl> getAllMakeRequest() async {
    Map<String, dynamic> _resp = await _queryProvider.allMake();
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = AllMakeMdl(status: "error", message: _resp['message']);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return AllMakeMdl.fromJson(data);
      }
    } else {
      final errorMsg =
          AllMakeMdl(status: "error", message: "No Internet connection");
      return errorMsg;
    }
  }
}
