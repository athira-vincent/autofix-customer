import 'package:flutter/material.dart';

class MechanicHomeUIScreen extends StatefulWidget {

  MechanicHomeUIScreen();

  @override
  State<StatefulWidget> createState() {
    return _MechanicHomeUIScreenState();
  }
}

class _MechanicHomeUIScreenState extends State<MechanicHomeUIScreen> {
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
                  "Mechanic Home UI Screen"
              ),
            ),
          ),
        ),
      ),
    );
  }

}