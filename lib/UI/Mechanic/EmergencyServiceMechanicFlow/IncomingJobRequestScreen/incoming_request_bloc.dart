import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Mechanic/EmergencyServiceMechanicFlow/IncomingJobRequestScreen/incoming_request_mdl.dart';
import 'package:auto_fix/UI/Mechanic/SideBar/MyJobReview/my_job_review_mdl.dart';
import 'package:rxdart/rxdart.dart';

class MechanicIncomingJobRequestBloc {
  final Repository repository = Repository();

  final postMechanicIncomingJobRequest = PublishSubject<MechanicIncomingJobMdl>();
  Stream<MechanicIncomingJobMdl> get MechanicMyJobReviewResponse => postMechanicIncomingJobRequest.stream;

  postMechanicFetchIncomingUpdateRequest(
      String token,  bookingId, bookStatus
      ) async {
    MechanicIncomingJobMdl _mechanicIncomingRequestMdl = await repository.postMechanicIncomingRequestUpdate(token,  bookingId, bookStatus);
    postMechanicIncomingJobRequest.sink.add(_mechanicIncomingRequestMdl);
  }


  dispose() {
    postMechanicIncomingJobRequest.close();
  }


}
