import 'package:auto_fix/ApiProvider/customer_apiProvider.dart';
import 'package:auto_fix/ApiProvider/mechanic_api_provider.dart';
import 'package:auto_fix/Constants/GlobelTime/timeApiProvider.dart';
import 'package:auto_fix/Constants/GlobelTime/timeMdl.dart';
import 'package:auto_fix/Models/cod_model/cod_model.dart';
import 'package:auto_fix/Models/customer_models/add_address_model/add_address_model.dart';
import 'package:auto_fix/Models/customer_models/add_cart_model/add_cart_model.dart';
import 'package:auto_fix/Models/customer_models/cancel_order_module/cancel_order_module.dart';
import 'package:auto_fix/Models/customer_models/cart_list_model/cart_list_model.dart';
import 'package:auto_fix/Models/customer_models/delete_address_model/delete_address_model.dart';
import 'package:auto_fix/Models/customer_models/get_address_model/get_address_model.dart';
import 'package:auto_fix/Models/customer_models/order_list_model/order_list_model.dart';
import 'package:auto_fix/Models/customer_models/place_order_model/place_order_model.dart';
import 'package:auto_fix/Models/customer_models/spare_parts_list_model/spare_parts_list_model.dart';
import 'package:auto_fix/Models/customer_models/spare_parts_model/spare_parts_model.dart';
import 'package:auto_fix/Models/customer_rating_model/customer_rating_model.dart';
import 'package:auto_fix/Models/customer_wallet_detail_model/customer_wallet_detail_model.dart';
import 'package:auto_fix/Models/delete_cart_model/delete_cart_model.dart';
import 'package:auto_fix/Models/notification_model/notification_model.dart';
import 'package:auto_fix/Models/wallet_history_model/wallet_history_model.dart';
import 'package:auto_fix/UI/Common/FcmTokenUpdate/fcm_token_update_api_provider.dart';
import 'package:auto_fix/UI/Common/GenerateAuthorization/generate_athorization_api_provider.dart';
import 'package:auto_fix/UI/Customer/BottomBar/MyProfile/customer_profile_api_provider.dart';
import 'package:auto_fix/UI/Customer/SideBar/EditProfile/ChangePassword/change_password_api_provider.dart';
import 'package:auto_fix/UI/Customer/SideBar/EditProfile/customer_edit_profile_api_provider.dart';
import 'package:auto_fix/UI/Customer/SideBar/MyVehicles/CustVehicleListMdl.dart';
import 'package:auto_fix/UI/Mechanic/BottomBar/AddPriceFault/add_price_fault_api_provider.dart';
import 'package:auto_fix/UI/Mechanic/BottomBar/MyProfile/profile_Mechanic_api_provider/mechanic_profile_api_provider.dart';
import 'package:auto_fix/UI/Mechanic/RegularServiceMechanicFlow/CommonScreensInRegular/ServiceStatusUpdate/service_status_update_api_provider.dart';
import 'package:auto_fix/UI/Mechanic/SideBar/MyJobReview/my_job_review_api_provider.dart';
import 'package:auto_fix/UI/Mechanic/SideBar/MyWallet/my_wallet_api_provider.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/AddServices/add_services_api_provider.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/CategoryList/category_list_api_provider.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/CompleteProfile/mechanic_complete_profile_api_provider.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/ServiceList/service_list_api_provider.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/ForgotPassword/ResetPasswordScreen/create_password_api_provider.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/ForgotPassword/forgot_password_api_provider.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signin/signin_api_provider.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signup/signup_api_provider.dart';
import '../UI/Mechanic/RegularServiceMechanicFlow/CommonScreensInRegular/ServiceDetailsScreen/mech_service_api_provider.dart';
import '../UI/WelcomeScreens/Login/CompleteProfile/Customer/add_car_api_provider.dart';
import '../UI/WelcomeScreens/Login/CompleteProfile/Mechanic/vechicleSpecialization/vehicleSpecialization_api_provider.dart';

class Repository {
  final _customerApiProvider = CustomerApiProvider();
  final _mechanicApiProvider = MechanicApiProvider();

  final _signupApiProvider = SignupApiProvider();
  final _customerFetchProfileApiProvider = CustomerProfileApiProvider();
  final _mechanicProfileApiProvider = MechanicProfileApiProvider();

