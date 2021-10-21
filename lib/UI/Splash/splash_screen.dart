// ignore_for_file: avoid_print

import 'dart:async';

import 'package:auto_fix/Constants/grapgh_ql_client.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/UI/Home/home_screen.dart';
import 'package:auto_fix/UI/Login/login_screen.dart';
import 'package:flutter/cupertino.dart';
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
    Timer(const Duration(seconds: 2), () {
      changeScreen();
    });
  }

  Future changeScreen() async {
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    bool? _isLoggedin = shdPre.getBool(SharedPrefKeys.isUserLoggedIn);
    var token = shdPre.getString(SharedPrefKeys.token);
    if (token == null || token == "") {
      GqlClient.I.config(token: "");
    } else {
      GqlClient.I.config(token: token);
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
    return const Scaffold();
  }
}
