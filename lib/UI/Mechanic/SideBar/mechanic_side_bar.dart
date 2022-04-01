import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/grapgh_ql_client.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/UI/Customer/SideBar/BookNow/cust_book_now.dart';
import 'package:auto_fix/UI/Customer/SideBar/EditProfile/cust_edit_profile.dart';
import 'package:auto_fix/UI/Customer/SideBar/MyAppointments/cust_my_appointment.dart';
import 'package:auto_fix/UI/Customer/SideBar/MyVehicles/cust_my_vehicles.dart';
import 'package:auto_fix/UI/Customer/SideBar/OrderDetails/cust_order_details.dart';
import 'package:auto_fix/UI/Mechanic/SideBar/MyWallet/my_wallet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MechanicSideBarScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MechanicSideBarScreenState();
  }
}

class _MechanicSideBarScreenState extends State<MechanicSideBarScreen> {
  String? _userName;
  String? _userEmail;
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
    Size size = MediaQuery.of(context).size;
    final drawerItems = ListView(
      padding: const EdgeInsets.all(0.0),
      children: [
        // drawerHeader,
        navigationBarHeader(size),

        ListTile(
          contentPadding: EdgeInsets.only(left: 20.4, top: 13),
          visualDensity: VisualDensity(horizontal: 0, vertical: -3),
          title: Align(
            alignment: Alignment(-1.21, 0),
            child: Text(
              "My wallet",
              style: Styles.navDrawerTextStyle02,
            ),
          ),
          leading: Container(
            child: Image.asset(
              'assets/image/ic_my_wallet.png',
              width: 14.28,
              height: 18.76,
            ),
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MechanicMyWalletScreen()));
          },
        ),

        ListTile(
          contentPadding: EdgeInsets.only(left: 20.4, top: 13),
          visualDensity: VisualDensity(horizontal: 0, vertical: -3),
          title: Align(
            alignment: Alignment(-1.21, 0),
            child: Text(
              "Order details",
              style: Styles.navDrawerTextStyle02,
            ),
          ),
          leading: Container(
            child: Image.asset(
              'assets/image/ic_order_details.png',
              width: 14.28,
              height: 18.76,
            ),
          ),
          /*onTap: () {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CustomerOrderDetailsScreen()));
          },*/
        ),

        ListTile(
          contentPadding: EdgeInsets.only(left: 20.4),
          visualDensity: VisualDensity(horizontal: 0, vertical: -3),
          title: Align(
            alignment: Alignment(-1.21, 0),
            child: Text(
              "My brand specialization",
              style: Styles.navDrawerTextStyle02,
            ),
          ),
          leading: Container(
            child: Image.asset(
              'assets/image/ic_my_specialization.png',
              width: 14.28,
              height: 18.76,
            ),
          ),
         /* onTap: () {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CustomerBookNowScreen()));
          },*/
        ),

        ListTile(
          contentPadding: EdgeInsets.only(left: 20.4),
          visualDensity: VisualDensity(horizontal: 0, vertical: -3),
          title: Align(
            alignment: Alignment(-1.21, 0),
            child: Text(
              "My job appointment",
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
          /*onTap: () {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CustomerMyVehicleScreen()));
          },*/
        ),

        ListTile(
          contentPadding: EdgeInsets.only(left: 20.4),
          visualDensity: VisualDensity(horizontal: 0, vertical: -3),
          title: Align(
            alignment: Alignment(-1.21, 0),
            child: Text(
              "My job reviews",
              style: Styles.navDrawerTextStyle02,
            ),
          ),
          leading: Container(
            child: Image.asset(
              'assets/image/ic_job_review.png',
              width: 14.28,
              height: 18.76,
            ),
          ),
          /*onTap: () {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CustomerMyAppointmentScreen()));
          },*/
        ),

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
              width: 14.28,
              height: 18.76,
            ),
          ),
         /* onTap: () {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CustomerEditProfileScreen()));
          },*/
        ),

        ListTile(
          contentPadding: EdgeInsets.only(left: 20.4),
          visualDensity: VisualDensity(horizontal: 0, vertical: -3),
          title: Align(
            alignment: Alignment(-1.21, 0),
            child: Text(
              "Add price & fault",
              style: Styles.navDrawerTextStyle02,
            ),
          ),
          leading: Container(
            child: Image.asset(
              'assets/image/ic_price_fault.png',
              width: 14.28,
              height: 18.76,
            ),
          ),
          /* onTap: () {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CustomerEditProfileScreen()));
          },*/
        ),

        ListTile(
          contentPadding: EdgeInsets.only(left: 20.4),
          visualDensity: VisualDensity(horizontal: 0, vertical: -3),
          title: Align(
            alignment: Alignment(-1.18, 0),
            child: Text(
              "Logout",
              style: TextStyle(
                  fontFamily: 'Corbel_Regular',
                  fontWeight: FontWeight.w600,
                  fontSize: 14.5,
                  color: CustColors.blue),
            ),
          ),
          leading: Container(
            child: SvgPicture.asset(
              'assets/image/ic_logout.svg',
              width: 21.84,
              height: 20.44,
            ),
          ),
          onTap: () {
            _logout();
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
              style: TextStyle(
                  fontFamily: 'Corbel_Regular',
                  fontWeight: FontWeight.w600,
                  fontSize: 14.5,
                  color: CustColors.blue),
            ),
            onTap: () {
              print(" on Tap Privacy policy");
            },
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 46),
          child: ListTile(
            visualDensity: VisualDensity(horizontal: 0, vertical: -3),
            title: Text(
              "Help & support Center",
              style: TextStyle(
                  fontFamily: 'Corbel_Regular',
                  fontWeight: FontWeight.w600,
                  fontSize: 14.5,
                  color: CustColors.blue),
            ),
            onTap: () {
              print("on Tap Help & support Center");
            },
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 46),
          child: ListTile(
            visualDensity: VisualDensity(horizontal: 0, vertical: -3),
            title: Text(
              "Terms & conditions",
              style: TextStyle(
                  fontFamily: 'Corbel_Regular',
                  fontWeight: FontWeight.w600,
                  fontSize: 14.5,
                  color: CustColors.blue),
            ),
            onTap: () {
              //_logout();
              print("on Tap Terms & conditions");
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
      height: size.height * 35 / 100,
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
                      ClipRRect(
                        child: Container(
                          margin: EdgeInsets.only(
                              right: 2
                          ),
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

                      Positioned(
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
                      ),

                      Positioned(
                        right: 0,
                        top: 20,
                        child: ClipRRect(
                          child: Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                              color: CustColors.green,
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  25,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: size.height * 1 / 100),
                    child: Text(
                      //_userName.toString(),
                      "Afamefuna",
                      softWrap: true,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Corbel_Bold',
                          color: Colors.white),
                    ),
                  ),
                  RatingBarIndicator(
                    direction: Axis.horizontal,
                    rating: 3.0,
                    itemBuilder: (context, index) => Icon(
                      Icons.star,
                      color: Colors.white,
                    ),
                    itemCount: 5,
                    itemSize: 12.0,
                    unratedColor: CustColors.azul,
                    itemPadding: EdgeInsets.all(1),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

}
