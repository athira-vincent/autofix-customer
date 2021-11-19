import 'package:auto_fix/QueryProvider/query_provider.dart';
import 'package:auto_fix/UI/Customer/Home/BottomBar/SpairParts/Brands/top_brands_mdl.dart';

class TopBrandsApiProvider {
  final QueryProvider _queryProvider = QueryProvider();
  Future<TopBrandsMdl> getTopBrandsRequest() async {
    Map<String, dynamic> _resp = await _queryProvider.topBrands();
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg =
            TopBrandsMdl(status: "error", message: _resp['message']);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return TopBrandsMdl.fromJson(data);
      }
    } else {
      final errorMsg =
          TopBrandsMdl(status: "error", message: "No Internet connection");
      return errorMsg;
    }
  }
}
