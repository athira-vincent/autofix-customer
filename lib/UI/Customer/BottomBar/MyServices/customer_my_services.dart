import 'package:flutter/material.dart';

class CustomerMyServiceScreen extends StatefulWidget {

  CustomerMyServiceScreen();

  @override
  State<StatefulWidget> createState() {
    return _CustomerMyServiceScreenState();
  }
}

class _CustomerMyServiceScreenState extends State<CustomerMyServiceScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text("My Services"),
        ),
      ),
    );
  }

}
