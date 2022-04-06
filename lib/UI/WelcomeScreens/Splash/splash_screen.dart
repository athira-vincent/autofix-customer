// ignore_for_file: avoid_print
import 'dart:async';
import 'package:auto_fix/Constants/grapgh_ql_client.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/UI/Customer/customer_home_screen.dart';
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
    Timer(const Duration(seconds: 3), () {
      _changeScreen();
    });
  }

  Future _changeScreen() async {
    SharedPreferences _shdPre = await SharedPreferences.getInstance();
    bool? _isLoggedin = _shdPre.getBool(SharedPrefKeys.isUserLoggedIn);
    bool? isWalked = _shdPre.getBool(SharedPrefKeys.isWalked);
    String? userType = _shdPre.getString(SharedPrefKeys.userType);
    print("is logged in=======$_isLoggedin");
    print("is isWalked in=======$isWalked");
    print("User Type ============ $userType");
    var _token = _shdPre.getString(SharedPrefKeys.token);

    if (_token == null || _token == "") {
      GqlClient.I.config(token: "");
    } else {
      GqlClient.I.config(token: _token);
    }
    if (_isLoggedin != null && _isLoggedin == true) {
      print("chechingggg 01 $userType");

     /* Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>  FindMechanicListScreen(bookingId: '20',
                authToken: '',
              )));*/

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>  CustomerHomeScreen()));


      /*if (userType == TextStrings.user_customer) {
        if (_isDefaultVehicleAvailable == null ||
            _isDefaultVehicleAvailable == 1) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => AddVehicleScreen()));
        } else {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const HomeScreen()));
        }
      }*/
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
      /*  Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>  CustomerHomeScreen()));*/
       /* Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    AddCarScreen(
                      userType: 'customer',
                      userCategory: 'individual',)));*/
      }
    }
  }


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
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
