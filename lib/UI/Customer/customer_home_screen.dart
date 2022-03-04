import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Cart/customer_cart.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/customer_home.dart';
import 'package:auto_fix/UI/Customer/BottomBar/MyProfile/customer_my_profile.dart';
import 'package:auto_fix/UI/Customer/BottomBar/MyServices/customer_my_services.dart';
import 'package:auto_fix/UI/Customer/SideBar/navigation_drawer_screen.dart';
import 'package:flutter/material.dart';

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

    var bottomNavigationBarItems = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
          icon: Container(
            margin: EdgeInsets.only(top: 2.3),
            width: _setValue(65),
            height: _setValue(65),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: _index == 0
                    ? Colors.white.withOpacity(.05)
                    : Colors.transparent),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(top: _setValue(5.1)),
                  child: Image.asset(
                    'assets/images/profile_blue.png',
                    width: _setValue(22.4),
                    height: _setValue(27.2),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: _setValue(10.1)),
                  child: Text(
                    'Home',
                    style: TextStyle(
                        fontFamily: 'Corbel_Light',
                        fontSize: _setValueFont(9.5),
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          label: ''),
      BottomNavigationBarItem(
          icon: Container(
            margin: EdgeInsets.only(top: 2.3),
            width: _setValue(65),
            height: _setValue(65),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: _index == 1
                    ? Colors.white.withOpacity(.05)
                    : Colors.transparent),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(top: _setValue(5.1)),
                  child: Image.asset(
                    'assets/images/spair_parts.png',
                    width: _setValue(29),
                    height: _setValue(29),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: _setValue(10.1)),
                  child: Text(
                    'Cart',
                    style: TextStyle(
                        fontFamily: 'Corbel_Light',
                        fontSize: _setValueFont(9.5),
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          label: ''),
      BottomNavigationBarItem(
          icon: Container(
            margin: EdgeInsets.only(top: 2.3),
            width: _setValue(65),
            height: _setValue(65),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: _index == 2
                  ? Colors.white.withOpacity(.05)
                  : Colors.transparent,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(top: _setValue(5.1)),
                  child: Image.asset(
                    'assets/images/services.png',
                    width: _setValue(32.4),
                    height: _setValue(31.2),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: _setValue(10.1)),
                  child: Text(
                    'My services ',
                    style: TextStyle(
                        fontFamily: 'Corbel_Light',
                        fontSize: _setValueFont(9.5),
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          label: ''),
      BottomNavigationBarItem(
          icon: Container(
            margin: EdgeInsets.only(top: 2.3),
            width: _setValue(65),
            height: _setValue(65),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: _index == 3
                  ? Colors.white.withOpacity(.05)
                  : Colors.transparent,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(top: _setValue(5.1)),
                  child: Image.asset(
                    'assets/images/services.png',
                    width: _setValue(32.4),
                    height: _setValue(31.2),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: _setValue(10.1)),
                  child: Text(
                    'Profile',
                    style: TextStyle(
                        fontFamily: 'Corbel_Light',
                        fontSize: _setValueFont(9.5),
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          label: ''),
    ];
    return Scaffold(
      drawer: CustomerNavigationDrawerScreen(),
      key: scaffoldKey,
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize:
        Size.fromHeight(60.0 + MediaQuery.of(context).padding.top),
        child: AppBar(
          actions: [],
          automaticallyImplyLeading: false,
          flexibleSpace: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(
                    left: 21, top: 36 + MediaQuery.of(context).padding.top),
                child: GestureDetector(
                    onTap: () {
                      scaffoldKey.currentState?.openDrawer();
                    },
                    child: Image.asset(
                      'assets/images/drawer.png',
                      width: 25,
                      height: 25,
                    )),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: 32.3 + MediaQuery.of(context).padding.top, left: 44.6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      //"Hi $_userName",
                      "Hi Abc",
                      style: TextStyle(
                          fontFamily: 'Corbel_Light',
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                          color: Colors.white),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Text(
                        "Welcome",
                        style: TextStyle(
                            fontFamily: 'Corbel_Light',
                            fontWeight: FontWeight.w600,
                            fontSize: 17,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
      ),
      body: Stack(
        children: [
          Container(
              color: Colors.white,
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top,
              ),
              child: Image.asset(
                'assets/images/app_bar_arc.png',
              )),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 120,
            ),
            child: _index == 0 ? HomeCustomerUIScreen() :
                _index == 1 ? CustomerCartScreen() :
                _index == 2 ? CustomerMyProfileScreen() : CustomerMyServiceScreen(),

          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(48),
            topRight: Radius.circular(48),
          ),
          child: SizedBox(
            height: 75,
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
              backgroundColor: CustColors.blue,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white,
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