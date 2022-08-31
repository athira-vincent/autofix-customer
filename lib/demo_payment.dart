import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:isw_mobile_sdk/isw_mobile_sdk.dart';

class DemoPayment extends StatefulWidget {
  const DemoPayment({Key? key}) : super(key: key);

  @override
  State<DemoPayment> createState() => _DemoPaymentState();
}

class _DemoPaymentState extends State<DemoPayment> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _amountString = '';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Charity Fortune'),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Amount'),
                  keyboardType: TextInputType.number,
                  onChanged: (String val) {
                   _amountString = val;
                  },
                ),
                Builder(
                  builder: (ctx) => SizedBox(
                    width: MediaQuery.of(ctx).size.width,
                    child: RaisedButton(
                      child: const Text(
                        "Pay",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () => pay(ctx),
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> initPlatformState() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      String merchantId = "IKIAB23A4E2756605C1ABC33CE3C287E27267F660D61";
      String merchantCode = "MX6072";
      String merchantKey = "secret";

      var config =
       IswSdkConfig(merchantId, merchantKey, merchantCode, "566");

      // initialize the sdk
      // await IswMobileSdk.initialize(config);
      // intialize with environment, default is Environment.TEST
      await  IswMobileSdk.initialize(config, Environment.TEST);

    } on PlatformException {}
  }



  /// paynow
  Future<void> pay(BuildContext context) async {
    // save form
    _formKey.currentState?.save();


    String customerId = "your+customer+id",
        customerName = "Muraino Yakubu", //replace with your customer Name
        customerEmail = "murainoy@yahoo.com", //replace with your customer Email
        customerMobile = "08133506869", //replace with your customer Mobile Nu
        reference = "pay" + DateTime.now().millisecond.toString();

    int amount;
    // initialize amount
    if (_amountString.isEmpty) {
      amount = 2500 * 100;
    } else {
      amount = int.parse(_amountString) * 100;
    }

    // create payment info
    IswPaymentInfo iswPaymentInfo =  IswPaymentInfo(customerId, customerName,
        customerEmail, customerMobile, reference, amount);
    print("rinho");
    print(iswPaymentInfo);

    // trigger payment
    var result = await IswMobileSdk.pay(iswPaymentInfo);

    var message;
    if (result.hasValue) {
      message = "You completed txn using: " + result.value.channel.toString();
    } else {
      message = "You cancelled the transaction pls try again";
    }
    Scaffold.of(context).showSnackBar( SnackBar(
      content:  Text(message),
      duration: const Duration(seconds: 3),
    ));
  }
}
