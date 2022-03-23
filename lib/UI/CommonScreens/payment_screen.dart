import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {

  PaymentScreen();

  @override
  State<StatefulWidget> createState() {
    return _PaymentScreenState();
  }
}

class _PaymentScreenState extends State<PaymentScreen> {
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
            margin: EdgeInsets.only(
              left: size.width * 3 / 100,
              right: size.width * 3 / 100,
              top: size.height * 3 / 100,
              bottom: size.height * 3 / 100,
            ),
            color: Colors.green,
            child: Container(
              color: Colors.purpleAccent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  paymentScreenTitle(size),
                  paymentScreenImage(size),

                  Container(

                  )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget paymentScreenTitle(Size size){
    return Container(
      margin: EdgeInsets.only(
        left: size.width * 2.8 /100,
        // bottom: size.height * 1 /100,
        top: size.height * .4 / 100,
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
        left: size.width * .9 /100,
        right: size.width * .9 /100,
        bottom: size.height * 4 /100,
        top: size.height * .9 / 100,
      ),
      child: Image.asset("assets/image/img_payment_bg.png"),
    );
  }

}
