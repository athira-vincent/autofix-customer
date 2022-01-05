import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Mechanic/Home/BottomBar/UpcomingService/upcoming_service_mdl.dart';
import 'package:rxdart/rxdart.dart';

class UpcomingServicesBloc {
  final Repository repository = Repository();
  final postUpcomingServiceList = PublishSubject<UpcomingServicesMdl>();
  Stream<UpcomingServicesMdl> get UpcomingServiceResponse =>
      postUpcomingServiceList.stream;
  dispose() {
    postUpcomingServiceList.close();
  }

  postUpcomingServiceRequest(
      String token,
      ) async {
    UpcomingServicesMdl _upcomingServicesMdl =
    await repository.getUpcomingServices(token);
    postUpcomingServiceList.sink.add(_upcomingServicesMdl);
  }
}
