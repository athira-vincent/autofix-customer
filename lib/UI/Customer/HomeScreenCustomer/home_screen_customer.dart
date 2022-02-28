import 'package:flutter/material.dart';

class CustomerHomeScreen extends StatefulWidget {

  CustomerHomeScreen();

  @override
  State<StatefulWidget> createState() {
    return _CustomerHomeScreenState();
  }
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(

      ),
    );
  }

}
