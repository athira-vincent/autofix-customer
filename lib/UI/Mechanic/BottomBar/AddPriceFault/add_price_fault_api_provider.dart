import 'package:auto_fix/QueryProvider/query_provider.dart';
import 'package:auto_fix/UI/Mechanic/BottomBar/AddPriceFault/time_price_mech_service_add_mdl.dart';

import 'add_price_fault_mdl.dart';
import 'emrg_reglr_add_price_mdl.dart';
import 'update_time_add_price_mdl.dart';

class AddPriceFaultApiProvider{

  final QueryProvider _queryProvider = QueryProvider();

  Future<AddPriceFaultMdl> postAddPriceFaultReviewRequest(
      token,mechanicId)async {
    Map<String, dynamic> _resp = await _queryProvider.postAddPriceFaultReviewRequest(
        token,mechanicId);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = AddPriceFaultMdl(data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return AddPriceFaultMdl.fromJson(data);
      }
    } else {
      final errorMsg = AddPriceFaultMdl(data: null);
      return errorMsg;
    }
  }
 Future<UpdateAddPriceFaultMdl> postUpdateAddPriceFaultReviewRequest(
     token,mechanicId,time,fee,serviceId)async{
    Map<String, dynamic> _resp = await _queryProvider.postUpdateAddPriceFaultReviewRequest(
        token,mechanicId,time,fee,serviceId);
    if(_resp != null){
      if(_resp['status']=="error"){
        final errormsg = UpdateAddPriceFaultMdl(data: null);
        return errormsg;
      }else{
        var data = {"data":_resp};
        return UpdateAddPriceFaultMdl.fromJson(data);
      }
    }else{
      final errorMsg = UpdateAddPriceFaultMdl(data: null);
      return errorMsg;
    }
 }
 Future<EnrgRegAddPriceMdl> postEmrgRegAddPriceReviewRequest(
     token,page,size,search,userId,catType)async{
    Map<String, dynamic> _resp = await _queryProvider.postEmrgRegAddPriceReviewRequest(
        token,page,size,search,userId,catType);
    print("pieuiey 03 $_resp");
    if(_resp != null){
      if(_resp['status']=="error"){
        final errormsg = EnrgRegAddPriceMdl(data: null);
        return errormsg;
      }else{
        var data = {"data":_resp};
        print("pieuiey 05 ${EnrgRegAddPriceMdl.fromJson(data)}");
        return EnrgRegAddPriceMdl.fromJson(data);
      }
    }else{
      final errorMsg = EnrgRegAddPriceMdl(data: null);
      return errorMsg;
    }
 }
 Future<TimePriceServiceDetailsMdl> postTimePriceServiceDetailsRequest(
     token,services,fee,time, catType)async{
    Map<String, dynamic> _resp = await _queryProvider.postTimePriceServiceDetailsRequest(
        token,services,fee,time, catType);
    if(_resp != null){
      if(_resp['status']=="error"){
        final errormsg = TimePriceServiceDetailsMdl(status: "error", message: _resp['message'], data: null);
        return errormsg;
      }else{
        var data = {"data":_resp};
        print("pieuiey 05 ${TimePriceServiceDetailsMdl.fromJson(data)}");
        return TimePriceServiceDetailsMdl.fromJson(data);
      }
    }else{
      final errorMsg = TimePriceServiceDetailsMdl(status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
 }
  // Future<Object> postEmergencyAddPriceFaultReviewRequest(
  //     token,mechanicId,time,fee,serviceId)async{
  //   Map<String, dynamic> _resp = await _queryProvider.postEmergencyAddPriceFaultReviewRequest(
  //       token,mechanicId,time,fee,serviceId);
  //   if(_resp == null){
  //     if(_resp['status']=="error"){
  //       final errormsg = EmergencyAddPriceFaultMdl(data: null);
  //       return errormsg;
  //     }else{
  //       var data = {"data":_resp};
  //       return EmergencyAddPriceFaultMdl.fromJson(data);
  //     }
  //   }else{
  //     final errorMsg = EmergencyAddPriceFaultMdl(data: null);
  //     return errorMsg;
  //   }
  // }

}