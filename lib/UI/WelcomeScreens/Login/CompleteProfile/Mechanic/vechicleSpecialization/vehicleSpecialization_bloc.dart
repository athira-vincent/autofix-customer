import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/vechicleSpecialization/vehicleSpecialization_mdl.dart';


import 'package:rxdart/rxdart.dart';

class vehicleSpecializationBloc {
  final Repository repository = Repository();

  final vehicleSpecializationCode = PublishSubject<List<VehicleSpecialization>>();
  Stream<List<VehicleSpecialization>> get vehicleSpecializationResponse => vehicleSpecializationCode.stream;

  List<VehicleSpecialization> vehicleSpecializationDataList = [];

  dialvehicleSpecializationListRequest() async {
    dynamic _vehicleSpecialization = await repository.getvehicleSpecializationList();
    vehicleSpecializationDataList.clear();
    vehicleSpecializationDataList.addAll(_vehicleSpecialization.vehicleSpecialization);
    vehicleSpecializationCode.sink.add(_vehicleSpecialization.vehicleSpecialization);
  }


  dispose() {
    vehicleSpecializationCode.close();
  }
}
