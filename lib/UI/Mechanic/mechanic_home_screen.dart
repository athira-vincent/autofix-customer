import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/UI/Mechanic/BottomBar/AddPrice/add_price_screen.dart';
import 'package:auto_fix/UI/Mechanic/BottomBar/Home/mechanic_home_screen_ui.dart';
import 'package:auto_fix/UI/Mechanic/BottomBar/MyProfile/profile_Mechanic_Ui/mechanic_my_profile.dart';
import 'package:auto_fix/UI/Mechanic/BottomBar/MyServices/my_services_screen.dart';
import 'package:auto_fix/UI/Mechanic/SideBar/mechanic_side_bar.dart';
import 'package:auto_fix/UI/Mechanic/WorkFlowScreens/IncomingJobRequestScreen/incoming_job_request_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class MechanicHomeScreen extends StatefulWidget {

  MechanicHomeScreen();

  @override
  State<StatefulWidget> createState() {
    return _MechanicHomeScreenState();
  }
}

class _MechanicHomeScreenState extends State<MechanicHomeScreen> {

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
          icon: Container(
            child: Column(
              children: [
                Container(
                    width: _setValue(25),
                    height: _setValue(25),
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
          ),
          label: ''
      ),
      BottomNavigationBarItem(
          backgroundColor: Colors.white,
          icon: Container(
            child: Column(
              children: [
                Container(
                    width: _setValue(25),
                    height: _setValue(25),
                    child: _index == 1
                        ? Image.asset('assets/image/ic_home_price_fault_active.png',
                      width: _setValue(26),
                      height: _setValue(26),
                    )
                        : SvgPicture.asset(
                      'assets/image/ic_home_price_fault_inactive.png.svg',
                      width: _setValue(26),
                      height: _setValue(26),
                    )
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 4, 0, 0),
                  child: Text(
                    'Add price',
                    style: _index == 1
                        ? Styles.homeActiveTextStyle
                        : Styles.homeInactiveTextStyle,
                  ),
                ),
              ],
            ),
          ),
          label: ''
      ),
      BottomNavigationBarItem(
          backgroundColor: Colors.white,
          icon: Container(
            child: Column(
              children: [
                Container(
                    width: _setValue(25),
                    height: _setValue(25),
                    child: _index == 2
                        ? SvgPicture.asset('assets/image/ic_home_service_active.svg',
                      width: _setValue(26),
                      height: _setValue(26),
                    )
                        : Image.asset(
                      'assets/image/ic_home_service_inactive.png',
                      width: _setValue(26),
                      height: _setValue(26),
                    )
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 4, 0, 0),
                  child: Text(
                    'My services',
                    style: _index == 2
                        ? Styles.homeActiveTextStyle
                        : Styles.homeInactiveTextStyle,
                  ),
                ),
              ],
            ),
          ),
          label: ''
      ),
      BottomNavigationBarItem(
          backgroundColor: Colors.white,
          icon: Column(
            children: [
              Container(
                width: _setValue(25),
                height: _setValue(25),
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
      drawer: MechanicSideBarScreen(),
      key: scaffoldKey,
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
                    left: 21, top: 20 + MediaQuery.of(context).padding.top),
                child: GestureDetector(
                    onTap: () {
                      scaffoldKey.currentState?.openDrawer();
                    },
                    child: Image.asset(
                      'assets/image/ic_drawer.png',
                      width: 30,
                      height: 30,
                    )),
              ),

              Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                      top: 25 + MediaQuery.of(context).padding.top, left: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome",
                        style: Styles.homeWelcomeTextStyle,
                      ),
                      Text(
                        //"welcome $_userName",
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

              InkWell(
                onTap: (){
                  print("on tap notification icon");

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  IncomingJobRequestScreen(serviceModel: "0",)));

                },
                child: Container(
                  margin: EdgeInsets.only(
                       top: 25 + MediaQuery.of(context).padding.top,
                    right: size.width * 4.2/100
                  ),
                  child: Stack(
                    children: [
                          SvgPicture.asset(
                            'assets/image/notification_icon.svg',
                            width: 22,
                            height: 22,
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
            child: _index == 0
                ? MechanicHomeUIScreen()
                : _index == 1 ? MechanicAddPriceScreen()
                : _index == 2 ? MechanicMyServiceScreen()
                : MechanicMyProfileScreen(),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
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
            height: size.height * 0.092,
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