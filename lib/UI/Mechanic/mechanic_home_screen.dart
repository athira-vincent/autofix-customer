import 'dart:async';

import 'package:auto_fix/Common/TokenChecking/JWTTokenChecking.dart';
import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/styles.dart';

import 'package:auto_fix/Provider/Profile/profile_data_provider.dart';
import 'package:auto_fix/UI/Mechanic/BottomBar/AddPriceFault/add_price_fault.dart';
import 'package:auto_fix/UI/Mechanic/BottomBar/Home/mechanic_home_bloc.dart';
import 'package:auto_fix/UI/Mechanic/BottomBar/Home/mechanic_home_screen_ui.dart';
import 'package:auto_fix/UI/Mechanic/BottomBar/MyProfile/profile_Mechanic_Ui/mechanic_my_profile.dart';
import 'package:auto_fix/UI/Mechanic/BottomBar/MyServices/mechanic_my_services.dart';
import 'package:auto_fix/UI/Mechanic/SideBar/mechanic_side_bar.dart';
import 'package:auto_fix/Utility/check_network.dart';
import 'package:auto_fix/Utility/network_error_screen.dart';
import 'package:auto_fix/Widgets/show_pop_up_widget.dart';
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
  static const routeName = '/mechanicHomeScreen';
  late final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  int _index = 0;
  int _counter = 0;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  double per = .10;
  double perfont = .10;
  String isOnline = "";
  String authToken = "",
      userId = "",
      userName = "";
  late Map<String, dynamic> notificationPayloadMdl;

  HomeMechanicBloc _mechanicHomeBloc = HomeMechanicBloc();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  DateTime timeBackPressed = DateTime.now();
  CheckInternet _checkInternet = CheckInternet();

  String location = 'Null, Press Button';
  String CurrentLatitude = "";
  String CurrentLongitude = "";

  double _setValue(double value) {
    return value * per + value;
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
    String localProfileUrl = "",
        localProfileName = "";
    print('getSharedPrefData -------> ');
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    setState(() {
      isOnline = shdPre.getString(SharedPrefKeys.mechanicIsOnline).toString();
      authToken = shdPre.getString(SharedPrefKeys.token).toString();
      userId = shdPre.getString(SharedPrefKeys.userID).toString();
      localProfileName = shdPre.getString(SharedPrefKeys.userName).toString();
      localProfileUrl =
          shdPre.getString(SharedPrefKeys.profileImageUrl).toString();
    });
    print('userFamilyId  MechanicHomeScreen ' + authToken.toString());
    print('userId  MechanicHomeScreen ' + userId.toString());
    print('userName  MechanicHomeScreen ' + userName.toString());
    print('isOnline  MechanicHomeScreen ' + isOnline.toString());

    _checkInternet.check().then((intenet){
      if (intenet != null && intenet) {
        JWTTokenChecking.checking(shdPre.getString(SharedPrefKeys.token).toString(), context);
      }else{
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    NetworkErrorScreen())).then((value) {
          JWTTokenChecking.checking(shdPre.getString(SharedPrefKeys.token).toString(), context);
        });
      }
    });

    Provider.of<ProfileDataProvider>(context, listen: false).setProfile(
        userId, localProfileName, localProfileUrl);
  }

  Future<void> _getCurrentMechanicLocation() async {
    Position position = await _getGeoLocationPosition();
    location = 'Lat: ${position.latitude} , Long: ${position.longitude}';
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

  _listenApiResponse() {
    _mechanicHomeBloc.postMechanicOnlineOffline.listen((value) async {
      if (value.status == "error") {
        setState(() {
          //_isLoading = false;
          SnackBarWidget().setMaterialSnackBar(
              value.message.toString(), _scaffoldKey);
        });
      } else {
        if (isOnline == "1") {
          setState(() {
            isOnline = "0";
          });
        } else {
          setState(() {
            isOnline = "1";
          });
        }
        //isOnline = !isOnline;
        SharedPreferences shdPre = await SharedPreferences.getInstance();
        shdPre.setString(SharedPrefKeys.mechanicIsOnline, isOnline);
        //SnackBarWidget().setMaterialSnackBar(value.data!.mechanicWorkStatusUpdate!.message.toString(),_scaffoldKey);
        /*_isLoading = false;
          socialLoginIsLoading = false;
          _signinBloc.userDefault(value.data!.socialLogin!.token.toString());*/
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    userName = Provider
        .of<ProfileDataProvider>(context)
        .getName;
    Size size = MediaQuery
        .of(context)
        .size;
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
                        ? Image.asset(
                      'assets/image/ic_home_price_fault_active.png',
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
                        ? SvgPicture.asset(
                      'assets/image/ic_home_service_active.svg',
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
    return WillPopScope(
      onWillPop: () async {
        final difference = DateTime.now().difference(timeBackPressed);
        final isExitWarning = difference >= Duration(seconds: 3);
        timeBackPressed = DateTime.now();
        if (isExitWarning) {
          /* final message = 'Press back again to exit';
            Fluttertoast.showToast(msg: message,fontSize: 18);
            */
          return false;
        } else {
          //Fluttertoast.cancel();
          ShowPopUpWidget().showPopUp(context);
          return false;
        }
      },
      child: Scaffold(
        drawer: MechanicSideBarScreen(),
        key: scaffoldKey,
        appBar: _index == 0
            ? PreferredSize(
          preferredSize: Size.fromHeight(40.0 + MediaQuery
              .of(context)
              .padding
              .top),
          child: AppBar(
            actions: [],
            automaticallyImplyLeading: false,
            flexibleSpace: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(

                  margin: EdgeInsets.only(
                      left: 21, top: 20 + MediaQuery
                      .of(context)
                      .padding
                      .top),

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
                      top: 25 + MediaQuery
                          .of(context)
                          .padding
                          .top, left: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome",
                        style: Styles.homeWelcomeTextStyle,
                      ),
                      Text(
                        " $userName", //" Athira",
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

                Container(
                  color: Colors.white,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        // Repository().postMechanicActiveServiceRequest(
                        //     authToken, userId).then((value) =>
                        // {
                        //   if(value.data!.currentlyWorkingService!.isEmpty){
                        //     if(isOnline == "1"){
                        //       _mechanicHomeBloc
                        //           .postMechanicOnlineOfflineRequest(
                        //         "$authToken", "0", userId,)
                        //     } else
                        //       {
                        //         _mechanicHomeBloc
                        //             .postMechanicOnlineOfflineRequest(
                        //           "$authToken", "1", userId,)
                        //       }
                        //   }else{
                        //     Fluttertoast.showToast(
                        //         msg: "You are in an active service"),
                        //   }
                        // });

                        if(isOnline == "1"){
                          _mechanicHomeBloc
                              .postMechanicOnlineOfflineRequest(
                            "$authToken", "0", userId,);
                        } else
                        {
                          _mechanicHomeBloc
                              .postMechanicOnlineOfflineRequest(
                            "$authToken", "1", userId,);
                        }
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                          top: 25 + MediaQuery
                              .of(context)
                              .padding
                              .top,
                          right: 10 + MediaQuery
                              .of(context)
                              .padding
                              .right
                      ),
                      padding: EdgeInsets.only(
                          left: 7, right: 7,
                          top: 4, bottom: 4
                      ),
                      decoration: BoxDecoration(
                          color: isOnline == "1"
                              ? CustColors.light_navy
                              : CustColors.cloudy_blue,
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: [new BoxShadow(
                            color: CustColors.roseText1,
                            blurRadius: 10.0,
                          ),
                          ]
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
                ),

                Container(
                  margin: EdgeInsets.only(
                      top: 25 + MediaQuery
                          .of(context)
                          .padding
                          .top,
                      right: size.width * 4.2 / 100
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
        )
            : PreferredSize(
          preferredSize: Size.fromHeight(0.0),
          child: AppBar(),
        ),
        body: Center(
            child: IndexedStack(
              index: _index,
              children: <Widget>[
                MechanicHomeUIScreen(),
                Addpricefault(position: 1,),
                MechanicMyServicesScreen(),
                MechanicMyProfileScreen(isEnableEditing: false,),
              ],
            )
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
            ],
          ),
          child: ClipRRect(
            child: SizedBox(
              height: size.height * 0.098,
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
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.blue,
                unselectedItemColor: Colors.grey,
                onTap: (index) {
                  setState(() {
                    _index = index;
                    //getSharedPrefData();
                  });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

}