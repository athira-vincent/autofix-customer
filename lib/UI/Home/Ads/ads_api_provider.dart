import 'package:auto_fix/QueryProvider/query_provider.dart';
import 'package:auto_fix/UI/Home/Ads/ads_md.dart';

class AdsApiProvider {
  final QueryProvider _queryProvider = QueryProvider();
  Future<AdsMdl> getAdsRequest() async {
    Map<String, dynamic> _resp = await _queryProvider.getAds();
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = AdsMdl(status: "error", message: _resp['message']);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return AdsMdl.fromJson(data);
      }
    } else {
      final errorMsg =
          AdsMdl(status: "error", message: "No Internet connection");
      return errorMsg;
    }
  }
}
