import 'package:flutter/material.dart';

class CustomerBookNowScreen extends StatefulWidget {

  CustomerBookNowScreen();

  @override
  State<StatefulWidget> createState() {
    return _CustomerBookNowScreenState();
  }
}

class _CustomerBookNowScreenState extends State<CustomerBookNowScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text(
            "Book Now",
          ),
        ),
      ),
    );
  }

}
