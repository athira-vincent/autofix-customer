import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Customer/Home/BottomBar/Services/Regular/regular_services_mdl.dart';
import 'package:rxdart/rxdart.dart';

class RegularServicesBloc {
  final Repository repository = Repository();
  final postRegularServices = PublishSubject<RegularServicesMdl>();
  Stream<RegularServicesMdl> get regularServicesResponse =>
      postRegularServices.stream;
  dispose() {
    postRegularServices.close();
  }

  postRegularServicesRequest() async {
    RegularServicesMdl _regularServicesMdl =
        await repository.getRegularServices();
    postRegularServices.sink.add(_regularServicesMdl);
  }
}
