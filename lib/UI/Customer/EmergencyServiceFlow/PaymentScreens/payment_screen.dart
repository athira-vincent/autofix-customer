import 'dart:async';
import 'dart:ui';

import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/UI/Common/direct_payment_screen.dart';
import 'package:auto_fix/Widgets/snackbar_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentScreen extends StatefulWidget {

  PaymentScreen();

  @override
  State<StatefulWidget> createState() {
    return _PaymentScreenState();
  }
}

class _PaymentScreenState extends State<PaymentScreen> {

  int _selectedOptionValue = -1;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String mechanicArrivalState = "0";
  Timer? timerObjVar;
  Timer? timerObj;

  String authToken="";
  String userName="";


  String serviceIdEmergency="";
  String mechanicIdEmergency="";
  String bookingIdEmergency="";
  var scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPrefData();
  }

  Future<void> getSharedPrefData() async {
    print('getSharedPrefData');
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    setState(() {
      authToken = shdPre.getString(SharedPrefKeys.token).toString();
      userName = shdPre.getString(SharedPrefKeys.userName).toString();
      serviceIdEmergency = shdPre.getString(SharedPrefKeys.serviceIdEmergency).toString();
      mechanicIdEmergency = shdPre.getString(SharedPrefKeys.mechanicIdEmergency).toString();
      bookingIdEmergency = shdPre.getString(SharedPrefKeys.bookingIdEmergency).toString();
      print('PaymentScreen authToken>>>>>>>>> ' + authToken.toString());
      print('PaymentScreen bookingIdEmergency>>>>>>>>> ' + bookingIdEmergency.toString());
      updateToCloudFirestoreMechanicCurrentScreenDB();

    });
  }


  void updateToCloudFirestoreMechanicCurrentScreenDB() {
    _firestore
        .collection("ResolMech")
        .doc('${bookingIdEmergency}')
        .update({
      "customerFromPage" : "C7",
    })
        .then((value) => print("Location Added"))
        .catchError((error) =>
        print("Failed to add Location: $error"));
  }

  void updateToCloudFirestoreDB() {

    _firestore
        .collection("ResolMech")
        .doc('${bookingIdEmergency}')
        .update({
          'paymentStatus': "1",
        })
        .then((value) => print("Location Added"))
        .catchError((error) =>
        print("Failed to add Location: $error"));

  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        body: Container(
          width: size.width,
          height: size.height,
          color: Colors.white,
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  paymentScreenTitle(size),
                  paymentScreenImage(size),
                  paymentScreenSubTitle(size),
                ],
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
                      //  paymentOptions(size, "UPI", "assets/image/img_payment_upi.png",2),
                      //  paymentOptions(size, "Credit/Debit /Atm cards", "assets/image/img_payment_card.png",3),
                      // paymentOptions(size, "Netbanking", "assets/image/img_payment_netbank.png",4),

                      InkWell(
                        child: paymentContinueButton(size),
                        onTap: (){
                          print("On Press Continue");

                          updateToCloudFirestoreDB();
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
    );
  }

  Widget paymentScreenTitle(Size size){
    return Container(
      margin: EdgeInsets.only(
        left: size.width * 5.8 /100,
        // bottom: size.height * 1 /100,
        top: size.height * 3.4 / 100,
      ),
      child: const Text("Payments ",style: TextStyle(
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
      child: const Text("Payment method ",style: TextStyle(
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

          Text(optionName, style: const TextStyle(
              fontSize: 13,
              fontFamily: "Samsung_SharpSans_Medium",
              fontWeight: FontWeight.w500,
              color: CustColors.greyish_brown
          ),),

          const Spacer(),

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
        decoration: const BoxDecoration(
            borderRadius: const BorderRadius.all(
              const Radius.circular(6),
            ),
            color: CustColors.light_navy
        ),
        padding: EdgeInsets.only(
          left: size.width * 4.5 / 100,
          right: size.width * 4.5 / 100,
          top: size.height * 1 / 100,
          bottom: size.height * 1 / 100,
        ),
        child: const Text(
          "Continue",
          style:  TextStyle(
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
    print(selectedOptionValue);
    if( selectedOptionValue == 1)
      {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => DirectPaymentScreen(isMechanicApp: false,isPaymentFailed: false,)));
      }
    else if( selectedOptionValue == -1)
    {
      SnackBarWidget().setMaterialSnackBar( "Please choose a payment method", scaffoldKey);
    }


  }

}
