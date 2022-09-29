import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/UI/Common/HelpAndSupport/help_and_support.dart';
import 'package:auto_fix/UI/Common/PrivacyPolicy/privacy_policy.dart';
import 'package:auto_fix/UI/Common/TermsAndCondition/terms_and_conditions.dart';
import 'package:auto_fix/UI/Customer/BottomBar/MyProfile/customer_my_profile.dart';
import 'package:auto_fix/UI/Customer/BottomBar/MyServices/customer_my_services.dart';
import 'package:auto_fix/UI/Customer/SideBar/CustomerNotifications/cust_notification_list.dart';
import 'package:auto_fix/UI/Customer/SideBar/MyOrders/my_orders_list.dart';
import 'package:auto_fix/UI/Customer/SideBar/MyVehicles/cust_my_vehicles.dart';
import 'package:auto_fix/UI/Customer/SideBar/MyWallet/my_wallet.dart';
import 'package:auto_fix/UI/Customer/SideBar/OrderDetails/cust_order_details.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signin/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerNavigationDrawerScreen extends StatefulWidget {
  const CustomerNavigationDrawerScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CustomerNavigationDrawerScreenState();
  }
}

class _CustomerNavigationDrawerScreenState extends State<CustomerNavigationDrawerScreen> {

  String authToken="";
  String userName="", profileImageUrl = "";
  BuildContext? dialogContext;
  @override
  void initState() {
    super.initState();
    getSharedPrefData();
  }

