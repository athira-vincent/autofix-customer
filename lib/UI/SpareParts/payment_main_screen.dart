import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Paymentsuccessscreen.dart';
import 'package:auto_fix/UI/Common/direct_payment_screen.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/cod_bloc/cod_bloc.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/cod_bloc/cod_event.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/cod_bloc/cod_state.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/placeallorderbloc/place_oder_all_bloc.dart';
import 'package:auto_fix/demo_payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:isw_mobile_sdk/isw_mobile_sdk.dart';

import '../../Repository/repository.dart';
import 'MyCart/placeallorderbloc/place_oder_all_state.dart';
import 'MyCart/placeallorderbloc/place_order_all_event.dart';
import 'purchase_response_screen.dart';
import '../Customer/MainLandingPageCustomer/customer_main_landing_screen.dart';

class Payment_Main_Screen extends StatefulWidget {
  final String amount,
      customerid,
      customername,
      customeremail,
      customerphone,
      addressid;
  final bool allitems;

  const Payment_Main_Screen(
      {Key? key,
        required this.amount,
        required this.customerid,
        required this.customername,
        required this.customeremail,
        required this.customerphone,
        required this.allitems,
        required this.addressid})
      : super(key: key);

  @override
  State<Payment_Main_Screen> createState() => _Payment_Main_ScreenState();
}

class _Payment_Main_ScreenState extends State<Payment_Main_Screen> {
  int _selectedOptionValue = -1;

