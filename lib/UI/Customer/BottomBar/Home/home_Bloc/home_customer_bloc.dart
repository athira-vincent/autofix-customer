
import 'package:auto_fix/Models/customer_models/booking_details_model/bookingDetailsMdl.dart';
import 'package:auto_fix/Models/customer_models/mechanic_List_model/mechanicListMdl.dart';
import 'package:auto_fix/Models/customer_models/mechanic_booking_model/emergencyBookingMdl.dart';
import 'package:auto_fix/Models/customer_models/mechanic_booking_model/mechanicBookingMdl.dart';
import 'package:auto_fix/Models/customer_models/mechanic_details_model/mechanicDetailsMdl.dart';
import 'package:auto_fix/Models/customer_models/mechanic_start_service_model/customer_start_service_mdl.dart';
import 'package:auto_fix/Models/customer_models/update_mechanic_booking_model/updateMechanicBookingMdl.dart';
import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/home_Customer_Models/category_list_home_mdl.dart';
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



  /// =============== Mechanics Profile Details ================== ///


  final postMechanicProfileDetails = PublishSubject<MechanicDetailsMdl>();
  Stream<MechanicDetailsMdl> get MechanicProfileDetailsResponse => postMechanicProfileDetails.stream;

  fetchMechanicProfileDetails(
      token,
      mechanicId,
      serviceId,
      latitude,
      longitude,) async {

    MechanicDetailsMdl _mechanicDetailsMdl = await repository.fetchMechanicProfileDetails(
      token,
      mechanicId,
      serviceId,
      latitude,
      longitude,);
    postMechanicProfileDetails.sink.add(_mechanicDetailsMdl);
  }



  /// =============== Mechanics Regular Service Booking Id  ================== ///


  final postMechanicsRegularBookingIDList = BehaviorSubject<MechanicBookingMdl>();
  Stream<MechanicBookingMdl> get mechanicsRegularBookingIDResponse => postMechanicsRegularBookingIDList.stream;

  postMechanicsRegularServiceBookingIDRequest(
      token, date, time,
      latitude, longitude,
      serviceId, mechanicId, reqType,
      totalPrice, paymentType, travelTime) async {

    MechanicBookingMdl _mechanicsBookingMdl = await repository.postMechanicsRegularServiceBookingIDRequest(
        token, date, time,
        latitude, longitude,
        serviceId, mechanicId, reqType,
        totalPrice, paymentType, travelTime);
    postMechanicsRegularBookingIDList.sink.add(_mechanicsBookingMdl);
  }

  /// =============== Mechanics Emergency Service Booking Id  ================== ///


  final postMechanicsEmergencyBookingIDList = BehaviorSubject<EmergencyBookingMdl>();
  Stream<EmergencyBookingMdl> get mechanicsEmergencyBookingIDResponse => postMechanicsEmergencyBookingIDList.stream;

  postMechanicsEmergencyServiceBookingIDRequest(
      token, date, time,
      latitude, longitude,
      serviceId, mechanicId, reqType,
      totalPrice, paymentType, travelTime) async {

    EmergencyBookingMdl _mechanicsBookingMdl = await repository.postMechanicsEmergencyServiceBookingIDRequest(
        token, date, time,
        latitude, longitude,
        serviceId, mechanicId, reqType,
        totalPrice, paymentType, travelTime);
    postMechanicsEmergencyBookingIDList.sink.add(_mechanicsBookingMdl);
  }


  /// =============== Update Mechanic Booking Id  ================== ///


  final postUpdateMechanicsBookingIDList = BehaviorSubject<UpdateMechanicBookingMdl>();
  Stream<UpdateMechanicBookingMdl> get mechanicsUpdateBookingIDResponse => postUpdateMechanicsBookingIDList.stream;

  postUpdateMechanicsBookingIDRequest(
      token, bookingId, mechanicId,)async {

    print('token   $token   token');

    UpdateMechanicBookingMdl _mechanicsBookingMdl = await repository.postUpdateMechanicsBookingIDRequest(
      token, bookingId, mechanicId,);
    postUpdateMechanicsBookingIDList.sink.add(_mechanicsBookingMdl);
  }

  /// ===============  Booking Details  ================== ///


  final postBookingDetailsList = BehaviorSubject<BookingDetailsMdl>();
  Stream<BookingDetailsMdl> get bookingDetailsResponse => postBookingDetailsList.stream;

  postBookingDetailsRequest(
      token, bookingId,)async {

    print('token   $token   token');

    BookingDetailsMdl _bookingDetailsMdl = await repository.postBookingDetailsRequest(
      token, bookingId,);
    postBookingDetailsList.sink.add(_bookingDetailsMdl);
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


  final postCustomerAddMoreServiceRequest = PublishSubject<CustomerAddMoreServiceMdl>();
  Stream<CustomerAddMoreServiceMdl> get postCustomerAddMoreServiceResponse => postCustomerAddMoreServiceRequest.stream;

  postCustomerAddMoreServiceUpdate(
      token, bookingId, serviceIds, totalPrice, travelTime) async {
    CustomerAddMoreServiceMdl _mechanicAddMoreServiceMdl = await repository. postCustomerAddMoreServiceUpdate(
        token, bookingId, serviceIds, totalPrice, travelTime);
    postCustomerAddMoreServiceRequest.sink.add(_mechanicAddMoreServiceMdl);
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

  /// =============== Time Conversion ================== ///

  timeConvertWithoutAmPm(DateTime Format) {
    final DateFormat formatter = DateFormat('hh:mm');
    final String formatted = formatter.format(Format);
    print(formatted);

    return formatted;
  }



  dispose() {

  }
}
