// ignore_for_file: avoid_print

import 'package:auto_fix/Models/customer_models/booking_details_model/bookingDetailsMdl.dart';
import 'package:auto_fix/Models/customer_models/mechanic_List_model/mechanicListMdl.dart';
import 'package:auto_fix/Models/customer_models/mechanic_booking_model/emergencyBookingMdl.dart';
import 'package:auto_fix/Models/customer_models/mechanic_booking_model/mechanicBookingMdl.dart';
import 'package:auto_fix/Models/customer_models/mechanic_details_model/mechanicDetailsMdl.dart';
import 'package:auto_fix/Models/customer_models/mechanic_start_service_model/customer_start_service_mdl.dart';
import 'package:auto_fix/Models/customer_models/update_mechanic_booking_model/updateMechanicBookingMdl.dart';
import 'package:auto_fix/QueryProvider/query_provider.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/home_Customer_Models/category_list_home_mdl.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/home_Customer_Models/serviceSearchListAll_Mdl.dart';
import 'package:auto_fix/UI/Customer/SideBar/MyVehicles/CustVehicleListMdl.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/FetchProfile/customerDetailsMdl.dart';


class CustomerApiProvider {

  final QueryProvider _queryProvider = QueryProvider();


  /// =============== Mechanics List Emergency ================== ///


  Future<MechanicListMdl>  postFindMechanicsListEmergencyRequest(
      token,
      page,
      size,
      latitude,
      longitude,
      serviceId,
      serviceType)async {
    Map<String, dynamic> _resp = await _queryProvider. postFindMechanicsListEmergencyRequest(
        token,
        page,
        size,
        latitude,
        longitude,
        serviceId,
        serviceType);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = MechanicListMdl(status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return MechanicListMdl.fromJson(data);
      }
    } else {
      final errorMsg = MechanicListMdl(status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }

  /// =============== Mechanics Profile Details ================== ///

  Future<MechanicDetailsMdl>    fetchMechanicProfileDetails(
      token,
      mechanicId,
      serviceId,
      latitude,
      longitude,)async {
    Map<String, dynamic> _resp = await _queryProvider.fetchMechanicProfileDetails(
      token,
      mechanicId,
      serviceId,
      latitude,
      longitude,);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = MechanicDetailsMdl(status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return MechanicDetailsMdl.fromJson(data);
      }
    } else {
      final errorMsg = MechanicDetailsMdl(status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }


  /// =============== Mechanics Regular Service Booking Id  ================== ///

  Future<MechanicBookingMdl> postMechanicsRegularServiceBookingIDRequest(
      token, date, time,
      latitude, longitude,
      serviceId, mechanicId, reqType,
      totalPrice, paymentType, travelTime) async {
    Map<String, dynamic> _resp = await _queryProvider.postMechanicsRegularServiceBookingIDRequest(
        token, date, time,
        latitude, longitude,
        serviceId, mechanicId, reqType,
        totalPrice, paymentType, travelTime);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = MechanicBookingMdl(status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return MechanicBookingMdl.fromJson(data);
      }
    } else {
      final errorMsg = MechanicBookingMdl(status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }

  /// =============== Mechanics Emergency Service Booking Id  ================== ///

  Future<EmergencyBookingMdl> postMechanicsEmergencyServiceBookingIDRequest(
      token, date, time,
      latitude, longitude,
      serviceId, mechanicId, reqType,
      totalPrice, paymentType, travelTime) async {
    Map<String, dynamic> _resp = await _queryProvider.postMechanicsEmergencyServiceBookingIDRequest(
        token, date, time,
        latitude, longitude,
        serviceId, mechanicId, reqType,
        totalPrice, paymentType, travelTime);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = EmergencyBookingMdl(status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return EmergencyBookingMdl.fromJson(data);
      }
    } else {
      final errorMsg = EmergencyBookingMdl(status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }



  /// =============== Update Mechanic Booking Id  ================== ///

  Future<UpdateMechanicBookingMdl>  postUpdateMechanicsBookingIDRequest(
      token, bookingId, mechanicId,) async {
    Map<String, dynamic> _resp = await _queryProvider.postUpdateMechanicsBookingIDRequest(
      token, bookingId, mechanicId,);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = UpdateMechanicBookingMdl(status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return UpdateMechanicBookingMdl.fromJson(data);
      }
    } else {
      final errorMsg = UpdateMechanicBookingMdl(status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }


  /// ===============  Booking Details  ================== ///

  Future<BookingDetailsMdl>   postBookingDetailsRequest(
      token, bookingId,) async {
    Map<String, dynamic> _resp = await _queryProvider. postBookingDetailsRequest(
      token, bookingId,);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = BookingDetailsMdl(status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return BookingDetailsMdl.fromJson(data);
      }
    } else {
      final errorMsg = BookingDetailsMdl(status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }


  Future<CustomerAddMoreServiceMdl>  postCustomerAddMoreServiceUpdate(
      token, bookingId, serviceIds, totalPrice, travelTime) async {
    Map<String, dynamic> _resp = await _queryProvider. postCustomerAddMoreServiceUpdate(
        token, bookingId, serviceIds, totalPrice, travelTime);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = CustomerAddMoreServiceMdl(status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return CustomerAddMoreServiceMdl.fromJson(data);
      }
    } else {
      final errorMsg = CustomerAddMoreServiceMdl(status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }



  Future<ServiceSearchListAllMdl>  postSearchServiceRequest(
      token,
      bookMechanicId,
      serviceId,
      serviceType)async {
    Map<String, dynamic> _resp = await _queryProvider. postSearchServiceRequest(
        token,
        bookMechanicId,
        serviceId,
        serviceType);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = ServiceSearchListAllMdl(status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return ServiceSearchListAllMdl.fromJson(data);
      }
    } else {
      final errorMsg = ServiceSearchListAllMdl(status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }

  Future<CustVehicleListMdl>   postCustVehicleListRequest(
      token)async {
    Map<String, dynamic> _resp = await _queryProvider. postCustVehicleListRequest(
      token,);

    print('$_resp >>>>>>>>>>>>>>>>>>+++++++++++++++++++_resp');
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = CustVehicleListMdl(status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return CustVehicleListMdl.fromJson(data);
      }
    } else {
      final errorMsg = CustVehicleListMdl(status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }

  Future<CustomerDetailsMdl>   postCustFetchProfileRequest(
      token)async {
    Map<String, dynamic> _resp = await _queryProvider. postCustFetchProfileRequest(
      token,);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = CustomerDetailsMdl(status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return CustomerDetailsMdl.fromJson(data);
      }
    } else {
      final errorMsg = CustomerDetailsMdl(status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }

  Future<CategoryListHomeMdl> getCategoryListHomeRequest(
      String token, categoryId) async {
    Map<String, dynamic> _resp = await _queryProvider.categoryListHome(token,  categoryId);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = CategoryListHomeMdl(status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return CategoryListHomeMdl.fromJson(data);
      }
    } else {
      final errorMsg = CategoryListHomeMdl(status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }



}
