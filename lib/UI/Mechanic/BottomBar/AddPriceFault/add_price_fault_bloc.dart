import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Mechanic/BottomBar/AddPriceFault/time_price_mech_service_add_mdl.dart';
import 'package:rxdart/rxdart.dart';

import 'add_price_fault_mdl.dart';
import 'emrg_reglr_add_price_mdl.dart';
import 'update_time_add_price_mdl.dart';

class AddPriceFaultReviewBloc{
  final Repository repository = Repository();

  final postAddPriceFaultReview = PublishSubject<AddPriceFaultMdl>();
  Stream<AddPriceFaultMdl> get AddPriceFaultMdlResponse => postAddPriceFaultReview.stream;

  postAddFetchPriceFaultReviewRequest(
      String token, mechanicId
      )async{
    AddPriceFaultMdl _AddPriceFaultMdl = await repository.postAddFetchPriceFaultReviewRequest(token, mechanicId);
    postAddPriceFaultReview.sink.add(_AddPriceFaultMdl);
  }
  dispose(){
    postAddPriceFaultReview.close();
  }
  final postUpdateAddPriceFaultReview = PublishSubject<UpdateAddPriceFaultMdl>();
  Stream<UpdateAddPriceFaultMdl> get UpdateAddPriceFaultMdlResponse => postUpdateAddPriceFaultReview.stream;

  postUpdateAddPriceFaultReviewRequest(
      String token,mechanicId,time,fee,serviceId
      )async{
    UpdateAddPriceFaultMdl _UpdateAddPriceFaultMdl = await repository.postUpdateAddPriceFaultReviewRequest(token,mechanicId,time,fee,serviceId);
    postUpdateAddPriceFaultReview.sink.add(_UpdateAddPriceFaultMdl);
  }
  final postEnrgRegAddPriceReview = PublishSubject<EnrgRegAddPriceMdl>();
  Stream<EnrgRegAddPriceMdl> get EnrgRegAddPriceMdlResponse => postEnrgRegAddPriceReview.stream;
  postEnrgRegAddPriceReviewRequest(
      token,page,size,search,userId,catType)async {

    EnrgRegAddPriceMdl _EnrgRegAddPriceMdl = await repository
        .postEmrgRegAddPriceReviewRequest(
        token, page, size, search, userId, catType);
    print('pieuiey 004 ${_EnrgRegAddPriceMdl.data}');
    postEnrgRegAddPriceReview.sink.add(_EnrgRegAddPriceMdl);
  }
  // dispose(){
  //   postEnrgRegAddPriceReview.close();
  // }
  final postTimeServicePriceAddReview = PublishSubject<TimePriceServiceDetailsMdl>();
  Stream<TimePriceServiceDetailsMdl> get TimePriceServiceDetailsMdlResponse => postTimeServicePriceAddReview.stream;

  postTimeServicePriceAddReviewRequest(
      String token,services,fee,time, catType
      )async{
    TimePriceServiceDetailsMdl _TimePriceServiceDetailsMdl = await repository.postTimeServicePriceAddReviewRequest(token,services,fee,time, catType);
    postTimeServicePriceAddReview.sink.add(_TimePriceServiceDetailsMdl);
  }

}