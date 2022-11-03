import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Customer/MainLandingPageCustomer/customer_main_landing_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:isw_mobile_sdk/isw_mobile_sdk.dart';

import 'Constants/styles.dart';

class DemoPayment extends StatefulWidget {
  final String amount,
      customerid,
      customername,
      customeremail,
      customerphone,
      customerorderid;

  const DemoPayment(
      {Key? key,
      required this.amount,
      required this.customerid,
      required this.customername,
      required this.customeremail,
      required this.customerphone,
      required this.customerorderid})
      : super(key: key);

  @override
  State<DemoPayment> createState() => _DemoPaymentState();
}

class _DemoPaymentState extends State<DemoPayment> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _amountString = '';
  TextEditingController amountcontroller = TextEditingController();

  @override
  void initState() {
    amountcontroller.text = widget.amount;
    super.initState();

    initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }

  Future<void> initPlatformState() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    pay(context);
    try {
      String merchantId = "IKIABFC88BB635BAE1C834A37CF63FB68B4D19CE8742";
      String merchantCode = "MX104222";
      String merchantKey = "ELjqMeFJxYHAPDM";

      var config = IswSdkConfig(merchantId, merchantKey, merchantCode, "566");

      // initialize the sdk
      // await IswMobileSdk.initialize(config);
      // intialize with environment, default is Environment.TEST
      await IswMobileSdk.initialize(config, Environment.TEST);
    } on PlatformException {}
  }

  // /// paynow
  // Future<void> pay(BuildContext context) async {
  //   // save form
  //   _formKey.currentState?.save();
  //
  //
  //   String customerId = widget.customerid,
  //       customerName = widget.customeremail, //replace with your customer Name
  //       customerEmail = widget.customeremail, //replace with your customer Email
  //       customerMobile = widget.customerphone, //replace with your customer Mobile Nu
  //       reference = "pay" + DateTime.now().millisecond.toString();
  //
  //   int amount;
  //   // initialize amount
  //   if (_amountString.isEmpty) {
  //     amount = 2500 * 100;
  //   } else {
  //     amount = int.parse(_amountString) * 100;
  //   }
  //
  //   // create payment info
  //   IswPaymentInfo iswPaymentInfo =  IswPaymentInfo(customerId, customerName,
  //       customerEmail, customerMobile, reference, amount);
  //   print("rinho");
  //   print(iswPaymentInfo);
  //
  //   // trigger payment
  //   var result = await IswMobileSdk.pay(iswPaymentInfo);
  //
  //   var message;
  //   if (result.hasValue) {
  //     print("transactioncredntials");
  //     print(result.value.channel.name);
  //     print(result.value.channel.index);
  //     print(result.value.amount);
  //     print(result.value.isSuccessful);
  //     print(result.value.responseCode);
  //     print(result.value.responseDescription);
  //     print(result.value.transactionReference);
  //     message = "You completed txn using: " + result.value.channel.name;
  //
  //   } else {
  //     message = "You cancelled the transaction pls try again";
  //   }
  //   Scaffold.of(context).showSnackBar( SnackBar(
  //     content:  Text(message),
  //     duration: const Duration(seconds: 3),
  //   ));
  // }

  Future<void> pay(BuildContext context) async {
    // save form
    // _formKey.currentState?.save();

    String customerId = widget.customerid,
        customerName = widget.customeremail, //replace with your customer Name
        customerEmail = widget.customeremail, //replace with your customer Email
        customerMobile =
            widget.customerphone, //replace with your customer Mobile Nu
        reference = "pay" + DateTime.now().millisecond.toString();

    int amount;
    // initialize amount
    if (widget.amount.isEmpty) {
      //amount = 2500 * 100;
      amount = 0;
    } else {
      amount = int.parse(widget.amount) * 100;
    }

    // create payment info
    IswPaymentInfo iswPaymentInfo = IswPaymentInfo(customerId, customerName,
        customerEmail, customerMobile, reference, amount);
    print("rinho");
    print(iswPaymentInfo);

    // trigger payment
    var result = await IswMobileSdk.pay(iswPaymentInfo);

    var message;
    if (result.hasValue) {
      Repository()
          .fetchpaymentsucess("2", widget.amount, "2",
              result.value.transactionReference, widget.customerorderid)
          .then((value) async => {
                setState(() {
                  if (value.data!.paymentCreate.id.toString().isNotEmpty) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CustomerMainLandingScreen()));
                  } else {
                    print("popcontext");
                    Navigator.pop(context);
                  }
                })
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

    // print("transactioncredntials");
    // print(result.value.channel.name);
    // print(result.value.amount);
    // print(result.value.isSuccessful);
    // print(result.value.responseCode);
    // print(result.value.responseDescription);
    // print(result.value.transactionReference);
    // Scaffold.of(context).showSnackBar( SnackBar(
    //   content:  Text(message),
    //   duration: const Duration(seconds: 3),
    // ));
  }
}
