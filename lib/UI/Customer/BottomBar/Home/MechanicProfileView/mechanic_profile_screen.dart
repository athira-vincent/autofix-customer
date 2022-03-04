import 'package:flutter/material.dart';

class MechanicProfileViewScreen extends StatefulWidget {

  MechanicProfileViewScreen();

  @override
  State<StatefulWidget> createState() {
    return _MechanicProfileViewScreenState();
  }
}

class _MechanicProfileViewScreenState extends State<MechanicProfileViewScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text("Cart"),
        ),
      ),
    );
  }

}
