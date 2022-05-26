import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Mechanic/SideBar/MyJobReview/my_job_review_mdl.dart';
import 'package:auto_fix/UI/Mechanic/WorkFlowScreens/CustomerApproved/additional_time_mdl.dart';
import 'package:auto_fix/UI/Mechanic/WorkFlowScreens/IncomingJobRequestScreen/incoming_request_mdl.dart';
import 'package:rxdart/rxdart.dart';

class MechanicAddMoreTimeBloc {
  final Repository repository = Repository();

  final postMechanicAddTimeRequest = PublishSubject<MechanicAddTimeMdl>();
  Stream<MechanicAddTimeMdl> get MechanicAddTimeResponse => postMechanicAddTimeRequest.stream;

  postMechanicSetAddTimeRequest(
      String token, extendTime, bookingId,
      ) async {
    MechanicAddTimeMdl _mechanicAddTimeMdl = await repository.postMechanicAddTimeUpdate(token, extendTime, bookingId,);
    postMechanicAddTimeRequest.sink.add(_mechanicAddTimeMdl);
  }


  dispose() {
    postMechanicAddTimeRequest.close();
  }


}
