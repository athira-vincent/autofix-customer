import 'package:auto_fix/Constants/grapgh_ql_client.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Customer/vehicleCreate_Mdl.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signin/signin_mdl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddCarBloc {
  final Repository repository = Repository();


  final postAddCar = PublishSubject<VehicleCreateMdl>();
  Stream<VehicleCreateMdl> get addCarResponse => postAddCar.stream;


  postAddCarRequest(
      token,
      year,
      plateNo,
      engineName,
      lastMaintenance,
      milege,
      makeId,
      vehicleModelId,
  ) async {
    VehicleCreateMdl vehicleCreateMdl = await repository.postAddCarRequest(
      token,
      year,
      plateNo,
      engineName,
      lastMaintenance,
      milege,
      makeId,
      vehicleModelId,);
    postAddCar.sink.add(vehicleCreateMdl);
  }


  dispose() {
    postAddCar.close();
  }
}
