import 'package:auto_fix/QueryProvider/query_provider.dart';
import 'package:auto_fix/UI/Mechanic/BottomBar/AddPriceFault/add_price_fault_mdl.dart';

import 'mech_service_mdl.dart';

class MechServiceDetailsApiProvider1 {
  final QueryProvider _queryProvider = QueryProvider();

  Future postMechServiceDetailsRequest(
      token, bookingId)async{
    Map<String,dynamic> _resp = await _queryProvider.postMechServiceDetailsRequest(
      token, bookingId);
    if(_resp != null){
      if(_resp['status'] == "error"){
        final errorMsg = MechServiceDetailsMdl(data: null);
        return errorMsg;
      }else{
        var data = {"data": _resp};
        return MechServiceDetailsMdl.fromJson(data);
      }
    }else{
      final errorMsg = MechServiceDetailsMdl(data: null);
      return errorMsg;
    }
  }
}