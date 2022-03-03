import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/vechicleSpecialization/vehicleSpecialization_bloc.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/vechicleSpecialization/vehicleSpecialization_mdl.dart';
import 'package:auto_fix/Widgets/screen_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class VehicleSpecializationScreen extends StatefulWidget {

  VehicleSpecializationScreen();

  @override
  State<StatefulWidget> createState() {
    return _VehicleSpecializationScreenState();
  }
}

class _VehicleSpecializationScreenState extends State<VehicleSpecializationScreen> {

  final vehicleSpecializationBloc _specializationBloc = vehicleSpecializationBloc();


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
  List selectedServiceList = [];
  List<bool>? _regularIsChecked;

  List<VehicleSpecialization> _countryData = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _specializationBloc.dialvehicleSpecializationListRequest();
    _populateCountryList();
  }

  _populateCountryList() {
    _specializationBloc.vehicleSpecializationCode.listen((value) {
      setState(() {
        _countryData = value.cast<VehicleSpecialization>();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
        body: Container(
          height: size.height,
          width:  size.width,
          color: Colors.red,
        ),
      ),
    );
  }

}