import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/UI/Common/HelpAndSupport/help_and_support.dart';
import 'package:auto_fix/UI/Common/PrivacyPolicy/privacy_policy.dart';
import 'package:auto_fix/UI/Common/TermsAndCondition/terms_and_conditions.dart';
import 'package:auto_fix/UI/Mechanic/BottomBar/AddPriceFault/add_price_fault.dart';
import 'package:auto_fix/UI/Mechanic/BottomBar/MyProfile/profile_Mechanic_Ui/mechanic_my_profile.dart';
import 'package:auto_fix/UI/Mechanic/BottomBar/MyServices/mechanic_my_services.dart';
import 'package:auto_fix/UI/Mechanic/SideBar/MechanicNotifications/mech_notification_list.dart';
import 'package:auto_fix/UI/Mechanic/SideBar/MyWallet/my_wallet_screen.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signin/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Common/HelpAndSupport/help_and_support.dart';
import '../../Common/PrivacyPolicy/privacy_policy.dart';
import '../../Common/TermsAndCondition/terms_and_conditions.dart';
import '../BottomBar/AddPriceFault/add_price_fault.dart';

class MechanicSideBarScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MechanicSideBarScreenState();
  }
}

class _MechanicSideBarScreenState extends State<MechanicSideBarScreen> {
  String isOnline = "";
  String authToken="";
  String userName="", profileImageUrl = "";
  BuildContext? dialogContext;

  _logout() async {
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    /* shdPre.setString(SharedPrefKeys.token, "");
    shdPre.setBool(SharedPrefKeys.isUserLoggedIn, false);
    shdPre.setString(SharedPrefKeys.userName, "");
    shdPre.setString(SharedPrefKeys.userEmail, "");
    shdPre.setString(SharedPrefKeys.mechanicID, "");
    shdPre.setString(SharedPrefKeys.userProfilePic, "");
    GqlClient.I
        .config(token: shdPre.getString(SharedPrefKeys.token).toString());
    Navigator.pop(context);
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // await preferences.clear();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => MechanicSigninScreen(),
      ),
          (route) => false,
    );*/
  }


  @override
  void initState() {
    super.initState();
    getSharedPrefData();
  }

