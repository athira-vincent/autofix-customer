import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/UI/Common/direct_payment_screen.dart';
import 'package:auto_fix/UI/Customer/PaymentScreens/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PaymentFailedScreen extends StatefulWidget {

  PaymentFailedScreen();

  @override
  State<StatefulWidget> createState() {
    return _PaymentFailedScreenState();
  }
}

class _PaymentFailedScreenState extends State<PaymentFailedScreen> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
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
                          buttonsWidget(size)
                        ]
                    )
                )
            )
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
      child: Text("Payment failed !",
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
                top: size.width * 5 / 100,
                bottom: size.width * 5 / 100
            ),
            margin: EdgeInsets.only(
              left: size.width * 5 / 100,
              right: size.width * 2 / 100,
            ),
            child: SvgPicture.asset("assets/image/ic_info_blue_white.svg",
              height: size.height * 3 / 100,width: size.width * 3 / 100,),
          ),
          Text(
            "Something went wrong! Payment failed! \nTry another method like direct payment etc.. \nOr you can try after some time",
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
          left: size.width * 7 / 100,
          right: size.width * 7 / 100,
          top: size.height * 6 / 100
      ),
      child: Image.asset("assets/image/img_payment_failed_bg.png"),
    );
  }

  Widget buttonsWidget(Size size){
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
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PaymentScreen()));
            },
              child: returnToPaymentOptionButton(size)),
          InkWell(
            onTap: (){
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DirectPaymentScreen(isMechanicApp: true,isPaymentFailed: true,)));
            },
              child: directPaymentButton(size)),
        ],
      ),
    );
  }

  Widget returnToPaymentOptionButton(Size size){
    return Container(
      width: size.width * 42 / 100,
      decoration: Styles.rateBoxDecorationStyle01,
      padding: EdgeInsets.only(
          left:  size.width * 3 / 100,
          right:  size.width * 3 / 100,
          top: size.height * 2.7 / 100,
          bottom: size.height * 2.7 / 100
      ),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset("assets/image/ic_payment_options.svg",
              height: size.height * 5 / 100,
              width: size.width * 5 / 100),
          SizedBox(
            width: size.width * 1.5 / 100,
          ),
          Expanded(child: Text("Other Payment Options", style: buttonTextStyle,))
        ],
      ),
    );
  }

  Widget directPaymentButton(Size size){
    return Container(
      width: size.width * 42 / 100,
      decoration: Styles.rateBoxDecorationStyle02,
      padding: EdgeInsets.only(
          left:  size.width * 3 / 100,
          right:  size.width * 3 / 100,
          top: size.height * 2.7 / 100,
          bottom: size.height * 2.7 / 100
      ),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset("assets/image/img_payment_cash.png",
               height: size.height * 5 / 100,
               width: size.width * 8 / 100),
          SizedBox(
            width: size.width * 1.5 / 100,
          ),
          Expanded(child: Text("Direct payment", style: buttonTextStyle,))
        ],
      ),
    );
  }

  TextStyle warningTextStyle01 = TextStyle(
    fontSize: 12,
    fontFamily: "Samsung_SharpSans_Regular",
    fontWeight: FontWeight.w600,
    color: Colors.black,
    letterSpacing: .8,
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