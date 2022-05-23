import 'dart:async';

import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/Provider/locale_provider.dart';
import 'package:auto_fix/UI/Common/NotificationPayload/notification_mdl.dart';
import 'package:auto_fix/UI/Mechanic/BottomBar/AddPrice/add_price_screen.dart';
import 'package:auto_fix/UI/Mechanic/BottomBar/Home/mechanic_home_bloc.dart';
import 'package:auto_fix/UI/Mechanic/BottomBar/Home/mechanic_home_screen_ui.dart';
import 'package:auto_fix/UI/Mechanic/BottomBar/MyProfile/profile_Mechanic_Ui/mechanic_my_profile.dart';
import 'package:auto_fix/UI/Mechanic/BottomBar/MyServices/my_services_screen.dart';
import 'package:auto_fix/UI/Mechanic/SideBar/mechanic_side_bar.dart';
import 'package:auto_fix/UI/Mechanic/WorkFlowScreens/IncomingJobRequestScreen/incoming_job_request_screen.dart';
import 'package:auto_fix/Widgets/snackbar_widget.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MechanicHomeScreen extends StatefulWidget {

  MechanicHomeScreen();

  @override
  State<StatefulWidget> createState() {
    return _MechanicHomeScreenState();
  }
}

class _MechanicHomeScreenState extends State<MechanicHomeScreen> {

  late final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  int _index = 0;
  int _counter = 0;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  double per = .10;
  double perfont = .10;
  String isOnline = "";
  String authToken = "", userId = "", userName = "";
  late Map<String, dynamic> notificationPayloadMdl;

  HomeMechanicBloc _mechanicHomeBloc = HomeMechanicBloc();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String location ='Null, Press Button';
  String CurrentLatitude ="10.506402";
  String CurrentLongitude ="76.244164";

  double _setValue(double value) {
    return value * per + value;
  }

  double _setValueFont(double value) {
    return value * perfont + value;
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPrefData();
    _listenApiResponse();
    _getCurrentMechanicLocation();

  }

  Future<void> getSharedPrefData() async {
    print('getSharedPrefData -------> ');
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    setState(() {
      isOnline = shdPre.getString(SharedPrefKeys.mechanicIsOnline).toString();
      authToken = shdPre.getString(SharedPrefKeys.token).toString();
      userId = shdPre.getString(SharedPrefKeys.userID).toString();
      userName =  shdPre.getString(SharedPrefKeys.userName).toString();
    });
    print('userFamilyId  MechanicHomeScreen ' + authToken.toString());
    print('userId  MechanicHomeScreen ' + userId.toString());
    print('userName  MechanicHomeScreen ' + userName.toString());
    print('isOnline  MechanicHomeScreen ' + isOnline.toString());
  }

