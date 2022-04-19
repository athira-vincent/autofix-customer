import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DirectPaymentScreen extends StatefulWidget {

  DirectPaymentScreen();

  @override
  State<StatefulWidget> createState() {
    return _DirectPaymentScreenState();
  }
}

class _DirectPaymentScreenState extends State<DirectPaymentScreen> {

  bool isMechanicApp = false;

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
                        isMechanicApp == true ? MechanicTitleImageWidget(size) : customerTitleImageWidget(size),
                        warningTextWidget(size),
                        paymentReceivedButton(size)
                      ]
                  ),
               ),
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
      child: Text("Direct payment ",
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
            isMechanicApp == true ?
            "Your customer chooses direct payment method! \nReceive the payment and click the \n“payment received” button"
            :
            "You choosed the direct payment method! \nSo this transaction process completed only after, \nwhen mechanic confirm as  he received ",
            style: warningTextStyle01,
          )
        ],
      ),
    );
  }

  Widget customerTitleImageWidget(Size size){
    return Container(
      //decoration: Styles.boxDecorationStyle,
      margin: EdgeInsets.only(
          left: size.width * 5 / 100,
          right: size.width * 5 / 100,
          top: size.height * 6.5 / 100
      ),
      child: Image.asset("assets/image/img_cust_direct_pay_bg.png"),
    );
  }

  Widget MechanicTitleImageWidget(Size size){
    return Container(
      //decoration: Styles.boxDecorationStyle,
      margin: EdgeInsets.only(
          left: size.width * 5 / 100,
          right: size.width * 5 / 100,
          top: size.height * 2 / 100
      ),
      child: Image.asset("assets/image/img_mech_direct_pay_bg.png"),
    );
  }


  Widget warningTextWidget(Size size){
    return Container(
      decoration: Styles.boxDecorationStyle,
      margin: EdgeInsets.only(
          left: size.width * 6 / 100,
          right: size.width * 6 / 100,
          top: size.height * 4.5 / 100
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
            isMechanicApp == true ?
            "If you clicked the payment received button \nThis service cycle will completed from your side "
            :
            "Continue with direct payment. It will send a \nnotification to your mechanic and then \nyou can give the payment.",
            style: warningTextStyle01,
          )
        ],
      ),
    );
  }

  Widget paymentReceivedButton(Size size){
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.only(
            right: size.width * 6.2 / 100,
            top: size.height * 7.5 / 100
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
          isMechanicApp == true ?
          "Payment received "
          :
          "Continue",
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

  TextStyle warningTextStyle01 = TextStyle(
    fontSize: 12,
    fontFamily: "Samsung_SharpSans_Regular",
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

}
