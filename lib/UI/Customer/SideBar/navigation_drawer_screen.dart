import 'package:auto_fix/Constants/grapgh_ql_client.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/UI/Customer/Login/Signin/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavigationDrawerScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NavigationDrawerScreenState();
  }
}

class _NavigationDrawerScreenState extends State<NavigationDrawerScreen> {
  String? _userName;
  String? _userEmail;
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

  _getUser() async {
    SharedPreferences _shdPre = await SharedPreferences.getInstance();
    _userName = _shdPre.getString(SharedPrefKeys.userName).toString();
    _userEmail = _shdPre.getString(SharedPrefKeys.userEmail).toString();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    final UserAccountsDrawerHeader drawerHeader = UserAccountsDrawerHeader(
      accountName: Text(
        _userName.toString(),
      ),
      accountEmail: Text(
        _userEmail.toString(),
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
            "My Services",
          ),
          leading: const Icon(Icons.favorite),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text(
            "My Orders",
          ),
          leading: const Icon(Icons.favorite),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text(
            "My Vehicle",
          ),
          leading: const Icon(Icons.favorite),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text(
            "Cart",
          ),
          leading: const Icon(Icons.favorite),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text(
            "Choose Language",
          ),
          leading: const Icon(Icons.favorite),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text(
            "Notification",
          ),
          leading: const Icon(Icons.favorite),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text(
            "My wallet",
          ),
          leading: const Icon(Icons.favorite),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text(
            "Help",
          ),
          leading: const Icon(Icons.favorite),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text(
            "Terms and Conditions",
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
