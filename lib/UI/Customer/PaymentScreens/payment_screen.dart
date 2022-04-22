import 'dart:ffi';

import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/UI/Common/direct_payment_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {

  PaymentScreen();

  @override
  State<StatefulWidget> createState() {
    return _PaymentScreenState();
  }
}

class _PaymentScreenState extends State<PaymentScreen> {

  int _selectedOptionValue = -1;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Container(
            width: size.width,
            height: size.height,
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      paymentScreenTitle(size),
                      paymentScreenImage(size),
                      paymentScreenSubTitle(size),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                     //color: Colors.yellow,
                    color: CustColors.white_02,
                    margin: EdgeInsets.only(
                      top: size.height * 1 / 100,
                    ),
                    padding: EdgeInsets.only(top: size.height * 1 / 100),
                    child: Column(
                      children: [
                        paymentOptions(size, "Direct payment", "assets/image/img_payment_cash.png",1),
                        paymentOptions(size, "UPI", "assets/image/img_payment_upi.png",2),
                        paymentOptions(size, "Credit/Debit /Atm cards", "assets/image/img_payment_card.png",3),
                        paymentOptions(size, "Netbanking", "assets/image/img_payment_netbank.png",4),

                        InkWell(
                            child: paymentContinueButton(size),
                          onTap: (){
                              print("On Press Continue");
                              changeScreen(_selectedOptionValue);
                          },
                        )

                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget paymentScreenTitle(Size size){
    return Container(
      margin: EdgeInsets.only(
        left: size.width * 5.8 /100,
        // bottom: size.height * 1 /100,
        top: size.height * 3.4 / 100,
      ),
      child: Text("Payments ",style: TextStyle(
        fontSize: 16,
        fontFamily: "Samsung_SharpSans_Medium",
        fontWeight: FontWeight.w400,
        color: CustColors.light_navy,
      ),),
    );
  }

  Widget paymentScreenImage(Size size){
    return Container(
      margin: EdgeInsets.only(
        left: size.width * 3.9 /100,
        right: size.width * 3.9 /100,
        //bottom: size.height * 4 /100,
        top: size.height * .9 / 100,
      ),
      child: Image.asset("assets/image/img_payment_bg.png"),
    );
  }

  Widget paymentScreenSubTitle(Size size){
    return Container(
      margin: EdgeInsets.only(
        left: size.width * 11.7 /100,
        // bottom: size.height * 1 /100,
        top: size.height * 4.1 / 100,
      ),
      child: Text("Payment method ",style: TextStyle(
        fontSize: 15,
        fontFamily: "Samsung_SharpSans_Medium",
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),),
    );
  }

  Widget paymentOptions(Size size, String optionName, String imagePath,int radioValue){
    return Container(
      margin: EdgeInsets.only(
        left: size.width * 6 / 100,
        right: size.width * 6 / 100,
        top: size.height * 1.5 / 100,
        bottom: size.height * 1 / 100,
      ),
      padding: EdgeInsets.only(
        left: size.width * 3 / 100,
        right: size.width * 5 / 100,
        top: size.height * 1 / 100,
        bottom: size.height * 1 / 100,
      ),
      color: Colors.white70,
      child: Row(
        children: [
          Theme(
            data: ThemeData(
              unselectedWidgetColor: CustColors.light_navy,
            ),
            child: Radio(
                value: radioValue,
                groupValue: _selectedOptionValue,
                activeColor: CustColors.light_navy,
                onChanged: (value){
                  setState(() {
                    //_value = value  ;
                    _selectedOptionValue = value as int;
                    print("value >>>>>>> " + value.toString());
                  });
                }),
          ),

          Text(optionName, style: TextStyle(
              fontSize: 13,
              fontFamily: "Samsung_SharpSans_Medium",
              fontWeight: FontWeight.w500,
              color: CustColors.greyish_brown
          ),),

          Spacer(),

          Image.asset(
            imagePath,
            height: size.height * 6.5 / 100,
            width: size.width * 6.5 / 100,
          )
        ],
      ),
    );
  }

  Widget paymentContinueButton(Size size){
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.only(
            right: size.width * 8.3 / 100,
            top: size.height * 4 / 100
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(6),
            ),
            color: CustColors.light_navy
        ),
        padding: EdgeInsets.only(
          left: size.width * 4.5 / 100,
          right: size.width * 4.5 / 100,
          top: size.height * 1 / 100,
          bottom: size.height * 1 / 100,
        ),
        child: Text(
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

  void changeScreen(int selectedOptionValue){
    if( selectedOptionValue == 1)
      {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => DirectPaymentScreen(isMechanicApp: false,)));
      }

  }

}
