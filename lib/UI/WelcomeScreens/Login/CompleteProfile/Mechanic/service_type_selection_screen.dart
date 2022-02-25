import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/Widgets/user_type_widget.dart';
import 'package:flutter/material.dart';

class ServiceTypeSelectionScreen extends StatefulWidget {

  ServiceTypeSelectionScreen();

  @override
  State<StatefulWidget> createState() {
    return _ServiceTypeSelectionScreenState();
  }
}

class _ServiceTypeSelectionScreenState extends State<ServiceTypeSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
        body: Container(
          height: size.height,
          width:  size.width,
          color: Colors.white,
          child: Container(
            margin: EdgeInsets.only(
              top: size.height * 0.040,
              bottom: size.height * 0.049,
              left: size.width * 0.06,
              right: size.width * 0.06
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    alignment: Alignment.centerLeft,
                      child: Text("Select your services on both categories")),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                        top: size.height * 0.026,
                        right: size.width * 0.06,
                        left: size.width * 0.06,
                        bottom: size.height * 0.035
                    ),
                    height: size.height * 0.82,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Center(
                          child: UserTypeSelectionWidget(
                            imagePath: 'assets/image/UserType/img_user_customer.png',
                            titleText: Text("Regular",
                                style: Styles.titleTextStyle),
                            //titleText: ,
                          ),
                        ),

                        Center(
                          child: UserTypeSelectionWidget(
                            imagePath: 'assets/image/UserType/img_user_mechanic.png',
                            titleText: Text("Emergency ",
                                style: Styles.titleTextStyle),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}