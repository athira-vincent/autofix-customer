import 'package:auto_fix/UI/SideBar/navigation_drawer_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerScreen(),
      appBar: AppBar(
        actions: [],
        title: Text('Hi John'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [],
      ),
    );
  }
}
