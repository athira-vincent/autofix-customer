import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/UI/Home/Profile/ViewProfile/view_profile_bloc.dart';
import 'package:flutter/material.dart';

class ViewProfileScreen extends StatefulWidget {
  const ViewProfileScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ViewProfileScreenState();
  }
}

class _ViewProfileScreenState extends State<ViewProfileScreen> {
  final ViewProfileBloc _viewProfileBloc = ViewProfileBloc();
  @override
  void initState() {
    super.initState();
    _viewProfileBloc.postViewProfileRequest();
    _getViewProfile();
  }

  @override
  void dispose() {
    super.dispose();
    _viewProfileBloc.dispose();
  }

  _getViewProfile() async {
    _viewProfileBloc.postViewProfile.listen((value) {
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
