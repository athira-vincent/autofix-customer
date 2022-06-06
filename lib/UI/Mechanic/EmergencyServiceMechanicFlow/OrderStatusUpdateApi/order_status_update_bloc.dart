import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Mechanic/EmergencyServiceMechanicFlow/OrderStatusUpdateApi/order_status_update_mdl.dart';
import 'package:rxdart/rxdart.dart';

class MechanicOrderStatusUpdateBloc {
  final Repository repository = Repository();

  final postMechanicOrderStatusRequest = PublishSubject<MechanicOrderStatusUpdateMdl>();
  Stream<MechanicOrderStatusUpdateMdl> get MechanicOrderStatusUpdateResponse => postMechanicOrderStatusRequest.stream;

  postMechanicOrderStatusUpdateRequest(
      String token, bookingId, bookStatus
      ) async {
    MechanicOrderStatusUpdateMdl _mechanicIncomingRequestMdl = await repository.postMechanicOrderStatusUpdate(token,  bookingId, bookStatus);
    postMechanicOrderStatusRequest.sink.add(_mechanicIncomingRequestMdl);
  }


  dispose() {
    postMechanicOrderStatusRequest.close();
  }


}
