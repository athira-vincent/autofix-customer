import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/UI/Common/FcmTokenUpdate/fcm_token_update_bloc.dart';
import 'package:auto_fix/UI/Common/Location/change_location.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/home_Bloc/home_customer_bloc.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/home_Customer_Models/category_list_home_mdl.dart';
import 'package:auto_fix/UI/Customer/EmergencyServiceFlow/MechanicList/EmergencyFindMechanicList/find_mechanic_list_screen.dart';
import 'package:auto_fix/UI/Customer/RegularServiceFlow/CommonScreensInRegular/AddRegularMoreServices/add_more_regular_service_list_screen.dart';
import 'package:auto_fix/UI/SpareParts/SparePartsList/spare_parts_list_screen.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../SearchService/search_service_screen.dart';

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
  late final FirebaseMessaging  _messaging = FirebaseMessaging.instance;
  FcmTokenUpdateBloc _fcmTokenUpdateBloc = FcmTokenUpdateBloc();

  String? filter;
  String authToken="",profileImageUrl = "";

  String serviceIdEmergency="";
  String mechanicIdEmergency="";
  String bookingIdEmergency="";
  String addressLocationText = "";

  final List<String> imageList = [
    "https://firebasestorage.googleapis.com/v0/b/autofix-336509.appspot.com/o/SupportChatImages%2FsparepartImage1.png?alt=media&token=0130eb9b-662e-4c1c-b8a1-f4232cbba284",
    'https://firebasestorage.googleapis.com/v0/b/autofix-336509.appspot.com/o/SupportChatImages%2FsparepartImage2.png?alt=media&token=419e2555-5c26-4295-8201-6c78f1ed563e',
    "https://firebasestorage.googleapis.com/v0/b/autofix-336509.appspot.com/o/SupportChatImages%2FsparepartImage1.png?alt=media&token=0130eb9b-662e-4c1c-b8a1-f4232cbba284",
    'https://firebasestorage.googleapis.com/v0/b/autofix-336509.appspot.com/o/SupportChatImages%2FsparepartImage2.png?alt=media&token=419e2555-5c26-4295-8201-6c78f1ed563e',
  ];

  bool isEmergencyService = false;
  bool isRegularService = true;

   List<Choice> choices = const <Choice>[
    const Choice(title: 'Home', icon: Icons.home),
    const Choice(title: 'relay of urgent mechanic', icon: Icons.contacts),
    const Choice(title: 'Map', icon: Icons.map),
    const Choice(title: 'Phone', icon: Icons.phone),
    const Choice(title: 'Camera', icon: Icons.camera_alt),
    const Choice(title: 'Setting', icon: Icons.settings),
    const Choice(title: 'Album', icon: Icons.photo_album),
    const Choice(title: 'WiFi', icon: Icons.wifi),
  ];

   String CurrentLatitude ="";
   String CurrentLongitude ="";

    String preferredLatitude ="10.506402";
    String preferredLongitude ="76.244164";
    String preferredAddress ="";

  String location ='';
  String Address = '';
  String displayAddress = '';

  String serviceIds = "";

  double per = .10;

  double _setValue(double value) {
    return value * per + value;
  }

  bool _isLoading = false;

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
    print("xkkhhnbb 001");
    //setFcmToken(authToken);
    _getCurrentCustomerLocation(false);
    getSharedPrefData();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getSharedPrefData();

    _listenServiceListResponse();

  }


  Future<void> setFcmToken(String Authtoken) async {
    _messaging.getToken().then((value) {
      String? token = value;
      print("FCM Token >>>>>>>>>>  " + token.toString());
      _fcmTokenUpdateBloc.postFcmTokenUpdateRequest(token!,Authtoken);
    });
  }

  Future<void> getSharedPrefData() async {
    print('getSharedPrefData');
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    setState(() {
      authToken = shdPre.getString(SharedPrefKeys.token).toString();

      preferredLatitude = shdPre.getString(SharedPrefKeys.preferredLatitude).toString() ;
      preferredLongitude = shdPre.getString(SharedPrefKeys.preferredLongitude).toString() ;
      preferredAddress = shdPre.getString(SharedPrefKeys.preferredAddress).toString() ;

      if( (preferredLatitude.toString() != "" && preferredLatitude.toString() != "null")
          && (preferredLongitude.toString() != "" && preferredLongitude.toString() != "null")){
        GetAddressFromLatLong(LatLng(double.parse(preferredLatitude), double.parse(preferredLongitude)));
      }else{
        _getCurrentCustomerLocation(true);
      }

      serviceIdEmergency = shdPre.getString(SharedPrefKeys.serviceIdEmergency).toString();
      mechanicIdEmergency = shdPre.getString(SharedPrefKeys.mechanicIdEmergency).toString();
      bookingIdEmergency = shdPre.getString(SharedPrefKeys.bookingIdEmergency).toString();
      profileImageUrl = shdPre.getString(SharedPrefKeys.profileImageUrl).toString();

      print('authToken>>>>>>>>> ' + authToken.toString());
      print('profileImageUrl>>>>>>>>> _HomeCustomerUIScreenState' + profileImageUrl.toString());
      print('authToken>>>>>>>>>' + authToken.toString());
      print('serviceIdEmergency>>>>>>>>' + serviceIdEmergency.toString());
      print('mechanicIdEmergency>>>>>>>' + mechanicIdEmergency.toString());
      print('bookingIdEmergency>>>>>>>>>' + bookingIdEmergency.toString());
      setFcmToken(authToken);
      if(serviceIdEmergency.toString() != 'null'  && serviceIdEmergency.toString() != "" )
        {
          print('serviceIdEmergency>>>>>>>>11111' + serviceIdEmergency.toString());
        }
      else
        {
          print('serviceIdEmergency>>>>>>>>000000' + serviceIdEmergency.toString());
        }

      _homeCustomerBloc.postEmergencyServiceListRequest("$authToken", "1");
      _homeCustomerBloc.postRegularServiceListRequest("$authToken", "2");

    });
  }

  _listenServiceListResponse() {
    _homeCustomerBloc.emergencyServiceListResponse.listen((value) {
      if (value.status == "error") {
        setState(() {
          print("message postServiceList >>>>>>>  ${value.message}");
          print("errrrorr postServiceList >>>>>>>  ${value.status}");
        });
      } else {
        setState(() {
          print("message postServiceList >>>>>>>  ${value.message}");
          print("errrrorr postServiceList >>>>>>>  ${value.status}");
        });
      }
    });

    _homeCustomerBloc.regularServiceListResponse.listen((value) {
      if (value.status == "error") {
        setState(() {
          print("message postServiceList >>>>>>>  ${value.message}");
          print("errrrorr postServiceList >>>>>>>  ${value.status}");
        });
      } else {
        setState(() {
          print("message postServiceList >>>>>>>  ${value.message}");
          print("errrrorr postServiceList >>>>>>>  ${value.status}");

        });
      }
    });
  }

  Future<void> _getCurrentCustomerLocation(bool isChangeAddress) async {
    Position position = await _getGeoLocationPosition();
    location ='Lat: ${position.latitude} , Long: ${position.longitude}';
    setState(() {
      CurrentLatitude = position.latitude.toString();
      CurrentLongitude = position.longitude.toString();
    });
    print(location);

    if(isChangeAddress){
      GetAddressFromLatLong(LatLng(position.latitude, position.longitude));
    }else{

    }

    SharedPreferences shdPre = await SharedPreferences.getInstance();
    shdPre.setString(SharedPrefKeys.currentLatitude, CurrentLatitude);
    shdPre.setString(SharedPrefKeys.currentLongitude, CurrentLongitude);
    //shdPre.setString(SharedPrefKeys.currentAddress, Address);
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
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> GetAddressFromLatLong(LatLng position)async {
    // SharedPreferences shdPre = await SharedPreferences.getInstance();
    // shdPre.setString(SharedPrefKeys.preferredLatitude, selectedLatLng.latitude.toString());
    // shdPre.setString(SharedPrefKeys.preferredLongitude, selectedLatLng.longitude.toString());
    // shdPre.setString(SharedPrefKeys.preferredAddress, Address);
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude,);
    print(placemarks);
    Placemark place = placemarks[0];
    Address = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';

    setState(() {
      displayAddress = '${place.locality}';//${place.name},
    });
    print(" displayAddress >>>>>> " + displayAddress);
  }

  Future<void> GetAddressString(LatLng position) async {

    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude,);
    print(placemarks);
    Placemark place = placemarks[0];

    String addressLocation = '${place.street}, ${place.subLocality}, ${place.locality}';

    setState(() {
      addressLocationText = addressLocation;
      print("addressLocationText >>>>>>> " + addressLocationText);
    });
    //return addressLocation;
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: [
                searchYouService(context, size),
                serviceBanners(),
                emergencyService(size),
                regularService(),
                //upcomingServices(),
                //sparePartsServices()
              ],
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
                flex:1,
                child: InkWell(
                  onTap: () {
                      print("clicked");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>  SearchServiceScreen()));
                  },
                  child: Container(
                    height: 35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11),
                        border: Border.all(width: 1,color: CustColors.light_navy)),
                    child: Row(
                      children: [
                        Icon(Icons.search_rounded, color: CustColors.light_navy),
                        Text('Search your Services'),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 3,
              ),
              locationWidget(size),
            ],
          ),
        ],
      ),
    );
  }

  Widget locationWidget(Size size){
    return InkWell(
      onTap: () async {
      var result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangeLocationScreen(latitude: CurrentLatitude,
                        longitude: CurrentLongitude),
                  ));
      setState(() {
        GetAddressFromLatLong(result);
      });
      },
      child: Row(
        children: [
          Icon(Icons.location_on, color: CustColors.light_navy,size: 32,),
          SizedBox(
            width: 55,
            child: Column(
              children: [
                Text('$displayAddress',
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
                borderRadius: BorderRadius.circular(11.0)
            ),
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
          padding: const EdgeInsets.fromLTRB(10,5,10,5),
          child: Container(
            height: 35.0,
            margin: const EdgeInsets.only(top:10.0,bottom: 10.0,),
            decoration: BoxDecoration(
                border: Border.all(
                  color: CustColors.light_navy,
                ),
                borderRadius: BorderRadius.circular(11.0)
            ),
            child: InkWell(
              onTap: (){
                setState(() {
                  if(isEmergencyService==true)
                    {
                      isEmergencyService=false;
                    }
                  else
                    {
                      isEmergencyService=true;
                    }
                });
              },
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Emergency Services',
                      maxLines: 2,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.visible,
                      style: Styles.textLabelTitle_Regular,
                    ),
                  ),
                  Spacer(),
                  Icon(isEmergencyService==true?Icons.keyboard_arrow_down_rounded:Icons.keyboard_arrow_right, color: CustColors.light_navy,size: 30,),
                ],
              ),
            ),
          ),
        ),
        isEmergencyService==true
        ? Container(
          child: StreamBuilder(
              stream:  _homeCustomerBloc.emergencyServiceListResponse,
              builder: (context, AsyncSnapshot<CategoryListHomeMdl> snapshot) {
                print("${snapshot.hasData}");
                print("${snapshot.connectionState}");
                print("+++++++++++++++${snapshot.data?.data?.categoryList?.length}++++++++++++++++");

                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          CustColors.light_navy),
                    );
                  default:
                    return
                      snapshot.data?.data?.categoryList?[0].service?.length != 0 && snapshot.data?.data?.categoryList?[0].service?.length != null
                          ? GridView.builder(
                              itemCount:snapshot.data?.data?.categoryList?[0].service?.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                childAspectRatio: .9,
                                crossAxisSpacing: .08,
                                mainAxisSpacing: .05,
                              ),
                              itemBuilder: (context,index,) {
                                return GestureDetector(
                                  onTap:(){

                                    setState(() {

                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              contentPadding: EdgeInsets.all(0.0),
                                              content: StatefulBuilder(
                                                  builder: (BuildContext context, StateSetter monthYear) {
                                                    return  setupAlertDialogMonthAndYear(
                                                      snapshot.data?.data?.categoryList?[0].service?[index],
                                                       snapshot.data?.data?.categoryList![0],
                                                      size,
                                                    );
                                                  }
                                              ),
                                            );
                                          });
                                    });
                                  },
                                  child: Container(
                                    child: Column(
                                      mainAxisAlignment:MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              color: CustColors.whiteBlueish,
                                              borderRadius: BorderRadius.circular(11.0)
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(15),
                                            child:
                                            snapshot.data?.data?.categoryList?[0].service?[index].icon.toString() != ""
                                                ? Image.network(snapshot.data?.data?.categoryList?[0].service?[index].icon,
                                                  width: 35,
                                                  fit: BoxFit.cover,)
                                                : Icon(choices[0].icon,size: 35,color: CustColors.light_navy,),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(2),
                                          child: Text('${snapshot.data?.data?.categoryList?[0].service?[index].serviceName}',
                                            style: Styles.textLabelTitleEmergencyServiceName,
                                            maxLines: 2,
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.visible,),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            )
                          : Container();
                }
              }
              ),
        )
        : Container()
      ],
    );
  }

  Widget regularService() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10,5,10,5),
          child: Container(
            height: 35.0,
            margin: const EdgeInsets.only(top:10.0,bottom: 10.0,),
            decoration: BoxDecoration(
                border: Border.all(
                  color: CustColors.light_navy,
                ),
                borderRadius: BorderRadius.circular(11.0)
            ),
            child: InkWell(
              onTap: (){
                setState(() {

                  if(isRegularService==true)
                  {
                    isRegularService=false;
                  }
                  else
                  {
                    isRegularService=true;
                  }
                });
              },
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Regular Services',
                      maxLines: 2,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.visible,
                      style: Styles.textLabelTitle_Regular,
                    ),
                  ),
                  Spacer(),
                  Icon(isRegularService==true?Icons.keyboard_arrow_down_rounded:Icons.keyboard_arrow_right, color: CustColors.light_navy,size: 30,),
                ],
              ),
            ),
          ),
        ),
        isRegularService==true
            ? Container(
                child: StreamBuilder(
                    stream:  _homeCustomerBloc.regularServiceListResponse,
                    builder: (context, AsyncSnapshot<CategoryListHomeMdl> snapshot) {
                      print("${snapshot.hasData}");
                      print("${snapshot.connectionState}");
                      print("+++++++++++++++${snapshot.data?.data?.categoryList?.length}++++++++++++++++");

                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                CustColors.light_navy),
                          );
                        default:
                          return
                            snapshot.data?.data?.categoryList?.length != 0 && snapshot.data?.data?.categoryList?.length != null
                                ? GridView.builder(
                                  itemCount:snapshot.data?.data?.categoryList?.length,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    childAspectRatio: .9,
                                    crossAxisSpacing: .05,
                                    mainAxisSpacing: .05,
                                  ),
                                  itemBuilder: (context,index,) {
                                    return GestureDetector(
                                      onTap:() async {
                                        SharedPreferences shdPre = await SharedPreferences.getInstance();

                                        print(">>>>>>>>>> Latitude  ${shdPre.getString(SharedPrefKeys.preferredLatitude,)}");
                                        print(">>>>>>>>>> Longitude  ${shdPre.getString(SharedPrefKeys.preferredLongitude,)}");
                                        print(">>>>>>>>>> Date  ${_homeCustomerBloc.dateConvert(DateTime.now())}");
                                        print(">>>>>>>>>> Time  ${_homeCustomerBloc.timeConvert(DateTime.now())}");

                                        serviceIds = '${snapshot.data?.data?.categoryList![index].id}';
                                        print(">>>>>>>>>> ServiceId  $serviceIds");

                                        if(shdPre.getString(SharedPrefKeys.preferredLatitude,).toString() != "null"
                                        && shdPre.getString(SharedPrefKeys.preferredLatitude,).toString() != ""){
                                          GetAddressString(LatLng(
                                              double.parse(shdPre.getString(SharedPrefKeys.preferredLatitude,).toString()),
                                              double.parse(shdPre.getString(SharedPrefKeys.preferredLongitude,).toString())));

                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>  AddMoreRegularServicesListScreen(
                                                    categoryList: snapshot.data?.data?.categoryList![index],
                                                    isAddService: true,
                                                    isReturnData: false,
                                                    latitude: shdPre.getString(SharedPrefKeys.preferredLatitude,).toString(),
                                                    longitude: shdPre.getString(SharedPrefKeys.preferredLongitude,).toString(),
                                                    address: addressLocationText,
                                                  )));
                                        }else{
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>  AddMoreRegularServicesListScreen(
                                                    categoryList: snapshot.data?.data?.categoryList![index],
                                                    isAddService: true,
                                                    isReturnData: false,
                                                    latitude: CurrentLatitude,
                                                    longitude: CurrentLongitude,
                                                    address: Address,
                                                  )));
                                        }
                                      },
                                      child: Container(
                                        child: Column(
                                          mainAxisAlignment:MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: CustColors.whiteBlueish,
                                                  borderRadius: BorderRadius.circular(11.0)
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(15),
                                                child: snapshot.data?.data?.categoryList?[index].icon.toString() != "" && snapshot.data?.data?.categoryList?[index].icon.toString() != "null"
                                                    ? Image.network(snapshot.data?.data?.categoryList?[index].icon,
                                                    width: 35,
                                                    fit: BoxFit.cover,)
                                                    : Icon(Icons.miscellaneous_services_outlined,size: 35,color: CustColors.light_navy,),
                                                //child: Icon(choices[0].icon,size: 35,color: CustColors.light_navy,),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(2),
                                              child: Text('${snapshot.data?.data?.categoryList![index].catName}',
                                                style: Styles.textLabelTitleEmergencyServiceName,
                                                maxLines: 2,
                                                textAlign: TextAlign.center,
                                                overflow: TextOverflow.visible,),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                            )
                                : Container();
                      }
                    }
                ),
              )
            : Container()
      ],
    );
  }

  Widget upcomingServices() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10,20,0,0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Upcoming Services',
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.visible,
              style: Styles.sparepartsForYourModelsStyle,
            ),
          ),
          Container(
            height: 200,
            margin: EdgeInsets.all(0),
            child: ListView.builder(
              itemCount: imageList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, i, ){
                //for onTap to redirect to another screen
                return Padding(
                  padding: const EdgeInsets.all(5),
                  child: InkWell(
                    child: Column(
                      children: [
                        Container(
                          height: 180,
                          width: 250,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.white,)
                          ),
                          //ClipRRect for image border radius
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.network(
                              imageList[i],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>  SparePartsListScreen()));
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget sparePartsServices() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10,10,0,0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Spareparts for your models ',
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.visible,
              style: Styles.sparepartsForYourModelsStyle,
            ),
          ),
          Container(
            height: 200,
            margin: EdgeInsets.all(0),
            child: ListView.builder(
              itemCount: imageList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, i, ){
                //for onTap to redirect to another screen
                return Padding(
                  padding: const EdgeInsets.all(5),
                  child: InkWell(
                    child: Column(
                      children: [
                        Container(
                          height: 160,
                          width: 150,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.white,)
                          ),
                          //ClipRRect for image border radius
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.network(
                              imageList[i],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Text('Gear'),
                      ],
                    ),
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>  SparePartsListScreen()));
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget circleBar(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 5),
      height: isActive ? 5 : 5,
      width: isActive ? 30 : 25,
      decoration: BoxDecoration(
          color: isActive ? Colors.white : CustColors.whiteBlueish,
          borderRadius: BorderRadius.all(Radius.circular(12))),
    );
  }

  Widget setupAlertDialogMonthAndYear(Service? service,CategoryList? categoryList, Size size ) {
    return Container(
      height: 335, // Change as per your requirement
      child: Column(
        children: [
          Container(
              width: double.infinity,
              height: 50,
              color: CustColors.light_navy,
              alignment: Alignment.center,
              child: Text(service!.serviceName,
                style: Styles.textButtonLabelSubTitle,)
          ),
          Container(
            padding: EdgeInsets.only(
              top: size.height * 2.5 / 100,
              bottom: size.height * 2.5 / 100,
              left: size.width * 4 / 100,
              right: size.width * 4 / 100
            ),
            child: Row(
             children: [
               Container(
                 padding: EdgeInsets.only(
                   top: size.height * 1.5 / 100,
                   bottom: size.height * 1.5 / 100,
                   left: size.width * 2 / 100,
                   right: size.width * 2 / 100
                 ),
                 decoration: Styles.serviceIconBoxDecorationStyle,
                 child: Icon(choices[0].icon, size: 35, color: CustColors.light_navy,),
               ),
               SizedBox(
                 width: size.width * 8 / 100,
               ),
               Container(
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Text("Estimated cost",
                       style: TextStyle(
                         fontSize: 18,
                         color: Colors.black,
                         fontFamily: "Samsung_SharpSans_Medium",
                         fontWeight: FontWeight.w600,
                         letterSpacing: .6,
                         height: 1.7
                       ),
                     ),
                     Text("₦ "+ service.minPrice,
                       style: TextStyle(
                           fontSize: 22,
                           color: Colors.black,
                           fontFamily: "SharpSans_Bold",
                           fontWeight: FontWeight.w600,
                           letterSpacing: .6,
                           height: 1.7
                       ),
                     )
                   ],
                 ),
               )
             ],
            ),
          ),
          
          InfoTextWidget(size),

          Container(
            margin: EdgeInsets.only(
                //left: size.width * 4 / 100,
                //right: size.width * 4 / 100,
                top: size.height * 1.5 / 100
            ),
            child: _isLoading
                ? Center(
                    child: Container(
                      height: _setValue(28),
                      width: _setValue(28),
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            CustColors.light_navy),
                      ),
                    ),
                  )
                : MaterialButton(
                  onPressed: () async {
                    SharedPreferences shdPre = await SharedPreferences.getInstance();

                    print(">>>>>>>>>> Latitude  $CurrentLatitude");
                    print(">>>>>>>>>> Longitude  $CurrentLongitude");
                    print(">>>>>>>>>> Date  ${_homeCustomerBloc.dateConvert(DateTime.now())}");
                    print(">>>>>>>>>> Time  ${_homeCustomerBloc.timeConvert(DateTime.now())}");
                    serviceIds = '${service.id}';
                    print(">>>>>>>>>> ServiceId  $serviceIds");

                    if(serviceIdEmergency.toString() == '$serviceIds' )
                    {
                      print('serviceIdEmergency>>>>>>>>==11111' + serviceIdEmergency.toString());

                    }
                    else
                    {
                      shdPre.setString(SharedPrefKeys.serviceIdEmergency, "");
                      shdPre.setString(SharedPrefKeys.mechanicIdEmergency, "");
                      shdPre.setString(SharedPrefKeys.bookingIdEmergency, "");

                      print('serviceIdEmergency>>>>>>>>000000' + serviceIdEmergency.toString());

                    }
                    Navigator.pop(context);
                    GetAddressString(LatLng(double.parse(CurrentLatitude), double.parse(CurrentLongitude)));
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  FindMechanicListScreen(
                              serviceIds: serviceIds,
                              serviceType: 'emergency',
                              customerAddress: addressLocationText,
                              latitude: CurrentLatitude,
                              longitude: CurrentLongitude,
                              authToken: authToken,)));
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(
                      left: size.width * 2.5 / 100,
                      right: size.width * 2.5 / 100,
                      top: size.height * 1 / 100,
                      bottom: size.height * 1 / 100
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                            Radius.circular(6),
                      ),
                        color: CustColors.light_navy
                    ),
                    child: Text(
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

  Widget InfoTextWidget(Size size){
    return Container(
      decoration: Styles.boxDecorationStyle,
      margin: EdgeInsets.only(
          left: size.width * 4 / 100,
          right: size.width * 4 / 100,
          top: size.height * .2 / 100
      ),
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
            child: SvgPicture.asset("assets/image/ic_info_blue_white.svg",
              height: size.height * 2.5 / 100,width: size.width * 2.5 / 100,),
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

  TextStyle warningTextStyle01 = TextStyle(
    fontSize: 12,
    fontFamily: "Samsung_SharpSans_Regular",
    fontWeight: FontWeight.w400,
    color: Colors.black,
    letterSpacing: .7,
    wordSpacing: .7
  );

}

class Choice {
  const Choice({required this.title, required this.icon});
  final String title;
  final IconData icon;
}



class MyBehavior extends ScrollBehavior {


  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
