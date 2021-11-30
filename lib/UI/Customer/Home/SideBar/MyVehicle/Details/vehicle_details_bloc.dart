import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Customer/Home/SideBar/MyVehicle/Details/vehicle_details_mdl.dart';
import 'package:rxdart/rxdart.dart';

class VehilceDetailsBloc {
  final Repository repository = Repository();
  final postVehicleDetails = PublishSubject<VehicleDetailsMdl>();
  Stream<VehicleDetailsMdl> get vehicleDetailsResponse =>
      postVehicleDetails.stream;
  dispose() {
    postVehicleDetails.close();
  }

  postVehicleDetailsRequest(String token) async {
    VehicleDetailsMdl vehicleDetailsMdl =
        await repository.getVehicleDetails(token);
    postVehicleDetails.sink.add(vehicleDetailsMdl);
  }
}
