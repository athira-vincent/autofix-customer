
import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/AddServices/add_services_mdl.dart';
import 'package:rxdart/rxdart.dart';

class MechanicAddServiceListBloc {
  final Repository repository = Repository();

  final postAddServiceList = PublishSubject<AddServicesMdl>();
  Stream<AddServicesMdl> get mechanicAddServicesResponse => postAddServiceList.stream;

  postMechanicAddServicesRequest(String token,String serviceList,String timeList, String costList ) async {
 print('timeList postMechanicAddServicesRequest MechanicAddServiceListBloc>>>>>>>>>>>>>>>>>>>> $timeList');
    AddServicesMdl _addServiceMdl = await repository.getAddMechanicServiceList(token,serviceList,timeList,costList);
    postAddServiceList.sink.add(_addServiceMdl);
  }

}