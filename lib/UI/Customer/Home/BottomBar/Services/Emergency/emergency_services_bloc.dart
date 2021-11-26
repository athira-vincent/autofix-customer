import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Customer/Home/BottomBar/Services/Emergency/emergency_services_mdl.dart';
import 'package:rxdart/rxdart.dart';

class EmergencyServicesBloc {
  final Repository repository = Repository();
  final postEmergencyServices = PublishSubject<EmergencyServicesMdl>();
  Stream<EmergencyServicesMdl> get emergencyServicesResponse =>
      postEmergencyServices.stream;
  dispose() {
    postEmergencyServices.close();
  }

  postEmergencyServicesRequest(int page, int size, String token) async {
    EmergencyServicesMdl _emergencyServicesMdl =
        await repository.getEmerGencyServices(page, size, token);
    postEmergencyServices.sink.add(_emergencyServicesMdl);
  }
}
