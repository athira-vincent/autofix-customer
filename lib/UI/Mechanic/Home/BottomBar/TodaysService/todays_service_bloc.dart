import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Mechanic/Home/BottomBar/TodaysService/todays_service_mdl.dart';
import 'package:rxdart/rxdart.dart';

class TodaysServicesBloc {
  final Repository repository = Repository();
  final postTodaysServiceList = PublishSubject<TodaysServicesMdl>();
  Stream<TodaysServicesMdl> get TodaysServiceResponse =>
      postTodaysServiceList.stream;
  dispose() {
    postTodaysServiceList.close();
  }

  postTodaysServiceRequest(
      String token,
      ) async {
    TodaysServicesMdl _todaysServicesMdl =
    await repository.getTodaysServices(token);
    postTodaysServiceList.sink.add(_todaysServicesMdl);
  }
}
