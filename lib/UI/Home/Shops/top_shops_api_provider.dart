import 'package:auto_fix/QueryProvider/query_provider.dart';
import 'package:auto_fix/UI/Home/Shops/top_shops_mdl.dart';

class TopShopsApiProvider {
  final QueryProvider _queryProvider = QueryProvider();
  Future<TopShopsMdl> getTopShopsRequest() async {
    Map<String, dynamic> _resp = await _queryProvider.topShops();
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg =
            TopShopsMdl(status: "error", message: _resp['message']);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return TopShopsMdl.fromJson(data);
      }
    } else {
      final errorMsg =
          TopShopsMdl(status: "error", message: "No Internet connection");
      return errorMsg;
    }
  }
}
