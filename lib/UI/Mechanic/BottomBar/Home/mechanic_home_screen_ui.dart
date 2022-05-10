import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/UI/Mechanic/BottomBar/Home/brand_specialization_mdl.dart';
import 'package:auto_fix/UI/Mechanic/BottomBar/Home/mechanic_home_bloc.dart';
import 'package:auto_fix/UI/Mechanic/BottomBar/Home/upcoming_services_mdl.dart';
import 'package:auto_fix/Widgets/snackbar_widget.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MechanicHomeUIScreen extends StatefulWidget {

  MechanicHomeUIScreen();

  @override
  State<StatefulWidget> createState() {
    return _MechanicHomeUIScreenState();
  }
}

class _MechanicHomeUIScreenState extends State<MechanicHomeUIScreen> {


  //String serverToken = 'AAAADMxJq7A:APA91bHrfSmm2qgmwuPI5D6de5AZXYibDCSMr2_qP9l3HvS0z9xVxNru5VgIA2jRn1NsXaITtaAs01vlV8B6VjbAH00XltINc32__EDaf_gdlgD718rluWtUzPwH-_uUbQ5XfOYczpFL';
  late final FirebaseMessaging    _messaging = FirebaseMessaging.instance;
  //late FirebaseMessaging messaging;

  String authToken="", mechanicId = "";
  String location ='Null, Press Button';
  String CurrentLatitude ="10.506402";
  String CurrentLongitude ="76.244164";
  String Address = 'search';
  List<BrandDetail>? brandDetails;
  bool _isLoadingPage = false;


  final List<String> imageList = [
    "https://firebasestorage.googleapis.com/v0/b/autofix-336509.appspot.com/o/SupportChatImages%2FsparepartImage1.png?alt=media&token=0130eb9b-662e-4c1c-b8a1-f4232cbba284",
    'https://firebasestorage.googleapis.com/v0/b/autofix-336509.appspot.com/o/SupportChatImages%2FsparepartImage2.png?alt=media&token=419e2555-5c26-4295-8201-6c78f1ed563e',
    "https://firebasestorage.googleapis.com/v0/b/autofix-336509.appspot.com/o/SupportChatImages%2FsparepartImage1.png?alt=media&token=0130eb9b-662e-4c1c-b8a1-f4232cbba284",
    'https://firebasestorage.googleapis.com/v0/b/autofix-336509.appspot.com/o/SupportChatImages%2FsparepartImage2.png?alt=media&token=419e2555-5c26-4295-8201-6c78f1ed563e',
  ];

