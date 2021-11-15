import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/UI/Customer/Home/Profile/profile_screen.dart';
import 'package:auto_fix/UI/Customer/Home/Services/services_screen.dart';
import 'package:auto_fix/UI/Customer/Home/SpairParts/spair_parts_screen.dart';
import 'package:auto_fix/UI/Customer/SideBar/navigation_drawer_screen.dart';
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
          icon: Icon(
            Icons.car_rental,
          ),
          label: 'Services'),
      BottomNavigationBarItem(
          icon: Icon(Icons.room_service_outlined), label: 'Spare Parts'),
      BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
    ];
    return Scaffold(
      drawer: NavigationDrawerScreen(),
      appBar: AppBar(
        actions: [],
        title: Text("Hi $_userName"),
      ),
      body: _index == 0
          ? ServicesScreen()
          : _index == 1
              ? SpairPartsScreen()
              : ProfileScreen(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: bottomNavigationBarItems,
        currentIndex: _index,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: CustColors.blue,
        unselectedItemColor: CustColors.darkBlue,
        onTap: (index) {
          setState(() {
            _index = index;
          });
        },
      ),
    );
  }
}
