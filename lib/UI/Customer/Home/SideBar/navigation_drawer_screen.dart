import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/grapgh_ql_client.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/UI/Customer/Home/BottomBar/Profile/ViewProfile/view_profile_screen.dart';
import 'package:auto_fix/UI/Customer/Login/Signin/signin_screen.dart';
import 'package:auto_fix/UI/Customer/Home/SideBar/Help/help_screen.dart';
import 'package:auto_fix/UI/Customer/Home/SideBar/MyServices/my_services_screen.dart';
import 'package:auto_fix/UI/Customer/Home/SideBar/TermsAndConditions/terms_and_conditions_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'MyVehicle/Details/vehicle_details_screen.dart';

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
    shdPre.setString(SharedPrefKeys.userName, "");
    shdPre.setString(SharedPrefKeys.userEmail, "");
    shdPre.setString(SharedPrefKeys.userID, "");
    shdPre.setString(SharedPrefKeys.userProfilePic, "");
    shdPre.setString(SharedPrefKeys.defaultVehicleID, "");
    GqlClient.I
        .config(token: shdPre.getString(SharedPrefKeys.token).toString());
    Navigator.pop(context);
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // await preferences.clear();

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
    final drawerItems = ListView(
      padding: const EdgeInsets.all(0.0),
      children: [
        // drawerHeader,
        Container(
          width: double.infinity,
          height: 174.3 + MediaQuery.of(context).padding.top,
          decoration: BoxDecoration(
            color: CustColors.blue,
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(
                72,
              ),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(
                    top: 31 + MediaQuery.of(context).padding.top, left: 16.5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/home.png',
                      width: 20,
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 14.6, top: 4),
                      alignment: Alignment.center,
                      child: Text(
                        'Home',
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Corbel_Bold',
                            color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 18.1, right: 16.2),
                alignment: Alignment.bottomRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Flexible(
                      child: Container(
                        margin: EdgeInsets.only(right: 12.8),
                        child: Text(
                          _userName.toString(),
                          softWrap: true,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Corbel_Bold',
                              color: Colors.white),
                        ),
                      ),
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 93,
                          height: 93,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                72,
                              ),
                            ),
                          ),
                        ),
                        ClipRRect(
                          child: Container(
                            color: Colors.white,
                            child: Image.network(
                              'http://www.londondentalsmiles.co.uk/wp-content/uploads/2017/06/person-dummy.jpg',
                              fit: BoxFit.cover,
                              width: 88,
                              height: 88,
                            ),
                          ),
                          borderRadius: BorderRadius.circular(44),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        ListTile(
          contentPadding: EdgeInsets.only(left: 20.4, top: 13),
          visualDensity: VisualDensity(horizontal: 0, vertical: -3),
          title: Align(
            alignment: Alignment(-1.21, 0),
            child: Text(
              "My Profile",
              style: TextStyle(
                  fontFamily: 'Corbel_Regular',
                  fontWeight: FontWeight.w600,
                  fontSize: 14.5,
                  color: CustColors.blue01),
            ),
          ),
          leading: Container(
            child: Image.asset(
              'assets/images/profile.png',
              width: 14.28,
              height: 18.76,
            ),
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ViewProfileScreen(id: '1',)));
          },
        ),
        ListTile(
          contentPadding: EdgeInsets.only(left: 20.4),
          visualDensity: VisualDensity(horizontal: 0, vertical: -3),
          title: Align(
            alignment: Alignment(-1.21, 0),
            child: Text(
              "My Services",
              style: TextStyle(
                  fontFamily: 'Corbel_Regular',
                  fontWeight: FontWeight.w600,
                  fontSize: 14.5,
                  color: CustColors.blue01),
            ),
          ),
          leading: Container(
            child: Image.asset(
              'assets/images/my_services.png',
              width: 21.14,
              height: 19.6,
            ),
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MyServicesScreen()));
          },
        ),
        ListTile(
          contentPadding: EdgeInsets.only(left: 20.4),
          visualDensity: VisualDensity(horizontal: 0, vertical: -3),
          title: Align(
            alignment: Alignment(-1.21, 0),
            child: Text(
              "My Orders",
              style: TextStyle(
                  fontFamily: 'Corbel_Regular',
                  fontWeight: FontWeight.w600,
                  fontSize: 14.5,
                  color: CustColors.blue01),
            ),
          ),
          leading: Container(
            child: Image.asset(
              'assets/images/my_orders.png',
              width: 16.8,
              height: 20.2,
            ),
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MyServicesScreen()));
          },
        ),
        ListTile(
          contentPadding: EdgeInsets.only(left: 20.4),
          visualDensity: VisualDensity(horizontal: 0, vertical: -3),
          title: Align(
            alignment: Alignment(-1.18, 0),
            child: Text(
              "Cart",
              style: TextStyle(
                  fontFamily: 'Corbel_Regular',
                  fontWeight: FontWeight.w600,
                  fontSize: 14.5,
                  color: CustColors.blue01),
            ),
          ),
          leading: Container(
            child: Image.asset(
              'assets/images/cart.png',
              width: 20.02,
              height: 20.02,
            ),
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MyServicesScreen()));
          },
        ),
        ListTile(
          contentPadding: EdgeInsets.only(left: 20.4),
          visualDensity: VisualDensity(horizontal: 0, vertical: -3),
          title: Align(
            alignment: Alignment(-1.27, 0),
            child: Text(
              "Choose Language",
              style: TextStyle(
                  fontFamily: 'Corbel_Regular',
                  fontWeight: FontWeight.w600,
                  fontSize: 14.5,
                  color: CustColors.blue01),
            ),
          ),
          leading: Container(
            child: Image.asset(
              'assets/images/my_language.png',
              width: 20.3,
              height: 20.3,
            ),
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MyServicesScreen()));
          },
        ),
        ListTile(
          contentPadding: EdgeInsets.only(left: 20.4),
          visualDensity: VisualDensity(horizontal: 0, vertical: -3),
          title: Align(
            alignment: Alignment(-1.21, 0),
            child: Text(
              "Notification",
              style: TextStyle(
                  fontFamily: 'Corbel_Regular',
                  fontWeight: FontWeight.w600,
                  fontSize: 14.5,
                  color: CustColors.blue01),
            ),
          ),
          leading: Container(
            child: Image.asset(
              'assets/images/notification.png',
              width: 17.92,
              height: 19.88,
            ),
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MyServicesScreen()));
          },
        ),
        ListTile(
          contentPadding: EdgeInsets.only(left: 20.4),
          visualDensity: VisualDensity(horizontal: 0, vertical: -3),
          title: Align(
            alignment: Alignment(-1.18, 0),
            child: Text(
              "My Vehicles",
              style: TextStyle(
                  fontFamily: 'Corbel_Regular',
                  fontWeight: FontWeight.w600,
                  fontSize: 14.5,
                  color: CustColors.blue01),
            ),
          ),
          leading: Container(
            child: Image.asset(
              'assets/images/my_vehicle.png',
              width: 21.84,
              height: 20.44,
            ),
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => VehicleDetailsScreen()));
          },
        ),
        ListTile(
          contentPadding: EdgeInsets.only(left: 20.4),
          visualDensity: VisualDensity(horizontal: 0, vertical: -3),
          title: Align(
            alignment: Alignment(-1.18, 0),
            child: Text(
              "My Wallet",
              style: TextStyle(
                  fontFamily: 'Corbel_Regular',
                  fontWeight: FontWeight.w600,
                  fontSize: 14.5,
                  color: CustColors.blue01),
            ),
          ),
          leading: Container(
            child: Image.asset(
              'assets/images/my_wallet.png',
              width: 21.84,
              height: 19.88,
            ),
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MyServicesScreen()));
          },
        ),
        SizedBox(
            child: Divider(
          thickness: 1,
          height: 0,
        )),
        Container(
          margin: EdgeInsets.only(left: 46, top: 10),
          child: ListTile(
            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
            title: Text(
              "Help Center",
              style: TextStyle(
                  fontFamily: 'Corbel_Regular',
                  fontWeight: FontWeight.w600,
                  fontSize: 14.5,
                  color: CustColors.blue01),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HelpScreen()));
            },
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 46),
          child: ListTile(
            visualDensity: VisualDensity(horizontal: 0, vertical: -3),
            title: Text(
              "Terms and Conditions",
              style: TextStyle(
                  fontFamily: 'Corbel_Regular',
                  fontWeight: FontWeight.w600,
                  fontSize: 14.5,
                  color: CustColors.blue01),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TermsAndConditionsScreen()));
            },
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 46),
          child: ListTile(
            visualDensity: VisualDensity(horizontal: 0, vertical: -3),
            title: Text(
              "Logout",
              style: TextStyle(
                  fontFamily: 'Corbel_Regular',
                  fontWeight: FontWeight.w600,
                  fontSize: 14.5,
                  color: CustColors.blue01),
            ),
            onTap: () {
              _logout();
            },
          ),
        ),
      ],
    );
    return Drawer(
      child: drawerItems,
    );
  }
}
