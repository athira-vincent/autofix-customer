import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Cart/customer_cart.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/customer_home.dart';
import 'package:auto_fix/UI/Customer/BottomBar/MyProfile/customer_my_profile.dart';
import 'package:auto_fix/UI/Customer/BottomBar/MyServices/customer_my_services.dart';
import 'package:auto_fix/UI/Customer/SideBar/navigation_drawer_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'BottomBar/Home/customer_home.dart';

class CustomerHomeScreen extends StatefulWidget {

  CustomerHomeScreen();

  @override
  State<StatefulWidget> createState() {
    return _CustomerHomeScreenState();
  }
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {

  int _index = 0;
  int _counter = 0;

  var scaffoldKey = GlobalKey<ScaffoldState>();

  double per = .10;
  double perfont = .10;


  double _setValue(double value) {
    return value * per + value;
  }

  double _setValueFont(double value) {
    return value * perfont + value;
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;




    var bottomNavigationBarItems = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
          backgroundColor: Colors.white,
          icon: Column(
            children: [
              Container(
                  child: _index == 0
                      ? Image.asset('assets/image/ic_home_active.png',
                    width: _setValue(26),
                    height: _setValue(26),
                  )
                      : SvgPicture.asset(
                    'assets/image/ic_home_inactive.svg',
                    width: _setValue(26),
                    height: _setValue(26),
                  )
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 4, 0, 0),
                child: Text(
                  'Home',
                  style: _index == 0
                      ? Styles.homeActiveTextStyle
                      : Styles.homeInactiveTextStyle,
                ),
              ),
            ],
          ),
          label: ''
      ),
      BottomNavigationBarItem(
          backgroundColor: Colors.white,
          icon: Column(
            children: [
              Container(
                child: _index == 1
                    ? SvgPicture.asset(
                  'assets/image/ic_home_cart_active.svg',
                  width: _setValue(26),
                  height: _setValue(26),
                )
                    : Image.asset(
                  'assets/image/ic_home_cart_inactive.png',
                  width: _setValue(28),
                  height: _setValue(28),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 4, 0, 0),
                child: Text(
                  'Cart',
                  style: _index == 1
                      ? Styles.homeActiveTextStyle
                      : Styles.homeInactiveTextStyle,
                ),
              ),
            ],
          ),
          label: ''
      ),
      BottomNavigationBarItem(
          backgroundColor: Colors.white,
          icon: Column(
            children: [
              Container(
                child:
                _index == 2
                    ? SvgPicture.asset(
                      'assets/image/ic_home_service_active.svg',
                      width: _setValue(26),
                      height: _setValue(26),
                    )
                    : Image.asset(
                  'assets/image/ic_home_service_inactive.png',
                  width: _setValue(26),
                  height: _setValue(26),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 4, 0, 0),
                child: Text(
                  'My services ',
                  style: _index == 2
                      ? Styles.homeActiveTextStyle
                      : Styles.homeInactiveTextStyle,
                ),
              ),
            ],
          ),
          label: ''
      ),
      BottomNavigationBarItem(
          backgroundColor: Colors.white,
          icon: Column(
            children: [
              Container(
                child: _index == 3
                    ? SvgPicture.asset(
                  'assets/image/ic_home_profile_active.svg',
                  width: _setValue(26),
                  height: _setValue(26),
                )
                    : Image.asset(
                  'assets/image/ic_home_profile_inactive.png',
                  width: _setValue(26),
                  height: _setValue(26),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 4, 0, 0),
                child: Text(
                  'Profile',
                  style: _index == 3
                      ? Styles.homeActiveTextStyle
                      : Styles.homeInactiveTextStyle,
                ),
              ),
            ],
          ),
          label: ''
      ),
    ];


    return Scaffold(
      drawer: CustomerNavigationDrawerScreen(),
      key: scaffoldKey,
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0 + MediaQuery.of(context).padding.top),
        child: AppBar(

          actions: [],
          automaticallyImplyLeading: false,
          flexibleSpace: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(
                    left: 21, top: 30 + MediaQuery.of(context).padding.top),
                child: GestureDetector(
                    onTap: () {
                      scaffoldKey.currentState?.openDrawer();
                    },
                    child: Image.asset(
                      'assets/image/ic_drawer.png',
                      width: 25,
                      height: 25,
                    )),
              ),

              Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                      top: 32.5 + MediaQuery.of(context).padding.top, left: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        //"Hi $_userName",
                        "Welcome",
                        style: Styles.homeWelcomeTextStyle,
                      ),
                      Text(
                        " Athira",
                        style: Styles.homeNameTextStyle,
                      ),
                      Text(
                        " !",
                        style: Styles.homeWelcomeSymbolTextStyle,
                      ),
                    ],
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.only(
                     top: 36 + MediaQuery.of(context).padding.top,
                  right: size.width * 4.2/100
                ),
                child: Stack(
                  children: [
                        GestureDetector(
                        onTap: () {},
                          child: SvgPicture.asset(
                            'assets/image/notification_icon.svg',
                            width: 25,
                            height: 25,
                          ),
                        ),
                    Positioned(
                      right: 0,
                      child: _counter > 0 ? Container(
                        padding: EdgeInsets.all(1),
                        decoration: new BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        constraints: BoxConstraints(
                          minWidth: 12,
                          minHeight: 12,
                        ),
                        child: new Text(
                         '$_counter',
                          style: new TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ) : Container(),
                    ),

                  ],
                ),
              ),
            ],
          ),
          backgroundColor: Colors.white,
          shadowColor: Colors.white,
        ),
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            child: _index == 0 ? HomeCustomerUIScreen() :
                _index == 1 ? CustomerCartScreen() :
                _index == 2 ? CustomerMyProfileScreen() : CustomerMyServiceScreen(),

          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.only(
          //     topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
          ],
        ),
        child: ClipRRect(
          // borderRadius: BorderRadius.only(
          //   topLeft: Radius.circular(48),
          //   topRight: Radius.circular(48),
          // ),
          child: SizedBox(
            height: size.height * 0.090,
            child: BottomNavigationBar(
              selectedLabelStyle: TextStyle(
                  fontFamily: 'Corbel_Light',
                  fontWeight: FontWeight.w600,
                  fontSize: 0),
              unselectedLabelStyle: TextStyle(
                  fontFamily: 'Corbel_Light',
                  fontWeight: FontWeight.w600,
                  fontSize: 0),
              items: bottomNavigationBarItems,
              currentIndex: _index,
              //backgroundColor: CustColors.blue,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.blue,
              unselectedItemColor: Colors.grey,
              onTap: (index) {
                setState(() {
                  _index = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }

}