import 'package:flutter/material.dart';

class MechanicMyProfileScreen extends StatefulWidget {

  MechanicMyProfileScreen();

  @override
  State<StatefulWidget> createState() {
    return _MechanicMyProfileScreenState();
  }
}

class _MechanicMyProfileScreenState extends State<MechanicMyProfileScreen> {
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Container(
            width: size.width,
            height: size.height,
            child: Center(
              child: Text(
                "Mechanic My Profile"
              ),
            ),
          ),
        ),
      ),
    );
  }

}