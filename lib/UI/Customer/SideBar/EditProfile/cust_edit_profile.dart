import 'package:flutter/material.dart';

class CustomerEditProfileScreen extends StatefulWidget {

  CustomerEditProfileScreen();

  @override
  State<StatefulWidget> createState() {
    return _CustomerEditProfileScreenState();
  }
}

class _CustomerEditProfileScreenState extends State<CustomerEditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text("Edit Profile")
        ),
      ),
    );
  }

}
