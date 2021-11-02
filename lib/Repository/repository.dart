import 'package:auto_fix/UI/Home/Ads/ads_api_provider.dart';
import 'package:auto_fix/UI/Home/Bookings/BookingsDetails/bookings_details_api_provider.dart';
import 'package:auto_fix/UI/Home/Bookings/BookingsList/bookings_list_api_provider.dart';
import 'package:auto_fix/UI/Home/Brands/top_brands_api_provider.dart';
import 'package:auto_fix/UI/Home/ChangePassword/change_password_api_provider.dart';
import 'package:auto_fix/UI/Home/Profile/EditProfile/edit_profile_api_provider.dart';
import 'package:auto_fix/UI/Home/Profile/ViewProfile/view_profile_api_provider.dart';
import 'package:auto_fix/UI/Home/SearchResult/search_result_api_provider.dart';
import 'package:auto_fix/UI/Home/SelectCar/select_car_api_provider.dart';
import 'package:auto_fix/UI/Home/Shops/top_shops_api_provider.dart';
import 'package:auto_fix/UI/Home/Vehicle/Add/Engine/all_engine_api_provider.dart';
import 'package:auto_fix/UI/Home/Vehicle/Add/Make/all_make_api_provider.dart';
import 'package:auto_fix/UI/Home/Vehicle/Add/Model/all_model_api_provider.dart';
import 'package:auto_fix/UI/Home/Vehicle/Add/add_vehicle_api_provider.dart';
import 'package:auto_fix/UI/Home/Vehicle/Delete/delete_vehicle_api_provider.dart';
import 'package:auto_fix/UI/Home/Vehicle/Details/vehicle_details_api_provider.dart';
import 'package:auto_fix/UI/Home/Vehicle/View/view_vehicle_api_provider.dart';
import 'package:auto_fix/UI/Login/ForgotPassword/forgot_password_api_provider.dart';
import 'package:auto_fix/UI/Login/Signin/signin_api_provider.dart';
import 'package:auto_fix/UI/Login/Signup/signup_api_provider.dart';

class Repository {
  final _signupApiProvider = SignupApiProvider();
  final _signinApiProvider = SigninApiProvider();
  final _forgotPasswordApiProvider = ForgotPasswordApiProvider();
  final _changePasswordApiProvider = ChangePasswordApiProvider();
  final _editProfileApiProvider = EditProfileApiProvider();
  final _viewProfileApiProvider = ViewProfileApiProvider();
  final _searchResultApiProvider = SearchResultApiProvider();
  final _selectCarApiProvider = SelectCarApiProvider();
  final _viewVehicleApiProvider = ViewVehicleApiProvider();
  final _deleteVehicleApiProvider = DeleteVehicleApiProvider();
  final _vehicleDetailsApiProvider = VehicleDetailsApiProvider();
  final _addVehicleApiProvider = AddVehicleApiProvider();
  final _bookingsListApiProvider = BookingsListApiProvider();
  final _bookingsDetailsApiProvider = BookingsDetailsApiProvider();
  final _allModelApiProvider = AllModelApiProvider();
  final _allEngineApiProvider = AllEngineApiProvider();
  final _allMakeApiProvider = AllMakeApiProvider();
  final _adsApiProvider = AdsApiProvider();
  final _topBrandsApiProvider = TopBrandsApiProvider();
  final _topShopsApiProvider = TopShopsApiProvider();
  //SignUp
  Future<dynamic> getSignUp(String firstName, String userName, String email,
          String state, String password, String phone) =>
      _signupApiProvider.getSignUpRequest(
          firstName, userName, email, state, password, phone);
  //SignIn
  Future<dynamic> getSignIn(String userName, String password) =>
      _signinApiProvider.getSignInRequest(userName, password);
  //Forgot Password
  Future<dynamic> getForgotPassword(String email) =>
      _forgotPasswordApiProvider.getForgotPasswordRequest(email);
  //Change Password
  Future<dynamic> getChangePassword(String password) =>
      _changePasswordApiProvider.getChangePasswordRequest(password);
  //EditPrfile
  Future<dynamic> getEditProfile() =>
      _editProfileApiProvider.getEditProfileRequest();
  //ViewPrfile
  Future<dynamic> getViewProfile(String id) =>
      _viewProfileApiProvider.getViewProfileRequest(id);
  //Search Result
  Future<dynamic> getSearchResult() =>
      _searchResultApiProvider.getSearchResultRequest();
  //Select Car
  Future<dynamic> getSelectCar() => _selectCarApiProvider.getSelectCarRequest();
  //View Vehicle
  Future<dynamic> getViewVehicle() =>
      _viewVehicleApiProvider.getViewVehicleRequest();
  //Delete Vehicle
  Future<dynamic> getDeleteVehicle() =>
      _deleteVehicleApiProvider.getDeleteVehicleRequest();
  //Vehicle Details
  Future<dynamic> getVehicleDetails() =>
      _vehicleDetailsApiProvider.getVehicleDetailsRequest();
  //Add Vehicle
  Future<dynamic> getAddVehicle() =>
      _addVehicleApiProvider.getAddVehicleRequest();
  //Bookings List
  Future<dynamic> getBookingsList() =>
      _bookingsListApiProvider.getBookingsListRequest();
  //Bookings Details
  Future<dynamic> getBookingsDetails() =>
      _bookingsDetailsApiProvider.getBookingsDetailRequest();
  //All Model
  Future<dynamic> getAllModel() => _allModelApiProvider.getAllModelRequest();
  //All Engine
  Future<dynamic> getAllEngine() => _allEngineApiProvider.getAllEngineRequest();
  //All Make
  Future<dynamic> getAllMake() => _allMakeApiProvider.getAllMakeRequest();
  //Ads
  Future<dynamic> getAds() => _adsApiProvider.getAdsRequest();
  //Top Brands
  Future<dynamic> getTopBrands() => _topBrandsApiProvider.getTopBrandsRequest();
  //Top Shops
  Future<dynamic> getTopShops() => _topShopsApiProvider.getTopShopsRequest();
}
