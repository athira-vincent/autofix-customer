import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PaymentSuccessScreen extends StatefulWidget {

  PaymentSuccessScreen();

  @override
  State<StatefulWidget> createState() {
    return _PaymentSuccessScreenState();
  }
}

class _PaymentSuccessScreenState extends State<PaymentSuccessScreen> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
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
          )
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
          top: size.height * 8.2 / 100
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(
                top: size.width * 6 / 100,
                bottom: size.width * 6 / 100
            ),
            margin: EdgeInsets.only(
              left: size.width * 6 / 100,
              right: size.width * 3 / 100,
            ),
            child: SvgPicture.asset("assets/image/ic_info_blue_white.svg",
              height: size.height * 3 / 100,width: size.width * 3 / 100,),
          ),
          Text(
            //"Congratulations your payment was successful \nPlease review your mechanic!"
            "Your Mechanic has received the\n payment of the service rendered.\n The service cycle is completed from\n the mechanic’s end. Thank you for\n choosing Resol mech.",
            style: warningTextStyle01,
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
          top: size.height * 6 / 100
      ),
      child: Image.asset("assets/image/img_payment_success_bg.png"),
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
              child: reviewLaterButton(size)),
          InkWell(
              child: reviewNowButton(size)),
        ],
      ),
    );
  }

  Widget reviewLaterButton(Size size){
    return Container(
      width: size.width * 42 / 100,
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
              height: size.height * 4 / 100, width: size.width * 4 / 100),
          Text("Review later", style: buttonTextStyle,)
        ],
      ),
    );
  }

  Widget reviewNowButton(Size size){
    return Container(
      width: size.width * 42 / 100,
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
              height: size.height * 4 / 100, width: size.width * 4 / 100),
          Text("Review Now", style: buttonTextStyle,)
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