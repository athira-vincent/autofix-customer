
import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/HomeCustomer/models_CustomerHome/category_list_home_mdl.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/HomeCustomer/models_CustomerHome/mechaniclist_for_services_Mdl.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/HomeCustomer/models_CustomerHome/mechanics_Booking_Mdl.dart';
import 'package:auto_fix/UI/Customer/SideBar/MyVehicles/CustVehicleListMdl.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/FetchProfile/customerDetailsMdl.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/ServiceList/service_list_mdl.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import '../SearchService/serviceSearchListAll_Mdl.dart';


class HomeCustomerBloc {

  final Repository repository = Repository();


  /// =============== Regular services list ================== ///


  final postRegularServiceList = BehaviorSubject<CategoryListHomeMdl>();
  Stream<CategoryListHomeMdl> get regularServiceListResponse => postRegularServiceList.stream;

  postRegularServiceListRequest(String token, String categoryId) async {

    CategoryListHomeMdl _serviceListMdl = await repository.getCategoryListHomeRequest(token, categoryId);
    postRegularServiceList.sink.add(_serviceListMdl);
  }


  /// =============== Emergency services list ================== ///


  final postEmergencyServiceList = BehaviorSubject<CategoryListHomeMdl>();
  Stream<CategoryListHomeMdl> get emergencyServiceListResponse => postEmergencyServiceList.stream;

  postEmergencyServiceListRequest(String token, String categoryId) async {

    CategoryListHomeMdl _serviceListMdl = await repository.getCategoryListHomeRequest(token, categoryId);
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


  /// =============== Fetch Profile Request ================== ///

  final postFetchProfile = PublishSubject<CustomerDetailsMdl>();
  Stream<CustomerDetailsMdl> get postFetchProfileResponse => postFetchProfile.stream;

  postCustFetchProfileRequest(
      token,) async {

    CustomerDetailsMdl _customerDetailsMdl = await repository.postCustFetchProfileRequest(
        token,);
    postFetchProfile.sink.add(_customerDetailsMdl);
  }


  /// =============== Vehicle List Request ================== ///

  final postCustVehicleList = PublishSubject<CustVehicleListMdl>();
  Stream<CustVehicleListMdl> get postCustVehicleListResponse => postCustVehicleList.stream;

  postCustVehicleListRequest(
      token,) async {

    CustVehicleListMdl _custVehicleListMdl = await repository.postCustVehicleListRequest(
      token,);
    postCustVehicleList.sink.add(_custVehicleListMdl);
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