  final _customerEditProfileApiProvider = CustomerEditProfileApiProvider();
  final _addCarApiProvider = AddCarApiProvider();
  final _vehicleSpecializationApiProvider = vehicleSpecializationApiProvider();

  final _signinApiProvider = SigninApiProvider();
  final _forgotPasswordApiProvider = ForgotPasswordApiProvider();
  final _createPasswordApiProvider = ResetPasswordApiProvider();
  final _changePasswordApiProvider = ChangePasswordApiProvider();
  final _fcmTokenUpdateApiProvider = FcmTokenUpdateApiProvider();
  final _genrateAuthorizationApiProvider = GenerateAuthorizationApiProvider();
  final _completeProfileMechanicApiProvider =
      MechanicCompleteProfileApiProvider();
  final _serviceListApiProvider = ServiceListApiProvider();
  final _addServiceListApiProvider = AddServicesApiProvider();
  final _addMechanicMyWalletApiProvider = MechanicMyWalletApiProvider();
  final _addMechanicMyJobReviewApiProvider = MechanicMyJobReviewApiProvider();

  final _categoryListApiProvider = CategoryListApiProvider();
  final _AddPriceFaultApiProvider = AddPriceFaultApiProvider();
  final _MechServiceDetailsApiProvider = MechServiceDetailsApiProvider1();
  final _serviceStatusUpdateApiProvider = ServiceStatusUpdateApiProvider();

  final _sparepartsprovider = CustomerApiProvider();
  final _sparepartslistprovider = CustomerApiProvider();
  final _addcartprovider = CustomerApiProvider();
  final _cartlistprovider = CustomerApiProvider();
  final _deleteprovider = CustomerApiProvider();
  final _addressprovider = CustomerApiProvider();
  final _editaddressprovider = CustomerApiProvider();
  final _deleteaddressprovider = CustomerApiProvider();
  final _placeorderprovider=CustomerApiProvider();
  final _orderlistprovider=CustomerApiProvider();
  final _cancelorderprovider=CustomerApiProvider();
  final _codprovider=CustomerApiProvider();
  final _wallethistoryprovider=CustomerApiProvider();
  final _customerratingprovider=CustomerApiProvider();
  final _notificationprovider = CustomerApiProvider();
  final _vendornotificationprovider = MechanicApiProvider();
  final _apiTimeProvider = WorldTimeApiProvider();

  // Add Mechanic Service List
  Future<dynamic> getServiceList(String token, categoryId, search, catSearch) =>
      _serviceListApiProvider.getServiceListRequest(
          token, categoryId, search, catSearch);

  // Service List
  Future<dynamic> getAddMechanicServiceList(String token, String serviceList,
          String timeList, String costList, catType) =>
      _addServiceListApiProvider.getMechanicAddServiceListRequest(
          token, serviceList, timeList, costList, catType);

  //  Category List
  Future<dynamic> getCategoryList(
          String token, searchText, count, categoryId) =>
      _categoryListApiProvider.getCategoryListRequest(
          token, searchText, count, categoryId);

  //  Category List Home Request
  Future<dynamic> getCategoryListHomeRequest(
          String token, categoryId, serviceSearch, catSearch) =>
      _customerApiProvider.getCategoryListHomeRequest(
          token, categoryId, serviceSearch, catSearch);

  // SignUp
  Future<dynamic> signUp(
    type,
    firstName,
    lastName,
    emailId,
    phoneNo,
    password,
    state,
    fcmToken,
    userTypeId,
    userType,
    profilepic,
    orgName,
    orgType,
    ministryName,
    hod,
    latitude,
    longitude,
    yearExp,
    shopName,
  ) =>
      _signupApiProvider.signUp(
        type,
        firstName,
        lastName,
        emailId,
        phoneNo,
        password,
        state,
        fcmToken,
        userTypeId,
        userType,
        profilepic,
        orgName,
        orgType,
        ministryName,
        hod,
        latitude,
        longitude,
        yearExp,
        shopName,
      );

  //AddCar Of Customer
  Future<dynamic> postAddCarRequest(
    token,
    brand,
    model,
    engine,
    year,
    plateNo,
    lastMaintenance,
    milege,
    vehiclePic,
    color,
    latitude,
    longitude,
  ) =>
      _addCarApiProvider.postAddCarRequest(
        token,
        brand,
        model,
        engine,
        year,
        plateNo,
        lastMaintenance,
        milege,
        vehiclePic,
        color,
        latitude,
        longitude,
      );

