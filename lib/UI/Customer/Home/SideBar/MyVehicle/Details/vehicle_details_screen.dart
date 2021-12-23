import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/UI/Customer/Home/SideBar/MyVehicle/Details/vehicle_details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    _getVehicleList();
    _getVehicleDetails();
  }

  _getVehicleList() async {
    SharedPreferences _shdPre = await SharedPreferences.getInstance();
    String token = _shdPre.getString(SharedPrefKeys.token)!;
    _vehilceDetailsBloc.postVehicleDetailsRequest(token);
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
            content: Text(value.message.toString(),
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
    return  Scaffold(
      body: Container(
        height: 20,
        width: 100,
        color: CustColors.red,
        child: Text('VehicleDetailsScreen'),
      ),
    );
  }
}
