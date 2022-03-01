import 'package:flutter/material.dart';

class CustomerCartScreen extends StatefulWidget {

  CustomerCartScreen();

  @override
  State<StatefulWidget> createState() {
    return _CustomerCartScreenState();
  }
}

class _CustomerCartScreenState extends State<CustomerCartScreen> {
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