  Future<void> getSharedPrefData() async {
    print('getSharedPrefData');
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    setState(() {

      authToken = shdPre.getString(SharedPrefKeys.token).toString();
      userName = shdPre.getString(SharedPrefKeys.userName).toString();
      isOnline = shdPre.getString(SharedPrefKeys.mechanicIsOnline).toString();
      profileImageUrl = shdPre.getString(SharedPrefKeys.profileImageUrl).toString();

      print('authToken>>>>>>>>> ' + authToken.toString());
      print('profileImageUrl>>>>>>>>> MechanicSideBarScreen' + profileImageUrl.toString());

    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final drawerItems = ListView(
      padding: const EdgeInsets.all(0.0),
      children: [
        // drawerHeader,
        navigationBarHeader(size),

        ListTile(
          contentPadding: EdgeInsets.only(left: 20.4, top: 13),
          visualDensity: VisualDensity(horizontal: 0, vertical: -3),
          title: const Align(
            alignment: Alignment(-1.21, 0),
            child: Text(
              "My wallet",
              style: Styles.navDrawerTextStyle02,
            ),
          ),
          leading: Image.asset(
            'assets/image/ic_my_wallet.png',
            width: 19.28,
            height: 21.76,
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MechanicMyWalletScreen()));
          },
        ),

        /*ListTile(
          contentPadding: EdgeInsets.only(left: 20.4,),
          visualDensity: VisualDensity(horizontal: 0, vertical: -3),
          title: Align(
            alignment: Alignment(-1.26, 0),
            child: Text(
              "Order details",
              style: Styles.navDrawerTextStyle02,
            ),
          ),
          leading: Container(
            child: Image.asset(
              'assets/image/ic_order_details.png',
              width: 18.28,
              height: 20.76,
            ),
          ),
          *//*onTap: () {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CustomerOrderDetailsScreen()));
          },*//*
        ),*/

        /*ListTile(
          contentPadding: EdgeInsets.only(left: 20.4),
          visualDensity: VisualDensity(horizontal: 0, vertical: -3),
          title: Align(
            alignment: Alignment(-1.45, 0),
            //alignment: Alignment.centerLeft,
            child: Text(
              "My brand specialization",
              style: Styles.navDrawerTextStyle02,
            ),
          ),
          leading: Container(
            child: Image.asset(
              'assets/image/ic_my_specialization.png',
              width: 18.28,
              height: 20.76,
            ),
          ),
         *//* onTap: () {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CustomerBookNowScreen()));
          },*//*
        ),*/

        ListTile(
          contentPadding: EdgeInsets.only(left: 20.4),
          visualDensity: VisualDensity(horizontal: 0, vertical: -3),
          title: Align(
            alignment: Alignment(-1.21, 0),
            child: Text(
              "My Services",
              style: Styles.navDrawerTextStyle02,
            ),
          ),
          leading: Container(
            child: SvgPicture.asset(
              'assets/image/ic_my_appointments.svg',
              width: 14.28,
              height: 18.76,
            ),
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MechanicMyServicesScreen()));
          },
        ),

        /* ListTile(
          contentPadding: EdgeInsets.only(left: 20.4),
          visualDensity: VisualDensity(horizontal: 0, vertical: -3),
          title: Align(
            alignment: Alignment(-1.25, 0),
            child: Text(
              "My job reviews",
              style: Styles.navDrawerTextStyle02,
            ),
          ),
          leading: Container(
            child: Image.asset(
              'assets/image/ic_job_review.png',
              width: 18.28,
              height: 20.76,
            ),
          ),
          *//*onTap: () {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CustomerMyAppointmentScreen()));
          },*//*
        ),*/

        ListTile(
          contentPadding: EdgeInsets.only(left: 20.4),
          visualDensity: VisualDensity(horizontal: 0, vertical: -3),
          title: Align(
            alignment: Alignment(-1.21, 0),
            child: Text(
              "Edit profile",
              style: Styles.navDrawerTextStyle02,
            ),
          ),
          leading: Container(
            child: SvgPicture.asset(
              'assets/image/ic_edit_profile.svg',
              width: 18.28,
              height: 20.76,
            ),
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MechanicMyProfileScreen(isEnableEditing: true,)));
          },
        ),

        ListTile(
          contentPadding: EdgeInsets.only(left: 20.4),
          visualDensity: VisualDensity(horizontal: 0, vertical: -3),
          title: Align(
            alignment: Alignment(-1.28, 0),
            child: Text(
              "Add price & fault",
              style: Styles.navDrawerTextStyle02,
            ),
          ),
          leading: Container(
            child: Image.asset(
              'assets/image/ic_price_fault.png',
              width: 18.28,
              height: 20.76,
            ),
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) =>Addpricefault(position: 1,)));
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
                  color: CustColors.blue),
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
                MaterialPageRoute(builder: (context) => MechanicNotificationList()));
          },
        ),

        ListTile(
          contentPadding: EdgeInsets.only(left: 20.4),
          visualDensity: VisualDensity(horizontal: 0, vertical: -3),
          title: Align(
            alignment: Alignment(-1.18, 0),
            child: Text(
              "Logout",
              style: Styles.navDrawerTextStyle02,
            ),
          ),
          leading: Container(
            child: SvgPicture.asset(
              'assets/image/ic_logout.svg',
              width: 18.28,
              height: 20.76,
            ),
          ),
          onTap: () {
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  dialogContext = context;
                  return deactivateDialog();
                });
          },
        ),

        SizedBox(
            child: Divider(
              thickness: 1,
              height: 0,
            )),

        SizedBox(
          height: 20,
        ),

        Container(
          margin: EdgeInsets.only(left: 46, top: 10),
          child: ListTile(
            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
            title: Text(
              "Privacy policy",
              style: Styles.navDrawerTextStyle02,
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Privacypolicy()));
            },
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 46),
          child: ListTile(
            visualDensity: VisualDensity(horizontal: 0, vertical: -3),
            title: Text(
              "Help & support Center",
              style: Styles.navDrawerTextStyle02,
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HelpAndSupport()));
            },
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 46),
          child: ListTile(
            visualDensity: VisualDensity(horizontal: 0, vertical: -3),
            title: Text(
              "General Terms & Conditions",
              style: Styles.navDrawerTextStyle02,
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => TermsAndConditon()));
            },
          ),
        ),
      ],
    );
    return Drawer(
      child: drawerItems,
    );
  }

  Widget navigationBarHeader(Size size){
    return Container(
      width: double.infinity,
      //height: 174.3 + MediaQuery.of(context).padding.top,
      height: size.height * 37 / 100,
      decoration: BoxDecoration(
        color: CustColors.light_navy,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(
            72,
          ),
        ),
      ),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(
                top: 31 + MediaQuery.of(context).padding.top, left: 16.5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/image/ic_home_white_outline.png',
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
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              //color: Colors.redAccent,
              margin: EdgeInsets.only(
                  top: size.height * 5 / 100,
                  right: size.width * 10 / 100
              ),
              //alignment: Alignment.bottomRight,
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            right: 2
                        ),
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
                      Container(
                        width: 88.0,
                        height: 88.0,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child:Container(
                                child:CircleAvatar(
                                    radius: 50,
                                    backgroundColor: Colors.white,
                                    child: ClipOval(
                                        child: profileImageUrl != null && profileImageUrl != ""
                                            ?
                                        Image.network(profileImageUrl,
                                          width: 150,
                                          height: 150,
                                          fit: BoxFit.cover,
                                        )
                                            :
                                        SvgPicture.asset('assets/image/CustomerType/profileAvathar.svg')
                                    )))

                        ),
                      ),

                      /* Positioned(
                        right: 1.5,
                        bottom: 1,
                        child: ClipRRect(
                          child: Container(
                            width: 25,
                            height: 25,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  50,
                                ),
                              ),
                            ),
                            child: Image.asset("assets/image/ic_camera.png"),
                          ),
                        ),
                      ),*/
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: 5
                    ),
                    child: Text(
                      //_userName.toString(),
                      "$userName",
                      softWrap: true,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Corbel_Bold',
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget deactivateDialog() {
    return CupertinoAlertDialog(
      title: Text("Logout account?",
          style: TextStyle(
            fontFamily: 'Formular',
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: CustColors.materialBlue,
          )),
      content: Text("Are you sure you want to logout?"),
      actions: <Widget>[
        CupertinoDialogAction(
            textStyle: TextStyle(
              color: CustColors.rusty_red,
              fontWeight: FontWeight.normal,
            ),
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(dialogContext!);
            },
            child: Text("Cancel")),
        CupertinoDialogAction(
            textStyle: TextStyle(
              color: CustColors.rusty_red,
              fontWeight: FontWeight.normal,
            ),
            isDefaultAction: true,
            onPressed: () async {
              setState(() {
                Navigator.pop(dialogContext!);
                setDeactivate();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LoginScreen()),
                    ModalRoute.withName("/LoginScreen"));
              });
            },
            child: Text("Logout")),
      ],
    );
  }

  void setDeactivate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(SharedPrefKeys.token, "");
    prefs.setString(SharedPrefKeys.userID, "");
    prefs.setString(SharedPrefKeys.userName, "");
    prefs.setBool(SharedPrefKeys.isUserLoggedIn, false);
    prefs.setString(SharedPrefKeys.userType, "");

  }

}
