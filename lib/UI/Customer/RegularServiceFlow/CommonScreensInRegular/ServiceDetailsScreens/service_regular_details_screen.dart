import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/UI/Common/add_more_service_list_screen.dart';
import 'package:auto_fix/Widgets/input_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ServiceRegularDetailsScreen extends StatefulWidget {


  ServiceRegularDetailsScreen(
   );

  @override
  State<StatefulWidget> createState() {
    return _ServiceRegularDetailsScreenState();
  }
}

class _ServiceRegularDetailsScreenState extends State<ServiceRegularDetailsScreen> {


  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return
       Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                  width: size.width,
                  height: size.height,
              ),
            )
        ),
      );
  }


}