import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Customer/Home/SideBar/MyVehicle/Delete/delete_vehicle_mdl.dart';
import 'package:rxdart/rxdart.dart';

class DeleteVehicleBloc {
  final Repository repository = Repository();
  final postDeleteVehicle = PublishSubject<DeleteVehicleMdl>();
  Stream<DeleteVehicleMdl> get deleteVehicleResponse =>
      postDeleteVehicle.stream;
  dispose() {
    postDeleteVehicle.close();
  }

  postDeleteVehicleRequest() async {
    DeleteVehicleMdl _deleteVehicleMdl = await repository.getDeleteVehicle();
    postDeleteVehicle.sink.add(_deleteVehicleMdl);
  }
}
