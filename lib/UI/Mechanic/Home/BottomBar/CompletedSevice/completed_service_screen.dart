import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/UI/Mechanic/Home/BottomBar/CompletedSevice/completed_service_bloc.dart';
import 'package:flutter/material.dart';

class CompletedServiceScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CompletedServiceScreenState();
  }
}

class _CompletedServiceScreenState extends State<CompletedServiceScreen> {

  final CompletedServicesBloc _completedServicesBloc = CompletedServicesBloc();

  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _completedServicesBloc.dispose();
  }

  _getCompletedServiceList() {
    _completedServicesBloc.postCompletedServiceList.listen((value) {
      if (value.status == "error") {
        setState(() {
          _isLoading = false;
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
          _isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Password Reset Enabled.\nCheck Your mail",
                style: TextStyle(fontFamily: 'Roboto_Regular', fontSize: 14)),
            duration: Duration(seconds: 2),
            backgroundColor: CustColors.peaGreen,
          ));

          FocusScope.of(context).unfocus();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            47.3,
          ),
        ),
      ),
      child: Center(child: Text('Completed Service Screen')),
    );
  }
}
