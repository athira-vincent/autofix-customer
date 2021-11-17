import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Customer/SideBar/MyVehicle/Add/add_vehicle_mdl.dart';
import 'package:rxdart/rxdart.dart';

class AddVehicleBloc {
  final Repository repository = Repository();
  final postAddVehicle = PublishSubject<AddVehicleMdl>();
  Stream<AddVehicleMdl> get addVehicleResponse => postAddVehicle.stream;
  dispose() {
    postAddVehicle.close();
  }

  postAddVehicleRequest(
      String year,
      String latitude,
      String longitude,
      String milege,
      String lastMaintenance,
      String interval,
      int makeId,
      int vehicleModelId,
      int engineId) async {
    AddVehicleMdl _addVehicleMdl = await repository.getAddVehicle(
        year,
        latitude,
        longitude,
        milege,
        lastMaintenance,
        interval,
        makeId,
        vehicleModelId,
        engineId);
    postAddVehicle.sink.add(_addVehicleMdl);
  }
}
