import 'package:auto_fix/UI/Customer/Home/BottomBar/Services/Emergency/emergency_services_api_provider.dart';
import 'package:auto_fix/UI/Customer/Home/BottomBar/Services/PreBooking/MechanicList/mechanic_list_api_provider.dart';
import 'package:auto_fix/UI/Customer/Home/BottomBar/Services/Regular/regular_services_api_provider.dart';
import 'package:auto_fix/UI/Customer/Home/BottomBar/SpairParts/Ads/ads_api_provider.dart';
import 'package:auto_fix/UI/Customer/Home/SideBar/Bookings/BookingsDetails/bookings_details_api_provider.dart';
import 'package:auto_fix/UI/Customer/Home/SideBar/Bookings/BookingsList/bookings_list_api_provider.dart';
import 'package:auto_fix/UI/Customer/Home/BottomBar/SpairParts/Brands/top_brands_api_provider.dart';
import 'package:auto_fix/UI/Customer/Home/SideBar/ChangePassword/change_password_api_provider.dart';
import 'package:auto_fix/UI/Customer/Home/BottomBar/Profile/EditProfile/edit_profile_api_provider.dart';
import 'package:auto_fix/UI/Customer/Home/BottomBar/Profile/ViewProfile/view_profile_api_provider.dart';
import 'package:auto_fix/UI/Customer/Home/BottomBar/Services/SearchResult/search_result_api_provider.dart';
import 'package:auto_fix/UI/Customer/Home/BottomBar/SpairParts/Shops/top_shops_api_provider.dart';
import 'package:auto_fix/UI/Customer/Login/ForgotPassword/forgot_password_api_provider.dart';
import 'package:auto_fix/UI/Customer/Login/Signin/signin_api_provider.dart';
import 'package:auto_fix/UI/Customer/Login/Signup/signup_api_provider.dart';
import 'package:auto_fix/UI/Customer/Home/SideBar/MyVehicle/Add/Engine/all_engine_api_provider.dart';
import 'package:auto_fix/UI/Customer/Home/SideBar/MyVehicle/Add/Make/all_make_api_provider.dart';
import 'package:auto_fix/UI/Customer/Home/SideBar/MyVehicle/Add/Model/all_model_api_provider.dart';
import 'package:auto_fix/UI/Customer/Home/SideBar/MyVehicle/Add/add_vehicle_api_provider.dart';
import 'package:auto_fix/UI/Customer/Home/SideBar/MyVehicle/Delete/delete_vehicle_api_provider.dart';
import 'package:auto_fix/UI/Customer/Home/SideBar/MyVehicle/Details/vehicle_details_api_provider.dart';
import 'package:auto_fix/UI/Customer/Home/SideBar/MyVehicle/View/view_vehicle_api_provider.dart';

class Repository {
  final _signupApiProvider = SignupApiProvider();
  final _signinApiProvider = SigninApiProvider();
  final _forgotPasswordApiProvider = ForgotPasswordApiProvider();
  final _changePasswordApiProvider = ChangePasswordApiProvider();
  final _editProfileApiProvider = EditProfileApiProvider();
  final _viewProfileApiProvider = ViewProfileApiProvider();
  final _searchResultApiProvider = SearchResultApiProvider();
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
  final _regularServicesApiProvider = RegularServicesApiProvider();
  final _emergencyServicesApiProvider = EmergencyServicesApiProvider();
  final _allMechanicListApiProvider = MechanicListApiProvider();
  //SignUp
  Future<dynamic> getSignUp(String firstName, String userName, String email,
          String state, String password, String phone) =>
      _signupApiProvider.getSignUpRequest(
          firstName, userName, email, state, password, phone);
  // Get State
  Future<dynamic> getStateList() => _signupApiProvider.getStates();
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
  Future<dynamic> getSearchResult(int page, int size, String searchText) =>
      _searchResultApiProvider.getSearchResultRequest(page, size, searchText);
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
  Future<dynamic> getAddVehicle(
      String token,
          String year,
          String latitude,
          String longitude,
          String milege,
          String lastMaintenance,
          String interval,
          int makeId,
          int vehicleModelId,
          int engineId) =>
      _addVehicleApiProvider.getAddVehicleRequest(token,year, latitude, longitude,
          milege, lastMaintenance, interval, makeId, vehicleModelId, engineId);
  //Bookings List
  Future<dynamic> getBookingsList() =>
      _bookingsListApiProvider.getBookingsListRequest();
  //Bookings Details
  Future<dynamic> getBookingsDetails() =>
      _bookingsDetailsApiProvider.getBookingsDetailRequest();
  //All Model
  Future<dynamic> getAllModel(int id,String token) =>
      _allModelApiProvider.getAllModelRequest(id,token);
  //All Engine
  Future<dynamic> getAllEngine(int id, String token) =>
      _allEngineApiProvider.getAllEngineRequest(id, token);
  //All Make
  Future<dynamic> getAllMake(String token) => _allMakeApiProvider.getAllMakeRequest(token);

  //All Mechanic List
  Future<dynamic> getAllMechanicList(String token,int page, int size) =>
      _allMechanicListApiProvider.getAllMechanicListRequest(token, page, size);
  //Ads
  Future<dynamic> getAds() => _adsApiProvider.getAdsRequest();
  //Top Brands
  Future<dynamic> getTopBrands() => _topBrandsApiProvider.getTopBrandsRequest();
  //Top Shops
  Future<dynamic> getTopShops() => _topShopsApiProvider.getTopShopsRequest();
  //Regular Service
  Future<dynamic> getRegularServices(int page, int size) =>
      _regularServicesApiProvider.getRegularServicesRequest(page, size);
  //Emergency Service
  Future<dynamic> getEmerGencyServices(int page, int size) =>
      _emergencyServicesApiProvider.getEmergencyServicesRequest(page, size);
}
