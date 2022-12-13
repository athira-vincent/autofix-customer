import 'dart:async';

import 'package:auto_fix/Common/FcmTokenUpdate/fcm_token_update_bloc.dart';
import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/Constants/text_strings.dart';
import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Common/direct_payment_screen.dart';
import 'package:auto_fix/UI/Mechanic/BottomBar/Home/brand_specialization_mdl.dart';
import 'package:auto_fix/UI/Mechanic/BottomBar/Home/mechanic_home_bloc.dart';
import 'package:auto_fix/UI/Mechanic/BottomBar/Home/upcoming_services_mdl.dart';
import 'package:auto_fix/UI/Mechanic/BottomBar/MyProfile/profile_Mechanic_Bloc/mechanic_profile_bloc.dart';
import 'package:auto_fix/UI/Mechanic/EmergencyServiceMechanicFlow/CustomerApproved/customer_approved_screen.dart';
import 'package:auto_fix/AA/customer_approved_second_screen.dart';
import 'package:auto_fix/UI/Mechanic/EmergencyServiceMechanicFlow/MechanicStartService/mechanic_start_service_screen.dart';
import 'package:auto_fix/UI/Mechanic/EmergencyServiceMechanicFlow/MechanicWorkComleted/mechanic_work_completed_screen.dart';
import 'package:auto_fix/UI/Mechanic/EmergencyServiceMechanicFlow/TrackingScreens/FindYourCustomer/find_your_customer_screen.dart';
import 'package:auto_fix/UI/Mechanic/RegularServiceMechanicFlow/CommonScreensInRegular/ServiceDetailsScreen/mech_service_regular_details_screen.dart';
import 'package:auto_fix/UI/Mechanic/SideBar/MyJobReview/my_job_review_screen.dart';
import 'package:auto_fix/UI/Mechanic/SideBar/MyWallet/my_wallet_screen.dart';
import 'package:auto_fix/Widgets/snackbar_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MechanicHomeUIScreen extends StatefulWidget {
  MechanicHomeUIScreen();

  @override
  State<StatefulWidget> createState() {
    return _MechanicHomeUIScreenState();
  }
}

class _MechanicHomeUIScreenState extends State<MechanicHomeUIScreen> with WidgetsBindingObserver{
  late final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  FcmTokenUpdateBloc _fcmTokenUpdateBloc = FcmTokenUpdateBloc();

  //late FirebaseMessaging messaging;

  String authToken = "",
      mechanicId = "",
      bookingId = "",
      vehicleName = "",
      customerName = "";
  String location = 'Null, Press Button';
  String CurrentLatitude = "10.506402";
  String CurrentLongitude = "76.244164";
  String Address = '';
  String displayAddress = '';
  String firebaseCustomerLatitude = "",
      firebaseScreen = "",
      firebaseCustomerLongitude = "", totalstarttimecurrenttimevalue = "";

  List<BrandDetail>? brandDetails;
  bool _isLoadingPage = false;
  MechanicProfileBloc _mechanicProfileBloc = MechanicProfileBloc();
  bool _hasActiveService = false;

  String emergencybookinid="";


  HomeMechanicBloc _mechanicHomeBloc = HomeMechanicBloc();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _hasActiveService = false;
    getSharedPrefData();

    // Timer.periodic(const Duration(seconds: 90), (Timer t) {
    //   // _mechanicHomeBloc.postMechanicActiveServiceRequest(
    //   //     "$authToken", mechanicId);
    //   _getCurrentMechanicLocation();
    // });

