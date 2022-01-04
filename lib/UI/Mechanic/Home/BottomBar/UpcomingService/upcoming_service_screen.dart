import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/UI/Mechanic/Home/BottomBar/UpcomingService/upcoming_service_bloc.dart';
import 'package:flutter/material.dart';

class UpcomingServiceScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UpcomingServiceScreenState();
  }
}

class _UpcomingServiceScreenState extends State<UpcomingServiceScreen> {

  final UpcomingServicesBloc _upcomingServicesBloc = UpcomingServicesBloc();

  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _upcomingServicesBloc.dispose();
  }

  _getTodaysServiceList() {
    _upcomingServicesBloc.postUpcomingServiceList.listen((value) {
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
      child: Center(child: Text('Upcoming Service Screen')),
    );
  }
}
