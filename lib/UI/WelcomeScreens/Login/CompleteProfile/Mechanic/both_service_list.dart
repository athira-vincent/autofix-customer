import 'package:flutter/material.dart';



class BothServiceListScreen extends StatefulWidget {

  BothServiceListScreen();

  @override
  State<StatefulWidget> createState() {
    return _BothServiceListScreenState();
  }
}

class _BothServiceListScreenState extends State<BothServiceListScreen> {

  List regularServiceList = [
    "Service 1",
    "Service 2",
    "Service 3",
    "Service 4",
    "Service 5",
    "Service 6",
    "Service 7",
    "Service 8",
    "Service 9",
    "Service 10",
    "Service 11",
    "Service 12",

  ];
  String title = "";
  List selectedRegularServiceList = [];
  List<bool>? _regularIsChecked;

  List emergencyServiceList = [
    "Service 1",
    "Service 2",
    "Service 3",
    "Service 4",
    "Service 5",
    "Service 6",
    "Service 7",
    "Service 8",
    "Service 9",
    "Service 10",
    "Service 11",
    "Service 12",

  ];
  List selectedEmergencyServiceList = [];
  List<bool>? _emergencyIsChecked;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _regularIsChecked = List<bool>.filled(regularServiceList.length, false);
    _emergencyIsChecked = List<bool>.filled(emergencyServiceList.length, false);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
        body: Container(
          height: size.height,
          width:  size.width,
          color: Colors.white,

      ),
      ),
    );
  }

}