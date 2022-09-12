import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/cod_bloc/cod_bloc.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/cod_bloc/cod_event.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/cod_bloc/cod_state.dart';
import 'package:auto_fix/demo_payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Payment_Main_Screen extends StatefulWidget {
  final String amount, orderid;

  const Payment_Main_Screen(
      {Key? key, required this.amount, required this.orderid})
      : super(key: key);

  @override
  State<Payment_Main_Screen> createState() => _Payment_Main_ScreenState();
}

class _Payment_Main_ScreenState extends State<Payment_Main_Screen> {
  int _selectedOptionValue = -1;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: MultiBlocListener(
        listeners: [
          BlocListener<CodBloc, CodState>(
            listener: (context, state) {
              if (state is CodLoadedState) {
                if (state.codmodel.data!.cashOnDelivery.message ==
                    "Cash on Delivery is successfully completed!!!") {
                  Fluttertoast.showToast(msg: "Payment recieved");
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
                          onTap: () {
                            print("On Press Continue");
                            if (_selectedOptionValue == 1) {
                              final codBloc = BlocProvider.of<CodBloc>(context);
                              codBloc.add(
                                  FetchCodEvent(widget.amount, widget.orderid));
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DemoPayment()));
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
}
