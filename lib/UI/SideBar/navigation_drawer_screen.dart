import 'package:auto_fix/Constants/grapgh_ql_client.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/UI/Login/Signin/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavigationDrawerScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NavigationDrawerScreenState();
  }
}

class _NavigationDrawerScreenState extends State<NavigationDrawerScreen> {
  _logout() async {
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    shdPre.setString(SharedPrefKeys.token, "");
    shdPre.setBool(SharedPrefKeys.isUserLoggedIn, false);
    GqlClient.I
        .config(token: shdPre.getString(SharedPrefKeys.token).toString());
    Navigator.pop(context);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => SigninScreen(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final UserAccountsDrawerHeader drawerHeader = UserAccountsDrawerHeader(
      accountName: Text(
        "John",
      ),
      accountEmail: Text(
        "john@gmail.com",
      ),
      currentAccountPicture: const CircleAvatar(
        child: FlutterLogo(size: 42.0),
      ),
    );
    final drawerItems = ListView(
      padding: const EdgeInsets.all(0.0),
      children: [
        drawerHeader,
        ListTile(
          title: Text(
            "Home",
          ),
          leading: const Icon(Icons.favorite),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text(
            "Logout",
          ),
          leading: const Icon(Icons.comment),
          onTap: () {
            _logout();
          },
        ),
      ],
    );
    return Drawer(
      child: drawerItems,
    );
  }
}
