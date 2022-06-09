import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/UI/Customer/EmergencyServiceFlow/RateMechanic/rate_mechanic_screen.dart';
import 'package:auto_fix/UI/Customer/MainLandingPageCustomer/customer_main_landing_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DirectPaymentSuccessScreen extends StatefulWidget {

  DirectPaymentSuccessScreen();

  @override
  State<StatefulWidget> createState() {
    return _DirectPaymentSuccessScreenState();
  }
}

class _DirectPaymentSuccessScreenState extends State<DirectPaymentSuccessScreen> {

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
                      InfoTextWidget(size),
                      titleImageWidget(size),
                      reviewButtonsWidget(size),
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
      child: Text("Payment Successful !",
        style: TextStyle(
          fontSize: 16,
          fontFamily: "Samsung_SharpSans_Medium",
          fontWeight: FontWeight.w400,
          color: CustColors.light_navy,
        ),),
    );
  }

  Widget InfoTextWidget(Size size){
    return Container(
      decoration: Styles.boxDecorationStyle,
      margin: EdgeInsets.only(
          left: size.width * 6 / 100,
          right: size.width * 6 / 100,
          top: size.height * 5 / 100
      ),
      padding: EdgeInsets.only(
          top: size.width * 3 / 100,
          bottom: size.width * 3 / 100
      ),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          children: [
            Container(

              margin: EdgeInsets.only(
                left: size.width * 5 / 100,
                right: size.width * 2 / 100,
              ),
              child: SvgPicture.asset("assets/image/ic_info_blue_white.svg",
                height: size.height * 3 / 100,width: size.width * 3 / 100,),
            ),
            Expanded(
              child: Text(
                "Congratulations! Your mechanic confirmed as he received the payment. This service cycle completed from mechanic side ",
                style: warningTextStyle01,
                textAlign: TextAlign.start,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget titleImageWidget(Size size){
    return Container(
      //decoration: Styles.boxDecorationStyle,
      margin: EdgeInsets.only(
          left: size.width * 5 / 100,
          right: size.width * 5 / 100,
          top: size.height * 5 / 100
      ),
      child: Image.asset("assets/image/img_direct_payment_success_bg.png"),
    );
  }

  Widget reviewButtonsWidget(Size size){
    return Container(
      margin: EdgeInsets.only(
          left: size.width * 5 / 100,
          right: size.width * 5 / 100,
          top: size.height * 10 / 100
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: (){

              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                  CustomerMainLandingScreen()), (Route<dynamic> route) => false);

            },
              child: reviewLaterButton(size)),
          InkWell(
            onTap: (){

             /* Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                  CustomerMainLandingScreen()), (Route<dynamic> route) => false);*/

              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RateMechanicScreen()));
            },
              child: reviewNowButton(size)),
        ],
      ),
    );
  }

  Widget reviewLaterButton(Size size){
    return Container(
      decoration: Styles.rateBoxDecorationStyle01,
      padding: EdgeInsets.only(
          left:  size.width * 6 / 100,
          right:  size.width * 6 / 100,
          top: size.height * 3 / 100,
          bottom: size.height * 3 / 100
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset("assets/image/ic_star_blue.svg",
              height: size.height * 5 / 100, width: size.width * 5 / 100),
          Text(" Review later", style: buttonTextStyle,)
        ],
      ),
    );
  }

  Widget reviewNowButton(Size size){
    return Container(
      decoration: Styles.rateBoxDecorationStyle02,
      padding: EdgeInsets.only(
          left:  size.width * 6 / 100,
          right:  size.width * 6 / 100,
          top: size.height * 3 / 100,
          bottom: size.height * 3 / 100
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset("assets/image/ic_star_yellow.svg",
              height: size.height * 5 / 100, width: size.width * 5 / 100),
          Text(" Review Now", style: buttonTextStyle,)
        ],
      ),
    );
  }

  TextStyle warningTextStyle01 = TextStyle(
    fontSize: 12,
    fontFamily: "Samsung_SharpSans_Regular",
    fontWeight: FontWeight.w600,
    color: Colors.black,
    letterSpacing: .7,
    //wordSpacing: .7
  );

  TextStyle buttonTextStyle = TextStyle(
    fontSize: 12,
    fontFamily: "SharpSans_Bold",
    fontWeight: FontWeight.bold,
    color: Colors.black,
    //letterSpacing: .7,
    //wordSpacing: .7
  );

}