// ignore_for_file: avoid_print

import 'dart:async';

import 'package:auto_fix/Constants/grapgh_ql_client.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/UI/Customer/Home/home_screen.dart';
import 'package:auto_fix/UI/Customer/Login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    Key? key
  }) : super(key: key);

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

    var _token = _shdPre.getString(SharedPrefKeys.token);
    if (_token == null || _token == "") {
      GqlClient.I.config(token: "");
    } else {
      GqlClient.I.config(token: _token);
    }

    if (_isLoggedin == null) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    } else if (_isLoggedin) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    } else {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
         decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/splash_background.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
           child: Container(
                    margin: EdgeInsets.only(left: 72, right: 72),
                    child: Image.asset("assets/auto_fix_logo.png",
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
