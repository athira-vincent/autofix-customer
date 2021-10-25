import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Home/SearchResult/search_result_mdl.dart';
import 'package:rxdart/rxdart.dart';

class SearchResultBloc {
  final Repository repository = Repository();
  final postSearchResult = PublishSubject<SearchResultMdl>();
  Stream<SearchResultMdl> get searchResultResponse => postSearchResult.stream;
  dispose() {
    postSearchResult.close();
  }

  postSearchResultRequest() async {
    SearchResultMdl _searchResultMdl = await repository.getSearchResult();
    postSearchResult.sink.add(_searchResultMdl);
  }
}
