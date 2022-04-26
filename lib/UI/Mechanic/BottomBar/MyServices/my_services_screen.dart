import 'package:flutter/material.dart';

class MechanicMyServiceScreen extends StatefulWidget {

  MechanicMyServiceScreen();

  @override
  State<StatefulWidget> createState() {
    return _MechanicMyServiceScreenState();
  }
}

class _MechanicMyServiceScreenState extends State<MechanicMyServiceScreen> {
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
                  "My Service Screen"
              ),
            ),
          ),
        ),
      ),
    );
  }

}