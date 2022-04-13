import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MechanicDirectPaymentScreen extends StatefulWidget {

  MechanicDirectPaymentScreen();

  @override
  State<StatefulWidget> createState() {
    return _MechanicDirectPaymentScreenState();
  }
}

class _MechanicDirectPaymentScreenState extends State<MechanicDirectPaymentScreen> {
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
                        warningTextWidget(size),
                        titleImageWidget(size),
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
      child: Text("Direct payment ",style: TextStyle(
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
          Text("Your customer chooses direct payment method! \nReceive the payment and click the \n“payment received” button",
            style: warningTextStyle01,
          )
        ],
      ),
    );
  }

  Widget titleImageWidget(Size size){
    return Container(
      decoration: Styles.boxDecorationStyle,
      margin: EdgeInsets.only(
          left: size.width * 6 / 100,
          right: size.width * 6 / 100,
          top: size.height * 2.2 / 100
      ),
      child: Image.asset("assets/image/img_mech_direct_pay_bg.png"),
    );
  }

  TextStyle warningTextStyle01 = TextStyle(
    fontSize: 12,
    fontFamily: "Samsung_SharpSans_Regular",
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

}
