import 'package:auto_fix/QueryProvider/query_provider.dart';
import 'package:auto_fix/UI/Customer/Home/BottomBar/Services/SearchResult/search_result_mdl.dart';

class SearchResultApiProvider {
  final QueryProvider _queryProvider = QueryProvider();
  Future<SearchResultMdl> getSearchResultRequest(
      int page, int size, String searchText) async {
    Map<String, dynamic> _resp =
        await _queryProvider.searchResult(page, size, searchText);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg =
            SearchResultMdl(status: "error", message: _resp['message']);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return SearchResultMdl.fromJson(data);
      }
    } else {
      final errorMsg =
          SearchResultMdl(status: "error", message: "No Internet connection");
      return errorMsg;
    }
  }
}
