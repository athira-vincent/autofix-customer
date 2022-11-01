import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/Constants/text_strings.dart';
import 'package:auto_fix/UI/Common/FcmTokenUpdate/fcm_token_update_bloc.dart';
import 'package:auto_fix/UI/Common/Location/change_location.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/home_Bloc/home_customer_bloc.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/home_Customer_Models/category_list_home_mdl.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/home_spare_part_bloc/home_spare_part_bloc.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/home_spare_part_bloc/home_spare_part_event.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/home_spare_part_bloc/home_spare_part_state.dart';
import 'package:auto_fix/UI/Customer/EmergencyServiceFlow/MechanicList/EmergencyFindMechanicList/find_mechanic_list_screen.dart';
import 'package:auto_fix/UI/Customer/RegularServiceFlow/CommonScreensInRegular/AddRegularMoreServices/add_more_regular_service_list_screen.dart';
import 'package:auto_fix/UI/Customer/RegularServiceFlow/CommonScreensInRegular/ServiceDetailsScreens/cust_service_regular_details_screen.dart';
import 'package:auto_fix/UI/SpareParts/SparePartsList/spare_parts_list_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../SearchService/search_service_screen.dart';

//import '../../../../../../Models/customer_models/cust_completed_orders_model/customerCompletedOrdersListMdl.dart' as customerCompletedOrdersListMdl ;
import 'package:auto_fix/Models/customer_models/cust_completed_orders_model/customerCompletedOrdersListMdl.dart'
    as customerCompletedOrdersListMdl;

class HomeCustomerUIScreen extends StatefulWidget {
  HomeCustomerUIScreen();

  @override
  State<StatefulWidget> createState() {
    return _HomeCustomerUIScreenState();
  }
}

class _HomeCustomerUIScreenState extends State<HomeCustomerUIScreen> {
  final HomeCustomerBloc _homeCustomerBloc = HomeCustomerBloc();

  TextEditingController searchController = new TextEditingController();
  late final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  FcmTokenUpdateBloc _fcmTokenUpdateBloc = FcmTokenUpdateBloc();
  customerCompletedOrdersListMdl.Data? CustomerUpcomingServicesList;

  final SparePartBloc _sparepartbloc = SparePartBloc();

  String? filter;
  String authToken = "", profileImageUrl = "", userID = "";

  String serviceIdEmergency = "";
  String mechanicIdEmergency = "";
  String bookingIdEmergency = "";
  String addressLocationText = "";

  final List<String> imageList = [
    "https://firebasestorage.googleapis.com/v0/b/autofix-336509.appspot.com/o/SupportChatImages%2FsparepartImage1.png?alt=media&token=0130eb9b-662e-4c1c-b8a1-f4232cbba284",
    'https://firebasestorage.googleapis.com/v0/b/autofix-336509.appspot.com/o/SupportChatImages%2FsparepartImage2.png?alt=media&token=419e2555-5c26-4295-8201-6c78f1ed563e',
    "https://firebasestorage.googleapis.com/v0/b/autofix-336509.appspot.com/o/SupportChatImages%2FsparepartImage1.png?alt=media&token=0130eb9b-662e-4c1c-b8a1-f4232cbba284",
    'https://firebasestorage.googleapis.com/v0/b/autofix-336509.appspot.com/o/SupportChatImages%2FsparepartImage2.png?alt=media&token=419e2555-5c26-4295-8201-6c78f1ed563e',
  ];

  bool isEmergencyService = false;
  bool isRegularService = true;

  String CurrentLatitude = "";
  String CurrentLongitude = "";

  String preferredLatitude = "10.506402";
  String preferredLongitude = "76.244164";
  String preferredAddress = "";

  String location = '';
  String Address = '';
  String displayAddress = '';

  String serviceIds = "";

  double per = .10;


  double _setValue(double value) {
    return value * per + value;
  }

