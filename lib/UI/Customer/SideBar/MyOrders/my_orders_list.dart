import 'package:flutter/material.dart';

class MyOrdersListScreen extends StatefulWidget {

  MyOrdersListScreen();

  @override
  State<StatefulWidget> createState() {
    return _MyOrdersListScreenState();
  }
}

class _MyOrdersListScreenState extends State<MyOrdersListScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text(
            "Order List"
          ),
        ),
      ),
    );
  }

}
