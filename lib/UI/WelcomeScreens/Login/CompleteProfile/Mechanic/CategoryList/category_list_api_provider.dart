
import 'package:auto_fix/QueryProvider/query_provider.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/CategoryList/category_list_mdl.dart';

class CategoryListApiProvider {

  final QueryProvider _queryProvider = QueryProvider();

  Future<CategoryListMdl> getCategoryListRequest(
      String token, searchText, count, categoryId) async {
    Map<String, dynamic> _resp = await _queryProvider.categoryList(token, searchText, count, categoryId);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = CategoryListMdl(status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return CategoryListMdl.fromJson(data);
      }
    } else {
      final errorMsg = CategoryListMdl(status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }


}