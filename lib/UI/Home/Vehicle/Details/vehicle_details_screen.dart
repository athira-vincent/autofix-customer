import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/UI/Home/Vehicle/Details/vehicle_details_bloc.dart';
import 'package:flutter/material.dart';

class VehicleDetailsScreen extends StatefulWidget {
  const VehicleDetailsScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _VehicleDetailsScreenState();
  }
}

class _VehicleDetailsScreenState extends State<VehicleDetailsScreen> {
  final VehilceDetailsBloc _vehilceDetailsBloc = VehilceDetailsBloc();
  @override
  void initState() {
    super.initState();
    _vehilceDetailsBloc.postVehicleDetailsRequest();
    _getVehicleDetails();
  }

  @override
  void dispose() {
    super.dispose();
    _vehilceDetailsBloc.dispose();
  }

  _getVehicleDetails() async {
    _vehilceDetailsBloc.postVehicleDetails.listen((value) {
      if (value.status == "error") {
        setState(() {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(value.message,
                style: const TextStyle(
                    fontFamily: 'Roboto_Regular', fontSize: 14)),
            duration: const Duration(seconds: 2),
            backgroundColor: CustColors.peaGreen,
          ));
        });
      } else {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
