import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomerApprovedScreen extends StatefulWidget {

  CustomerApprovedScreen();

  @override
  State<StatefulWidget> createState() {
    return _CustomerApprovedScreenState();
  }
}

class _CustomerApprovedScreenState extends State<CustomerApprovedScreen> {
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customerApprovedScreenTitle(size),

                  customerApprovedScreenSubTitle(size),

                  customerApprovedScreenTitleImage(size),

                  customerApprovedScreenStartWorkText(size),

                  customerApprovedScreenWarningText(size),

                  customerApprovedScreenTimer(size),

                  mechanicStartServiceButton(size),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  Widget customerApprovedScreenTitle(Size size){
    return Container(
      margin: EdgeInsets.only(
        left: size.width * 6 /100,
        // bottom: size.height * 1 /100,
        top: size.height * 3.4 / 100,
      ),
      child: Text("Customer approved ! ",style: TextStyle(
        fontSize: 16,
        fontFamily: "Samsung_SharpSans_Medium",
        fontWeight: FontWeight.w400,
        color: CustColors.light_navy,
      ),),
    );
  }

  Widget customerApprovedScreenSubTitle(Size size){
    return Container(
      margin: EdgeInsets.only(
        left: size.width * 6 /100,
        // bottom: size.height * 1 /100,
        top: size.height * 8.5 / 100,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text("Hi...", style: TextStyle(

              ),),
              Text("George Dola", style: TextStyle(
                color: CustColors.light_navy
              ),)
            ],
          ),
          Row(
            children: [
              Text("Customer ", style: TextStyle(

              ),),
              Text("John Eric ", style: TextStyle(
                  color: CustColors.light_navy
              ),),
              Text("approved the services you added.",style: TextStyle(

              ),)
            ],
          )
        ],
      ),
    );
  }

  Widget customerApprovedScreenTitleImage(Size size){
    return Center(
      child: Container(
        margin: EdgeInsets.only(
          //left: size.width * 20 /100,
         // right: size.width * 20 / 100,
          // bottom: size.height * 1 /100,
          top: size.height * 3.3 / 100,
        ),
        child: SvgPicture.asset('assets/image/img_customer_approved.svg',
          width: size.width * 60 / 100,
          height: size.height * 30 / 100,),
      ),
    );
  }

  Widget customerApprovedScreenStartWorkText(Size size){
    return Container(
      decoration: boxDecorationStyle,
      margin: EdgeInsets.only(
          left: size.width * 6 / 100,
          right: size.width * 6 / 100,
          top: size.height * 3.3 / 100
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(
                top: size.width * 3 / 100,
                bottom: size.width * 3 / 100
            ),
            margin: EdgeInsets.only(
                left: size.width * 5 / 100,
                right: size.width * 2 / 100
            ),
            child: SvgPicture.asset("assets/image/ic_info_blue_white.svg",
              height: size.height * 3 / 100,width: size.width * 3 / 100,),
          ),
          Text("Customer agree with the diagnostic test report \nand estimated cost . So you can start repair ",
            style: warningTextStyle01,

          )
        ],
      ),
    );
  }

  Widget customerApprovedScreenWarningText(Size size){
    return Container(
      decoration: boxDecorationStyle,
      margin: EdgeInsets.only(
          left: size.width * 6 / 100,
          right: size.width * 6 / 100,
          top: size.height * 2.2 / 100
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(
                top: size.width * 3 / 100,
                bottom: size.width * 3 / 100
            ),
            margin: EdgeInsets.only(
                left: size.width * 5 / 100,
                right: size.width * 2 / 100
            ),
            child: SvgPicture.asset("assets/image/ic_info_blue_white.svg",
              height: size.height * 3 / 100,width: size.width * 3 / 100,),
          ),
          Text("Note:  If you click the ‘Start repair’ button, it will \nenables the timer countdown feature also.",
            style: warningTextStyle01,
          )
        ],
      ),
    );
  }

  Widget customerApprovedScreenTimer(Size size){
    return Container(
      margin: EdgeInsets.only(
          left: size.width * 27.5 / 100,
          right: size.width * 27.5 / 100,
          top: size.height * 4.3 / 100
      ),
      child: Flexible(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                left: size.width * 4.5 / 100,
                right: size.width * 4.5 / 100,
                top: size.height * 1 / 100,
                bottom: size.height * 1 / 100,
              ),
              child: Row(
                children: [
                  SvgPicture.asset('assets/image/ic_alarm.svg',
                    width: size.width * 4 / 100,
                    height: size.height * 4 / 100,),
                  Spacer(),
                  Text("25:00 ",
                    style: TextStyle(
                        fontSize: 36,
                        fontFamily: "SharpSans_Bold",
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
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
              /*margin: EdgeInsets.only(
                                left: size.width * 4 / 100,
                                right: size.width * 4 / 100,
                                top: size.height * 2.8 / 100
                            ),*/
              padding: EdgeInsets.only(
                left: size.width * 4 / 100,
                right: size.width * 4 / 100,
                top: size.height * 1 / 100,
                bottom: size.height * 1 / 100,
              ),
              child: Text("Total estimated time "),
            )
          ],
        ),
      ),
    );
  }

  Widget mechanicStartServiceButton(Size size){
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.only(
            right: size.width * 6.2 / 100,
            top: size.height * 3.7 / 100
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
          "Start work",
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

  BoxDecoration boxDecorationStyle = BoxDecoration(
      borderRadius: BorderRadius.all(
        Radius.circular(8),
      ),
      border: Border.all(
          color: CustColors.greyish,
          width: 0.3
      )
  );

  TextStyle warningTextStyle01 = TextStyle(
      fontSize: 12,
      fontFamily: "Samsung_SharpSans_Regular",
      fontWeight: FontWeight.w600,
      color: Colors.black,
  );

}