import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Customer/Home/Vehicle/Add/add_vehicle_mdl.dart';
import 'package:rxdart/rxdart.dart';

class AddVehicleBloc {
  final Repository repository = Repository();
  final postAddVehicle = PublishSubject<AddVehicleMdl>();
  Stream<AddVehicleMdl> get addVehicleResponse => postAddVehicle.stream;
  dispose() {
    postAddVehicle.close();
  }

  postAddVehicleRequest() async {
    AddVehicleMdl _addVehicleMdl = await repository.getAddVehicle();
    postAddVehicle.sink.add(_addVehicleMdl);
  }
}
