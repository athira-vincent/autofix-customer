import 'package:auto_fix/Constants/grapgh_ql_client.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signin/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JWTTokenChecking {
  static checking(String token, BuildContext context) async {
    //token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NDUxLCJ1c2VyVHlwZUlkIjoxLCJpYXQiOjE2NjU2NTExMDgsImV4cCI6MTU2NTczNzUwOH0.2JiHeMsLRYuTgAu-0wtTXVWpSHUuaKEUwjo9L4_GwhU";
    print("JWTTokenChecking 0001 $token");
    if (token == "") {
      print("JWTTokenChecking 0002 ");
      SharedPreferences shdPre = await SharedPreferences.getInstance();
      shdPre.setString(SharedPrefKeys.token, "");
      //shdPre.setBool(SharedPrefKeys.isUserLoggedIn, false);
      shdPre.setString(SharedPrefKeys.userID, "");
      GqlClient.I.config(token: shdPre.getString(SharedPrefKeys.token).toString());
      //Navigator.pop(context);
      Fluttertoast.showToast(msg: "Session Expired Login Again !!",fontSize: 18);
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.clear();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => LoginScreen(),
        ),
            (route) => false,
      );
    } else {
      bool hasExpired = JwtDecoder.isExpired(token);
      if (hasExpired) {
        print("JWTTokenChecking 0002 ");
        SharedPreferences shdPre = await SharedPreferences.getInstance();
        shdPre.setString(SharedPrefKeys.token, "");
        shdPre.setBool(SharedPrefKeys.isUserLoggedIn, false);
        shdPre.setString(SharedPrefKeys.userID, "");
        GqlClient.I.config(token: shdPre.getString(SharedPrefKeys.token).toString());
        //Navigator.pop(context);
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.clear();
        Fluttertoast.showToast(msg: "Session Expired Login Again !!",fontSize: 18);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => LoginScreen(),
          ),
              (route) => false,
        );
      }
    }
  }
}
