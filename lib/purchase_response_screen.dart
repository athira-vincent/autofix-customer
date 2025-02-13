import 'dart:async';

import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'UI/Customer/MainLandingPageCustomer/customer_main_landing_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';



class PurchaseResponseScreen extends StatefulWidget {

  final bool isSuccess;

  PurchaseResponseScreen({required this.isSuccess});

  @override
  State<StatefulWidget> createState() {
    return _PurchaseResponseScreenState();
  }
}

class _PurchaseResponseScreenState extends State<PurchaseResponseScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: Container(
            margin: EdgeInsets.only(
              left: size.width * 2 / 100,
              right: size.width * 2 / 100,
              top: size.height * 2 / 100,
              bottom: size.height * 2 / 100,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                appBarCustomUi(size),
                mainContent(size),
                InkWell(
                    onTap: (){
                      print("on tap button");



                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CustomerMainLandingScreen()));
                    },
                    child: doneButton(size)
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget appBarCustomUi(Size size) {
    return Container(

    );
  }

  Widget mainContent(Size size){
    return Container(
      height: size.height * 75 / 100,
      width: size.width * 63 / 100,
      margin: EdgeInsets.only(
        left: size.width * 16 / 100,
        right: size.width * 16 / 100,
        //top: size.height * 4 / 100,
      ),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
              margin: EdgeInsets.only(
                bottom: size.height * 12 / 100
              ),
              child: SvgPicture.asset(
                "assets/images/img_purchase_bg.svg",
              ),),
          Column(
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: size.height * 25 / 100,
                width: size.width * 25 / 100,
                margin: EdgeInsets.only(
                  //left: size.width * 18 / 100,
                  //right: size.width * 18 / 100,
                  top: size.height * 6.5 / 100,
                ),
                child: SvgPicture.asset(
                  widget.isSuccess
                  ? "assets/images/ic_success_blue_white.svg"
                  : "assets/images/ic_failed_blue_white.svg",
                ),
              ),
              Text(
                widget.isSuccess
                ? "Thank you !"
                : "Sorry your ",
                style: TextStyle(
                  fontSize: 33.3,
                  fontWeight: FontWeight.w600,
                  fontFamily: "SharpSans_Bold",
                  color: CustColors.light_navy,
                  letterSpacing: .5
              ),),
              Text(
                widget.isSuccess
                ? "Purchase was successful"
                : "Purchase was unsuccessful",
                style: TextStyle(
                    fontSize: widget.isSuccess ? 21.3 : 20.3,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Samsung_SharpSans_Medium",
                    color: Colors.black,
                    letterSpacing: .5
                ),
              ),
              // Container(
              //   margin: EdgeInsets.only(
              //     top: size.height * .7 / 100
              //   ),
              //   child: Row(
              //    mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Text(
              //         widget.isSuccess
              //         ? "Order id : "
              //         : "Try again after some time",
              //         style: TextStyle(
              //             fontSize: 12,
              //             fontWeight: FontWeight.w400,
              //             fontFamily: "Samsung_SharpSans_Medium",
              //             color: Colors.black,
              //             letterSpacing: .5
              //         ),
              //       ),
              //       Text(
              //         widget.isSuccess
              //         ? "C35465454" : "",
              //         style: TextStyle(
              //             fontSize: 12,
              //             fontWeight: FontWeight.w400,
              //             fontFamily: "Samsung_SharpSans_Regular",
              //             color: Colors.black,
              //             letterSpacing: .5
              //         ),
              //       ),
              //     ],
              //   ),
              // )
            ],
          ),

        ],
      ),
    );
  }

  Widget doneButton(Size size){
    return Align(
      alignment: Alignment.center,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(7),
            ),
            color: CustColors.light_navy
        ),
        height: size.height * 6 / 100,
        width: size.width * 92 / 100,
        child: Center(
          child: Text(
            AppLocalizations.of(context)!.text_DONE ,
            style: TextStyle(
              fontSize: 14.3,
              fontWeight: FontWeight.w600,
              fontFamily: "SharpSans_Bold",
              color: Colors.white,
              letterSpacing: .5
            ),
          ),
        ),
      ),
    );
  }

}
