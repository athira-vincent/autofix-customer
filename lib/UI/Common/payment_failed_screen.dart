import 'dart:async';

import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/UI/Common/direct_payment_screen.dart';
import 'package:auto_fix/UI/Customer/EmergencyServiceFlow/PaymentScreens/payment_screen.dart';
import 'package:auto_fix/UI/Customer/RegularServiceFlow/CommonScreensInRegular/RegularServicePayment/regular_direct_payment_screen.dart';
import 'package:auto_fix/UI/Customer/RegularServiceFlow/CommonScreensInRegular/RegularServicePayment/regular_payment_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PaymentFailedScreen extends StatefulWidget {
  String firebaseCollection;
  String bookingId;

  PaymentFailedScreen({
  required this.firebaseCollection,
  required this.bookingId
});

  @override
  State<StatefulWidget> createState() {
    return _PaymentFailedScreenState();
  }
}

class _PaymentFailedScreenState extends State<PaymentFailedScreen> {

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String totalServiceCost = "";
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listenToCloudFirestoreDB();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      body: SafeArea(
          child: isLoading == true
              ?
          Container(
              width: size.width,
              height: size.height,
              child: Center(child: CircularProgressIndicator(color: CustColors.light_navy)))
              :
          SingleChildScrollView(
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
    );
  }

  Widget titleWidget(Size size){
    return Container(
      margin: EdgeInsets.only(
        left: size.width * 6 /100,
        // bottom: size.height * 1 /100,
        top: size.height * 3.4 / 100,
      ),
      child: Text(AppLocalizations.of(context)!.text_Payment_failed,
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
          left: size.width * 3 / 100,
          right: size.width * 3 / 100,
          top: size.height * 7.2 / 100
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
            //"Something went wrong! Payment failed! \nTry another method like direct payment etc.. \nOr you can try after some time",
            AppLocalizations.of(context)!.text_Something_wrong_Payment_failed,
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
                      builder: (context) => RegularPaymentScreen(
                        firebaseCollection: widget.firebaseCollection,
                        bookingId: widget.bookingId,
                      )));
            },
              child: returnToPaymentOptionButton(size)),
          InkWell(
            onTap: (){
              setCashConfirmationBottomsheet(int.parse(totalServiceCost));
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
          Expanded(child: Text(AppLocalizations.of(context)!.text_Other_Payment_Options, style: buttonTextStyle,))
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
          Expanded(child: Text(AppLocalizations.of(context)!.text_Direct_payment, style: buttonTextStyle,))
        ],
      ),
    );
  }

  setCashConfirmationBottomsheet(int totalAmount) {
    return showModalBottomSheet(
      context: context,
      shape:
      const RoundedRectangleBorder(
        // <-- SEE HERE
        borderRadius:
        BorderRadius.vertical(
          top: Radius.circular(
              25.0),
        ),
      ),
      backgroundColor: Colors.white,
      builder: (context) =>
          StatefulBuilder(
              builder: (context, snapshot) {
                return Wrap(children: <Widget>[
                  SizedBox(height: 10,),
                  Container(
                    child: ListTile(leading: Text(AppLocalizations.of(context)!.text_Total_Payable,style: TextStyle(
                      fontSize: 14.3,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Samsung_SharpSans_Medium",
                      color: CustColors.light_navy,
                    )),
                      trailing: Text("₹ $totalAmount"),
                    ),
                  ),
                  Divider(thickness: 2,color: CustColors.grey_02,),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: ListTile(
                      leading:  Image.asset("assets/image/img_payment_cash.png",height: 20,width: 20,),
                      title: const Text(
                          AppLocalizations.of(context)!.text_Direct_payment,
                          style: TextStyle(
                            fontSize: 14.3,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Samsung_SharpSans_Medium",
                            color: CustColors.light_navy,
                          )
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children:  [
                          Text("₹ $totalAmount"),
                          Checkbox(
                            activeColor: Colors.white,
                            checkColor: CustColors.light_navy,
                            value: true,
                            onChanged: ( value) {

                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      /*if(value==false){
                        Fluttertoast.showToast(msg: "Recharge wallet");
                      }
                      else{*/
                      updateToCloudFirestoreDB("isPayment","1");
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegularDirectPaymentScreen(
                                firebaseCollection: widget.firebaseCollection,
                                bookingId: widget.bookingId,
                              )));
                      //}
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(6),
                            ),
                            color: CustColors.light_navy
                        ),

                        child: Center(
                          child: Text(
                            AppLocalizations.of(context)!.text_Click_Continue,
                            style: TextStyle(
                              fontSize: 14.3,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Samsung_SharpSans_Medium",
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ]);
              }
          ),
    );
  }

  void updateToCloudFirestoreDB(String key, String value) {

    _firestore
        .collection("${widget.firebaseCollection}")
        .doc('${widget.bookingId}')
        .update({
      "$key" : "$value",
      "${key}Time" : "${DateFormat("hh:mm a").format(DateTime.now())}",
      //'isPayment': "$paymentOption",
    })
        .then((value) => print("Location Added"))
        .catchError((error) =>
        print("Failed to add Location: $error"));
  }

  Future<void> listenToCloudFirestoreDB() async {
    await _firestore.collection("${widget.firebaseCollection}").doc('${widget.bookingId}').snapshots().listen((event) {
      setState(() {
        totalServiceCost = event.get('serviceTotalAmount');
      });
      Timer(const Duration(seconds: 2), () {
        setState(() {
          isLoading = false;
        });
      });
    });
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