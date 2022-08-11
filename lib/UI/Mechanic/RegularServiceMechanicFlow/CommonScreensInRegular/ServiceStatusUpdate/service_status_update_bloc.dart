import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Mechanic/RegularServiceMechanicFlow/CommonScreensInRegular/ServiceStatusUpdate/service_status_update_mdl.dart';
import 'package:rxdart/rxdart.dart';

class ServiceStatusUpdateBloc {
  final Repository repository = Repository();

  final postStatusUpdate = PublishSubject<ServiceStatusUpdateMdl>();
  Stream<ServiceStatusUpdateMdl> get statusUpdateResponse => postStatusUpdate.stream;

  postStatusUpdateRequest(
      String  token,  bookingId, bookStatus
      ) async {
    ServiceStatusUpdateMdl _mechanicMyJobReviewMdl = await repository.postServiceStatusUpdateRequest( token,  bookingId, bookStatus);
    postStatusUpdate.sink.add(_mechanicMyJobReviewMdl);
  }


  dispose() {
    postStatusUpdate.close();
  }


}
