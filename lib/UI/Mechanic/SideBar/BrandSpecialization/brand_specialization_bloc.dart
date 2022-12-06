import 'package:auto_fix/Models/customer_models/brand_list_model/brandListMdl.dart';
import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Mechanic/SideBar/BrandSpecialization/brand_specialization_mdl.dart';
import 'package:auto_fix/UI/Mechanic/SideBar/BrandSpecialization/brand_specialization_update_mdl.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/vechicleSpecialization/vehicleSpecialization_mdl.dart';


import 'package:rxdart/rxdart.dart';

class brandSpecializationBloc {
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


  final postBrandListRequest = PublishSubject<BrandSpecializationMdl>();
  Stream<BrandSpecializationMdl> get postBrandListResponse => postBrandListRequest.stream;

  postBrandDetailsRequest(
      token,userId)  async {
    BrandSpecializationMdl _mechanicIncomingRequestMdl = await repository.postMechBrandDetailsRequest(
        token,userId);
    postBrandListRequest.sink.add(_mechanicIncomingRequestMdl);
  }

  final postUpdateBrandListRequest = PublishSubject<UpdateBrandSpecializationMdl>();
  Stream<UpdateBrandSpecializationMdl> get postUpdateBrandListResponse => postUpdateBrandListRequest.stream;

  postUpdateBrandDetailsRequest(
      token,userId, brandNames)  async {
    UpdateBrandSpecializationMdl _updateBrandSpecializationMdl = await repository.postMechBrandUpdateDetailsRequest(
        token,userId, brandNames);
    postUpdateBrandListRequest.sink.add(_updateBrandSpecializationMdl);
  }


  dispose() {
    vehicleSpecializationCode.close();
  }
}
