import 'package:flutter/material.dart';

class CustomerMyVehicleScreen extends StatefulWidget {

  CustomerMyVehicleScreen();

  @override
  State<StatefulWidget> createState() {
    return _CustomerMyVehicleScreenState();
  }
}

class _CustomerMyVehicleScreenState extends State<CustomerMyVehicleScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text(
            "My Vehicle"
          ),
        ),
      ),
    );
  }

}
