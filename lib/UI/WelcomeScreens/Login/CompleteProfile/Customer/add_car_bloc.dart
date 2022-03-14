import 'package:auto_fix/Constants/grapgh_ql_client.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Customer/vehicleCreate_Mdl.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signin/signin_mdl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'brand_model_engine/makeBrandDetails_Mdl.dart';
import 'brand_model_engine/modelDetails_Mdl.dart';

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
      vehiclePic
  ) async {
    VehicleCreateMdl vehicleCreateMdl = await repository.postAddCarRequest(
      token,
      year,
      plateNo,
      engineName,
      lastMaintenance,
      milege,
      makeId,
      vehicleModelId,
        vehiclePic);
    postAddCar.sink.add(vehicleCreateMdl);
  }


  final postMakeBrand = BehaviorSubject<MakeBrandDetailsMdl>();
  Stream<MakeBrandDetailsMdl> get MakeBrandResponse => postMakeBrand.stream;
  postMakeBrandRequest(token,) async {
    MakeBrandDetailsMdl makeBrandDetailsMdl = await repository.postMakeBrandRequest(token,);
    postMakeBrand.sink.add(makeBrandDetailsMdl);
  }


  final postModelDetail = BehaviorSubject<ModelDetailsMdl>();
  Stream<ModelDetailsMdl> get ModelDetailResponse => postModelDetail.stream;
  postModelDetailRequest(token,type) async {
    ModelDetailsMdl modelDetail = await repository.postModelDetailRequest(token,type);
    postModelDetail.sink.add(modelDetail);
  }



  dispose() {
    postMakeBrand.close();
    postAddCar.close();
  }
}
