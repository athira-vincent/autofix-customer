import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/UI/Common/GenerateAuthorization/generate_authorization_bloc.dart';
import 'package:auto_fix/UI/Mechanic/Home/BottomBar/CompletedSevice/completed_service_screen.dart';
import 'package:auto_fix/UI/Mechanic/Home/BottomBar/TodaysService/todays_service_screen.dart';
import 'package:auto_fix/UI/Mechanic/Home/BottomBar/UpcomingService/upcoming_service_screen.dart';
import 'package:auto_fix/UI/Mechanic/Home/SideBar/navigation_drawer_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MechanicHomeScreen extends StatefulWidget {
  const MechanicHomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MechanicHomeScreenState();
  }
}

class _MechanicHomeScreenState extends State<MechanicHomeScreen> {
  int _index = 0;
  String _userName = "";  var scaffoldKey = GlobalKey<ScaffoldState>();
  double per = .10;
  double perfont = .10;
  GenerateAuthorizationBloc _generateAuthorizationBloc =
      GenerateAuthorizationBloc();
  double _setValue(double value) {
    return value * per + value;
  }

  double _setValueFont(double value) {
    return value * perfont + value;
  }

  @override
  void initState() {
    super.initState();
    _index = 1;
    _getUser();
    _getToken();
  }

  _getUser() async {
    SharedPreferences _shdPre = await SharedPreferences.getInstance();
    _userName = _shdPre.getString(SharedPrefKeys.userName).toString();
    setState(() {});
  }

  _getToken() async {
    SharedPreferences _shdPre = await SharedPreferences.getInstance();
    _generateAuthorizationBloc.postGenerateAutorizationRequest(
        _shdPre.getInt(SharedPrefKeys.userID).toString(), 1);
    _getSignUpRes();
  }

  _getSignUpRes() {
    _generateAuthorizationBloc.postGenerateAutorization.listen((value) async {
      if (value.status == "error") {
      } else {
        SharedPreferences shdPre = await SharedPreferences.getInstance();
        shdPre.setString(
            SharedPrefKeys.token, value.data!.generateAuthorization!.token!);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _generateAuthorizationBloc.dispose();
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
                    'Upcoming ',
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
                    'Today\'s',
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
                    'Completed',
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
      drawer: MechanicNavigationDrawerScreen(),
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
                      "Hi $_userName",
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
            child: _index == 0
                ? UpcomingServiceScreen()
                : _index == 1
                    ? TodayServiceScreen()
                    : CompletedServiceScreen(),
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
