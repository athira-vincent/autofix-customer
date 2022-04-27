import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/UI/Customer/customer_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PickedUpVehicleScreen extends StatefulWidget {

  PickedUpVehicleScreen();

  @override
  State<StatefulWidget> createState() {
    return _PickedUpVehicleScreenState();
  }
}

class _PickedUpVehicleScreenState extends State<PickedUpVehicleScreen> {
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
                    warningTextWidget(size),
                    titleImageWidget(size),
                    estimatedDateWidget(size),
                    InkWell(
                      onTap: (){
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CustomerHomeScreen()));
                      },
                        child: backToHomeButton(size))
                  ],
                ),
              ),
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
      child: Text("mechanic picked up your vehicle",
        style: TextStyle(
          fontSize: 16,
          fontFamily: "Samsung_SharpSans_Medium",
          fontWeight: FontWeight.w400,
          color: CustColors.light_navy,
        ),),
    );
  }
  Widget warningTextWidget(Size size){
    return Container(
      decoration: Styles.boxDecorationStyle,
      margin: EdgeInsets.only(
          left: size.width * 6 / 100,
          right: size.width * 6 / 100,
          top: size.height * 7 / 100
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
              "NB: Your mechanic picked up your vehicle. He returned your vehicle only after service, as per the date you both agreed.",
              style: Styles.warningTextStyle01,
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
          left: size.width * 6.5 / 100,
          right: size.width * 6.5 / 100,
          top: size.height * 5.5 / 100
      ),
      child: SvgPicture.asset("assets/image/img_picked_up_vehicle_bg.svg",
        height: size.height * 33 / 100,
      ),
    );
  }
  Widget estimatedDateWidget(Size size){
    return Container(
      margin: EdgeInsets.only(
          left: size.width * 27.5 / 100,
          right: size.width * 27.5 / 100,
          top: size.height * 5.5 / 100
      ),
      child: Flexible(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                left: size.width * 4.5 / 100,
                right: size.width * 4.5 / 100,
                top: size.height * 1 / 100,
                bottom: size.height * 2 / 100,
              ),
              child: Row(
                children: [
                  SvgPicture.asset('assets/image/ic_calendar_blue.svg',
                    width: size.width * 4 / 100,
                    height: size.height * 4 / 100,),
                  Spacer(),
                  Text("12 Jan 2022",
                    style: TextStyle(
                        fontSize: 22,
                        fontFamily: "SharpSans_Bold",
                        fontWeight: FontWeight.bold,
                        color: CustColors.light_navy,
                        letterSpacing: .7
                    ),
                  ),
                ],
              ),
            ),

            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(13),
                  ),
                  border: Border.all(
                      color: CustColors.light_navy02,
                      width: 0.3
                  )
              ),
              padding: EdgeInsets.only(
                left: size.width * 4 / 100,
                right: size.width * 4 / 100,
                top: size.height * 1.3 / 100,
                bottom: size.height * 1.3 / 100,
              ),
              child: Text("Estimated return date"),
            )
          ],
        ),
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
          "Back to home",
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