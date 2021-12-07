import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/UI/Customer/Home/SideBar/MyVehicle/View/view_vehicle_bloc.dart';
import 'package:flutter/material.dart';

class ViewVehicleListScreen extends StatefulWidget {
  const ViewVehicleListScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ViewVehicleListScreenState();
  }
}

class _ViewVehicleListScreenState extends State<ViewVehicleListScreen> {
  final ViewVehicleBloc _viewVehicleBloc = ViewVehicleBloc();
  @override
  void initState() {
    super.initState();
    _viewVehicleBloc.postViewVehicleRequest("");
    _getViewVehicle();
  }

  @override
  void dispose() {
    super.dispose();
    _viewVehicleBloc.dispose();
  }

  _getViewVehicle() async {
    _viewVehicleBloc.postViewVehicle.listen((value) {
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
        setState(() {

        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