  bool _isLoading = false;
  bool isLoadingUpcomingServices = true;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    getSharedPrefData();
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant HomeCustomerUIScreen oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    _getCurrentCustomerLocation(false);
    getSharedPrefData();
  }

  @override
  void initState() {
    super.initState();
    getSharedPrefData();
    _getCurrentCustomerLocation(false);
    _listenServiceListResponse();
  }

  Future<void> setFcmToken(String Authtoken) async {
    _messaging.getToken().then((value) {
      String? token = value;
      _fcmTokenUpdateBloc.postFcmTokenUpdateRequest(token!, Authtoken);
    });
  }

  Future<void> getSharedPrefData() async {
    print('getSharedPrefData');
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    setState(() {
      authToken = shdPre.getString(SharedPrefKeys.token).toString();
      userID = shdPre.getString(SharedPrefKeys.userID).toString();
      preferredLatitude =
          shdPre.getString(SharedPrefKeys.preferredLatitude).toString();
      preferredLongitude =
          shdPre.getString(SharedPrefKeys.preferredLongitude).toString();
      preferredAddress =
          shdPre.getString(SharedPrefKeys.preferredAddress).toString();





      if ((preferredLatitude.toString() != "" &&
              preferredLatitude.toString() != "null") &&
          (preferredLongitude.toString() != "" &&
              preferredLongitude.toString() != "null")) {
        GetAddressFromLatLong(LatLng(
            double.parse(preferredLatitude), double.parse(preferredLongitude)));
      } else {
        _getCurrentCustomerLocation(true);
      }

      serviceIdEmergency =
          shdPre.getString(SharedPrefKeys.serviceIdEmergency).toString();
      mechanicIdEmergency =
          shdPre.getString(SharedPrefKeys.mechanicIdEmergency).toString();
      bookingIdEmergency =
          shdPre.getString(SharedPrefKeys.bookingIdEmergency).toString();
      profileImageUrl =
          shdPre.getString(SharedPrefKeys.profileImageUrl).toString();

      setFcmToken(authToken);
      if (serviceIdEmergency.toString() != 'null' &&
          serviceIdEmergency.toString() != "") {
        print(
            'serviceIdEmergency>>>>>>>>11111' + serviceIdEmergency.toString());
      } else {
        print(
            'serviceIdEmergency>>>>>>>>000000' + serviceIdEmergency.toString());
      }

      _homeCustomerBloc.postEmergencyServiceListRequest(
          "$authToken", "1", null, null);
      _homeCustomerBloc.postRegularServiceListRequest(
          "$authToken", "2", null, null);
      _homeCustomerBloc.postCustomerUpcomingOrdersRequest(
          authToken, 300, "1", "$userID");
      //_sparepartbloc.
    });
  }

  _listenServiceListResponse() {
    _homeCustomerBloc.emergencyServiceListResponse.listen((value) {
      if (value.status == "error") {
        setState(() {});
      } else {
        setState(() {});
      }
    });

    _homeCustomerBloc.regularServiceListResponse.listen((value) {
      if (value.status == "error") {
        /*setState(() {});*/
      } else {
        /*setState(() {});*/
      }
    });

    _homeCustomerBloc.postCustomerUpcomingOrdersResponse.listen((value) {
      if (value.status == "error") {
        setState(() {
          isLoadingUpcomingServices = false;
        });
      } else {
        setState(() {
          isLoadingUpcomingServices = false;
          CustomerUpcomingServicesList = value.data;
        });
      }
    });
  }

  Future<void> _getCurrentCustomerLocation(bool isChangeAddress) async {
    Position position = await _getGeoLocationPosition();
    location = 'Lat: ${position.latitude} , Long: ${position.longitude}';
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    setState(() {
      CurrentLatitude = position.latitude.toString();
      CurrentLongitude = position.longitude.toString();
      shdPre.setString(SharedPrefKeys.currentLatitude, CurrentLatitude);
      shdPre.setString(SharedPrefKeys.currentLongitude, CurrentLongitude);
    });

    if (isChangeAddress) {
      GetAddressFromLatLong(LatLng(position.latitude, position.longitude));
    } else {}
  }

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
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
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
  }

  Future<void> GetAddressFromLatLong(LatLng position) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    Placemark place = placemarks[0];
    Address =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';

    setState(() {
      displayAddress = '${place.locality}';
    });
  }

  Future<void> GetAddressString(LatLng position) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    Placemark place = placemarks[0];

    String addressLocation =
        '${place.street}, ${place.subLocality}, ${place.locality}';

    setState(() {
      addressLocationText = addressLocation;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SparePartBloc()..add(FetchSparePartEvent()),
          ),
        ],
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: [
                searchYouService(context, size),
                serviceBanners(),
                emergencyService(size),
                regularService(),
                upcomingServices(size),
                sparePartsServices()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget searchYouService(BuildContext context, Size size) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchServiceScreen()));
                  },
                  child: Container(
                    height: 35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11),
                        border:
                            Border.all(width: 1, color: CustColors.light_navy)),
                    child: Row(
                      children: const [
                        Icon(Icons.search_rounded,
                            color: CustColors.light_navy),
                        Text('Search your Services'),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 3,
              ),
              locationWidget(size),
            ],
          ),
        ],
      ),
    );
  }

  Widget locationWidget(Size size) {
    return InkWell(
      onTap: () async {
        _getCurrentCustomerLocation(false);
        var result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChangeLocationScreen(
                  latitude: CurrentLatitude, longitude: CurrentLongitude),
            ));
        setState(() {
          GetAddressFromLatLong(result);
        });
      },
      child: Row(
        children: [
          const Icon(
            Icons.location_on,
            color: CustColors.light_navy,
            size: 32,
          ),
          SizedBox(
            width: 55,
            child: Column(
              children: [
                Text(
                  displayAddress,
                  //maxLines: 2,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  style: Styles.textLabelTitle_10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget serviceBanners() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            decoration: BoxDecoration(
                color: CustColors.whiteBlueish,
                borderRadius: BorderRadius.circular(11.0)),
            child: Image.asset('assets/image/bannerPngDummy1.png'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: circleBar(true),
          ),
        ],
      ),
    );
  }

  Widget emergencyService(Size size) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: Container(
            height: 35.0,
            margin: const EdgeInsets.only(
              top: 10.0,
              bottom: 10.0,
            ),
            decoration: BoxDecoration(
                border: Border.all(
                  color: CustColors.light_navy,
                ),
                borderRadius: BorderRadius.circular(11.0)),
            child: InkWell(
              onTap: () {
                setState(() {
                  if (isEmergencyService == true) {
                    isEmergencyService = false;
                  } else {
                    isEmergencyService = true;
                  }
                });
              },
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Emergency Services',
                      maxLines: 2,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.visible,
                      style: Styles.textLabelTitle_Regular,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    isEmergencyService == true
                        ? Icons.keyboard_arrow_down_rounded
                        : Icons.keyboard_arrow_right,
                    color: CustColors.light_navy,
                    size: 30,
                  ),
                ],
              ),
            ),
          ),
        ),
        isEmergencyService == true
            ? StreamBuilder(
                stream: _homeCustomerBloc.emergencyServiceListResponse,
                builder:
                    (context, AsyncSnapshot<CategoryListHomeMdl> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            CustColors.light_navy),
                      );
                    default:
                      return snapshot.data?.data?.categoryList?[0].service
                                  ?.length !=
                              null
                          ? GridView.builder(
                              itemCount: snapshot
                                  .data?.data?.categoryList?[0].service?.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                childAspectRatio: .9,
                                crossAxisSpacing: .08,
                                mainAxisSpacing: .05,
                              ),
                              itemBuilder: (
                                context,
                                index,
                              ) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _getCurrentCustomerLocation(false);

                                      if(CurrentLatitude.isNotEmpty && CurrentLongitude.isNotEmpty){
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                contentPadding:
                                                const EdgeInsets.all(0.0),
                                                content: StatefulBuilder(builder:
                                                    (BuildContext context,
                                                    StateSetter monthYear) {
                                                  return setupAlertDialogMonthAndYear(
                                                    snapshot
                                                        .data
                                                        ?.data
                                                        ?.categoryList?[0]
                                                        .service?[index],
                                                    snapshot.data?.data
                                                        ?.categoryList![0],
                                                    size,
                                                  );
                                                }),
                                              );
                                            });
                                      }else{
                                        _getCurrentCustomerLocation(false);
                                        Fluttertoast.showToast(
                                          msg: "Fetching Location..",
                                          backgroundColor: CustColors.light_navy,
                                          timeInSecForIosWeb: 1,
                                        );
                                      }
                                    });
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            color: CustColors.whiteBlueish,
                                            borderRadius:
                                                BorderRadius.circular(11.0)),
                                        child: Padding(
                                            padding: const EdgeInsets.all(15),
                                            child: snapshot.data?.data?.categoryList?[0]
                                                            .service?[index]
                                                            .icon
                                                            .toString() != ""
                                                ||
                                                    snapshot.data?.data?.categoryList?[0]
                                                            .service?[index]
                                                            .icon
                                                            .toString() !=
                                                        "null"
                                                ? SvgPicture.network(
                                                    snapshot
                                                        .data
                                                        ?.data
                                                        ?.categoryList?[0]
                                                        .service?[index]
                                                        .icon,
                                                    width: 35,
                                                    height: 20,
                                                    fit: BoxFit.contain,
                                                  )
                                                : Image.network(
                                                    'https://firebasestorage.googleapis.com/v0/b/autofix-336509.appspot.com/o/RelexProductImagesDummy%2Fservice.png?alt=media&token=2cd2becd-04c9-488a-9bdc-6082bc11ce36',
                                                    width: 35,
                                                    fit: BoxFit.cover,
                                                  )
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2),
                                        child: Text(
                                          '${snapshot.data?.data?.categoryList?[0].service?[index].serviceName}',
                                          style: Styles
                                              .textLabelTitleEmergencyServiceName,
                                          maxLines: 2,
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.visible,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            )
                          : Container();
                  }
                })
            : Container()
      ],
    );
  }

  Widget regularService() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: Container(
            height: 35.0,
            margin: const EdgeInsets.only(
              top: 10.0,
              bottom: 10.0,
            ),
            decoration: BoxDecoration(
                border: Border.all(
                  color: CustColors.light_navy,
                ),
                borderRadius: BorderRadius.circular(11.0)),
            child: InkWell(
              onTap: () {
                setState(() {
                  if (isRegularService == true) {
                    isRegularService = false;
                  } else {
                    isRegularService = true;
                  }
                });
              },
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Regular Services',
                      maxLines: 2,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.visible,
                      style: Styles.textLabelTitle_Regular,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    isRegularService == true
                        ? Icons.keyboard_arrow_down_rounded
                        : Icons.keyboard_arrow_right,
                    color: CustColors.light_navy,
                    size: 30,
                  ),
                ],
              ),
            ),
          ),
        ),
        isRegularService == true
            ? StreamBuilder(
                stream: _homeCustomerBloc.regularServiceListResponse,
                builder:
                    (context, AsyncSnapshot<CategoryListHomeMdl> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            CustColors.light_navy),
                      );
                    default:
                      return snapshot.data?.data?.categoryList?.length != null
                          ? GridView.builder(
                              itemCount:
                                  snapshot.data?.data?.categoryList?.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                childAspectRatio: .9,
                                crossAxisSpacing: .05,
                                mainAxisSpacing: .05,
                              ),
                              itemBuilder: (
                                context,
                                index,
                              ) {
                                return GestureDetector(
                                  onTap: () async {
                                    SharedPreferences shdPre =
                                        await SharedPreferences.getInstance();

                                    serviceIds =
                                        '${snapshot.data?.data?.categoryList![index].id}';

                                    if (shdPre
                                                .getString(
                                                  SharedPrefKeys
                                                      .preferredLatitude,
                                                )
                                                .toString() !=
                                            "null" &&
                                        shdPre
                                                .getString(
                                                  SharedPrefKeys
                                                      .preferredLatitude,
                                                )
                                                .toString() !=
                                            "") {
                                      GetAddressString(LatLng(
                                          double.parse(shdPre
                                              .getString(
                                                SharedPrefKeys
                                                    .preferredLatitude,
                                              )
                                              .toString()),
                                          double.parse(shdPre
                                              .getString(
                                                SharedPrefKeys
                                                    .preferredLongitude,
                                              )
                                              .toString())));

                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AddMoreRegularServicesListScreen(
                                                    categoryList: snapshot
                                                        .data
                                                        ?.data
                                                        ?.categoryList![index],
                                                    isAddService: true,
                                                    isReturnData: false,
                                                    latitude: shdPre
                                                        .getString(
                                                          SharedPrefKeys
                                                              .preferredLatitude,
                                                        )
                                                        .toString(),
                                                    longitude: shdPre
                                                        .getString(
                                                          SharedPrefKeys
                                                              .preferredLongitude,
                                                        )
                                                        .toString(),
                                                    address:
                                                        addressLocationText,
                                                    isFromScheduleServicePage:
                                                        false,
                                                  )));
                                    } else {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AddMoreRegularServicesListScreen(
                                                    categoryList: snapshot
                                                        .data
                                                        ?.data
                                                        ?.categoryList![index],
                                                    isAddService: true,
                                                    isReturnData: false,
                                                    latitude: CurrentLatitude,
                                                    longitude: CurrentLongitude,
                                                    address: Address,
                                                    isFromScheduleServicePage:
                                                        false,
                                                  )));
                                    }
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            color: CustColors.whiteBlueish,
                                            borderRadius:
                                                BorderRadius.circular(11.0)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(15),
                                          child: snapshot
                                                          .data
                                                          ?.data
                                                          ?.categoryList?[index]
                                                          .icon
                                                          .toString() !=
                                                      "" &&
                                                  snapshot
                                                          .data
                                                          ?.data
                                                          ?.categoryList?[index]
                                                          .icon
                                                          .toString() !=
                                                      "null"
                                              ? Image.network(
                                                  snapshot
                                                      .data
                                                      ?.data
                                                      ?.categoryList?[index]
                                                      .icon,
                                                  width: 35,
                                                  fit: BoxFit.cover,
                                                )
                                              : const Icon(
                                                  Icons
                                                      .miscellaneous_services_outlined,
                                                  size: 35,
                                                  color: CustColors.light_navy,
                                                ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2),
                                        child: Text(
                                          '${snapshot.data?.data?.categoryList![index].catName}',
                                          style: Styles
                                              .textLabelTitleEmergencyServiceName,
                                          maxLines: 2,
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.visible,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            )
                          : Container();
                  }
                })
            : Container()
      ],
    );
  }

  Widget upcomingServices(Size size) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(9, 1, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
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
                        _homeCustomerBloc.postCustomerUpcomingOrdersResponse,
                    builder: (context,
                        AsyncSnapshot<
                                customerCompletedOrdersListMdl
                                    .CustomerCompletedOrdersListMdl>
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
                          return snapshot.data?.data?.custCompletedOrders
                                          ?.length !=
                                      0 &&
                                  snapshot.data?.data?.custCompletedOrders
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
                  visible: isLoadingUpcomingServices,
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

  Widget sparePartsServices() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Spare parts for my models ',
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.visible,
              style: Styles.sparepartsForYourModelsStyle,
            ),
          ),
          BlocBuilder<SparePartBloc, SparePartState>(builder: (context, state) {
            if (state is SparePartLoadingState) {
              return const CircularProgressIndicator();
            } else if (state is SparePartLoadedState) {
              return Container(
                height: 200,
                margin: const EdgeInsets.all(0),
                child: ListView.builder(
                  itemCount:
                      state.sparePartsModel.data!.custVehicleList!.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (
                    context,
                    index,
                  ) {
                    return Padding(
                      padding: const EdgeInsets.all(5),
                      child: InkWell(
                        child: Column(
                          children: [
                            Container(
                              height: 140,
                              width: 130,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: Colors.grey,
                                  )),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: state
                                        .sparePartsModel
                                        .data!
                                        .custVehicleList![index]
                                        .vehiclePic
                                        .isEmpty
                                    ? Container(
                                        color: Colors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.all(25),
                                          child: SvgPicture.asset(
                                            'assets/image/CustomerType/dummyCar00.svg',
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      )
                                    : Image.network(
                                        state.sparePartsModel.data!
                                            .custVehicleList![index].vehiclePic,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                            Text(state.sparePartsModel.data!
                                    .custVehicleList![index].brand +
                                " " +
                                state.sparePartsModel.data!
                                    .custVehicleList![index].model),
                          ],
                        ),
                        onTap: ()async {

                          SharedPreferences shdPre = await SharedPreferences.getInstance();
                          shdPre.remove("ischanged");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                       SparePartsListScreen(
                                          modelname: state.sparePartsModel.data!
                                              .custVehicleList![index].model)));
                        },
                      ),
                    );
                  },
                ),
              );
            } else if (state is SparePartErrorState) {
              return Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: const [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "We couldn't connect to the page you are looking for.",
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              );
            } else {
              return Container();
            }
          }),
        ],
      ),
    );
  }

  Widget upcomingServicesList(
      Size size,
      AsyncSnapshot<
              customerCompletedOrdersListMdl.CustomerCompletedOrdersListMdl>
          snapshot,
      BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: snapshot.data?.data?.custCompletedOrders?.length,
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
                          builder: (context) => CustServiceRegularDetailsScreen(
                            bookingId:
                                '${CustomerUpcomingServicesList?.custCompletedOrders?[i].id}',
                            firebaseCollection: CustomerUpcomingServicesList
                                        ?.custCompletedOrders?[i].regularType
                                        .toString() ==
                                    "1"
                                ? TextStrings.firebase_pick_up
                                : CustomerUpcomingServicesList
                                            ?.custCompletedOrders?[i]
                                            .regularType
                                            .toString() ==
                                        "2"
                                    ? TextStrings.firebase_mobile_mech
                                    : TextStrings.firebase_take_vehicle,
                          ),
                        ));
                    /* Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MechServiceRegularDetailsScreen(
                            bookingId: snapshot.data!.data!.upcomingCompletedServices![i].id.toString(),
                            firebaseCollection: snapshot.data!.data!.upcomingCompletedServices![i].regularType.toString() == "1"
                                ? TextStrings.firebase_pick_up :
                            snapshot.data!.data!.upcomingCompletedServices![i].regularType.toString() == "2"
                                ? TextStrings.firebase_mobile_mech : TextStrings.firebase_take_vehicle,
                          ),
                        ));*/
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
                                        _homeCustomerBloc.dateConverter(snapshot
                                            .data!
                                            .data!
                                            .custCompletedOrders![i]
                                            .bookedDate!),
                                        // "02-12-2021",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "SharpSans_Bold",
                                            color: Colors.white,
                                            fontSize: 15),
                                      ),
                                      Text(
                                        _homeCustomerBloc
                                            .timeConvert(
                                                new DateFormat("hh:mm:ss")
                                                    .parse(snapshot
                                                        .data!
                                                        .data!
                                                        .custCompletedOrders![i]
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
                                                .custCompletedOrders![i]
                                                .mechanic!
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
                                        " [ " +
                                            snapshot
                                                .data!
                                                .data!
                                                .custCompletedOrders![i]
                                                .vehicle!
                                                .brand
                                                .toString() +
                                            " ] ",
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
                                snapshot.data!.data!.custCompletedOrders![i]
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
                                                          .custCompletedOrders![
                                                              i]
                                                          .regularType
                                                          .toString() ==
                                                      "1"
                                                  ? "Pick Up & Drop Off"
                                                  : snapshot
                                                              .data!
                                                              .data!
                                                              .custCompletedOrders![
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

  Widget circleBar(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      height: isActive ? 5 : 5,
      width: isActive ? 30 : 25,
      decoration: BoxDecoration(
          color: isActive ? Colors.white : CustColors.whiteBlueish,
          borderRadius: const BorderRadius.all(Radius.circular(12))),
    );
  }

  Widget setupAlertDialogMonthAndYear(
      Service? service, CategoryList? categoryList, Size size) {
    return SizedBox(
      height: 335, // Change as per your requirement
      child: Column(
        children: [
          Container(
              width: double.infinity,
              height: 50,
              color: CustColors.light_navy,
              alignment: Alignment.center,
              child: Text(
                service!.serviceName,
                style: Styles.textButtonLabelSubTitle,
              )),
          Container(
            padding: EdgeInsets.only(
                top: size.height * 2.5 / 100,
                bottom: size.height * 2.5 / 100,
                left: size.width * 4 / 100,
                right: size.width * 4 / 100),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.only(
                      top: size.height * 2 / 100,
                      bottom: size.height * 2 / 100,
                      left: size.width * 2.7 / 100,
                      right: size.width * 2.7 / 100
                  ),
                  decoration: Styles.serviceIconBoxDecorationStyle,
                  child: service.icon.toString() != ""
                      || service.icon.toString() != "null"
                      ? SvgPicture.network(
                          service.icon,
                          width: 40,
                          height: 25,
                          fit: BoxFit.contain,
                         )
                      : Icon(Icons.miscellaneous_services,size: 35,color: CustColors.light_navy,),
                  //Icon(choices[0].icon, size: 35, color: CustColors.light_navy,),
                ),
                SizedBox(
                  width: size.width * 5 / 100,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Estimated cost",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontFamily: "Samsung_SharpSans_Medium",
                          fontWeight: FontWeight.w600,
                          letterSpacing: .6,
                          height: 1.7),
                    ),
                    Text(
                      "₦ " + service.minPrice,
                      style: const TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                          fontFamily: "SharpSans_Bold",
                          fontWeight: FontWeight.w600,
                          letterSpacing: .6,
                          height: 1.7),
                    )
                  ],
                )
              ],
            ),
          ),
          InfoTextWidget(size),
          Container(
            margin: EdgeInsets.only(top: size.height * 1.5 / 100),
            child: _isLoading
                ? Center(
                    child: SizedBox(
                      height: _setValue(28),
                      width: _setValue(28),
                      child: const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            CustColors.light_navy),
                      ),
                    ),
                  )
                : MaterialButton(
                    onPressed: () async {
                      //_getCurrentCustomerLocation(false);

                      SharedPreferences shdPre =
                          await SharedPreferences.getInstance();

                      serviceIds = service.id;

                      if (serviceIdEmergency.toString() == serviceIds) {
                      } else {
                        shdPre.setString(SharedPrefKeys.serviceIdEmergency, "");
                        shdPre.setString(
                            SharedPrefKeys.mechanicIdEmergency, "");
                        shdPre.setString(SharedPrefKeys.bookingIdEmergency, "");
                      }
                      GetAddressString(LatLng(double.parse(CurrentLatitude),
                          double.parse(CurrentLongitude)));

                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FindMechanicListScreen(
                                    serviceIds: serviceIds,
                                    serviceType: 'emergency',
                                    customerAddress: addressLocationText,
                                    latitude: CurrentLatitude,
                                    longitude: CurrentLongitude,
                                    authToken: authToken,
                                  )));
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(
                          left: size.width * 2.5 / 100,
                          right: size.width * 2.5 / 100,
                          top: size.height * 1 / 100,
                          bottom: size.height * 1 / 100),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(6),
                          ),
                          color: CustColors.light_navy),
                      child: const Text(
                        'Find available mechanics ',
                        textAlign: TextAlign.center,
                        style: Styles.textButtonLabelSubTitle,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget InfoTextWidget(Size size) {
    return Container(
      decoration: Styles.boxDecorationStyle,
      margin: EdgeInsets.only(
          left: size.width * 4 / 100,
          right: size.width * 4 / 100,
          top: size.height * .2 / 100),
      padding: EdgeInsets.only(
        top: size.height * 1 / 100,
        bottom: size.height * 1 / 100,
        right: size.width * 2.3 / 100,
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(
              left: size.width * 2 / 100,
              right: size.width * 2.5 / 100,
            ),
            child: SvgPicture.asset(
              "assets/image/ic_info_blue_white.svg",
              height: size.height * 2.5 / 100,
              width: size.width * 2.5 / 100,
            ),
          ),
          Expanded(
            child: Text(
              "This cost may change for different mechanics due to change in Service charge or due to distance from your location",
              textAlign: TextAlign.justify,
              style: warningTextStyle01,
            ),
          )
        ],
      ),
    );
  }

  TextStyle warningTextStyle01 = const TextStyle(
      fontSize: 12,
      fontFamily: "Samsung_SharpSans_Regular",
      fontWeight: FontWeight.w400,
      color: Colors.black,
      letterSpacing: .7,
      wordSpacing: .7);
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
