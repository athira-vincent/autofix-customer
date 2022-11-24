// ignore_for_file: avoid_print

import 'package:auto_fix/Models/cod_model/cod_model.dart';
import 'package:auto_fix/Models/customer_models/add_address_model/add_address_model.dart';
import 'package:auto_fix/Models/customer_models/add_cart_model/add_cart_model.dart';
import 'package:auto_fix/Models/customer_models/add_rating_model/addRatingMdl.dart';
import 'package:auto_fix/Models/customer_models/booking_details_model/bookingDetailsMdl.dart';
import 'package:auto_fix/Models/customer_models/cancel_order_module/cancel_order_module.dart';
import 'package:auto_fix/Models/customer_models/cart_list_model/cart_list_model.dart';
import 'package:auto_fix/Models/customer_models/cust_completed_orders_model/customerCompletedOrdersListMdl.dart';
import 'package:auto_fix/Models/customer_models/delete_address_model/delete_address_model.dart';
import 'package:auto_fix/Models/customer_models/get_address_model/get_address_model.dart';
import 'package:auto_fix/Models/customer_models/mechanic_List_model/mechanicListMdl.dart';
import 'package:auto_fix/Models/customer_models/mechanic_booking_model/emergencyBookingMdl.dart';
import 'package:auto_fix/Models/customer_models/mechanic_booking_model/mechanicBookingMdl.dart';
import 'package:auto_fix/Models/customer_models/mechanic_details_model/mechanicDetailsMdl.dart';
import 'package:auto_fix/Models/customer_models/mechanic_start_service_model/customer_start_service_mdl.dart';
import 'package:auto_fix/Models/customer_models/order_list_model/order_list_model.dart';
import 'package:auto_fix/Models/customer_models/place_order_model/place_order_model.dart';
import 'package:auto_fix/Models/customer_models/spare_parts_list_model/spare_parts_list_model.dart';
import 'package:auto_fix/Models/customer_models/spare_parts_model/spare_parts_model.dart';
import 'package:auto_fix/Models/customer_models/update_mechanic_booking_model/updateMechanicBookingMdl.dart';
import 'package:auto_fix/Models/customer_rating_model/customer_rating_model.dart';
import 'package:auto_fix/Models/customer_wallet_detail_model/customer_wallet_detail_model.dart';
import 'package:auto_fix/Models/delete_cart_model/delete_cart_model.dart';
import 'package:auto_fix/Models/notification_model/notification_model.dart';
import 'package:auto_fix/Models/wallet_history_model/wallet_history_model.dart';
import 'package:auto_fix/QueryProvider/query_provider.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/home_Customer_Models/category_list_home_mdl.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/home_Customer_Models/customer_active_service_mdl.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/home_Customer_Models/serviceSearchListAll_Mdl.dart';
import 'package:auto_fix/UI/Customer/SideBar/MyVehicles/CustVehicleListMdl.dart';

import '../Models/new_checkout_model/new_checkout_model.dart';
import '../Models/payment_success_model/payment_success_model.dart';
import '../Models/wallet_check_balance_model.dart';

class CustomerApiProvider {
  final QueryProvider _queryProvider = QueryProvider();

  /// =============== Mechanics List Emergency ================== ///

