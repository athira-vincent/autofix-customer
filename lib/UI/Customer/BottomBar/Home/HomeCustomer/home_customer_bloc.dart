import 'package:auto_fix/Constants/grapgh_ql_client.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signup/signUp_models/customersCorporateSignUp_Mdl.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signup/signUp_models/customersGovernmentSignUp_Mdl.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signup/signUp_models/customersIndividualSignUp_Mdl.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signup/signUp_models/mechanicCorporateSignUp_Mdl.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signup/signUp_models/mechanicIndividualSignUp_Mdl.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signup/StateList/states_mdl.dart';
import 'package:intl/intl.dart';

import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../WelcomeScreens/Login/CompleteProfile/Mechanic/ServiceList/service_list_mdl.dart';
import 'ModelsCustomerHome/mechanics_Booking_Mdl.dart';


class HomeCustomerBloc {

  final Repository repository = Repository();


  /// =============== Regular services list ================== ///


  final postRegularServiceList = BehaviorSubject<ServiceListMdl>();
  Stream<ServiceListMdl> get regularServiceListResponse => postRegularServiceList.stream;

  postRegularServiceListRequest(String token, String type) async {

    ServiceListMdl _serviceListMdl = await repository.getServiceList(token,type);
    postRegularServiceList.sink.add(_serviceListMdl);
  }


  /// =============== Regular services list ================== ///


  final postEmergencyServiceList = BehaviorSubject<ServiceListMdl>();
  Stream<ServiceListMdl> get emergencyServiceListResponse => postEmergencyServiceList.stream;

  postEmergencyServiceListRequest(String token, String type) async {

    ServiceListMdl _serviceListMdl = await repository.getServiceList(token,type);
    postEmergencyServiceList.sink.add(_serviceListMdl);
  }


  /// =============== Regular services list ================== ///


  final postMechanicsBookingIDList = BehaviorSubject<MechanicsBookingMdl>();
  Stream<MechanicsBookingMdl> get mechanicsBookingIDResponse => postMechanicsBookingIDList.stream;

  postMechanicsBookingIDRequest(
      token,
      date,
      time,
      latitude,
      longitude,
      serviceId) async {

    MechanicsBookingMdl _mechanicsBookingMdl = await repository.postMechanicsBookingIDRequest(
        token,
        date,
        time,
        latitude,
        longitude,
        serviceId);
    postMechanicsBookingIDList.sink.add(_mechanicsBookingMdl);
  }


  /// =============== Date Conversion ================== ///

  dateConvert(DateTime Format) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(Format);
    print(formatted);

    return formatted;
  }

  /// =============== Time Conversion ================== ///

  timeConvert(DateTime Format) {
    final DateFormat formatter = DateFormat('hh:mm a');
    final String formatted = formatter.format(Format);
    print(formatted);

    return formatted;
  }



  dispose() {

  }
}
