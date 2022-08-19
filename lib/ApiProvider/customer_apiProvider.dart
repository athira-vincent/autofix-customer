// ignore_for_file: avoid_print

import 'package:auto_fix/Models/customer_models/add_cart_model/add_cart_model.dart';
import 'package:auto_fix/Models/customer_models/add_rating_model/addRatingMdl.dart';
import 'package:auto_fix/Models/customer_models/booking_details_model/bookingDetailsMdl.dart';
import 'package:auto_fix/Models/customer_models/cart_list_model/cart_list_model.dart';
import 'package:auto_fix/Models/customer_models/cust_completed_orders_model/customerCompletedOrdersListMdl.dart';
import 'package:auto_fix/Models/customer_models/mechanic_List_model/mechanicListMdl.dart';
import 'package:auto_fix/Models/customer_models/mechanic_booking_model/emergencyBookingMdl.dart';
import 'package:auto_fix/Models/customer_models/mechanic_booking_model/mechanicBookingMdl.dart';
import 'package:auto_fix/Models/customer_models/mechanic_details_model/mechanicDetailsMdl.dart';
import 'package:auto_fix/Models/customer_models/mechanic_start_service_model/customer_start_service_mdl.dart';
import 'package:auto_fix/Models/customer_models/spare_parts_list_model/spare_parts_list_model.dart';
import 'package:auto_fix/Models/customer_models/spare_parts_model/spare_parts_model.dart';
import 'package:auto_fix/Models/customer_models/update_mechanic_booking_model/updateMechanicBookingMdl.dart';
import 'package:auto_fix/Models/delete_cart_model/delete_cart_model.dart';
import 'package:auto_fix/QueryProvider/query_provider.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/home_Customer_Models/category_list_home_mdl.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/home_Customer_Models/serviceSearchListAll_Mdl.dart';
import 'package:auto_fix/UI/Customer/SideBar/MyVehicles/CustVehicleListMdl.dart';


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
      serviceId, mechanicId, reqType, regularServiceType,
      totalPrice, paymentType, travelTime) async {
    Map<String, dynamic> _resp = await _queryProvider.postMechanicsRegularServiceBookingIDRequest(
        token, date, time,
        latitude, longitude,
        serviceId, mechanicId, reqType, regularServiceType,
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
      serviceSearch,
      catSearch,
      count,
      categoryId)async {
    Map<String, dynamic> _resp = await _queryProvider. postSearchServiceRequest(
        token,
        serviceSearch,
        catSearch,
        count,
        categoryId);
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

  Future<AddRatingMdl>    postAddMechanicReviewAndRatingRequest(
      token,rating, feedback, bookingId, )async {
    Map<String, dynamic> _resp = await _queryProvider. postAddMechanicReviewAndRatingRequest(
        token,rating, feedback, bookingId, );

    print('$_resp >>>>>>>>>>>>>>>>>>+++++++++++++++++++_resp');
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = AddRatingMdl(status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return AddRatingMdl.fromJson(data);
      }
    } else {
      final errorMsg = AddRatingMdl(status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }


  Future<CategoryListHomeMdl> getCategoryListHomeRequest(
      String token, categoryId, serviceSearch, catSearch) async {
    Map<String, dynamic> _resp = await _queryProvider.categoryListHome(token, categoryId, serviceSearch, catSearch);
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


  Future<CustomerCompletedOrdersListMdl> postCustomerCompletedOrdersRequest(
      token,count, recent, customerId) async {
    Map<String, dynamic> _resp = await _queryProvider.postCustomerCompletedOrdersRequest(
        token,count, recent, customerId);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = CustomerCompletedOrdersListMdl(status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return CustomerCompletedOrdersListMdl.fromJson(data);
      }
    } else {
      final errorMsg = CustomerCompletedOrdersListMdl(status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }



/// spare parts api provider

  Future<CustVehicleListMdl>fetchServicespareparts(
      ) async {
    Map<String, dynamic> _resp = await _queryProvider.fetchServicespareparts(
        ) ;
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




  /// spare partslist api provider

  Future<SparePartsListModel>fetchServicesparepartslist(
      model,search,fromcost,tocost
      ) async {
    Map<String, dynamic> _resp = await _queryProvider.fetchServicesparepartslist(
      model,search,fromcost,tocost
    ) ;
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = SparePartsListModel(status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return SparePartsListModel.fromMap(data);
      }
    } else {
      final errorMsg = SparePartsListModel(status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }




  /// addcart api provider

  Future<AddCartModel>fetchServiceaddcart(
     productid
      ) async {
    Map<String, dynamic> _resp = await _queryProvider.fetchServiceaddcart(
        productid
    ) ;
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = AddCartModel(status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return AddCartModel.fromMap(data);
      }
    } else {
      final errorMsg = AddCartModel(status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }



  /// cartlist api provider

  Future<CartListModel>fetchServicecartlist(
      ) async {
    Map<String, dynamic> _resp = await _queryProvider.fetchServicecartlist(
    ) ;
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = CartListModel(status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return CartListModel.fromMap(data);
      }
    } else {
      final errorMsg = CartListModel(status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }


  /// delete cart
  Future<DeleteCartModel>fetchServicedeletelist(
      productid) async {
    Map<String, dynamic> _resp = await _queryProvider.fetchServicedeletelist(productid
    ) ;
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = DeleteCartModel(status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return DeleteCartModel.fromMap(data);
      }
    } else {
      final errorMsg = DeleteCartModel(status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }
}
