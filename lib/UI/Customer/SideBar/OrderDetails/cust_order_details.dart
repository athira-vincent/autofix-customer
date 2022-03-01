import 'package:flutter/material.dart';

class CustomerOrderDetailsScreen extends StatefulWidget {

  CustomerOrderDetailsScreen();

  @override
  State<StatefulWidget> createState() {
    return _CustomerOrderDetailsScreenState();
  }
}

class _CustomerOrderDetailsScreenState extends State<CustomerOrderDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text(
            "Order Details"
          ),
        ),
      ),
    );
  }

}
