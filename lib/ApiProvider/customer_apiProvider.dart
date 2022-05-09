// ignore_for_file: avoid_print

import 'package:auto_fix/Models/customer_models/mechanic_List_model/mechanicListMdl.dart';
import 'package:auto_fix/QueryProvider/query_provider.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/home_Customer_Models/category_list_home_mdl.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/home_Customer_Models/mechanics_Booking_Mdl.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/home_Customer_Models/serviceSearchListAll_Mdl.dart';
import 'package:auto_fix/UI/Customer/SideBar/MyVehicles/CustVehicleListMdl.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/FetchProfile/customerDetailsMdl.dart';


class CustomerApiProvider {

  final QueryProvider _queryProvider = QueryProvider();

  Future<MechanicsBookingMdl> postMechanicsBookingIDRequest(
      token, date, time,
      latitude, longitude,
      serviceId, mechanicId, reqType,
      totalPrice, paymentType, travelTime) async {
    Map<String, dynamic> _resp = await _queryProvider.postMechanicsBookingIDRequest(
        token, date, time,
        latitude, longitude,
        serviceId, mechanicId, reqType,
        totalPrice, paymentType, travelTime);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = MechanicsBookingMdl(status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return MechanicsBookingMdl.fromJson(data);
      }
    } else {
      final errorMsg = MechanicsBookingMdl(status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }

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
