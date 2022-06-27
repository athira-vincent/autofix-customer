import 'dart:async';

import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/UI/Customer/EmergencyServiceFlow/PaymentScreens/direct_payment_success_screen.dart';
import 'package:auto_fix/UI/Customer/EmergencyServiceFlow/PaymentScreens/payment_failed_screen.dart';
import 'package:auto_fix/UI/Mechanic/BottomBar/Home/mechanic_home_bloc.dart';
import 'package:auto_fix/UI/Mechanic/EmergencyServiceMechanicFlow/OrderStatusUpdateApi/order_status_update_bloc.dart';
import 'package:auto_fix/UI/Mechanic/mechanic_home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DirectPaymentRegularScreen extends StatefulWidget {

  bool isMechanicApp;
  bool isPaymentFailed;   // ------ change the variable as isDirectPaymentRegular for screen 106
                            // isMechanicApp - true && isPaymentFailed - true  ==> screen 080,
                            // isMechanicApp - true && isPaymentFailed - false  ==> screen 106,
                            // isMechanicApp - false && isPaymentFailed - false  ==> screen 080 a,
                            // isMechanicApp - false && isPaymentFailed - true  ==> screen 080 a,

  DirectPaymentRegularScreen({
    required this.isMechanicApp,
    required this.isPaymentFailed
  });

  @override
  State<StatefulWidget> createState() {
    return _DirectPaymentRegularScreenState();
  }
}

class _DirectPaymentRegularScreenState extends State<DirectPaymentRegularScreen> {

  bool isDirectPayment = true;
  final MechanicOrderStatusUpdateBloc _mechanicOrderStatusUpdateBloc = MechanicOrderStatusUpdateBloc();
  HomeMechanicBloc _mechanicHomeBloc = HomeMechanicBloc();

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String isPaymentAccepted = "0";
  Timer? timerObjVar;
  Timer? timerObj;

  String authToken="";
  String userName="";

  String userId = "";
  String bookingIdEmergency="";

  String paymentStatus="0";



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
      userId = shdPre.getString(SharedPrefKeys.userID).toString();
      bookingIdEmergency = shdPre.getString(SharedPrefKeys.bookingIdEmergency).toString();


    });
    await _firestore.collection("Regular-PickUp").doc('1138').snapshots().listen((event) {
      setState(() {
        paymentStatus = event.get("paymentStatus");

      });
    });
  }

  void updateToCloudFirestoreDB() {

    _firestore
        .collection("ResolMech")
        .doc('${bookingIdEmergency}')
        .update({
        'isPaymentAccepted': "1",
        "customerFromPage" : "MechanicWaitingPaymentScreen",
        "mechanicFromPage" : "DirectPaymentSuccessScreen",
    })
        .then((value) => print("Location Added"))
        .catchError((error) =>
        print("Failed to add Location: $error"));

  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return  Scaffold(
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
                      widget.isMechanicApp
                          ?
                      isDirectPayment
                          ? MechanicDirectPaymentTitleImageWidget(size)
                          : MechanicOtherPaymentTitleImageWidget(size)
                          : customerTitleImageWidget(size),
                      warningTextWidget(size),
                      paymentReceivedButton(size)
                    ]
                ),
              ),
            )
        )
    );
  }

  void changeScreen(){
    if(!widget.isMechanicApp && !widget.isPaymentFailed){

      print(paymentStatus);

      if(paymentStatus == "1")
      {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => DirectPaymentSuccessScreen()));
      }
    }
  }

  Widget titleWidget(Size size){
    return Container(
      margin: EdgeInsets.only(
        left: size.width * 6 /100,
        // bottom: size.height * 1 /100,
        top: size.height * 3.4 / 100,
      ),
      child: Text(
        widget.isMechanicApp && !isDirectPayment
            ? "payment received "
            : "Direct payment ",
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
          Expanded(
            child: Text(
              widget.isMechanicApp
                  ?
                  isDirectPayment
                      ?
                  "Your customer chooses direct payment method! Receive the payment and click the “payment received” button"
                      :
                  "Hi..George you received a payment of rupees ₦ 1500 from customer Afamefuna "
                  :
              "You choosed the direct payment method! So this transaction process completed only after, when mechanic confirm as  he received ",
              style: warningTextStyle01,
            ),
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

  Widget MechanicOtherPaymentTitleImageWidget(Size size){
    return Container(
      color: Colors.purpleAccent,
      height: size.height * 30 / 100,
      //decoration: Styles.boxDecorationStyle,
      margin: EdgeInsets.only(
          left: size.width * 5 / 100,
          right: size.width * 5 / 100,
          top: size.height * 2 / 100
      ),
      //child: Image.asset("assets/image/img_mech_direct_pay_bg.png"),
    );
  }

  Widget warningTextWidget(Size size){
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
                bottom: size.width * 3 / 100
            ),
            margin: EdgeInsets.only(
              left: size.width * 5 / 100,
              right: size.width * 2 / 100,
            ),
            child: SvgPicture.asset("assets/image/ic_warning_blue_white.svg",
              height: size.height * 3 / 100,width: size.width * 3 / 100,),
          ),
          Expanded(
            child: Text(
              widget.isMechanicApp
                  ? isDirectPayment
                  ? "If you clicked the payment received button This service cycle will completed from your side "
                  : "You received the payment. So this service cycle ending here. Go home and complete the pending services."
                  : "Continue with direct payment. It will send a notification to your mechanic and then you can give the payment.",
              style: warningTextStyle01,
            ),
          )
        ],
      ),
    );
  }

  Widget paymentReceivedButton(Size size){
    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: (){

          changeScreen();
        },
        child: Container(
          margin: EdgeInsets.only(
              right: size.width * 6.2 / 100,
              top: size.height * 5 / 100
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
           widget.isMechanicApp
               ? isDirectPayment
               ? "Payment received "
               : "Go home"
            : "Continue",
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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("dispose");
    _mechanicOrderStatusUpdateBloc.dispose();
  }


  TextStyle warningTextStyle01 = TextStyle(
    fontSize: 12,
    fontFamily: "Samsung_SharpSans_Regular",
    fontWeight: FontWeight.w600,
    color: Colors.black,
    letterSpacing: .7,
  );

}
