import 'package:flutter/material.dart';

class CustomerMyAppointmentScreen extends StatefulWidget {

  CustomerMyAppointmentScreen();

  @override
  State<StatefulWidget> createState() {
    return _CustomerMyAppointmentScreenState();
  }
}

class _CustomerMyAppointmentScreenState extends State<CustomerMyAppointmentScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text(
            "My Appointment"
          ),
        ),
      ),
    );
  }

}