  Future<MechanicListMdl> postFindMechanicsListEmergencyRequest(
      token, page, size, latitude, longitude, serviceId, serviceType) async {
    Map<String, dynamic> _resp =
        await _queryProvider.postFindMechanicsListEmergencyRequest(
            token, page, size, latitude, longitude, serviceId, serviceType);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = MechanicListMdl(
            status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return MechanicListMdl.fromJson(data);
      }
    } else {
      final errorMsg = MechanicListMdl(
          status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }

  /// =============== Mechanics Profile Details ================== ///

  Future<MechanicDetailsMdl> fetchMechanicProfileDetails(
    token,
    mechanicId,
    serviceId,
    latitude,
    longitude,
  ) async {
    Map<String, dynamic> _resp =
        await _queryProvider.fetchMechanicProfileDetails(
      token,
      mechanicId,
      serviceId,
      latitude,
      longitude,
    );
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = MechanicDetailsMdl(
            status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return MechanicDetailsMdl.fromJson(data);
      }
    } else {
      final errorMsg = MechanicDetailsMdl(
          status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }

  /// =============== Mechanics Regular Service Booking Id  ================== ///

  Future<MechanicBookingMdl> postMechanicsRegularServiceBookingIDRequest(
      token,
      date,
      time,
      latitude,
      longitude,
      serviceId,
      mechanicId,
      reqType,
      regularServiceType,
      totalPrice,
      paymentType,
      travelTime) async {
    Map<String, dynamic> _resp =
        await _queryProvider.postMechanicsRegularServiceBookingIDRequest(
            token,
            date,
            time,
            latitude,
            longitude,
            serviceId,
            mechanicId,
            reqType,
            regularServiceType,
            totalPrice,
            paymentType,
            travelTime);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = MechanicBookingMdl(
            status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return MechanicBookingMdl.fromJson(data);
      }
    } else {
      final errorMsg = MechanicBookingMdl(
          status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }

  /// =============== Mechanics Emergency Service Booking Id  ================== ///

  Future<EmergencyBookingMdl> postMechanicsEmergencyServiceBookingIDRequest(
      token,
      date,
      time,
      latitude,
      longitude,
      serviceId,
      mechanicId,
      reqType,
      totalPrice,
      paymentType,
      travelTime) async {
    Map<String, dynamic> _resp =
        await _queryProvider.postMechanicsEmergencyServiceBookingIDRequest(
            token,
            date,
            time,
            latitude,
            longitude,
            serviceId,
            mechanicId,
            reqType,
            totalPrice,
            paymentType,
            travelTime);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = EmergencyBookingMdl(
            status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return EmergencyBookingMdl.fromJson(data);
      }
    } else {
      final errorMsg = EmergencyBookingMdl(
          status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }

  /// =============== Update Mechanic Booking Id  ================== ///

  Future<UpdateMechanicBookingMdl> postUpdateMechanicsBookingIDRequest(
    token,
    bookingId,
    mechanicId,
  ) async {
    Map<String, dynamic> _resp =
        await _queryProvider.postUpdateMechanicsBookingIDRequest(
      token,
      bookingId,
      mechanicId,
    );
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = UpdateMechanicBookingMdl(
            status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return UpdateMechanicBookingMdl.fromJson(data);
      }
    } else {
      final errorMsg = UpdateMechanicBookingMdl(
          status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }

  /// ===============  Booking Details  ================== ///

  Future<BookingDetailsMdl> postBookingDetailsRequest(
    token,
    bookingId,
  ) async {
    Map<String, dynamic> _resp = await _queryProvider.postBookingDetailsRequest(
      token,
      bookingId,
    );
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = BookingDetailsMdl(
            status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return BookingDetailsMdl.fromJson(data);
      }
    } else {
      final errorMsg = BookingDetailsMdl(
          status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }

  Future<CustomerAddMoreServiceMdl> postCustomerAddMoreServiceUpdate(
      token, bookingId, serviceIds, totalPrice, travelTime) async {
    Map<String, dynamic> _resp =
        await _queryProvider.postCustomerAddMoreServiceUpdate(
            token, bookingId, serviceIds, totalPrice, travelTime);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = CustomerAddMoreServiceMdl(
            status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return CustomerAddMoreServiceMdl.fromJson(data);
      }
    } else {
      final errorMsg = CustomerAddMoreServiceMdl(
          status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }

  Future<CustomerActiveServiceUpdateMdl> postCustomerActiveServiceRequest(
      token, userId) async {
    Map<String, dynamic> _resp =
    await _queryProvider.postCustomerActiveServiceRequest(
        token, userId);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = CustomerActiveServiceUpdateMdl(
            status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return CustomerActiveServiceUpdateMdl.fromJson(data);
      }
    } else {
      final errorMsg = CustomerActiveServiceUpdateMdl(
          status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }

  Future<ServiceSearchListAllMdl> postSearchServiceRequest(
      token, serviceSearch, catSearch, count, categoryId) async {
    Map<String, dynamic> _resp = await _queryProvider.postSearchServiceRequest(
        token, serviceSearch, catSearch, count, categoryId);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = ServiceSearchListAllMdl(
            status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return ServiceSearchListAllMdl.fromJson(data);
      }
    } else {
      final errorMsg = ServiceSearchListAllMdl(
          status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }

  Future<CustVehicleListMdl> postCustVehicleListRequest(token) async {
    Map<String, dynamic> _resp =
        await _queryProvider.postCustVehicleListRequest(
      token,
    );

    print('$_resp >>>>>>>>>>>>>>>>>>+++++++++++++++++++_resp');
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = CustVehicleListMdl(
            status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return CustVehicleListMdl.fromJson(data);
      }
    } else {
      final errorMsg = CustVehicleListMdl(
          status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }

  Future<AddRatingMdl> postAddMechanicReviewAndRatingRequest(
    token,
    rating,
    feedback,
    bookingId,
  ) async {
    Map<String, dynamic> _resp =
        await _queryProvider.postAddMechanicReviewAndRatingRequest(
      token,
      rating,
      feedback,
      bookingId,
    );

    print('$_resp >>>>>>>>>>>>>>>>>>+++++++++++++++++++_resp');
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = AddRatingMdl(
            status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return AddRatingMdl.fromJson(data);
      }
    } else {
      final errorMsg = AddRatingMdl(
          status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }

  Future<CategoryListHomeMdl> getCategoryListHomeRequest(
      String token, categoryId, serviceSearch, catSearch) async {
    Map<String, dynamic> _resp = await _queryProvider.categoryListHome(
        token, categoryId, serviceSearch, catSearch);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = CategoryListHomeMdl(
            status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return CategoryListHomeMdl.fromJson(data);
      }
    } else {
      final errorMsg = CategoryListHomeMdl(
          status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }

  Future<CustomerCompletedOrdersListMdl> postCustomerCompletedOrdersRequest(
      token, count, recent, customerId) async {
    Map<String, dynamic> _resp = await _queryProvider
        .postCustomerCompletedOrdersRequest(token, count, recent, customerId);
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = CustomerCompletedOrdersListMdl(
            status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return CustomerCompletedOrdersListMdl.fromJson(data);
      }
    } else {
      final errorMsg = CustomerCompletedOrdersListMdl(
          status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }

  /// spare parts api provider

  Future<CustVehicleListMdl> fetchServicespareparts() async {
    Map<String, dynamic> _resp = await _queryProvider.fetchServicespareparts();
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = CustVehicleListMdl(
            status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return CustVehicleListMdl.fromJson(data);
      }
    } else {
      final errorMsg = CustVehicleListMdl(
          status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }

  /// spare partslist api provider

  Future<SparePartsListModel> fetchServicesparepartslist(
      model, search, fromcost, tocost, sort) async {
    Map<String, dynamic> _resp = await _queryProvider
        .fetchServicesparepartslist(model, search, fromcost, tocost, sort);
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = SparePartsListModel(
            status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return SparePartsListModel.fromMap(data);
      }
    } else {
      final errorMsg = SparePartsListModel(
          status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }

  /// addcart api provider

  Future<AddCartModel> fetchServiceaddcart(productid) async {
    Map<String, dynamic> _resp =
        await _queryProvider.fetchServiceaddcart(productid);
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = AddCartModel(
            status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return AddCartModel.fromMap(data);
      }
    } else {
      final errorMsg = AddCartModel(
          status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }

  /// cartlist api provider

  Future<CartListModel> fetchServicecartlist() async {
    Map<String, dynamic> _resp = await _queryProvider.fetchServicecartlist();
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = CartListModel(
            status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return CartListModel.fromMap(data);
      }
    } else {
      final errorMsg = CartListModel(
          status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }

  /// delete cart
  Future<DeleteCartModel> fetchServicedeletelist(
      productid, quantity, status) async {
    Map<String, dynamic> _resp = await _queryProvider.fetchServicedeletelist(
        productid, quantity, status);
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = DeleteCartModel(
            status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return DeleteCartModel.fromMap(data);
      }
    } else {
      final errorMsg = DeleteCartModel(
          status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }

  /// address
  Future<AddressModel> fetchServiceaddresslist() async {
    Map<String, dynamic> _resp = await _queryProvider.fetchServiceaddresslist();
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = AddressModel(
            status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return AddressModel.fromMap(data);
      }
    } else {
      final errorMsg = AddressModel(
          status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }

  /// add address
  Future<AddAddressModel> fetchaddaddresslist(
    fullname,
    phone,
    pincode,
    city,
    state,
    address,
    addressline2,
    type,
  ) async {
    Map<String, dynamic> _resp = await _queryProvider.fetchaddaddresslist(
      fullname,
      phone,
      pincode,
      city,
      state,
      address,
      addressline2,
      type,
    );
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = AddAddressModel(
            status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return AddAddressModel.fromMap(data);
      }
    } else {
      final errorMsg = AddAddressModel(
          status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }

  /// edit address
  Future<AddAddressModel> fetcheditaddresslist(fullname, phone, pincode, city,
      state, address, addressline2, type, isdefault, addressid) async {
    Map<String, dynamic> _resp = await _queryProvider.fetcheditaddresslist(
        fullname,
        phone,
        pincode,
        city,
        state,
        address,
        addressline2,
        type,
        isdefault,
        addressid);
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = AddAddressModel(
            status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return AddAddressModel.fromMap(data);
      }
    } else {
      final errorMsg = AddAddressModel(
          status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }

  /// delete address
  Future<DeleteAddressModel> fetchServicedeleteaddresslist(
      addressid, status) async {
    Map<String, dynamic> _resp =
        await _queryProvider.fetchServicedeleteaddresslist(addressid, status);
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = DeleteAddressModel(
            status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return DeleteAddressModel.fromMap(data);
      }
    } else {
      final errorMsg = DeleteAddressModel(
          status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }

  /// placeorder
  Future<PlaceOrderModel> fetchServiceplaceorderlist(
      qty, totprice, productid, addressid) async {
    Map<String, dynamic> _resp = await _queryProvider
        .fetchServiceplaceorderlist(qty, totprice, productid, addressid);
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = PlaceOrderModel(
            status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return PlaceOrderModel.fromMap(data);
      }
    } else {
      final errorMsg = PlaceOrderModel(
          status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }

  /// orderlist
  Future<OrderDetails> fetchServiceorderdetailslist() async {
    Map<String, dynamic> _resp =
        await _queryProvider.fetchServiceorderdetailslist();
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = OrderDetails(
            status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return OrderDetails.fromMap(data);
      }
    } else {
      final errorMsg = OrderDetails(
          status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }

  /// cancelorder
  Future<CancelOrder> fetchcancelorderlist(orderid) async {
    Map<String, dynamic> _resp =
        await _queryProvider.fetchcacncelorder(orderid);
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg =
            CancelOrder(status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return CancelOrder.fromMap(data);
      }
    } else {
      final errorMsg = CancelOrder(
          status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }

  /// cod
  Future<Codmodel> fetchcodlist(amount, orderid) async {
    Map<String, dynamic> _resp =
        await _queryProvider.fetchcodapprove(amount, orderid);
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg =
            Codmodel(status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return Codmodel.fromMap(data);
      }
    } else {
      final errorMsg = Codmodel(
          status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }

  /// wallethistorymerchant
  Future<WalletistoryModel> fetchwallethistory(date) async {
    Map<String, dynamic> _resp = await _queryProvider.fetchwallethistory(date);
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = WalletistoryModel(
            status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return WalletistoryModel.fromMap(data);
      }
    } else {
      final errorMsg = WalletistoryModel(
          status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }

  /// customerrating
  Future<CustomerRatingModel> fetchcustrating(
      rating, orderid, productid) async {
    Map<String, dynamic> _resp =
        await _queryProvider.fetchcustrating(rating, orderid, productid);
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = CustomerRatingModel(
            status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return CustomerRatingModel.fromMap(data);
      }
    } else {
      final errorMsg = CustomerRatingModel(
          status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }

  /// =============== Customer My Wallet ================== ///

  Future<CustomerWalletDetailModel> fetchcustomerwallet(/*date*/) async {
    Map<String, dynamic> _resp =
        await _queryProvider.fetchcustomerwallet(/*date*/);
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = CustomerWalletDetailModel(
            status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return CustomerWalletDetailModel.fromMap(data);
      }
    } else {
      final errorMsg = CustomerWalletDetailModel(
          status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }

  /// placeorderallitem
  Future<PlaceOrderModel> placeorderallitem(addressid) async {
    Map<String, dynamic> _resp =
        await _queryProvider.fetchServiceplaceorderallitemlist(addressid);
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = PlaceOrderModel(
            status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return PlaceOrderModel.fromMap(data);
      }
    } else {
      final errorMsg = PlaceOrderModel(
          status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }

  ///----- Customer Notification List----------///

  Future<NotificationModel> customernotification() async {
    Map<String, dynamic> _resp =
        await _queryProvider.fetchcustomernotification();
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = NotificationModel(
            status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return NotificationModel.fromMap(data);
      }
    } else {
      final errorMsg = NotificationModel(
          status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }

  ///----- Customer Payment Success----------///

  Future<PaymentSuccessModel> fetchpaymentsucess(
      transtype, amount, paymenttype, transid, orderid) async {
    Map<String, dynamic> _resp = await _queryProvider.fetchpaymentsucess(
        transtype, amount, paymenttype, transid, orderid);
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = PaymentSuccessModel(
            status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return PaymentSuccessModel.fromMap(data);
      }
    } else {
      final errorMsg = PaymentSuccessModel(
          status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }


  ///----- wallet balance response----------///

  Future<WalletCheckBalanceModel> fetchwalletcheckbalance(
      bookingid) async {
    Map<String, dynamic> _resp = await _queryProvider.fetchwalletcheckbalance(bookingid);
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = WalletCheckBalanceModel(
            status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return WalletCheckBalanceModel.fromMap(data);
      }
    } else {
      final errorMsg = WalletCheckBalanceModel(
          status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }


  /// checkout api
  Future<NewCheckoutModel> newcheckoutapi( cartid, addressid
      ) async {
    Map<String, dynamic> _resp =
    await _queryProvider.newcheckoutapi(cartid, addressid);
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg = NewCheckoutModel(
            status: "error", message: _resp['message'], data: null);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return NewCheckoutModel.fromMap(data);
      }
    } else {
      final errorMsg = NewCheckoutModel(
          status: "error", message: "No Internet connection", data: null);
      return errorMsg;
    }
  }
}
