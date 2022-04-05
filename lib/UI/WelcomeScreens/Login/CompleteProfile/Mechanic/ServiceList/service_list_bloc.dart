
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/ServiceList/service_list_mdl.dart';

import '../../../../../../Repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class ServiceListBloc {

  final Repository repository = Repository();

  final postServiceList = PublishSubject<ServiceListMdl>();
  Stream<ServiceListMdl> get serviceListResponse => postServiceList.stream;

  /// =============== regular services list ==================

  postServiceListRequest(String token, searchText, count, categoryId) async {
    print(">>>>>>>>>>>>>>>----- token" + token);
    ServiceListMdl _serviceListMdl = await repository.getServiceList(token, searchText, count, categoryId);
    postServiceList.sink.add(_serviceListMdl);
  }

  /// =============== Emergency services list ==================

/*  postSignUpMechanicCorporateRequest(String username,) async {
    String fullName = username;

    ServiceListMdl _signUpMdl = await repository.getSignUpMechanicCorporate("");
    postServiceList.sink.add(_signUpMdl);
  }*/



}