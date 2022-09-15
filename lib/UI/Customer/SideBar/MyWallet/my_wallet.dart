import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/Widgets/input_validator.dart';
import 'package:coupon_uikit/coupon_uikit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomerWalletScreen extends StatefulWidget {
  const CustomerWalletScreen({Key? key}) : super(key: key);

  @override
  State<CustomerWalletScreen> createState() => _CustomerWalletScreenState();
}

class _CustomerWalletScreenState extends State<CustomerWalletScreen> {

  TextEditingController _phoneController = TextEditingController();
  FocusNode _phoneFocusNode = FocusNode();


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: SingleChildScrollView(
            child: Stack(
              children: [
                BottomLightBackground01(size),
                Column(
                  children: [
                    appBarCustomUi(size),
                    profileImageAndWalletTotal(),

                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget appBarCustomUi(Size size) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        const Text(
          'My Wallet',
          textAlign: TextAlign.center,
          style: Styles.appBarTextBlue,
        ),
        const Spacer(),

      ],
    );
  }

  Widget profileImageAndWalletTotal() {
    return Wrap(
      children: [
        SizedBox(
          height: 292,
          width: 500,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 26, 8, 0),
                child: ClipRRect(
                  //borderRadius: BorderRadius.circular(20.0),
                  child: Image.asset('assets/image/bg_wallet.png'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Wrap(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: SizedBox(
                          width: 110.0,
                          height: 110.0,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: CircleAvatar(
                                  radius: 75,
                                  // child:Image.network(
                                  //         _BookingDatum![0].mechanic!.mechanic![0].profilePic,
                                  //     fit: BoxFit.fill,
                                  //     ),
                                  backgroundColor: Colors.white,
                                  child: SizedBox(
                                    height: 106.0,
                                    width: 106.0,
                                    child: ClipOval(
                                      child:  SvgPicture.asset(
                                          'assets/image/MechanicType/work_selection_avathar.svg'),
                                    ),
                                  ))),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 29, right: 33),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: const Text(
                              "Your balance ",
                              style: Styles.myWalletCardText02,
                            )),
                      ),
                    ),
                    Center(
                      child: Container(
                        margin: const EdgeInsets.only(top: 16, right: 33),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 100.0),
                            child: Row(children: const [
                              Text(
                                "₦ ",
                                style: Styles.myWalletCardText01,
                              ),
                              Text(
                                "0",
                                style: Styles.myWalletCardText01,
                              )
                            ]),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget BottomLightBackground(Size size) {
    return Container(
      height: MediaQuery.of(context).size.height * .70,
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * .28,
        left: size.width * 4 / 100,
        right: size.width * 4 / 100,
      ),
      child: Padding(
          padding: EdgeInsets.only(bottom: size.height * 3 / 100),
          child: Container(
            height: size.height * 70 / 100,
            //height: MediaQuery.of(context).size.height * double.parse(widget.percentage.toString()),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              //color: CustColors.blackishgrey,
              color: CustColors.whiteBlueish,
            ),
          )),
    );
  }

  Widget BottomLightBackground01(Size size) {
    return Container(
      height: MediaQuery.of(context).size.height * .50,
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * .45,
        left: size.width * 4 / 100,
        right: size.width * 4 / 100,
      ),
      child: Padding(
          padding: EdgeInsets.only(bottom: size.height * 3 / 100),
          child: Container(
            height: size.height * 70 / 100,
            //height: MediaQuery.of(context).size.height * double.parse(widget.percentage.toString()),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              //color: CustColors.blackishgrey,
            ),
            child: CouponCard(
              curveRadius: 70.0,
              firstChild: Container(
                height: size.height * 5 / 100,
                color: CustColors.whiteBlueish,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Container(
                    height: 100,
                    margin: EdgeInsets.only(
                      left: size.width * 9 / 100,
                      right: size.width * 9 / 100,
                    ),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceEvenly,
                      children: [
                        SubTitleTextRound(
                            size,
                            "Total spent",
                            "0"),
                        SubTitleTextRound(
                            size,
                            "Total balance",
                            "0"),
                      ],
                    ),
                  ),
                ),
              ),
              secondChild: Container(
                height: size.height * 5 / 100,
                color: CustColors.whiteBlueish,
                child: addMoneyWidget(size),
              ),
            ),
          )
      ),
    );
  }

  Widget addMoneyWidget(Size size){
    return  Container(
      margin: EdgeInsets.only(
        //top: size.height * .2 / 100,
        bottom: size.width * .2 / 100,
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
                margin: EdgeInsets.only(
                  top: size.height * 2 / 100,
                  left: size.width * 9 / 100,
                  right: size.width * 9 / 100,
                ),
                child: const Text(
                  "Add money to wallet",
                  style: Styles.myWalletTitleText05,
                )),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
                margin: EdgeInsets.only(
                  top: size.height * 2 / 100,
                  left: size.width * 9 / 100,
                  right: size.width * 9 / 100,
                ),
                child: const Text(
                  "Enter amount ",
                  style: Styles.myWalletListTileTitle01,
                )),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
                margin: EdgeInsets.only(
                  top: size.height * 2 / 100,
                  left: size.width * 9 / 100,
                  right: size.width * 9 / 100,
                ),
                child: TextFormField(
                  textAlignVertical: TextAlignVertical.center,
                  maxLines: 1,
                  style: Styles.textLabelSubTitle01,
                  focusNode: _phoneFocusNode,
                  keyboardType:
                  TextInputType.number,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(
                        15),
                  ],
                  validator: InputValidator(
                    ch: 'Amount',
                  ).phoneNumChecking,
                  controller: _phoneController,
                  cursorColor: CustColors.materialBlue,
                  decoration: InputDecoration(
                    errorStyle: TextStyle(color: Colors.red),
                    isDense: true,
                    hintText:
                    'Enter Amount',
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: CustColors.white_02,
                            width: .5,
                          ),
                        ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: CustColors.white_02,
                          width: .5,
                        )
                    ),
                    enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                    color: CustColors.white_02,
                    width: .5,
                  )
                ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 12.8,
                      horizontal: 8.0,
                    ),
                    hintStyle: Styles.textLabelSubTitle,
                  ),
                ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.only(
                top: size.height * 2 / 100,
                left: size.width * 9 / 100,
                right: size.width * 9 / 100,
              ),
              padding: EdgeInsets.only(
                top: size.height * 1.5 / 100,
                bottom: size.height * 1.5 / 100,
              ),
              color: CustColors.light_navy,
              child: Center(
                child: Text("Add Money", 
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontFamily: 'Samsung_SharpSans_Bold'
                ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget SubTitleTextRound(Size size, String titleText, String circleText) {
    return SizedBox(
      height: size.height * 20 / 100,
      width: size.width * 20 / 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              margin:
              const EdgeInsets.only(top: 2, left: 2, right: 2, bottom: 0),
              child: Text(
                titleText,
                textAlign: TextAlign.center,
                style: Styles.myWalletSubTitleTextRoundText01,
              )),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.white,
                child: Text(
                  circleText,
                  textAlign: TextAlign.center,
                  style: Styles.myWalletSubTitleTextRoundText02,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