  String orderid = "";
  bool value = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return SafeArea(
      child: MultiBlocListener(
        listeners: [
          BlocListener<CodBloc, CodState>(
            listener: (context, state) {
              if (state is CodLoadedState) {
                if (state.codmodel.data!.cashOnDelivery.message ==
                    "Cash on Delivery is successfully completed!!!") {
                  Fluttertoast.showToast(msg: "Payment recieved");

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              PurchaseResponseScreen(isSuccess: true,


                              )));
                }
              }
            },
          ),

          BlocListener<PlaceOrderAllBloc, PlaceOrderAllState>(
            listener: (context, state) {
              if (state is PlaceOrderAllLoadedState) {
                if (state.placeorderModel.data!.placeOrder.isNotEmpty) {
                  setState(() {
                    orderid = state
                        .placeorderModel.data!.placeOrder.first.id
                        .toString();
                  });

                }
              }
            },
          ),
        ],
        child: Scaffold(
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
                        paymentOptions(size, "Direct payment",
                            "assets/image/img_payment_cash.png", 1),
                        //paymentOptions(size, "Credit/Debit /Atm cards", "assets/image/img_payment_card.png",2),
                        //paymentOptions(size, "Netbanking", "assets/image/img_payment_netbank.png",3),
                        paymentOptions(size, "Other",
                            "assets/image/img_payment_netbank.png", 2),

                        InkWell(
                          child: paymentContinueButton(size),
                          onTap: () async {
                            print("On Press Continue");
                            if (_selectedOptionValue == 1) {
                              final codBloc = BlocProvider.of<CodBloc>(context);
                              codBloc.add(
                                  FetchCodEvent(widget.amount, orderid));
                            } else {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => DemoPayment(
                              //             amount:widget.amount,
                              //             customerid:widget.customerid,
                              //             customername:widget.customername,
                              //             customeremail:widget.customeremail,
                              //             customerphone:widget.customerphone,
                              //             customerorderid:widget.orderid)));

                              print("On Press Continue");
                              if (_selectedOptionValue == 1 &&
                                  widget.allitems == true) {
                                final placeorderallBloc =
                                BlocProvider.of<PlaceOrderAllBloc>(context);
                                placeorderallBloc.add(
                                    FetchPlaceOrderAllEvent(widget.addressid));


                                await Future.delayed(Duration(seconds: 2));

                                final codBloc = BlocProvider.of<CodBloc>(context);
                                codBloc
                                    .add(FetchCodEvent(widget.amount, orderid));
                              } else if (_selectedOptionValue == 2) {
                                initPlatformState();
                                // await Repository()
                                //     .fetchwalletcheckbalance(orderid)
                                //     .then((value) => {
                                //   if (value.data!.walletStatus.data!
                                //       .remain ==
                                //       0)
                                //     {
                                //       Repository()
                                //           .fetchpaymentsucess(
                                //           "2",
                                //           /*value.data!.walletStatus
                                //               .data.amount,*/
                                //           0,
                                //           "3",
                                //           "",
                                //           orderid)
                                //           .then((value) => {
                                //         if (value
                                //             .data!
                                //             .paymentCreate
                                //             .paymentData!
                                //             .id
                                //             .toString()
                                //             .isNotEmpty)
                                //           {
                                //             Navigator.of(context).push(
                                //                 MaterialPageRoute(
                                //                     builder:
                                //                         (context) =>
                                //                         CustomerMainLandingScreen()))
                                //           }
                                //         else
                                //           {
                                //             print("popcontext"),
                                //             Navigator.pop(context)
                                //           }
                                //       })
                                //     }
                                //   else
                                //     {
                                //       Fluttertoast.showToast(
                                //           msg:
                                //           "Insufficient wallet balance"),
                                //       setBottomsheet(
                                //           value.data!.walletStatus.data
                                //               .wallet,
                                //           value.data!.walletStatus.data
                                //               .remain,
                                //           value.data!.walletStatus.data
                                //               .wallet +
                                //               value.data!.walletStatus
                                //                   .data.remain)
                                //     }
                                // });
                              } else {
                                initPlatformState();
                              }


                            }
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

  Widget paymentScreenTitle(Size size) {
    return Container(
      margin: EdgeInsets.only(
        left: size.width * 5.8 / 100,
        // bottom: size.height * 1 /100,
        top: size.height * 3.4 / 100,
      ),
      child: const Text(
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
      child: const Text(
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

  Widget paymentOptions(Size size, String optionName, String imagePath,
      int radioValue) {
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
            style: const TextStyle(
                fontSize: 13,
                fontFamily: "Samsung_SharpSans_Medium",
                fontWeight: FontWeight.w500,
                color: CustColors.greyish_brown),
          ),
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

  Widget paymentContinueButton(Size size) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.only(
            right: size.width * 8.3 / 100, top: size.height * 4 / 100),
        decoration: const BoxDecoration(
            borderRadius: const BorderRadius.all(
              const Radius.circular(6),
            ),
            color: CustColors.light_navy),
        padding: EdgeInsets.only(
          left: size.width * 4.5 / 100,
          right: size.width * 4.5 / 100,
          top: size.height * 1 / 100,
          bottom: size.height * 1 / 100,
        ),
        child: const Text(
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

  Future<void> pay(BuildContext context) async {
    // save form
    // _formKey.currentState?.save();

    String customerId = widget.customerid,
        customerName = widget.customeremail, //replace with your customer Name
        customerEmail = widget.customeremail, //replace with your customer Email
        customerMobile =
            widget.customerphone, //replace with your customer Mobile Nu
        reference = "pay" + DateTime
            .now()
            .millisecond
            .toString();

    double amount;
    // initialize amount
    if (widget.amount.isEmpty) {
      //amount = 2500 * 100;
      amount = 0.0;
    } else {
      amount = double.parse(widget.amount) * 100.0;
    }

    // create payment info
    IswPaymentInfo iswPaymentInfo = IswPaymentInfo(customerId, customerName,
        customerEmail, customerMobile, reference, amount.toInt());


    // trigger payment
    var result = await IswMobileSdk.pay(iswPaymentInfo);

    var message;
    if (result.hasValue) {
      Repository()
          .fetchpaymentsucess("2", widget.amount, "2",
          result.value.transactionReference, orderid)
          .then((value) => {

      if (value.data!.paymentCreate.paymentData!.id.toString().isNotEmpty) {
          Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => CustomerMainLandingScreen()))
    } else {
      print("popcontext"),
      Navigator.pop(context)
    }
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
    result.value
    .
    transactionReference;

    print("transactioncredntials");
    print(result.value.channel.name);
    print(result.value.amount);
    print(result.value.isSuccessful);
    print(result.value.responseCode);
    print(result.value.responseDescription);
    print(result.value.transactionReference);
    Scaffold.of(context).showSnackBar( SnackBar(
      content:  Text(message),
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
                    color: CustColors.light_navy02,
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
                    color: CustColors.light_navy02,
                  )),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("₹ $amount"),
                  Checkbox(
                    activeColor: Colors.white,
                    checkColor: CustColors.light_navy02,
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
                    color: CustColors.light_navy02,
                  )),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("₹ $remain"),
                  Checkbox(
                    activeColor: Colors.white,
                    checkColor: CustColors.light_navy02,
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
                    color: CustColors.light_navy02),
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
    String customerId = widget.customerid,
        customerName = widget.customername, //replace with your customer Name
        customerEmail = "cust@gmail.com", //replace with your customer Email
        customerMobile =
            widget.customerphone, //replace with your customer Mobile Nu
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
