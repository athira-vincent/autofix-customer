import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/UI/Customer/Home/BottomBar/Profile/profile_screen.dart';
import 'package:auto_fix/UI/Customer/Home/BottomBar/Services/services_screen.dart';
import 'package:auto_fix/UI/Customer/Home/BottomBar/SpairParts/spair_parts_screen.dart';
import 'package:auto_fix/UI/Customer/Home/SideBar/navigation_drawer_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;
  String _userName = "";
  var scaffoldKey = GlobalKey<ScaffoldState>();
  double per = .10;
  double _setValue(double value) {
    return value * per + value;
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  _getUser() async {
    SharedPreferences _shdPre = await SharedPreferences.getInstance();
    _userName = _shdPre.getString(SharedPrefKeys.userName).toString();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var bottomNavigationBarItems = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
          icon: Container(
            margin: EdgeInsets.only(bottom: 12),
            child: Image.asset(
              'assets/images/profile_blue.png',
              width: _setValue(22.4),
              height: _setValue(27.2),
            ),
          ),
          label: 'Profile'),
      BottomNavigationBarItem(
          icon: Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Image.asset(
              'assets/images/spair_parts.png',
              width: _setValue(29),
              height: _setValue(29),
            ),
          ),
          label: 'Spare Parts'),
      BottomNavigationBarItem(
          icon: Container(
            margin: EdgeInsets.only(bottom: 12),
            child: Image.asset(
              'assets/images/services.png',
              width: _setValue(28.4),
              height: _setValue(27.2),
            ),
          ),
          label: 'Services'),
    ];
    return Scaffold(
      drawer: NavigationDrawerScreen(),
      key: scaffoldKey,
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
                      "Hi $_userName",
                      style: TextStyle(
                          fontFamily: 'Corbel_Light',
                          fontSize: 17,
                          color: Colors.white),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Text(
                        "Enjoy our service",
                        style: TextStyle(
                            fontFamily: 'Corbel_Light',
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
            child: _index == 0
                ? ServicesScreen()
                : _index == 1
                    ? SpairPartsScreen()
                    : ProfileScreen(),
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
              selectedLabelStyle:
                  TextStyle(fontFamily: 'Corbel_Light', fontSize: 9.5),
              unselectedLabelStyle:
                  TextStyle(fontFamily: 'Corbel_Light', fontSize: 9.5),
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
