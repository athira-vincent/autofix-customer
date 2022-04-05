
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/CategoryList/category_list_mdl.dart';

import '../../../../../../Repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class CategoryListBloc {

  final Repository repository = Repository();

  final postCategoryList = PublishSubject<CategoryListMdl>();
  Stream<CategoryListMdl> get categoryListResponse => postCategoryList.stream;


  postCategoryListRequest(String token, searchText, count, categoryId) async {
    print(">>>>>>>>>>>>>>>----- token" + token);
    CategoryListMdl _categoryListMdl = await repository.getCategoryList(token, searchText, count, categoryId);
    postCategoryList.sink.add(_categoryListMdl);
  }

  /// =============== Emergency services list ==================

/*  postSignUpMechanicCorporateRequest(String username,) async {
    String fullName = username;

    ServiceListMdl _signUpMdl = await repository.getSignUpMechanicCorporate("");
    postServiceList.sink.add(_signUpMdl);
  }*/



}