  Future<void> _getCurrentMechanicLocation() async {
    Position position = await _getGeoLocationPosition();
    location ='Lat: ${position.latitude} , Long: ${position.longitude}';
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



  _listenApiResponse() {
    _mechanicHomeBloc.postMechanicOnlineOffline.listen((value) async {
      if(value.status == "error"){
        setState(() {
          //_isLoading = false;
          SnackBarWidget().setMaterialSnackBar(value.message.toString(),_scaffoldKey);
        });
      }else{
          if(isOnline == "1"){
            setState(() {
              isOnline = "0";
            });
          }else{
            setState(() {
              isOnline = "1";
            });
          }
         //isOnline = !isOnline;
          SharedPreferences shdPre = await SharedPreferences.getInstance();
          shdPre.setString(SharedPrefKeys.mechanicIsOnline,isOnline);
          //SnackBarWidget().setMaterialSnackBar(value.data!.mechanicWorkStatusUpdate!.message.toString(),_scaffoldKey);
          /*_isLoading = false;
          socialLoginIsLoading = false;
          _signinBloc.userDefault(value.data!.socialLogin!.token.toString());*/
      }
    });
  }

  _listenNotification(BuildContext context){

    FirebaseMessaging.onMessage.listen((RemoteMessage event) {

      //Future<void>.delayed(const Duration(seconds: 2));//faking task delay

      setState(() {
        _counter += 1;
        //_notificationPayloadMdl = event.data;
      });
      print("event.notification!.data " + event.data.toString());

      NotificationPayloadMdl notificationPayloadMdl = NotificationPayloadMdl.fromJson(event.data);

      //var data = message['data'] ?? message;
      String bookingId = event.data['bookingId'];
      print("bookingId >>>>> " + bookingId );

      final provider = Provider.of<LocaleProvider>(context,listen: false);
      provider.setPayload(notificationPayloadMdl);

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>  IncomingJobRequestScreen(notificationPayloadMdl: notificationPayloadMdl,)
          )).then((value){
      });
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage event) {

      print("message received onMessageOpenedApp");
      NotificationPayloadMdl notificationPayloadMdl = NotificationPayloadMdl.fromJson(event.data);
      print("_notificationPayloadMdl >>>>> " + notificationPayloadMdl.toString());

      final provider = Provider.of<LocaleProvider>(context,listen: false);
      provider.setPayload(notificationPayloadMdl);
      setState(() {
        _counter += 1;
      });

      print("event.notification!.data " + event.data.toString());

      //var data = message['data'] ?? message;
      String bookingId = event.data['bookingId']; // here you need to replace YOUR_KEY with the actual key that you are sending in notification  **`"data"`** -field of the message.
      //String notificationMessage = message.data['YOUR_KEY'];// here you need to replace YOUR_KEY with the actual key that you are sending in notification  **`"data"`** -field of the message.
      print("bookingId >>>>> " + bookingId );
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>  IncomingJobRequestScreen(notificationPayloadMdl: notificationPayloadMdl,)
          )).then((value){
      });
    });

    /*FirebaseMessaging.onBackgroundMessage((message) async {
      print("onBackgroundMessage " + message.data.toString());

      setState(() {
        _counter += 1;
        //_notificationPayloadMdl = event.data;
      });
      print("message.notification!.data " + message.data.toString());
    });*/

  }

  @override
  Widget build(BuildContext context) {
    _listenNotification(context);
    Size size = MediaQuery.of(context).size;
    var bottomNavigationBarItems = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
          backgroundColor: Colors.white,
          icon: Container(
            child: Column(
              children: [
                Container(
                    width: _setValue(25),
                    height: _setValue(25),
                    child: _index == 0
                        ? Image.asset('assets/image/ic_home_active.png',
                      width: _setValue(26),
                      height: _setValue(26),
                    )
                        : SvgPicture.asset(
                      'assets/image/ic_home_inactive.svg',
                      width: _setValue(26),
                      height: _setValue(26),
                    )
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 4, 0, 0),
                  child: Text(
                    'Home',
                    style: _index == 0
                        ? Styles.homeActiveTextStyle
                        : Styles.homeInactiveTextStyle,
                  ),
                ),
              ],
            ),
          ),
          label: ''
      ),
      BottomNavigationBarItem(
          backgroundColor: Colors.white,
          icon: Container(
            child: Column(
              children: [
                Container(
                    width: _setValue(25),
                    height: _setValue(25),
                    child: _index == 1
                        ? Image.asset('assets/image/ic_home_price_fault_active.png',
                      width: _setValue(26),
                      height: _setValue(26),
                    )
                        : SvgPicture.asset(
                      'assets/image/ic_home_price_fault_inactive.png.svg',
                      width: _setValue(26),
                      height: _setValue(26),
                    )
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 4, 0, 0),
                  child: Text(
                    'Add price',
                    style: _index == 1
                        ? Styles.homeActiveTextStyle
                        : Styles.homeInactiveTextStyle,
                  ),
                ),
              ],
            ),
          ),
          label: ''
      ),
      BottomNavigationBarItem(
          backgroundColor: Colors.white,
          icon: Container(
            child: Column(
              children: [
                Container(
                    width: _setValue(25),
                    height: _setValue(25),
                    child: _index == 2
                        ? SvgPicture.asset('assets/image/ic_home_service_active.svg',
                      width: _setValue(26),
                      height: _setValue(26),
                    )
                        : Image.asset(
                      'assets/image/ic_home_service_inactive.png',
                      width: _setValue(26),
                      height: _setValue(26),
                    )
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 4, 0, 0),
                  child: Text(
                    'My services',
                    style: _index == 2
                        ? Styles.homeActiveTextStyle
                        : Styles.homeInactiveTextStyle,
                  ),
                ),
              ],
            ),
          ),
          label: ''
      ),
      BottomNavigationBarItem(
          backgroundColor: Colors.white,
          icon: Column(
            children: [
              Container(
                width: _setValue(25),
                height: _setValue(25),
                child: _index == 3
                    ? SvgPicture.asset(
                  'assets/image/ic_home_profile_active.svg',
                  width: _setValue(26),
                  height: _setValue(26),
                )
                    : Image.asset(
                  'assets/image/ic_home_profile_inactive.png',
                  width: _setValue(26),
                  height: _setValue(26),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 4, 0, 0),
                child: Text(
                  'Profile',
                  style: _index == 3
                      ? Styles.homeActiveTextStyle
                      : Styles.homeInactiveTextStyle,
                ),
              ),
            ],
          ),
          label: ''
      ),
    ];
    return Scaffold(
      drawer: MechanicSideBarScreen(),
      key: scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0 + MediaQuery.of(context).padding.top),
        child: AppBar(
          actions: [],
          automaticallyImplyLeading: false,
          flexibleSpace: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(

                margin: EdgeInsets.only(
                    left: 21, top: 20 + MediaQuery.of(context).padding.top),

                child: GestureDetector(
                    onTap: () {
                      scaffoldKey.currentState?.openDrawer();
                    },
                    child: Image.asset(
                      'assets/image/ic_drawer.png',
                      width: 30,
                      height: 30,
                    )),
              ),

              Container(
                margin: EdgeInsets.only(
                    top: 25 + MediaQuery.of(context).padding.top, left: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome",
                      style: Styles.homeWelcomeTextStyle,
                    ),
                    Text(
                      " $userName",  //" Athira",
                      style: Styles.homeNameTextStyle,
                    ),
                    Text(
                      " !",
                      style: Styles.homeWelcomeSymbolTextStyle,
                    ),
                  ],
                ),
              ),

              Spacer(),

              InkWell(
                onTap: (){
                  setState(() {
                    if(isOnline == "1"){
                      _mechanicHomeBloc.postMechanicOnlineOfflineRequest("$authToken", "0", userId, );
                    }else{
                      _mechanicHomeBloc.postMechanicOnlineOfflineRequest("$authToken","1", userId, );
                    }
                  });// !isOnline
                },
                child: Container(
                  margin: EdgeInsets.only(
                    top: 25 + MediaQuery.of(context).padding.top,
                    right: 10 + MediaQuery.of(context).padding.right
                  ),
                  padding: EdgeInsets.only(
                      left: 7, right: 7,
                      top: 4, bottom: 4
                  ),
                  decoration: BoxDecoration(
                      color: isOnline == "1" ? CustColors.light_navy : CustColors.cloudy_blue,
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: [new BoxShadow(
                        color: CustColors.roseText1,
                        blurRadius: 10.0,
                      ),]
                  ),
                  //color: isOnline ? CustColors.light_navy : CustColors.cloudy_blue,
                  child: Text(
                      isOnline == "1" ? "Online" : "Offline",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: "Samsung_SharpSans_Medium",
                        fontWeight: FontWeight.w400
                      ),
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.only(
                     top: 25 + MediaQuery.of(context).padding.top,
                     right: size.width * 4.2/100
                ),
                /*child: Stack(
                  children: [
                    SvgPicture.asset(
                          'assets/image/notification_icon.svg',
                          width: 22,
                          height: 22,
                        ),
                    Positioned(
                      right: 0,
                      child: _counter > 0 ? Container(
                        padding: EdgeInsets.all(1),
                        decoration: new BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        constraints: BoxConstraints(
                          minWidth: 12,
                          minHeight: 12,
                        ),
                        child: new Text(
                         '$_counter',
                          style: new TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ) : Container(),

                    ),
                  ],
                ),*/
              ),
            ],
          ),
          backgroundColor: Colors.white,
          shadowColor: Colors.white,
        ),
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            child: _index == 0
                ? MechanicHomeUIScreen()
                : _index == 1 ? MechanicAddPriceScreen()
                : _index == 2 ? MechanicMyServiceScreen()
                : MechanicMyProfileScreen(),
          ),
        ],
      ),
      //floatingActionButton: ,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
          ],
        ),
        child: ClipRRect(
          // borderRadius: BorderRadius.only(
          //   topLeft: Radius.circular(48),
          //   topRight: Radius.circular(48),
          // ),
          child: SizedBox(
            height: size.height * 0.092,
            child: BottomNavigationBar(
              selectedLabelStyle: TextStyle(
                  fontFamily: 'Corbel_Light',
                  fontWeight: FontWeight.w600,
                  fontSize: 0),
              unselectedLabelStyle: TextStyle(
                  fontFamily: 'Corbel_Light',
                  fontWeight: FontWeight.w600,
                  fontSize: 0),
              items: bottomNavigationBarItems,
              currentIndex: _index,
              //backgroundColor: CustColors.blue,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.blue,
              unselectedItemColor: Colors.grey,
              onTap: (index) {
                setState(() {
                  _index = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }

}