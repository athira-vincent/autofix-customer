
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/ServiceList/category_service_list_mdl.dart';

import '../../../../../../Repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class ServiceListBloc {

  final Repository repository = Repository();

  final postServiceList = PublishSubject<CategoryServiceListMdl>();
  Stream<CategoryServiceListMdl> get serviceListResponse => postServiceList.stream;

  postServiceListRequest(String token, searchText, count, categoryId, catSearch) async {
    print(">>>>>>>>>>>>>>>----- token" + token);
    CategoryServiceListMdl _serviceListMdl = await repository.getServiceList(token, categoryId, searchText, catSearch);
    postServiceList.sink.add(_serviceListMdl);
  }


}