  HomeMechanicBloc _mechanicHomeBloc = HomeMechanicBloc();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void initState() {
    // TODO: implement initState
    super.initState();

    getSharedPrefData();
    //callOnFcmApiSendPushNotifications(1);

    _getCurrentCustomerLocation();
    _listenApiResponse();

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

  /*Future<void> callOnFcmApiSendPushNotifications(int length) async {

    FirebaseMessaging.instance.getToken().then((value) {
      String? token = value;
      print("Instance ID: +++++++++ +++++ +++++ minnu " + token.toString());
    });

     final postUrl = 'https://fcm.googleapis.com/fcm/send';
    // print('userToken>>>${appData.fcmToken}'); //alp dec 28

    final data = {
      'notification': {
        'body': 'You have $length new order',
        'title': 'New Orders',
        'sound': 'alarmw.wav',
      },
      'priority': 'high',
      'data': {
        'click_action': 'FLUTTER_NOTIFICATION_CLICK',
        'id': '1',
        'status': 'done',
        'screen': 'screenA',
        'message': 'ACTION'
      },
      'apns': {
        'headers': {'apns-priority': '5', 'apns-push-type': 'background'},
        'payload': {
          'aps': {'content-available': 1, 'sound': 'alarmw.wav'}
        }
      },
      'to': 'ddN7dOfSSp6smPVEcm1-V6:APA91bEnvhxehhX_Dj2tQgLPXqL8s8YFs1xdYjIR1Fp8mqQYeCQKWupQUzLIIS7YWNC1bnZlN0Em1oHztKYPNx_dD5O8M0FQpAW9MzVkS6Xkkn7yea5zYv-EzhefvblGJvYa4YicEkOM',
    };

    final headers = {
      'content-type': 'application/json',
      'Authorization':
      'key=$serverToken'
    };

    BaseOptions options = new BaseOptions(
      connectTimeout: 5000,
      receiveTimeout: 3000,
      headers: headers,
    );

    try {
      final response = await Dio(options).post(postUrl, data: data);

      if (response.statusCode == 200) {
        print('notification sending success');
      } else {
        print('notification sending failed');
      }
    } catch (e) {
      print('exception $e');
    }
  }*/

  Future<void> getSharedPrefData() async {
    print('getSharedPrefData');
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    setState(() {
      authToken = shdPre.getString(SharedPrefKeys.token).toString();
      mechanicId = shdPre.getString(SharedPrefKeys.userID).toString();
      print('userFamilyId'+authToken.toString());
      print('userId ' + mechanicId.toString());

      _mechanicHomeBloc.postMechanicUpComingServiceRequest("$authToken", "1", "8");

      _mechanicHomeBloc.postMechanicBrandSpecializationRequest("$authToken",["bmw","maruthi"]);
      _mechanicHomeBloc.postMechanicActiveServiceRequest("$authToken",mechanicId);

    });
  }

  _listenApiResponse() {
    _mechanicHomeBloc.postMechanicBrandSpecialization.listen((value) {
      if(value.status == "error"){
        setState(() {
          //_isLoading = false;
          SnackBarWidget().setMaterialSnackBar(value.message.toString(),_scaffoldKey);
        });
      }else{
        setState(() {
          //brandDetails.add(value.data.brandDetails);
          //SnackBarWidget().setMaterialSnackBar(value.data!.mechanicWorkStatusUpdate!.message.toString(),_scaffoldKey);
          /*_isLoading = false;
          socialLoginIsLoading = false;
          _signinBloc.userDefault(value.data!.socialLogin!.token.toString());*/
        });
      }
    });
/*
    _mechanicHomeBloc.postMechanicUpComingService.listen((value) {
      if(value.status == "error"){
        setState(() {
          //_isLoading = false;
          SnackBarWidget().setMaterialSnackBar(value.message.toString(),_scaffoldKey);
        });
      }else{
        setState(() {
          //brandDetails.add(value.data.brandDetails);
          //SnackBarWidget().setMaterialSnackBar(value.data!.mechanicWorkStatusUpdate!.message.toString(),_scaffoldKey);
          *//*_isLoading = false;
          socialLoginIsLoading = false;
          _signinBloc.userDefault(value.data!.socialLogin!.token.toString());*//*
        });
      }
    });*/
  }

  Future<void> _getCurrentCustomerLocation() async {
    Position position = await _getGeoLocationPosition();
    location ='Lat: ${position.latitude} , Long: ${position.longitude}';
    setState(() {
      CurrentLatitude = position.latitude.toString();
      CurrentLongitude = position.longitude.toString();
    });
    print(location);
    GetAddressFromLatLong(position);
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

  Future<void> GetAddressFromLatLong(Position position)async {
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude,);
    print(placemarks);
    Placemark place = placemarks[0];
    Address = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
  }


  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  children: [
                    mechanicLocation(context),
                    upcomingServices(size),
                    brandSpecialization(size),
                    dashBoardItemsWidget(size),
                    emergencyServiceReminder(size),
                  ],
                ),
                /*Positioned(
                  right: 0,
                  bottom: 0,
                  //left: 0,
                 // width: size.width,
                  child: FloatingActionButton(
                      elevation: 0.0,
                      child: new Icon(Icons.check),
                      backgroundColor: new Color(0xFFE57373),
                      onPressed: (){}
                  ),
                )*/
              ],
            ),
          ),
          /*floatingActionButton: new FloatingActionButton(
              elevation: 0.0,
              child: new Icon(Icons.check),
              backgroundColor: new Color(0xFFE57373),
              onPressed: (){}
              ),*/
        ),
      ),
    );
  }

  Widget mechanicLocation(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          right: 8.0, left: 8.0, top: 2,bottom: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Icon(Icons.location_on_rounded, color: CustColors.light_navy,size: 35,),
          SizedBox(
            width: 50,
            child: Column(
              children: [
                Text('Elenjikkal house Empyreal Garden',
                  maxLines: 2,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.visible,
                  style: Styles.textLabelTitle_10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget upcomingServices(Size size) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10,2,0,0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
            child: Text('Upcoming Services',
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.visible,
              style: Styles.sparepartsForYourModelsStyle,
            ),
          ),
          Container(
            height: 185,
            margin: EdgeInsets.all(0),
            child: Stack(
              children: [
                StreamBuilder(
                    stream:  _mechanicHomeBloc.postMechanicUpComingServiceResponse,
                    builder: (context, AsyncSnapshot<MechanicUpcomingServiceMdl> snapshot) {
                      print("${snapshot.hasData}");
                      print("${snapshot.connectionState}");
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return Align(
                            alignment: Alignment.center,
                            child: Container(
                              height: MediaQuery.of(context).size.height,
                              alignment: Alignment.center,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    CustColors.peaGreen),
                              ),
                            ),
                          );
                        default:
                          return
                            snapshot.data?.data?.upcomingCompletedServices?.length != 0 && snapshot.data?.data?.upcomingCompletedServices?.length != null
                                ? upcomingServicesList(size,snapshot)
                                : Container();
                      }
                    }
                ),
                Visibility(
                  visible: _isLoadingPage,
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            CustColors.peaGreen),
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

  Widget upcomingServicesList(Size size, AsyncSnapshot<MechanicUpcomingServiceMdl> snapshot){
    return  Container(
      child: ListView.builder(
        itemCount: snapshot.data?.data?.upcomingCompletedServices?.length,
        scrollDirection: Axis.horizontal,
          itemBuilder: (context, i, ){
              return Padding(
                padding: const EdgeInsets.only(
                  left: 5,),
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
                          child: Stack(
                            children: [
                              Image.asset("assets/image/img_mech_home_service_bg.png"),
                              Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                      left: size.width * 2 / 100,
                                      right: size.width * 2 / 100,
                                      top: size.height * 4 / 100,
                                      //bottom: size.height * 2 / 100,
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          snapshot.data!.data!.upcomingCompletedServices![i].bookedDate!.day.toString() +
                                          "-" +
                                          snapshot.data!.data!.upcomingCompletedServices![i].bookedDate!.month.toString() +
                                          "-" +
                                          snapshot.data!.data!.upcomingCompletedServices![i].bookedDate!.year.toString(),
                                         // "02-12-2021",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "SharpSans_Bold",
                                              color: Colors.white,
                                              fontSize: 15),),
                                        Text(
                                          snapshot.data!.data!.upcomingCompletedServices![i].serviceTime.toString(),
                                          //"09:30 AM",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "SharpSans_Bold",
                                              color: Colors.white,
                                              fontSize: 15),)
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                      left: size.width * 2 / 100,
                                      right: size.width * 2 / 100,
                                      top: size.height * 4 / 100,
                                      //bottom: size.height * 2.5 / 100,
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Service from " +
                                          snapshot.data!.data!.upcomingCompletedServices![i].customer!.firstName.toString(),
                                          //"Service from Eric John. ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "SharpSans_Bold",
                                              color: Colors.white,
                                              fontSize: 12
                                          ),),

                                        Text(
                                          " [ " +
                                          snapshot.data!.data!.upcomingCompletedServices![i].vehicle!.brand.toString()
                                          + " ] ",
                                          //" [ HONDA CITY ]",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "SharpSans_Bold",
                                              color: Colors.white,
                                              fontSize: 12
                                          ),)
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
                  onTap: (){

                  },
                ),
              );
          }
      ),
    );
  }

  Widget brandSpecialization(Size size) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10,2,0,0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, bottom: 2.0),
            child: Text(
              'My brand specialisation ',
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.visible,
              style: Styles.sparepartsForYourModelsStyle,
            ),
          ),
          Container(
            height: size.height * 15 / 100,
            margin: EdgeInsets.all(0),
            child: ListView.builder(
              itemCount: imageList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, i, ){
                //for onTap to redirect to another screen
                return Padding(
                  padding: const EdgeInsets.all(5),
                  child: InkWell(
                    child: brandSpecializationListItem(size,i),
                    onTap: (){

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

  Widget brandSpecializationListItem(Size size,int i) {
    return Column(
      children: [
        Container(
          height: size.height * 12 / 100,
          width: size.width * 24 / 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              border: Border.all(
                color: Colors.white,
              ),
            color: CustColors.pale_grey
          ),
          padding: EdgeInsets.only(
            left: size.width * 6 / 100,
            right: size.width * 6 / 100,
            top: size.height * 3.5 / 100,
            bottom: size.height * 3.5 / 100
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
    );
  }

  Widget dashBoardItemsWidget(Size size,) {
    return Container(
      color: CustColors.pale_grey,
      //color: CustColors.green,
      padding: EdgeInsets.only(
          left: size.width * 4.5 / 100,
          right: size.width * 4.5 / 100,
          top: size.height * 4 / 100,
          bottom: size.height * 4 / 100
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
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
                bottom: size.height * 5 / 100
            ),
            //ClipRRect for image border radius
            child: ClipRRect(
              //borderRadius: BorderRadius.circular(5),
              child: SvgPicture.asset(
               "assets/image/ic_home_wallet.svg",
                //fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
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
                bottom: size.height * 5 / 100
            ),
            //ClipRRect for image border radius
            child: ClipRRect(
              //borderRadius: BorderRadius.circular(5),
              child: SvgPicture.asset(
                "assets/image/ic_home_job_review.svg",
                //fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget emergencyServiceReminder(Size size){
    return Container(
      height: size.height * 10 / 100,
      width: size.width,
      color: Colors.white,
      margin: EdgeInsets.only(
       // left: size.width * 5 / 100,
        bottom: size.height * .5 / 100
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
              Text("You have one Emergency service ",
                style: TextStyle(color: CustColors.light_navy),),
              Text("Service from Eric John.   [ HONDA CITY ]", )
            ],
          ),
          SvgPicture.asset(
              "assets/image/img_mech_home_car_bg.svg",
            height: size.height * 10 / 100,
          )
        ],
      ),
    );
  }

}