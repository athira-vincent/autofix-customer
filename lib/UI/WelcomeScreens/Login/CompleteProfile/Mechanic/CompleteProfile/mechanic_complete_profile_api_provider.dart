

import 'package:auto_fix/QueryProvider/query_provider.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/CompleteProfile/corporate_mech_complete_profile_mdl.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/CompleteProfile/individual_mech_complete_profile_mdl.dart';

class MechanicCompleteProfileApiProvider {

  final QueryProvider _queryProvider = QueryProvider();

// ------------ Complete Profile Mechanic - Individual--------------

  Future<IndividualMechCompleteProfileMdl> getCompleteProfileMechIndividualRequest(
      String token,
      String workSelection,
      String vehicleSpecialization,
      String address,String apprentice_cert,
      String identification_cert,
      String photoUrl) async {
    Map<String, dynamic> _resp = await _queryProvider.completeProfileMechanicIndividual(token, workSelection,
        vehicleSpecialization, address, apprentice_cert, identification_cert,photoUrl);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = IndividualMechCompleteProfileMdl(status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return IndividualMechCompleteProfileMdl.fromJson(data);
      }
    } else {
      final errorMsg = IndividualMechCompleteProfileMdl(status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }

  //--------------- Complete Profile Mechanic - Corporate-----------------

  Future<CorporateMechCompleteProfileMdl> getCompleteProfileMechCorporateRequest(
      String token,
      String serviceType,
      String vehicleSpecialization,
      String address,
      String mechanicNumber,
      String rcNumber,
      String existenceYear,
      String photoUrl) async {
    Map<String, dynamic> _resp = await _queryProvider.completeProfileMechanicCorporate(token,
    serviceType, vehicleSpecialization, address, mechanicNumber, rcNumber, existenceYear, photoUrl);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = CorporateMechCompleteProfileMdl(status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return CorporateMechCompleteProfileMdl.fromJson(data);
      }
    } else {
      final errorMsg = CorporateMechCompleteProfileMdl(status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }




}