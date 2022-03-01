import 'package:flutter/material.dart';

class CustomerMyProfileScreen extends StatefulWidget {

  CustomerMyProfileScreen();

  @override
  State<StatefulWidget> createState() {
    return _CustomerMyProfileScreenState();
  }
}

class _CustomerMyProfileScreenState extends State<CustomerMyProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text("My Profile"),
        ),
      ),
    );
  }

}
