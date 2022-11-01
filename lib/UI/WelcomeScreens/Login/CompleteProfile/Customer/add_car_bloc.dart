import 'package:auto_fix/Constants/grapgh_ql_client.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Models/customer_models/default_vechicle_model/updateDefaultVehicleMdl.dart';
import 'package:auto_fix/Models/customer_models/edit_vechicle_model/editVehicleMdl.dart';
import 'package:auto_fix/Models/customer_models/vehicle_update_model/vehicleUpdateMdl.dart';
import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Customer/vehicleCreate_Mdl.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signin/login_models/signin_mdl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'brand_model_engine/makeBrandDetails_Mdl.dart';
import 'brand_model_engine/modelDetails_Mdl.dart';

class AddCarBloc {
  final Repository repository = Repository();


  final postAddCar = PublishSubject<VehicleCreateMdl>();
  Stream<VehicleCreateMdl> get addCarResponse => postAddCar.stream;


  postAddCarRequest(
      token, brand, model, engine, year,
      plateNo, lastMaintenance, milege,
      vehiclePic,color, latitude, longitude,
  ) async {
    VehicleCreateMdl vehicleCreateMdl = await repository.postAddCarRequest(
      token, brand, model, engine, year,
      plateNo, lastMaintenance, milege,
      vehiclePic,color, latitude, longitude,);
    postAddCar.sink.add(vehicleCreateMdl);
  }


  final postUpdateDefaultVehicle = PublishSubject<UpdateDefaultVehicleMdl>();
  Stream<UpdateDefaultVehicleMdl> get updateDefaultVehicleResponse => postUpdateDefaultVehicle.stream;

  postUpdateDefaultVehicleApi(
      token,vehicleId, customerId)async {
    UpdateDefaultVehicleMdl updateDefaultVehicleMdl = await repository.postUpdateDefaultVehicle(
        token,vehicleId, customerId);
    postUpdateDefaultVehicle.sink.add(updateDefaultVehicleMdl);
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

  final postVechicleDelete = BehaviorSubject<VehicleUpdateMdl>();
  Stream<VehicleUpdateMdl> get VechicleDeleteResponse => postVechicleDelete.stream;
  postVechicleUpdateRequest(
      token, id,
      status)  async {
    VehicleUpdateMdl modelDetail = await repository.postVechicleUpdateRequest(
        token, id,
        status) ;
    postVechicleDelete.sink.add(modelDetail);
  }


  final postEditCar = PublishSubject<EditVehicleMdl>();
  Stream<EditVehicleMdl> get editCarResponse => postEditCar.stream;

  postEditCarRequest(
      token,
      vehicleId, year,
      lastMaintenance, milege,
      vehiclePic, color,
      ) async {
    EditVehicleMdl editVehicleMdl = await repository.postEditCarRequest(
      token,
      vehicleId, year,
      lastMaintenance, milege,
      vehiclePic, color,);
    postEditCar.sink.add(editVehicleMdl);
  }


  dispose() {
    postMakeBrand.close();
    postAddCar.close();
  }
}
