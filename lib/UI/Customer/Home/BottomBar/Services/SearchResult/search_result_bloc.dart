import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Customer/Home/BottomBar/Services/SearchResult/search_result_mdl.dart';
import 'package:rxdart/rxdart.dart';

class SearchResultBloc {
  final Repository repository = Repository();
  final postSearchResult = PublishSubject<SearchResultMdl>();
  Stream<SearchResultMdl> get searchResultResponse => postSearchResult.stream;
  dispose() {
    postSearchResult.close();
  }

  postSearchResultRequest(int page, int size, String searchText) async {
    SearchResultMdl _searchResultMdl =
        await repository.getSearchResult(page, size, searchText);
    postSearchResult.sink.add(_searchResultMdl);
  }
}
