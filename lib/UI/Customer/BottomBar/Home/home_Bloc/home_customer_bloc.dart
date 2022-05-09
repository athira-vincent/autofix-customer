
import 'package:auto_fix/Models/customer_models/mechanic_List_model/mechanicListMdl.dart';
import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/home_Customer_Models/category_list_home_mdl.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/home_Customer_Models/mechanics_Booking_Mdl.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/home_Customer_Models/serviceSearchListAll_Mdl.dart';
import 'package:auto_fix/UI/Customer/SideBar/MyVehicles/CustVehicleListMdl.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/FetchProfile/customerDetailsMdl.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';


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




  /// =============== Mechanics List Emergency ================== ///


  final postFindMechanicsListEmergency = PublishSubject<MechanicListMdl>();
  Stream<MechanicListMdl> get findMechanicsListEmergencyResponse => postFindMechanicsListEmergency.stream;

  postFindMechanicsListEmergencyRequest(
      token,
      page,
      size,
      latitude,
      longitude,
      serviceId,
      serviceType) async {

    MechanicListMdl _mechaniclist = await repository.postFindMechanicsListEmergencyRequest(
        token,
        page,
        size,
        latitude,
        longitude,
        serviceId,
        serviceType);
    postFindMechanicsListEmergency.sink.add(_mechaniclist);
  }


  /// =============== Mechanics Booking ID ================== ///


  final postMechanicsBookingIDList = BehaviorSubject<MechanicsBookingMdl>();
  Stream<MechanicsBookingMdl> get mechanicsBookingIDResponse => postMechanicsBookingIDList.stream;

  postMechanicsBookingIDRequest(
      token, date, time,
      latitude, longitude,
      serviceId, mechanicId, reqType,
      totalPrice, paymentType, travelTime) async {

    MechanicsBookingMdl _mechanicsBookingMdl = await repository.postMechanicsBookingIDRequest(
        token, date, time,
        latitude, longitude,
        serviceId, mechanicId, reqType,
        totalPrice, paymentType, travelTime);
    postMechanicsBookingIDList.sink.add(_mechanicsBookingMdl);
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
