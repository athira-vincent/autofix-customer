import 'package:flutter/material.dart';

class CustomerDirectPaymentScreen extends StatefulWidget {

  CustomerDirectPaymentScreen();

  @override
  State<StatefulWidget> createState() {
    return _CustomerDirectPaymentScreenState();
  }
}

class _CustomerDirectPaymentScreenState extends State<CustomerDirectPaymentScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
              child: SingleChildScrollView(

              )
          )
      ),
    );
  }

}
