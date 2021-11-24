import 'package:auto_fix/UI/Customer/home/SideBar/navigation_drawer_screen.dart';
import 'package:flutter/material.dart';

class VendorHomeScreen extends StatefulWidget {
  const VendorHomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _VendorHomeScreenState();
  }
}

class _VendorHomeScreenState extends State<VendorHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerScreen(),
      appBar: AppBar(
        actions: [],
        title: Text('Hi John'),
      ),
    );
  }
}
