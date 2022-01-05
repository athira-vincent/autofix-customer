// ignore_for_file: avoid_print

import 'dart:async';

import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/grapgh_ql_client.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/text_strings.dart';
import 'package:auto_fix/UI/Customer/Home/SideBar/MyVehicle/Add/add_vehicle_screen.dart';
import 'package:auto_fix/UI/Customer/Home/home_screen.dart';
import 'package:auto_fix/UI/WelcomeScreens/UserType/user_selection_screen.dart';

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
    int? _isDefaultVehicleAvailable =
        _shdPre.getInt(SharedPrefKeys.isDefaultVehicleAvailable);

    print("is logged in=======$_isLoggedin");
    print("is isWalked in=======$isWalked");
    print("User Type ============ $userType");
    print(
        "_isDefaultVehicleAvailable ============ $_isDefaultVehicleAvailable");

    var _token = _shdPre.getString(SharedPrefKeys.token);

    if (_token == null || _token == "") {
      GqlClient.I.config(token: "");
    } else {
      GqlClient.I.config(token: _token);
    }

    if (_isLoggedin != null && _isLoggedin == true) {
      print("chechingggg 01 $userType");
      if (userType == TextStrings.user_customer) {
        if (_isDefaultVehicleAvailable == null ||
            _isDefaultVehicleAvailable == 1) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => AddVehicleScreen()));
        } else {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const HomeScreen()));
        }
      }
    } else {
      if (isWalked == null || isWalked == false) {
        print('WalkThroughPage');
        Timer(
            Duration(seconds: 3),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => WalkThroughPages())));
      } else {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const UserSelectionScreen()));
      }
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustColors.blue,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: AssetImage("assets/images/splash_background.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Container(
              margin: EdgeInsets.only(left: 72, right: 72),
              child: Image.asset(
                "assets/images/auto_fix_logo.png",
                width: double.infinity,
                height: 100,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
