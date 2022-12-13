import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/home_Customer_UI/HomeCustomer/customer_home.dart';
import 'package:auto_fix/UI/Customer/MainLandingPageCustomer/customer_main_landing_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Payment_Success_Screen extends StatefulWidget {
  const Payment_Success_Screen({Key? key}) : super(key: key);

  @override
  State<Payment_Success_Screen> createState() => _Payment_Success_ScreenState();
}

class _Payment_Success_ScreenState extends State<Payment_Success_Screen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
            child: SizedBox(
              width: size.width,
              height: size.height,
              //color: Colors.green,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    titleWidget(size),
                   // InfoTextWidget(size),

                    MechanicDirectPaymentTitleImageWidget(size),



                    paymentReceivedButton(size)
                  ]
              ),
            ),
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
      child: const Text(

             AppLocalizations.of(context)!.text_Direct_payment,
        style:  TextStyle(
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
          top: size.height * 3 / 100
      ),
      padding: EdgeInsets.only(
          top: size.width * 3 / 100,
          bottom: size.width * 3 / 100
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

          const Expanded(
            child:  Text(

              AppLocalizations.of(context)!.text_customer_chosen_direct_payment,

                style:   TextStyle(
                  fontSize: 14,
                  fontFamily: "Samsung_SharpSans_Medium",
                  fontWeight: FontWeight.w300,
                  color: CustColors.light_navy,
                )
            ),
          )

        ],
      ),
    );


  }


  Widget MechanicDirectPaymentTitleImageWidget(Size size){
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



  Widget paymentReceivedButton(Size size){
    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: (){

          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => CustomerMainLandingScreen()));
        },
        child: Container(
          margin: EdgeInsets.only(
              right: size.width * 6.2 / 100,
              top: size.height * 5 / 100
          ),
          decoration: const BoxDecoration(
              borderRadius:  BorderRadius.all(
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
          child: const Text(

                 AppLocalizations.of(context)!.text_Go_home,

            style: TextStyle(
              fontSize: 14.3,
              fontWeight: FontWeight.w600,
              fontFamily: "Samsung_SharpSans_Medium",
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
