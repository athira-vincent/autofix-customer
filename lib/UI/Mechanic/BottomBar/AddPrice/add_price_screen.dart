import 'package:flutter/material.dart';

class MechanicAddPriceScreen extends StatefulWidget {

  MechanicAddPriceScreen();

  @override
  State<StatefulWidget> createState() {
    return _MechanicAddPriceScreenState();
  }
}

class _MechanicAddPriceScreenState extends State<MechanicAddPriceScreen> {
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Container(
            width: size.width,
            height: size.height,
            child: Center(
              child: Text(
                  "Add price"
              ),
            ),
          ),
        ),
      ),
    );
  }

}