    _listenApiResponse();
    _getCurrentMechanicLocation();
  }

  @override
  void didUpdateWidget(covariant MechanicHomeUIScreen oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    print("xkkhhnbb 001");
    setFcmToken(authToken);
    getSharedPrefData();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    getSharedPrefData();
    super.didChangeDependencies();
  }

  void registerNotification() async {
    // 3. On iOS, this helps to take the user permissions
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
      // TODO: handle the received notifications
    } else {
      print('User declined or has not accepted permission');
    }
  }

  Future<void> getSharedPrefData() async {
    print('getSharedPrefData MechanicHomeUIScreen');
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    setState(() {
      authToken = shdPre.getString(SharedPrefKeys.token).toString();
      mechanicId = shdPre.getString(SharedPrefKeys.userID).toString();
      print('userFamilyId MechanicHomeUIScreen ' + authToken.toString());
      print('userId  MechanicHomeUIScreen ' + mechanicId.toString());
      setFcmToken(authToken);
      _getCurrentMechanicLocation();
      _mechanicHomeBloc.postMechanicActiveServiceRequest("$authToken", mechanicId);
      _mechanicProfileBloc.postMechanicFetchProfileRequest(
          authToken, mechanicId);
      _mechanicHomeBloc.postMechanicUpComingServiceRequest(
          "$authToken", "2", mechanicId, 0, 200);
    });
  }

  Future<void> setFcmToken(String Authtoken) async {
    _messaging.getToken().then((value) {
      String? token = value;
      print("FCM Token >>>>>>>>>>  " + token.toString());
      _fcmTokenUpdateBloc.postFcmTokenUpdateRequest(token!, Authtoken);
    });
  }

  _listenApiResponse() {
    _mechanicProfileBloc.postMechanicProfile.listen((value) {
      if (value.status == "error") {
        setState(() {
          _isLoadingPage = false;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(value.message.toString(),
                style: const TextStyle(
                    fontFamily: 'Roboto_Regular', fontSize: 14)),
            duration: const Duration(seconds: 2),
            backgroundColor: CustColors.light_navy,
          ));
        });
      } else {
        setState(() {
          _isLoadingPage = false;
          String brandName = value.data!.mechanicDetails!.mechanic![0].brands
              .toString() /*.toLowerCase()*/;
          brandName = brandName.replaceAll(" ", "");
          print(
              "value.data!.mechanicDetails?.mechanic![0].brands.toLowerCase()" +
                  brandName);
          _mechanicHomeBloc.postMechanicBrandSpecializationRequest(
              "$authToken", brandName);
        });
      }
    });
    _mechanicHomeBloc.postMechanicBrandSpecialization.listen((value) {
      if (value.status == "error") {
        setState(() {
          //_isLoading = false;
          // SnackBarWidget().setMaterialSnackBar(value.message.toString(),_scaffoldKey);
        });
      } else {
        //brandDetails.add(value.data.brandDetails);
        //SnackBarWidget().setMaterialSnackBar(value.data!.mechanicWorkStatusUpdate!.message.toString(),_scaffoldKey);
        /*_isLoading = false;
          socialLoginIsLoading = false;
          _signinBloc.userDefault(value.data!.socialLogin!.token.toString());*/
      }
    });
    _mechanicHomeBloc.postMechanicActiveServiceResponse.listen((value) {
      if (value.status == "error") {
        setState(() {
          //_isLoading = false;
          SnackBarWidget()
              .setMaterialSnackBar(value.message.toString(), _scaffoldKey);
          if(mounted){
            setState(() {
              _hasActiveService = false;
            });
          }
          print("snackbareerror");
        });
      } else {
        print(
            "hasActiveService>>>> ${value.data?.currentlyWorkingService.toString()}");
        print(value.data?.currentlyWorkingService.toString());
        if (value.data?.currentlyWorkingService.toString() != [] &&
            value.data?.currentlyWorkingService.toString() != '[]' &&
            value.data?.currentlyWorkingService.toString() != null &&
            value.data?.currentlyWorkingService.toString() != 'null') {
          if(mounted){
            setState(() {
              _hasActiveService = true;
              setReminderData(
                  value.data?.currentlyWorkingService![0].id.toString());
              print("hasActiveService>>>> true");
            });
          }

        } else {
          if(mounted){
            setState(() {
              _hasActiveService = false;
              print("hasActiveService>>>> false");
            });
          }
        }
      }
    });
  }

  Future<void> setReminderData(String? bookedId) async {
    /*SharedPreferences shdPre = await SharedPreferences.getInstance();
    setState(() {
      bookingId = shdPre.getString(SharedPrefKeys.bookingIdEmergency).toString();
    });*/
    emergencybookinid=bookedId.toString();
    await _firestore
        .collection("ResolMech")
        .doc('$bookedId')
        .snapshots()
        .listen((event) {
      print('_firestore');
      setState(() {
        vehicleName = event.get('carName');
        customerName = event.get('customerName');
        firebaseScreen = event.get('mechanicFromPage');
        firebaseCustomerLatitude = event.get('customerLatitude');
        firebaseCustomerLongitude = event.get('customerLongitude');
        totalstarttimecurrenttimevalue = event.get("totalstarttimecurrenttimevalue");
      });
    });
  }

  Future<void> _getCurrentMechanicLocation() async {
    Position position = await _getGeoLocationPosition();
    location = 'Lat: ${position.latitude} , Long: ${position.longitude}';
    setState(() {
      CurrentLatitude = position.latitude.toString();
      CurrentLongitude = position.longitude.toString();
    });
    print(location + "+++++++>>>>>>");
    GetAddressFromLatLong(position);
    print("_getCurrentMechanicLocation >>> CurrentLatitude " +
        CurrentLatitude +
        "CurrentLongitude >>" +
        CurrentLongitude);
    _mechanicHomeBloc.postMechanicLocationUpdateRequest(
        authToken, mechanicId, CurrentLatitude, CurrentLongitude);
  }

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
  }

  Future<void> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    print(placemarks);
    Placemark place = placemarks[0];
    Address =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    setState(() {
      displayAddress = '${place.locality}'; //${place.name},
    });
    print(" displayAddress >>>>>> " + displayAddress);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  mechanicLocation(context),
                  upcomingServices(size, context),
                  brandSpecialization(size),
                  dashBoardItemsWidget(size),
                  _hasActiveService
                      ? SizedBox(
                          height: size.height * 0.092,
                        )
                      : Container(),
                ],
              ),
            ),
            _hasActiveService ? emergencyServiceReminder(size) : Container(),
          ],
        ),
      ),
    );
  }

  Widget mechanicLocation(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 6.0, left: 6.0, top: 0, bottom: 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Icon(
            Icons.location_on,
            color: CustColors.light_navy,
            size: 30,
          ),
          SizedBox(
            width: 55,
            child: Column(
              children: [
                InkWell(
                  onTap: () {},
                  child: Text(
                    displayAddress,
                    //'Elenjikkal house Empyreal Garden',
                    //maxLines: 2,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    style: Styles.textLabelTitle_10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget upcomingServices(Size size, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 8.0, bottom: 8.0),
            child: Text(
              'Upcoming Services',
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.visible,
              style: Styles.sparepartsForYourModelsStyle,
            ),
          ),
          Container(
            height: 160,
            margin: const EdgeInsets.all(0),
            child: Stack(
              children: [
                StreamBuilder(
                    stream:
                        _mechanicHomeBloc.postMechanicUpComingServiceResponse,
                    builder: (context,
                        AsyncSnapshot<MechanicUpcomingServiceMdl> snapshot) {
                      print("${snapshot.hasData}");
                      print("${snapshot.connectionState}");
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return Align(
                            alignment: Alignment.center,
                            child: Container(
                              height: MediaQuery.of(context).size.height,
                              alignment: Alignment.center,
                              child: const CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    CustColors.light_navy),
                              ),
                            ),
                          );
                        default:
                          return snapshot.data?.data?.upcomingCompletedServices
                                          ?.length !=
                                      0 &&
                                  snapshot.data?.data?.upcomingCompletedServices
                                          ?.length !=
                                      null
                              ? upcomingServicesList(size, snapshot, context)
                              : Container(
                                  margin: const EdgeInsets.all(10),
                                  padding: const EdgeInsets.all(25),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7),
                                      border: Border.all(
                                        color: Colors.white,
                                      ),
                                      color: CustColors.white_04),
                                  child: SvgPicture.asset(
                                    "assets/image/img_empty_service_list.svg",
                                    //fit: BoxFit.contain,
                                  ),
                                );
                      }
                    }),
                Visibility(
                  visible: _isLoadingPage,
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            CustColors.light_navy),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget upcomingServicesList(
      Size size,
      AsyncSnapshot<MechanicUpcomingServiceMdl> snapshot,
      BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: snapshot.data?.data?.upcomingCompletedServices?.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (
            context1,
            i,
          ) {
            return Padding(
              padding: const EdgeInsets.only(
                left: 5,
              ),
              child: InkWell(
                onTap: () {
                  setState(() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MechServiceRegularDetailsScreen(
                            bookingId: snapshot
                                .data!.data!.upcomingCompletedServices![i].id
                                .toString(),
                            firebaseCollection: snapshot
                                        .data!
                                        .data!
                                        .upcomingCompletedServices![i]
                                        .regularType
                                        .toString() ==
                                    "1"
                                ? TextStrings.firebase_pick_up
                                : snapshot
                                            .data!
                                            .data!
                                            .upcomingCompletedServices![i]
                                            .regularType
                                            .toString() ==
                                        "2"
                                    ? TextStrings.firebase_mobile_mech
                                    : TextStrings.firebase_take_vehicle,
                          ),
                        ));
                  });
                },
                child: Column(
                  children: [
                    Container(
                      height: 160,
                      width: 250,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: Colors.white,
                          )),
                      //ClipRRect for image border radius
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Stack(
                          children: [
                            Image.asset(
                                "assets/image/img_mech_home_service_bg.png"),
                            Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                    left: size.width * 2 / 100,
                                    right: size.width * 2 / 100,
                                    top: size.height * 3 / 100,
                                    //bottom: size.height * 2 / 100,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        _mechanicHomeBloc.dateConverter(snapshot
                                            .data!
                                            .data!
                                            .upcomingCompletedServices![i]
                                            .bookedDate!),
                                        // "02-12-2021",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "SharpSans_Bold",
                                            color: Colors.white,
                                            fontSize: 15),
                                      ),
                                      Text(
                                        _mechanicHomeBloc
                                            .timeConvert(new DateFormat(
                                                    "hh:mm:ss")
                                                .parse(snapshot
                                                    .data!
                                                    .data!
                                                    .upcomingCompletedServices![
                                                        i]
                                                    .bookedTime))
                                            .toString(),
                                        //"09:30 AM",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "SharpSans_Bold",
                                            color: Colors.white,
                                            fontSize: 15),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                    left: size.width * 2 / 100,
                                    right: size.width * 2 / 100,
                                    top: size.height * 3 / 100,
                                    //bottom: size.height * 2.5 / 100,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Service from " +
                                            snapshot
                                                .data!
                                                .data!
                                                .upcomingCompletedServices![i]
                                                .customer!
                                                .firstName
                                                .toString(),
                                        //"Service from Eric John. ",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "SharpSans_Bold",
                                            color: Colors.white,
                                            fontSize: 12),
                                      ),
                                      Text(
                                        " [ " + (snapshot.data?.data?.upcomingCompletedServices?[i].vehicle?.brand.toString()??"")+" ] ",
                                        //" [ HONDA CITY ]",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "SharpSans_Bold",
                                            color: Colors.white,
                                            fontSize: 11),
                                      )
                                    ],
                                  ),
                                ),
                                snapshot
                                            .data!
                                            .data!
                                            .upcomingCompletedServices![i]
                                            .reqType
                                            .toString() ==
                                        "1"
                                    ? Container(
                                        margin: EdgeInsets.only(
                                          left: size.width * 2 / 100,
                                          right: size.width * 2 / 100,
                                          top: size.height * 3 / 100,
                                          //bottom: size.height * 2.5 / 100,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: const [
                                            Text(
                                              "Emergency Service",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: "SharpSans_Bold",
                                                  color: Colors.white,
                                                  fontSize: 10),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Container(
                                        margin: EdgeInsets.only(
                                          left: size.width * 2 / 100,
                                          right: size.width * 2 / 100,
                                          top: size.height * 3 / 100,
                                          //bottom: size.height * 2.5 / 100,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              "Regular Service",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: "SharpSans_Bold",
                                                  color: Colors.white,
                                                  fontSize: 10),
                                            ),
                                            Text(
                                              snapshot
                                                          .data!
                                                          .data!
                                                          .upcomingCompletedServices![
                                                              i]
                                                          .regularType
                                                          .toString() ==
                                                      "1"
                                                  ? "Pick Up & Drop Off"
                                                  : snapshot
                                                              .data!
                                                              .data!
                                                              .upcomingCompletedServices![
                                                                  i]
                                                              .regularType
                                                              .toString() ==
                                                          "2"
                                                      ? "Mobile Mechanic"
                                                      : "Take Vehicle to Mechanic",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: "SharpSans_Bold",
                                                  color: Colors.white,
                                                  fontSize: 10),
                                            )
                                          ],
                                        ),
                                      ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  Widget brandSpecialization(Size size) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 2, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            child: const Padding(
              padding: EdgeInsets.only(left: 8.0, bottom: 2.0),
              child: Text(
                'My brand specialisation ',
                maxLines: 2,
                textAlign: TextAlign.start,
                overflow: TextOverflow.visible,
                style: Styles.sparepartsForYourModelsStyle,
              ),
            ),
          ),
          Container(
            height: size.height * 15 / 100,
            alignment: Alignment.center,
            margin: const EdgeInsets.all(0),
            child: Stack(
              children: [
                StreamBuilder(
                    stream: _mechanicHomeBloc
                        .postMechanicBrandSpecializationResponse,
                    builder: (context,
                        AsyncSnapshot<MechanicBrandSpecializationMdl>
                            snapshot) {
                      print("${snapshot.hasData}");
                      print("${snapshot.connectionState}");
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return Align(
                            alignment: Alignment.center,
                            child: Container(
                              height: MediaQuery.of(context).size.height,
                              alignment: Alignment.center,
                              child: const CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    CustColors.light_navy),
                              ),
                            ),
                          );
                        default:
                          return snapshot.data?.data?.brandDetails?.length !=
                                      0 &&
                                  snapshot.data?.data?.brandDetails?.length !=
                                      null
                              ? brandSpecializationList(size, snapshot)
                              : Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      boxShadow: const [
                                        BoxShadow(
                                            color: CustColors.materialBlue,
                                            spreadRadius: 1),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SvgPicture.asset(
                                        "assets/image/NoBrand.svg",
                                        //fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                );
                      }
                    }),
                Visibility(
                  visible: _isLoadingPage,
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            CustColors.light_navy),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget brandSpecializationList(
    Size size,
    AsyncSnapshot<MechanicBrandSpecializationMdl> snapshot,
  ) {
    return ListView.builder(
      itemCount: snapshot.data!.data?.brandDetails!.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (
        context,
        i,
      ) {
        //for onTap to redirect to another screen
        return Padding(
          padding: const EdgeInsets.all(5),
          child: InkWell(
            child: brandSpecializationListItem(
                size, i, snapshot.data!.data?.brandDetails![i].icon),
            onTap: () {},
          ),
        );
      },
    );
  }

  Widget brandSpecializationListItem(Size size, int i, iconImage) {
    return Column(
      children: [
        Container(
          height: size.height * 13 / 100,
          width: size.width * 24 / 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              border: Border.all(
                color: Colors.white,
              ),
              color: CustColors.pale_grey),
          padding: EdgeInsets.only(
              left: size.width * 6 / 100,
              right: size.width * 6 / 100,
              top: size.height * 3.5 / 100,
              bottom: size.height * 3.5 / 100),
          //ClipRRect for image border radius
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.network(
              iconImage!,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ],
    );
  }

  Widget dashBoardItemsWidget(
    Size size,
  ) {
    return Container(
      color: CustColors.pale_grey,
      padding: EdgeInsets.only(
          left: size.width * 4.5 / 100,
          right: size.width * 4.5 / 100,
          top: size.height * 4 / 100,
          bottom: size.height * 4 / 100),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MechanicMyWalletScreen(),
                    ));
              });
            },
            child: Container(
              height: size.height * 18 / 100,
              width: size.width * 40 / 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.white,
                ),
                color: Colors.white,
              ),
              padding: EdgeInsets.only(
                  left: size.width * 10 / 100,
                  right: size.width * 10 / 100,
                  top: size.height * 5 / 100,
                  bottom: size.height * 5 / 100),
              //ClipRRect for image border radius
              child: ClipRRect(
                //borderRadius: BorderRadius.circular(5),
                child: SvgPicture.asset(
                  "assets/image/ic_home_wallet.svg",
                  //fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MechanicMyJobReviewScreen(),
                    ));
              });
            },
            child: Container(
              height: size.height * 18 / 100,
              width: size.width * 40 / 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.white,
                ),
                color: Colors.white,
              ),
              padding: EdgeInsets.only(
                  left: size.width * 10 / 100,
                  right: size.width * 10 / 100,
                  top: size.height * 5 / 100,
                  bottom: size.height * 5 / 100),
              //ClipRRect for image border radius
              child: ClipRRect(
                //borderRadius: BorderRadius.circular(5),
                child: SvgPicture.asset(
                  "assets/image/ic_home_job_review.svg",
                  //fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget emergencyServiceReminder(Size size) {
    return Positioned(
      bottom: size.height * 1.70 / 100,
      child: InkWell(
        onTap: () async {
          if (firebaseScreen == "M1") {
            print("firebaseCustomerLatitude : $firebaseCustomerLatitude firebaseCustomerLongitude : $firebaseCustomerLongitude");
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FindYourCustomerScreen(
                          latitude: firebaseCustomerLatitude /*"10.0159"*/,
                          longitude: firebaseCustomerLongitude /*"76.3419"*/,
                          //notificationPayloadMdl: widget.notificationPayloadMdl,
                      bookingid: emergencybookinid,
                        ))).then((value){
              _mechanicHomeBloc.postMechanicActiveServiceRequest(
                  "$authToken", mechanicId);
            });
          } else if (firebaseScreen == "M2") {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MechanicStartServiceScreen(bookingId: emergencybookinid))).then((value){
              _mechanicHomeBloc.postMechanicActiveServiceRequest(
                  "$authToken", mechanicId);
            });
          } else if (firebaseScreen == "M3") {
            /// storing start time and end time in shared pref
            ///
            /*String remaintime = "";

            if(DateFormat("HH:mm:ss").format(DateTime.now())==totalstarttimecurrenttimevalue){
              print("work finished");

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CustomerApprovedScreen())).then((value){
                _mechanicHomeBloc.postMechanicActiveServiceRequest(
                    "$authToken", mechanicId);
              });
            }
            else{
              await    Repository().timedifferenceapi(DateFormat("HH:mm:ss").format(DateTime.now()), totalstarttimecurrenttimevalue).then((value) => {
                if (value.data!.timeDifference.remTime.isNotEmpty)
                  {
                    setState(() {
                      String string = value.data!.timeDifference.remTime;
                      int hour = int.parse(string.split(":")[0]);
                      int minute = int.parse(string.split(":")[1]);
                      int second = int.parse(string.split(":")[2]);
                      Duration duration = Duration(hours: hour, minutes: minute, seconds: second);
                      print("Minutes is: ${duration.inMinutes}");
                      print("inSeconds is: ${duration.inSeconds}");
                      remaintime = duration.inSeconds.toString();

                      print("remaintime");
                      print(remaintime);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CustomerApprovedScreen()));
                    })
                  }
              });
            }*/

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CustomerApprovedScreen(
                    )));
          } else if (firebaseScreen == "M4") {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MechanicWorkCompletedScreen())).then((value){
              _mechanicHomeBloc.postMechanicActiveServiceRequest(
                  "$authToken", mechanicId);
            });
          } else if (firebaseScreen == "M5") {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DirectPaymentScreen(
                          isMechanicApp: true,
                          isPaymentFailed: true,
                        ))).then((value) {
              _mechanicHomeBloc.postMechanicActiveServiceRequest(
                  "$authToken", mechanicId);
            });
          } else if (firebaseScreen == "M6") {
            print("Service Completed");
          }
        },
        child: Container(
          height: size.height * 10 / 100,
          width: size.width,
          color: Colors.white,
          margin: const EdgeInsets.only(
              // left: size.width * 5 / 100,
              //bottom: size.height * .5 / 100
              ),
          padding: EdgeInsets.only(
            left: size.width * 5 / 100,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "You have one Emergency service ",
                    style: TextStyle(color: CustColors.light_navy),
                  ),
                  Text(
                    "Service from $customerName ",
                  ),
                  Text(
                    "$vehicleName",
                  )
                ],
              ),
              SvgPicture.asset(
                "assets/image/img_mech_home_car_bg.svg",
                height: size.height * 10 / 100,
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