  //Update Default Vehicle
  Future<dynamic> postUpdateDefaultVehicle(token, vehicleId, customerId) =>
      _addCarApiProvider.postUpdateDefaultVehicle(token, vehicleId, customerId);

  //Otp Verification
  Future<dynamic> postOtpVerificationRequest(token, otp, userTypeId) =>
      _signupApiProvider.postOtpVerificationRequest(token, otp, userTypeId);

  //Phone Login Otp Verification
  Future<dynamic> postPhoneLoginOtpVerificationRequest(
          token, otp, userTypeId) =>
      _signupApiProvider.postPhoneLoginOtpVerificationRequest(
          token, otp, userTypeId);

  /// =============== Mechanics Regular Service Booking Id  ================== ///

  Future<dynamic> postMechanicsRegularServiceBookingIDRequest(
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
          travelTime) =>
      _customerApiProvider.postMechanicsRegularServiceBookingIDRequest(
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

  /// =============== Mechanics Emergency Service Booking Id  ================== ///

  Future<dynamic> postMechanicsEmergencyServiceBookingIDRequest(
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
          travelTime) =>
      _customerApiProvider.postMechanicsEmergencyServiceBookingIDRequest(
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

  /// =============== Update Mechanic Booking Id  ================== ///

  Future<dynamic> postUpdateMechanicsBookingIDRequest(
    token,
    bookingId,
    mechanicId,
  ) =>
      _customerApiProvider.postUpdateMechanicsBookingIDRequest(
        token,
        bookingId,
        mechanicId,
      );

  /// ===============  Booking Details  ================== ///

  Future<dynamic> postBookingDetailsRequest(
    token,
    bookingId,
  ) =>
      _customerApiProvider.postBookingDetailsRequest(
        token,
        bookingId,
      );

  /// =============== Mechanics List Emergency ================== ///

  Future<dynamic> postFindMechanicsListEmergencyRequest(
          token, page, size, latitude, longitude, serviceId, serviceType) =>
      _customerApiProvider.postFindMechanicsListEmergencyRequest(
          token, page, size, latitude, longitude, serviceId, serviceType);

  /// =============== Mechanics Profile Details ================== ///

  Future<dynamic> fetchMechanicProfileDetails(
    token,
    mechanicId,
    serviceId,
    latitude,
    longitude,
  ) =>
      _customerApiProvider.fetchMechanicProfileDetails(
        token,
        mechanicId,
        serviceId,
        latitude,
        longitude,
      );

  // Search Service Request
  Future<dynamic> postSearchServiceRequest(
          token, serviceSearch, catSearch, count, categoryId) =>
      _customerApiProvider.postSearchServiceRequest(
          token, serviceSearch, catSearch, count, categoryId);

  // Make Brand List
  Future<dynamic> postMakeBrandRequest(
    token,
  ) =>
      _addCarApiProvider.postMakeBrandRequest(
        token,
      );

  // Model Detail List
  Future<dynamic> postModelDetailRequest(token, type) =>
      _addCarApiProvider.postModelDetailRequest(token, type);

  // Model Detail List
  Future<dynamic> postVechicleUpdateRequest(token, id, status) =>
      _addCarApiProvider.postVechicleUpdateRequest(token, id, status);

  // Mechanic My Wallet
  Future<dynamic> postMechanicFetchMyWalletRequest(token, type) =>
      _addMechanicMyWalletApiProvider.postMechanicMyWalletRequest(token, type);

  // Mechanic My Job Review
  Future<dynamic> postMechanicFetchMyJobReviewRequest(token, type) =>
      _addMechanicMyJobReviewApiProvider.postMechanicMyJobReviewRequest(
          token, type);

  // Mechanic Individual Complete Profile
  Future<dynamic> getCompleteProfileMechIndividual(
          String token,
          String workSelection,
          String vehicleSpecialization,
          String address,
          String apprentice_cert,
          String identification_cert,
          String photoUrl) =>
      _completeProfileMechanicApiProvider
          .getCompleteProfileMechIndividualRequest(
              token,
              workSelection,
              vehicleSpecialization,
              address,
              apprentice_cert,
              identification_cert,
              photoUrl);

  // Mechanic Corporate Complete Profile
  Future<dynamic> getCompleteProfileMechCorporate(
          token,
          serviceType,
          vehicleSpecialization,
          address,
          mechanicNumber,
          rcNumber,
          existenceYear,
          photoUrl) =>
      _completeProfileMechanicApiProvider
          .getCompleteProfileMechCorporateRequest(
              token,
              serviceType,
              vehicleSpecialization,
              address,
              mechanicNumber,
              rcNumber,
              existenceYear,
              photoUrl);

  // Get State
  Future<dynamic> getStateList() => _signupApiProvider.getStates();

  Future<dynamic> postBrandDetailsRequest(token, search) =>
      _vehicleSpecializationApiProvider.postBrandDetailsRequest(token, search);

  // Get vehicleSpecialization
  Future<dynamic> getvehicleSpecializationList() =>
      _vehicleSpecializationApiProvider.getVehicleSpecialization();

  //SignIn
  Future<dynamic> getSignIn(String userName, String password) =>
      _signinApiProvider.getSignInRequest(userName, password);

  //socialLogin
  Future<dynamic> socialLogin(email, phoneNumber) =>
      _signinApiProvider.socialLogin(email, phoneNumber);

  //phoneLogin
  Future<dynamic> phoneLogin(phoneNumber) =>
      _signinApiProvider.phoneLogin(phoneNumber);

  //Forgot Password
  Future<dynamic> getForgotPassword(String email) =>
      _forgotPasswordApiProvider.getForgotPasswordRequest(email);

  //Reset Password
  Future<dynamic> getCreatePassword(
          String otp, String newPassword, String confirmPassword) =>
      _createPasswordApiProvider.getCreatePasswordRequest(
          otp, newPassword, confirmPassword);

  //Change Password
  Future<dynamic> getChangePassword(String token, String email,
          String oldPassword, String newPassword, String confirmPassword) =>
      _changePasswordApiProvider.getChangePasswordRequest(
          token, email, oldPassword, newPassword, confirmPassword);

  //FcmTokenUpdate
  Future<dynamic> getcmTokenUpdateRequest(String fcm, String Authtoken) =>
      _fcmTokenUpdateApiProvider.getfcmTokenUpdateRequest(fcm, Authtoken);

  //get Token
  Future<dynamic> getToken(String userId, int type) =>
      _genrateAuthorizationApiProvider.getGenerateAuthorizationRequest(
          userId, type);

  // Fetch Profile Customer Request
  Future<dynamic> postCustFetchProfileRequest(token, id) =>
      _customerFetchProfileApiProvider.postCustFetchProfileRequest(token, id);

  // Fetch Mechanic Online Offline Request
  Future<dynamic> postMechanicOnlineOfflineRequest(
          token, String status, String mechanicId) =>
      _mechanicApiProvider.postMechanicOnlineOfflineRequest(
          token, status, mechanicId);

  // Fetch Mechanic Mechanic Location Update Request
  Future<dynamic> postMechanicLocationUpdateRequest(
          token, mechanicId, lat, lng) =>
      _mechanicApiProvider.postMechanicLocationUpdateRequest(
          token, mechanicId, lat, lng);

  // Fetch Mechanic Mechanic Brand Specialization Request
  Future<dynamic> postMechanicBrandSpecializationRequest(token, brandName) =>
      _mechanicApiProvider.postMechanicBrandSpecializationRequest(
          token, brandName);

  // Fetch Mechanic Upcoming Service Request
  Future<dynamic> postMechanicUpComingServiceRequest(token, type, mechanicId) =>
      _mechanicApiProvider.postMechanicUpcomingServiceRequest(
          token, type, mechanicId);

  // Fetch Mechanic Active Service Request
  Future<dynamic> postMechanicActiveServiceRequest(token, mechanicId) =>
      _mechanicApiProvider.postMechanicActiveServiceRequest(token, mechanicId);

  // Fetch Mechanic Online Offline Request
  Future<dynamic> postMechanicIncomingRequestUpdate(
          token, bookingId, bookStatus) =>
      _mechanicApiProvider.postMechanicIncomingJobUpdateRequest(
          token, bookingId, bookStatus);

  // Fetch Mechanic Add additional time Request
  Future<dynamic> postMechanicAddTimeUpdate(
    token,
    extendTime,
    bookingId,
  ) =>
      _mechanicApiProvider.postMechanicAddTimeUpdateRequest(
        token,
        extendTime,
        bookingId,
      );

  // Fetch Customer Add More Service Request
  Future<dynamic> postCustomerAddMoreServiceUpdate(
          token, bookingId, serviceIds, totalPrice, travelTime) =>
      _customerApiProvider.postCustomerAddMoreServiceUpdate(
          token, bookingId, serviceIds, totalPrice, travelTime);

  // Fetch Mechanic Service Status Update
  Future<dynamic> postMechanicOrderStatusUpdate(token, bookingId, bookStatus) =>
      _mechanicApiProvider.postMechanicOrderStatusUpdate(
          token, bookingId, bookStatus);

  // Fetch Regular Service Status Update
  Future<dynamic> postServiceStatusUpdateRequest(
          token, bookingId, bookStatus) =>
      _serviceStatusUpdateApiProvider.postRegularServiceStatusUpdate(
          token, bookingId, bookStatus);

  // Fetch Profile Mechanic Request
  Future<dynamic> postMechanicFetchProfileRequest(token, userId) =>
      _mechanicProfileApiProvider.postMechanicFetchProfileRequest(
          token, userId);

  // Edit Profile Mechanic Individual Request
  Future<dynamic> postMechanicEditProfileIndividualRequest(
    token,
    firstName,
    lastName,
    state,
    profilepic,
    status,
    year_of_experience,
  ) =>
      _mechanicProfileApiProvider.postMechanicEditProfileIndividualRequest(
        token,
        firstName,
        lastName,
        state,
        profilepic,
        status,
        year_of_experience,
      );

  // Edit Profile Mechanic Corporate Request
  Future<dynamic> postMechanicEditProfileCorporateRequest(
    token,
    firstName,
    lastName,
    state,
    profilepic,
    status,
    year_of_experience,
    org_Name,
    org_Type,
  ) =>
      _mechanicProfileApiProvider.postMechanicEditProfileCorporateRequest(
        token,
        firstName,
        lastName,
        state,
        profilepic,
        status,
        year_of_experience,
        org_Name,
        org_Type,
      );

  // Update Customer - individual Profile Request
  Future<dynamic> postCustIndividualEditProfileRequest(
          String token, firstName, lastName, state, status, imageUrl) =>
      _customerEditProfileApiProvider.postCustIndividualEditProfileRequest(
          token, firstName, lastName, state, status, imageUrl);

  // Update Customer - corporate Profile Request
  Future<dynamic> postCustCorporateEditProfileRequest(String token, firstName,
          lastName, state, status, imageUrl, orgName, orgType) =>
      _customerEditProfileApiProvider.postCustCorporateEditProfileRequest(token,
          firstName, lastName, state, status, imageUrl, orgName, orgType);

  // Update Customer - government Profile Request
  Future<dynamic> postCustGovernmentEditProfileRequest(String token, firstName,
          lastName, state, status, imageUrl, ministryName) =>
      _customerEditProfileApiProvider.postCustGovernmentEditProfileRequest(
          token, firstName, lastName, state, status, imageUrl, ministryName);

  //  Vehicle List Request
  Future<dynamic> postCustVehicleListRequest(token) =>
      _customerApiProvider.postCustVehicleListRequest(token);

  Future<dynamic> postAddMechanicReviewAndRatingRequest(
    token,
    rating,
    feedback,
    bookingId,
  ) =>
      _customerApiProvider.postAddMechanicReviewAndRatingRequest(
        token,
        rating,
        feedback,
        bookingId,
      );

  /// ===============  Service List of Mechanic ================== ///
  Future<dynamic> fetchServiceListOfMechanic(
          token, mechanicId, page, size, search) =>
      _mechanicApiProvider.fetchServiceListOfMechanic(
          token, mechanicId, page, size, search);

  // add price and fault
  Future<dynamic> postAddFetchPriceFaultReviewRequest(token, mechanicId) =>
      _AddPriceFaultApiProvider.postAddPriceFaultReviewRequest(
          token, mechanicId);

  // update price and fault
  Future<dynamic> postUpdateAddPriceFaultReviewRequest(
          token, mechanicId, time, fee, serviceId) =>
      _AddPriceFaultApiProvider.postUpdateAddPriceFaultReviewRequest(
          token, mechanicId, time, fee, serviceId);

// emergency and regular services
  Future<dynamic> postEmrgRegAddPriceReviewRequest(
          token, page, size, search, userId, catType) =>
      _AddPriceFaultApiProvider.postEmrgRegAddPriceReviewRequest(
          token, page, size, search, userId, catType);

  Future<dynamic> postCustomerCompletedOrdersRequest(
          token, count, recent, customerId) =>
      _customerApiProvider.postCustomerCompletedOrdersRequest(
          token, count, recent, customerId);

  Future<dynamic> postGetMechServiceDetailsReviewRequest(token, bookingId) =>
      _MechServiceDetailsApiProvider.postMechServiceDetailsRequest(
          token, bookingId);

  Future<dynamic> postTimeServicePriceAddReviewRequest(
          token, services, fee, time, catType) =>
      _AddPriceFaultApiProvider.postTimePriceServiceDetailsRequest(
          token, services, fee, time, catType);

  Future<CustVehicleListMdl> getspareparts() =>
      _sparepartsprovider.fetchServicespareparts();

  Future<SparePartsListModel> getsparepartslist(
          modelname, search, fromcost, tocost, sort) =>
      _sparepartslistprovider.fetchServicesparepartslist(
          modelname, search, fromcost, tocost, sort);

  Future<AddCartModel> addcart(productid) =>
      _addcartprovider.fetchServiceaddcart(productid);

  Future<CartListModel> cartlist() => _cartlistprovider.fetchServicecartlist();

  Future<DeleteCartModel> deletecart(productid, quantity, status) =>
      _deleteprovider.fetchServicedeletelist(productid, quantity, status);

  Future<AddressModel> addresslist() =>
      _addressprovider.fetchServiceaddresslist();

  Future<AddAddressModel> addaddresslist(
    fullname,
    phone,
    pincode,
    city,
    state,
    address,
    addressline2,
    type,
  ) =>
      _addressprovider.fetchaddaddresslist(
        fullname,
        phone,
        pincode,
        city,
        state,
        address,
        addressline2,
        type,
      );

  Future<AddAddressModel> editaddresslist(
    fullname,
    phone,
    pincode,
    city,
    state,
    address,
    addressline2,
    type,
      isdefault,addressid
  ) =>
      _editaddressprovider.fetcheditaddresslist(fullname, phone, pincode, city,
          state, address, addressline2, type, isdefault, addressid);

  Future<DeleteAddressModel> deleteaddress(addressid, status) =>
      _deleteaddressprovider.fetchServicedeleteaddresslist(addressid, status);
  Future<PlaceOrderModel> placeorder(qty,totprice,productid,addressid) =>
      _placeorderprovider.fetchServiceplaceorderlist(qty,totprice,productid,addressid);

  Future<OrderDetails> orderlist() =>
      _orderlistprovider.fetchServiceorderdetailslist();
  Future<CancelOrder> cancelorder(orderid) =>
      _cancelorderprovider.fetchcancelorderlist(orderid);

  Future<Codmodel> Cod(amount,orderid) =>
      _codprovider.fetchcodlist(amount,orderid);

  Future<WalletistoryModel> wallethistory(date) =>
      _wallethistoryprovider.fetchwallethistory(date);

  Future<CustomerWalletDetailModel> customerwallet(/*date*/) =>
      _wallethistoryprovider.fetchcustomerwallet(/*date*/);

  Future<CustomerRatingModel> custrating(rating, orderid, productid) =>
      _customerratingprovider.fetchcustrating(rating, orderid, productid);


  Future<PlaceOrderModel> placeorderallitem(addressid) =>
      _placeorderprovider.placeorderallitem(addressid);

  Future<NotificationModel> customernotification() =>
      _notificationprovider.customernotification();

  Future<NotificationModel> vendornotification() =>
      _vendornotificationprovider.vendornotification();

  Future<TimeModel> getCurrentWorldTime(parameter) =>
      _apiTimeProvider.getTimeRequest(parameter);

}