  Future<void> getSharedPrefData() async {
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    setState(() {
      authToken = shdPre.getString(SharedPrefKeys.token).toString();
      userName = shdPre.getString(SharedPrefKeys.userName).toString();
      profileImageUrl = shdPre.getString(SharedPrefKeys.profileImageUrl).toString();

    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final drawerItems = ListView(
      padding: const EdgeInsets.all(0.0),
      children: [
        // drawerHeader,
        /*Container(
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
        )*/
        navigationBarHeader(size),




        ListTile(
          contentPadding: const EdgeInsets.only(left: 20.4, top: 13),
          visualDensity: const VisualDensity(horizontal: 0, vertical: -3),
          title: const Align(
            alignment:  Alignment(-1.22, 0),
            child:  Text(
              "Order details",
              style: Styles.navDrawerTextStyle02,
            ),
          ),
          leading: Image.asset(
            'assets/image/ic_order_details.png',
            width: 14.28,
            height: 18.76,
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MyOrdersListScreen()));
          },
        ),

        /*ListTile(
          contentPadding: EdgeInsets.only(left: 20.4),
          visualDensity: VisualDensity(horizontal: 0, vertical: -3),
          title: Align(
            alignment: Alignment(-1.21, 0),
            child: Text(
              "Book now",
              style: Styles.navDrawerTextStyle02,
            ),
          ),
          leading: Container(
            child: SvgPicture.asset(
                 'assets/image/ic_book_now.svg',
                  width: 14.28,
                  height: 18.76,
                ),
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CustomerBookNowScreen()));
          },
        ),*/
        ListTile(
          contentPadding: const EdgeInsets.only(left: 20.4),
          visualDensity: const VisualDensity(horizontal: 0, vertical: -3),
          title: const Align(
            alignment: Alignment(-1.21, 0),
            child: Text(
              "My wallet",
              style: Styles.navDrawerTextStyle02,
            ),
          ),
          leading: Image.asset(
            'assets/image/ic_my_wallet.png',
            width: 14.28,
            height: 18.76,
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const CustomerWalletScreen()));
          },
        ),

        ListTile(
          contentPadding: const EdgeInsets.only(left: 20.4),
          visualDensity: const VisualDensity(horizontal: 0, vertical: -3),
          title: const Align(
            alignment: Alignment(-1.21, 0),
            child: Text(
              "My vehicles",
              style: Styles.navDrawerTextStyle02,
            ),
          ),
          leading: SvgPicture.asset(
            'assets/image/ic_my_vehicles.svg',
            width: 14.28,
            height: 18.76,
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CustomerMyVehicleScreen()));
          },
        ),

        ListTile(
          contentPadding: const EdgeInsets.only(left: 20.4),
          visualDensity: const VisualDensity(horizontal: 0, vertical: -3),
          title: const Align(
            alignment: Alignment(-1.22, 0),
            child: Text(
              "My Services",
              style: Styles.navDrawerTextStyle02,
            ),
          ),
          leading: SvgPicture.asset(
            'assets/image/ic_my_appointments.svg',
            width: 14.28,
            height: 18.76,
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CustomerMyServicesScreen()));
          },
        ),

        ListTile(
          contentPadding: const EdgeInsets.only(left: 20.4),
          visualDensity: const VisualDensity(horizontal: 0, vertical: -3),
          title: const Align(
            alignment:  Alignment(-1.21, 0),
            child:  Text(
              "Edit profile",
              style: Styles.navDrawerTextStyle02,
            ),
          ),
          leading: SvgPicture.asset(
            'assets/image/ic_edit_profile.svg',
            width: 14.28,
            height: 18.76,
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CustomerMyProfileScreen(isEnableEditing: true)));
          },
        ),

        ListTile(
          contentPadding: EdgeInsets.only(left: 20.4),
          visualDensity: VisualDensity(horizontal: 0, vertical: -3),
          title: Align(
            alignment: Alignment(-1.21, 0),
            child: Text(
              "Notification",
              style: Styles.navDrawerTextStyle02,
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
                MaterialPageRoute(builder: (context) => CustNotificationList()));
          },
        ),

        ListTile(
          contentPadding: const EdgeInsets.only(left: 20.4),
          visualDensity: const VisualDensity(horizontal: 0, vertical: -3),
          title: const Align(
            alignment:  Alignment(-1.18, 0),
            child:  Text(
              "Logout",
              style: Styles.navDrawerTextStyle02,
            ),
          ),
          leading: SvgPicture.asset(
            'assets/image/ic_logout.svg',
            width: 21.84,
            height: 20.44,
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

        const SizedBox(
            child: Divider(
              thickness: 1,
              height: 0,
            )),

        const SizedBox(
          height: 25,
            ),

        Container(
          margin: const EdgeInsets.only(left: 46, top: 10),
          child: ListTile(
            visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
            title: const Text(
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
          margin: const EdgeInsets.only(left: 46),
          child: ListTile(
            visualDensity: const VisualDensity(horizontal: 0, vertical: -3),
            title: const Text(
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
          margin: const EdgeInsets.only(left: 46),
          child: ListTile(
            visualDensity: const VisualDensity(horizontal: 0, vertical: -3),
            title: const Text(
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
      height: size.height * 37 / 100,
      decoration: const BoxDecoration(
        color: CustColors.light_navy,
        borderRadius:  BorderRadius.only(
          bottomRight: Radius.circular(
            72,
          ),
        ),
      ),
      child: Column(
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
                  margin: const EdgeInsets.only(left: 14.6, top: 4),
                  alignment: Alignment.center,
                  child: const Text(
                    'Home',
                    style:  TextStyle(
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
              margin: EdgeInsets.only(
                  top: size.height * 5 / 100,
                  right: size.width * 10 / 100
              ),
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                            right: 2
                        ),
                        width: 93,
                        height: 93,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius:  BorderRadius.all(
                            Radius.circular(
                              72,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 88.0,
                        height: 88.0,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child:CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.white,
                                child: ClipOval(
                                    child: profileImageUrl != ""
                                        ?
                                    Image.network(profileImageUrl,
                                      width: 150,
                                      height: 150,
                                      fit: BoxFit.cover,
                                    )
                                        :
                                    SvgPicture.asset('assets/image/CustomerType/profileAvathar.svg')
                                ))

                        ),
                      ),

                      /*Positioned(
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
                    margin: EdgeInsets.only(top: size.height * 1 / 100),
                    child: Text(
                      //_userName.toString(),
                      userName,
                      softWrap: true,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
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
      title: const Text("Logout account?",
          style: TextStyle(
            fontFamily: 'Formular',
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: CustColors.materialBlue,
          )),
      content: const Text("Are you sure you want to logout?"),
      actions: <Widget>[
        CupertinoDialogAction(
            textStyle: const TextStyle(
              color: CustColors.rusty_red,
              fontWeight: FontWeight.normal,
            ),
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(dialogContext!);
            },
            child: const Text("Cancel")),
        CupertinoDialogAction(
            textStyle: const TextStyle(
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
                        builder: (context) => const LoginScreen()),
                    ModalRoute.withName("/LoginScreen"));
              });
            },
            child: const Text("Logout")),
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
