import 'package:auto_fix/UI/SideBar/navigation_drawer_screen.dart';
import 'package:flutter/material.dart';

class MechanicHomeScreen extends StatefulWidget {
  const MechanicHomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MechanicHomeScreenState();
  }
}

class _MechanicHomeScreenState extends State<MechanicHomeScreen> {
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
