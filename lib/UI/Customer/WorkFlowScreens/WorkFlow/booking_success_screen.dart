import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/UI/Customer/customer_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
                //color: Colors.green,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      titleWidget(size),
                      infoTextWidget(size),
                      titleImageWidget(size),
                      warningTextWidget(size),
                      InkWell(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CustomerHomeScreen()));
                        },
                          child: backToHomeButton(size))
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

  Widget infoTextWidget(Size size){
    return Container(
      width: size.width * 87 / 100,
      decoration: Styles.bannerTextBoxDecorationStyle,
      margin: EdgeInsets.only(
          left: size.width * 6 / 100,
          right: size.width * 6 / 100,
          top: size.height * 6.5 / 100
      ),
      padding: EdgeInsets.only(
        left: size.width * 3.5 / 100,
        right: size.width * 3.5 / 100,
        top: size.height * 3.5 / 100,
        bottom: size.height * 3.5 / 100
      ),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.ce,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Your service booked successfully ",
            style: TextStyle(
              fontSize: 18,
              fontFamily: "Samsung_SharpSans_Medium",
              fontWeight: FontWeight.bold,
              color: CustColors.light_navy, height: 1.5
            ),
          ),
          Text(
            "Service scheduled date ",
            style: TextStyle(
                fontSize: 16,
                fontFamily: "Samsung_SharpSans_Regular",
                fontWeight: FontWeight.w900,
                color: CustColors.warm_grey03,
                height: 1.5
            ),
          ),
          Text(
            "Mar 5, 2022",
            style: TextStyle(
                fontSize: 16,
                fontFamily: "Samsung_SharpSans_Medium",
                fontWeight: FontWeight.w700,
                color: Colors.black, height: 1.5
            ),
          )
        ],
      ),
    );
  }

  Widget titleImageWidget(Size size){
    return Container(
      //decoration: Styles.boxDecorationStyle,
      margin: EdgeInsets.only(
          left: size.width * 5 / 100,
          right: size.width * 5 / 100,
          top: size.height * 3 / 100
      ),
      child: SvgPicture.asset("assets/image/img_booking_success_bg.svg",
        height: size.height * 33 / 100,
      ),
    );
  }

  Widget warningTextWidget(Size size){
    return Container(
      decoration: Styles.boxDecorationStyle,
      margin: EdgeInsets.only(
          left: size.width * 6 / 100,
          right: size.width * 6 / 100,
          top: size.height * 5 / 100
      ),
      padding: EdgeInsets.only(
        right: size.width * 3 / 100,
        top: size.height * 2 / 100,
        bottom: size.height * 2 / 100,
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(
              left: size.width * 4 / 100,
              right: size.width * 2.5 / 100,
            ),
            child: SvgPicture.asset("assets/image/ic_info_blue_white.svg",
              height: size.height * 3 / 100,width: size.width * 3 / 100,),
          ),
          Expanded(
            child: Text(
              "Congratulations! Service booking successful. We will remind you about this service on the selected date, and we will send you the mechanic location soon.",
              style: Styles.warningTextStyle01,
            ),
          )
        ],
      ),
    );
  }

  Widget backToHomeButton(Size size){
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.only(
            right: size.width * 6.2 / 100,
            top: size.height * 10 / 100
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(6),
            ),
            color: CustColors.light_navy
        ),
        padding: EdgeInsets.only(
          left: size.width * 5.8 / 100,
          right: size.width * 5.8 / 100,
          top: size.height * 1 / 100,
          bottom: size.height * 1 / 100,
        ),
        child: Text(
          "Go to home",
          style: TextStyle(
            fontSize: 14.3,
            fontWeight: FontWeight.w600,
            fontFamily: "Samsung_SharpSans_Medium",
            color: Colors.white,
          ),
        ),
      ),
    );
  }

}