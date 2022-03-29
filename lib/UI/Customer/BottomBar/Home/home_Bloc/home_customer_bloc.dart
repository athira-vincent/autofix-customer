
import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/HomeCustomer/ModelsCustomerHome/mechaniclist_for_services_Mdl.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../WelcomeScreens/Login/CompleteProfile/Mechanic/ServiceList/service_list_mdl.dart';
import '../HomeCustomer/ModelsCustomerHome/mechanics_Booking_Mdl.dart';
import '../SearchService/serviceSearchListAll_Mdl.dart';


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


  /// =============== Mechanics Booking ID ================== ///


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


  /// =============== Find Mechanics List Emergency ================== ///


  final postFindMechanicsListEmergency = PublishSubject<MechaniclistForServicesMdl>();
  Stream<MechaniclistForServicesMdl> get findMechanicsListEmergencyResponse => postFindMechanicsListEmergency.stream;

  postFindMechanicsListEmergencyRequest(
      token,
      bookMechanicId,
      serviceId,
      serviceType) async {

    MechaniclistForServicesMdl _mechaniclistForServicesMdl = await repository.postFindMechanicsListEmergencyRequest(
        token,
        bookMechanicId,
        serviceId,
        serviceType);
    postFindMechanicsListEmergency.sink.add(_mechaniclistForServicesMdl);
  }

  /// =============== Search Service Request  ================== ///


  final postSearchService = PublishSubject<ServiceSearchListAllMdl>();
  Stream<ServiceSearchListAllMdl> get postSearchServiceResponse => postSearchService.stream;

  postSearchServiceRequest(
      token,
      search,
      count,
      categoryId) async {

    ServiceSearchListAllMdl _serviceSearchListAllMdl = await repository.postSearchServiceRequest(
        token,
        search,
        count,
        categoryId);
    postSearchService.sink.add(_serviceSearchListAllMdl);
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
