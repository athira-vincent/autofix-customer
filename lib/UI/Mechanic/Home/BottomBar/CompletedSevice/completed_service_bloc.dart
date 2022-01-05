import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Mechanic/Home/BottomBar/CompletedSevice/completed_service_mdl.dart';
import 'package:rxdart/rxdart.dart';

class CompletedServicesBloc {
  final Repository repository = Repository();
  final postCompletedServiceList = PublishSubject<CompletedServicesMdl>();
  Stream<CompletedServicesMdl> get completedServiceResponse =>
      postCompletedServiceList.stream;
  dispose() {
    postCompletedServiceList.close();
  }

  postCompletedServicesListRequest(
      String token,
      ) async {
    CompletedServicesMdl _completedServicesMdl =
    await repository.getCompletedServices(token);
    postCompletedServiceList.sink.add(_completedServicesMdl);
  }
}
