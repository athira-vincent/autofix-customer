
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/ServiceList/service_list_mdl.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/bothServicesDummy/serviceListAllBothMdl.dart';

import '../../../../../../Repository/repository.dart';
import 'package:rxdart/rxdart.dart';

import 'categoryListMdl.dart';

class ServiceListBothBloc {

  final Repository repository = Repository();

  final postServiceList = BehaviorSubject<CategoryListMdl>();
  Stream<CategoryListMdl> get serviceListResponse => postServiceList.stream;



  /// =============== Emergency Category list ==================

  postCatListEmergencyRequest(String token, String type) async {
    print(">>>>>>>>>>>>>>>----- token" + token);
    CategoryListMdl categoryListMdl = await repository.postCatListBothRequest(token,1);
    postServiceList.sink.add(categoryListMdl);
  }

  /// =============== regular Category list ==================



  final postServiceRegularList = BehaviorSubject<CategoryListMdl>();
  Stream<CategoryListMdl> get postServiceRegularListResponse => postServiceRegularList.stream;

  postCatListRegularRequest(String token, String type) async {
    print(">>>>>>>>>>>>>>>----- token" + token);
    CategoryListMdl categoryListRegularMdl = await repository.postCatListBothRequest(token,2);
    postServiceRegularList.sink.add(categoryListRegularMdl);
  }



  /// =============== Regular Service list ==================


  final postServiceAllRegularList = BehaviorSubject<ServiceListAllBothMdl>();
  Stream<ServiceListAllBothMdl> get postServiceAllRegularListResponse => postServiceAllRegularList.stream;

  postserviceListAllBothRequest(String token, String type) async {
    print(">>>>>>>>>>>>>>>----- token" + token);
    ServiceListAllBothMdl serviceListAllBothMdl = await repository.postserviceListAllBothRequest(token,2);
    postServiceAllRegularList.sink.add(serviceListAllBothMdl);
  }




}