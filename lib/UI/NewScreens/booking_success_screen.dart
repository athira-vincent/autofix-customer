import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:flutter/material.dart';

class BookingSuccessScreen extends StatefulWidget {

  BookingSuccessScreen();

  @override
  State<StatefulWidget> createState() {
    return _BookingSuccessScreenState();
  }
}

class _BookingSuccessScreenState extends State<BookingSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                width: size.width,
                height: size.height,
                color: Colors.green,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      titleWidget(size),

                    ]
                )
              )
            ),
          ),
        ),
    );
  }

  Widget titleWidget(Size size){
    return Container(
      margin: EdgeInsets.only(
        left: size.width * 6 /100,
        // bottom: size.height * 1 /100,
        top: size.height * 3.4 / 100,
      ),
      child: Text("Booking Successful !",
        style: TextStyle(
          fontSize: 16,
          fontFamily: "Samsung_SharpSans_Medium",
          fontWeight: FontWeight.w400,
          color: CustColors.light_navy,
        ),),
    );
  }

}