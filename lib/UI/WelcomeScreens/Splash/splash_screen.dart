// ignore_for_file: avoid_print
import 'dart:async';
import 'package:auto_fix/Constants/grapgh_ql_client.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/text_strings.dart';
import 'package:auto_fix/UI/Customer/MainLandingPageCustomer/customer_main_landing_screen.dart';
import 'package:auto_fix/UI/Mechanic/EmergencyServiceMechanicFlow/IncomingJobRequestScreen/incoming_job_request_screen.dart';
import 'package:auto_fix/UI/Mechanic/mechanic_home_screen.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Customer/add_car_screen.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/work_selection_screen.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/PhoneLogin/otp_screen.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signin/login_screen.dart';
import 'package:auto_fix/UI/WelcomeScreens/WalkThrough/walk_through_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    FocusManager.instance.primaryFocus?.unfocus();
    Timer(const Duration(seconds: 3), () {
      _changeScreen();
    });
  }

  Future _changeScreen() async {
    SharedPreferences _shdPre = await SharedPreferences.getInstance();
    bool? _isLoggedin = _shdPre.getBool(SharedPrefKeys.isUserLoggedIn);
    bool? isWalked = _shdPre.getBool(SharedPrefKeys.isWalked);
    String? userType = _shdPre.getString(SharedPrefKeys.userType);
    String? userCategory = _shdPre.getString(SharedPrefKeys.userCategory);
    int? _isDefaultVehicleAvailable = _shdPre.getInt(SharedPrefKeys.isDefaultVehicleAvailable);
    int? _isWorkProfileCompleted = _shdPre.getInt(SharedPrefKeys.isWorkProfileCompleted);
    //String? defaultVehicle = _shdPre.getString(SharedPrefKeys.defaultBrandID);
    String? phoneNo = _shdPre.getString(SharedPrefKeys.userPhone);
    String? otpCode = _shdPre.getString(SharedPrefKeys.otpCode);
    String? userTypeId = _shdPre.getString(SharedPrefKeys.userTypeId);

    print("is logged in=======$_isLoggedin");
    print("is isWalked in=======$isWalked");
    print("_isDefaultVehicleAvailable ============ $_isDefaultVehicleAvailable");
    print("_isWorkProfileCompleted ============ $_isWorkProfileCompleted");
    //print("defaultVehicleBrand ============ $defaultVehicle");
    print("User Type ============ $userType");

    print(userCategory);

    var _token = _shdPre.getString(SharedPrefKeys.token);

    if (_token == null || _token == "") {
      GqlClient.I.config(token: "");
    } else {
      GqlClient.I.config(token: _token);
    }
    if (_isLoggedin != null && _isLoggedin == true) {
      print("chechingggg 01 $userType");

      if (userType == TextStrings.user_customer) {
        if(_isDefaultVehicleAvailable != null || _isDefaultVehicleAvailable == 2){
          Navigator.pushReplacement(
            context,
             MaterialPageRoute(
                builder: (context) =>
                    AddCarScreen(userCategory:userCategory! ,userType: userType!,fromPage: "1",)),
          );
        }else if(_isDefaultVehicleAvailable != null || _isDefaultVehicleAvailable == 1){
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => OtpVerificationScreen(
                    userType: userType!,
                    userCategory: userCategory!,
                    phoneNumber: phoneNo!,
                    otpNumber:otpCode!,
                    userTypeId: userTypeId!,
                    fromPage: "1",
                  )));
        }else{

          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>  CustomerMainLandingScreen()));
        }
      }
      else{
        if(_isWorkProfileCompleted != null || _isWorkProfileCompleted == 2){
          Navigator.pushReplacement(
            context,
            new MaterialPageRoute(
                builder: (context) =>
                    WorkSelectionScreen(userCategory:userCategory! ,userType: userType!,)),
          );
        }else if(_isWorkProfileCompleted != null || _isWorkProfileCompleted == 1)
        {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => OtpVerificationScreen(
                    userType : userType!,
                    userCategory : userCategory!,
                    phoneNumber : phoneNo!,
                    otpNumber : otpCode!,
                    userTypeId : userTypeId!,
                    fromPage : "1",
                  )));
        }else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>  MechanicHomeScreen()));
        }
      }
    } else {
      if (isWalked == null || isWalked == false) {
        print('WalkThroughPages');
        Timer(
            Duration(seconds: 3),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => WalkThroughPages())));
      } else {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>  LoginScreen()));
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /*routes: {
        // '/CustomerMainLandingScreen': (BuildContext context) => CustomerMainLandingScreen(),
        "/CustomerMainLandingScreen": (context) => CustomerMainLandingScreen(),
        "/MechanicHomeScreen" : (context) => MechanicHomeScreen(),
        "/IncomingJobRequestScreen" : (context) => IncomingJobRequestScreen(),
      },*/
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.326,
                //margin: EdgeInsets.only(left: 0, right:  0, top: 0, bottom: 0),
                child: Image.asset(
                  "assets/image/splash_bg_top.png",
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.contain,
                ),
              ),

              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.562,
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.053,bottom: 0),
                    child: Image.asset(
                      "assets/image/splash_bg_bottom.png",
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.232,
                      right: MediaQuery.of(context).size.width * 0.198
                    ),
                    height: MediaQuery.of(context).size.height * 0.118,
                    width: MediaQuery.of(context).size.height * 0.569,
                    child: Image.asset(
                      "assets/image/splash_icon.png",
                      width: double.infinity,
                      height: 100,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

}
