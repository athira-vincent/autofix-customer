import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Customer/Home/Vehicle/Details/vehicle_details_mdl.dart';
import 'package:rxdart/rxdart.dart';

class VehilceDetailsBloc {
  final Repository repository = Repository();
  final postVehicleDetails = PublishSubject<VehicleDetailsMdl>();
  Stream<VehicleDetailsMdl> get vehicleDetailsResponse =>
      postVehicleDetails.stream;
  dispose() {
    postVehicleDetails.close();
  }

  postVehicleDetailsRequest() async {
    VehicleDetailsMdl _vehicleDetails = await repository.getVehicleDetails();
    postVehicleDetails.sink.add(_vehicleDetails);
  }
}
