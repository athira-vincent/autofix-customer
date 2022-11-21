import 'dart:async';
import 'dart:ui';

import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/UI/Customer/RegularServiceFlow/CommonScreensInRegular/RegularServicePayment/regular_direct_payment_screen.dart';
import 'package:auto_fix/Widgets/snackbar_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:isw_mobile_sdk/isw_mobile_sdk.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../Repository/repository.dart';
import '../../../MainLandingPageCustomer/customer_main_landing_screen.dart';

class RegularPaymentScreen extends StatefulWidget {
  String firebaseCollection;
  String bookingId;

  RegularPaymentScreen(
      {required this.firebaseCollection, required this.bookingId});

  @override
  State<StatefulWidget> createState() {
    return _RegularPaymentScreenState();
  }
}

class _RegularPaymentScreenState extends State<RegularPaymentScreen> {
  int _selectedOptionValue = -1;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String mechanicArrivalState = "0";
  Timer? timerObjVar;
  Timer? timerObj;

  String authToken = "";
  String userName = "";

  String userid = "";

  var scaffoldKey = GlobalKey<ScaffoldState>();
  bool value = false;

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

      //bookingIdEmergency = shdPre.getString(SharedPrefKeys.bookingIdEmergency).toString();
      print('PaymentScreen authToken>>>>>>>>> ' + authToken.toString());
      userid = shdPre.getString(SharedPrefKeys.userID).toString();
      //print('PaymentScreen bookingIdEmergency>>>>>>>>> ' + bookingIdEmergency.toString());
    });
  }

  void updateToCloudFirestoreDB(String paymentOption) {
    _firestore
        .collection("${widget.firebaseCollection}")
        .doc('${widget.bookingId}')
        .update({
          'isPayment': "$paymentOption",
        })
        .then((value) => print("Location Added"))
        .catchError((error) => print("Failed to add Location: $error"));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey,
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
                      paymentOptions(size, "Direct payment",
                          "assets/image/img_payment_cash.png", 1),
                      paymentOptions(size, "Wallet Payment",
                          "assets/image/img_payment_upi.png", 2),
                      paymentOptions(size, "Online Payment",
                          "assets/image/img_payment_card.png", 3),
                      // paymentOptions(size, "Netbanking", "assets/image/img_payment_netbank.png",4),

                      InkWell(
                        child: paymentContinueButton(size),
                        onTap: () {
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
    );
  }

  Widget paymentScreenTitle(Size size) {
    return Container(
      margin: EdgeInsets.only(
        left: size.width * 5.8 / 100,
        // bottom: size.height * 1 /100,
        top: size.height * 3.4 / 100,
      ),
      child: Text(
        "Payments ",
        style: TextStyle(
          fontSize: 16,
          fontFamily: "Samsung_SharpSans_Medium",
          fontWeight: FontWeight.w400,
          color: CustColors.light_navy,
        ),
      ),
    );
  }

  Widget paymentScreenImage(Size size) {
    return Container(
      margin: EdgeInsets.only(
        left: size.width * 3.9 / 100,
        right: size.width * 3.9 / 100,
        //bottom: size.height * 4 /100,
        top: size.height * .9 / 100,
      ),
      child: Image.asset("assets/image/img_payment_bg.png"),
    );
  }

  Widget paymentScreenSubTitle(Size size) {
    return Container(
      margin: EdgeInsets.only(
        left: size.width * 11.7 / 100,
        // bottom: size.height * 1 /100,
        top: size.height * 4.1 / 100,
      ),
      child: Text(
        "Payment method ",
        style: TextStyle(
          fontSize: 15,
          fontFamily: "Samsung_SharpSans_Medium",
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget paymentOptions(
      Size size, String optionName, String imagePath, int radioValue) {
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
                onChanged: (value) {
                  setState(() {
                    //_value = value  ;
                    _selectedOptionValue = value as int;
                    print("value >>>>>>> " + value.toString());
                  });
                }),
          ),
          Text(
            optionName,
            style: TextStyle(
                fontSize: 13,
                fontFamily: "Samsung_SharpSans_Medium",
                fontWeight: FontWeight.w500,
                color: CustColors.greyish_brown),
          ),
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

  Widget paymentContinueButton(Size size) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.only(
            right: size.width * 8.3 / 100, top: size.height * 4 / 100),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(6),
            ),
            color: CustColors.light_navy),
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

  Future<void> changeScreen(int selectedOptionValue) async {
    print(selectedOptionValue);
    if (selectedOptionValue == 1) {
      updateToCloudFirestoreDB("1");
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => RegularDirectPaymentScreen(
                    //isMechanicApp: false,isPaymentFailed: false,
                    firebaseCollection: widget.firebaseCollection,
                    bookingId: widget.bookingId,
                  )));
    } else if (selectedOptionValue == 3) {
      initPlatformState();
    } else if (_selectedOptionValue == 2) {
      await Repository()
          .fetchwalletcheckbalance(widget.bookingId)
          .then((value) => {
                if (value.data!.walletStatus.data.remain == 0)
                  {
                    Repository()
                        .fetchpaymentsucess(
                            "1",
                            value.data!.walletStatus.data.amount,
                            "3",
                            "",
                            widget.bookingId)
                        .then((value) => {
                              if (value.data!.paymentCreate.paymentData!.id
                                  .toString()
                                  .isNotEmpty)
                                {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          CustomerMainLandingScreen()))
                                }
                              else
                                {print("popcontext"), Navigator.pop(context)}
                            })
                  }
                else
                  {
                    Fluttertoast.showToast(msg: "Insufficient wallet balance"),
                    setBottomsheet(
                        value.data!.walletStatus.data.wallet,
                        value.data!.walletStatus.data.remain,
                        value.data!.walletStatus.data.wallet +
                            value.data!.walletStatus.data.remain)
                  }
              });
    } else if (selectedOptionValue == -1) {
      SnackBarWidget()
          .setMaterialSnackBar("Please choose a payment method", scaffoldKey);
    }
  }

  Future<void> initPlatformState() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    pay(context);
    try {
      String merchantId = "IKIABFC88BB635BAE1C834A37CF63FB68B4D19CE8742";
      String merchantCode = "MX104222";
      String merchantKey = "ELjqMeFJxYHAPDM";

      var config = IswSdkConfig(merchantId, merchantKey, merchantCode, "566");

      await IswMobileSdk.initialize(config, Environment.TEST);
    } on PlatformException {}
  }

  Future<void> pay(BuildContext context) async {
    String customerId = userid,
        customerName = userName, //replace with your customer Name
        customerEmail = "cust@gmail.com", //replace with your customer Email
        customerMobile = "8547101855", //replace with your customer Mobile Nu
        reference = "pay" + DateTime.now().millisecond.toString();

    int amount;
    // initialize amount
    // if (_phoneController.text.isEmpty) {
    //   //amount = 2500 * 100;
    //   amount = 0;
    // } else {
    //   amount = int.parse("100") * 100;
    // }

    /// here real amount should be added

    amount = int.parse("10") * 100;

    // create payment info
    IswPaymentInfo iswPaymentInfo = IswPaymentInfo(customerId, customerName,
        customerEmail, customerMobile, reference, amount);

    // trigger payment
    var result = await IswMobileSdk.pay(iswPaymentInfo);

    var message;
    if (result.hasValue) {
      Repository()
          .fetchpaymentsucess(null, "10", null,
              result.value.transactionReference, widget.bookingId)
          .then((value) => {
                if (value.data!.paymentCreate.paymentData!.id
                    .toString()
                    .isNotEmpty)
                  {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CustomerMainLandingScreen()))
                  }
                else
                  {print("popcontext"), Navigator.pop(context)}
              });
    } else {
      message = "You cancelled the transaction pls try again";
    }

    message = "You completed txn using: " +
        result.value.channel.name +
        result.value.channel.index.toString() +
        result.value.amount.toString() +
        result.value.isSuccessful.toString() +
        result.value.responseCode +
        result.value.responseDescription +
        result.value.transactionReference;

    print("transactioncredntials");
    print(result.value.channel.name);
    print(result.value.amount);
    print(result.value.isSuccessful);
    print(result.value.responseCode);
    print(result.value.responseDescription);
    print(result.value.transactionReference);
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 3),
    ));
  }

  setBottomsheet(int amount, int remain, int total) {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        // <-- SEE HERE
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      backgroundColor: Colors.white,
      builder: (context) => StatefulBuilder(builder: (context, snapshot) {
        return Wrap(children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Container(
            child: ListTile(
              leading: Text("Total Payable ",
                  style: TextStyle(
                    fontSize: 14.3,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Samsung_SharpSans_Medium",
                    color: CustColors.light_navy,
                  )),
              trailing: Text("₹ $total"),
            ),
          ),
          Divider(
            thickness: 2,
            color: CustColors.grey_02,
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: ListTile(
              leading: Image.asset(
                "assets/image/img_payment_upi.png",
                height: 20,
                width: 20,
              ),
              title: const Text('Wallet',
                  style: TextStyle(
                    fontSize: 14.3,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Samsung_SharpSans_Medium",
                    color: CustColors.light_navy,
                  )),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("₹ $amount"),
                  Checkbox(
                    activeColor: Colors.white,
                    checkColor: CustColors.light_navy,
                    value: true,
                    onChanged: (value) {},
                  ),
                ],
              ),
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: ListTile(
              leading: Image.asset(
                "assets/image/img_payment_card.png",
                height: 20,
                width: 20,
              ),
              title: const Text('Card Payment',
                  style: TextStyle(
                    fontSize: 14.3,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Samsung_SharpSans_Medium",
                    color: CustColors.light_navy,
                  )),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("₹ $remain"),
                  Checkbox(
                    activeColor: Colors.white,
                    checkColor: CustColors.light_navy,
                    value: value,
                    onChanged: (value) {
                      snapshot(() {
                        this.value = value!;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              if (value == false) {
                Fluttertoast.showToast(msg: "Recharge wallet");
              } else {
                walletrecharge(remain);
              }
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
                    color: CustColors.light_navy),
                child: Center(
                  child: Text(
                    "Pay",
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
      }),
    );
  }

  Future<void> walletrecharge(int amountwallet) async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    walletpay(context, amountwallet);
    try {
      String merchantId = "IKIABFC88BB635BAE1C834A37CF63FB68B4D19CE8742";
      String merchantCode = "MX104222";
      String merchantKey = "ELjqMeFJxYHAPDM";

      var config = IswSdkConfig(merchantId, merchantKey, merchantCode, "566");

      await IswMobileSdk.initialize(config, Environment.TEST);
    } on PlatformException {}
  }

  Future<void> walletpay(BuildContext context, int amountwallet) async {
    String customerId = userid,
        customerName = "Cust", //replace with your customer Name
        customerEmail = "cust@gmail.com", //replace with your customer Email
        customerMobile = "8547101855", //replace with your customer Mobile Nu
        reference = "pay" + DateTime.now().millisecond.toString();

    int amount;
    // initialize amount
    if (amountwallet.toString().isEmpty) {
      //amount = 2500 * 100;
      amount = 0;
    } else {
      amount = int.parse(amountwallet.toString()) * 100;
    }

    // create payment info
    IswPaymentInfo iswPaymentInfo = IswPaymentInfo(customerId, customerName,
        customerEmail, customerMobile, reference, amount);

    // trigger payment
    var result = await IswMobileSdk.pay(iswPaymentInfo);

    var message;
    if (result.hasValue) {
      Repository()
          .fetchpaymentsucess(
              null, amountwallet, null, result.value.transactionReference, null)
          .then((value) => {
                if (value.data!.paymentCreate.paymentData!.id
                    .toString()
                    .isNotEmpty)
                  {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CustomerMainLandingScreen()))

                    /// wallet deduction api integrate
                  }
                else
                  {print("popcontext"), Navigator.pop(context)}
              });
    } else {
      message = "You cancelled the transaction pls try again";
    }

    message = "You completed txn using: " +
        result.value.channel.name +
        result.value.channel.index.toString() +
        result.value.amount.toString() +
        result.value.isSuccessful.toString() +
        result.value.responseCode +
        result.value.responseDescription +
        result.value.transactionReference;

    print("transactioncredntials");
    print(result.value.channel.name);
    print(result.value.amount);
    print(result.value.isSuccessful);
    print(result.value.responseCode);
    print(result.value.responseDescription);
    print(result.value.transactionReference);
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 3),
    ));
  }
}
