import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Mechanic/WorkFlowScreens/mechanic_start_service_mdl.dart';
import 'package:rxdart/rxdart.dart';

class MechanicAddMoreServiceBloc {
  final Repository repository = Repository();

  final postMechanicAddMoreServiceRequest = PublishSubject<MechanicAddMoreServiceMdl>();
  Stream<MechanicAddMoreServiceMdl> get mechanicAddMoreServiceResponse => postMechanicAddMoreServiceRequest.stream;

  postAddMoreServiceRequest(
      String token, bookingId, serviceIds
      ) async {
    MechanicAddMoreServiceMdl _mechanicAddMoreServiceMdl = await repository.postMechanicAddMoreServiceUpdate(token, bookingId, serviceIds);
    postMechanicAddMoreServiceRequest.sink.add(_mechanicAddMoreServiceMdl);
  }


  dispose() {
    postMechanicAddMoreServiceRequest.close();
  }


}
