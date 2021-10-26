import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/UI/Home/Vehicle/Add/Engine/all_engine_bloc.dart';
import 'package:auto_fix/UI/Home/Vehicle/Add/Make/all_make_bloc.dart';
import 'package:auto_fix/UI/Home/Vehicle/Add/Model/all_model_bloc.dart';
import 'package:auto_fix/UI/Home/Vehicle/Add/add_vehicle_bloc.dart';
import 'package:flutter/material.dart';

class AddVehicleScreen extends StatefulWidget {
  const AddVehicleScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AddVehicleScreenState();
  }
}

class _AddVehicleScreenState extends State<AddVehicleScreen> {
  final AddVehicleBloc _addVehicleBloc = AddVehicleBloc();
  final AllModelBloc _allModelBloc = AllModelBloc();
  final AllMakeBloc _allMakeBloc = AllMakeBloc();
  final AllEngineBloc _allEngineBloc = AllEngineBloc();
  @override
  void initState() {
    super.initState();
    _allModelBloc.postAllModelRequest();
    _allMakeBloc.postAllMakeRequest();
    _allEngineBloc.postAllEngineRequest();
    _getAllModel();
    _getAllMake();
    _getAllEngine();
    _addVehicle();
  }

  @override
  void dispose() {
    super.dispose();
    _addVehicleBloc.dispose();
    _allModelBloc.dispose();
    _allMakeBloc.dispose();
    _allEngineBloc.dispose();
  }

  _getAllModel() async {
    _allModelBloc.postAllModel.listen((value) {
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

  _getAllMake() async {
    _allMakeBloc.postAllMake.listen((value) {
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

  _getAllEngine() async {
    _allEngineBloc.postAllEngine.listen((value) {
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

  _addVehicle() async {
    _addVehicleBloc.postAddVehicle.listen((value) {
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
