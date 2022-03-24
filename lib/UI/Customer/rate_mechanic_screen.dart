import 'package:flutter/material.dart';

class RateMechanicScreen extends StatefulWidget {

  RateMechanicScreen();

  @override
  State<StatefulWidget> createState() {
    return _RateMechanicScreenState();
  }
}

class _RateMechanicScreenState extends State<RateMechanicScreen> {

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
            color: Colors.blueAccent,
          ),
        ),
      ),
    );
  }

}