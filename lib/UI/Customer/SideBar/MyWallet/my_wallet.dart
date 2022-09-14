import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomerWalletScreen extends StatefulWidget {
  const CustomerWalletScreen({Key? key}) : super(key: key);

  @override
  State<CustomerWalletScreen> createState() => _CustomerWalletScreenState();
}

class _CustomerWalletScreenState extends State<CustomerWalletScreen> {

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
                BottomLightBackground(size),
                Column(
                  children: [
                    appBarCustomUi(size),
                    profileImageAndWalletTotal(),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                      child: Container(
                        height: 120,
                        margin: EdgeInsets.only(
                          left: size.width * 9 / 100,
                          right: size.width * 9 / 100,
                        ),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            SubTitleTextRound(
                                size,
                                "Total job done",
                                 "0"),
                            SubTitleTextRound(
                                size,
                                "All payments",
                                 "0"),
                            SubTitleTextRound(
                                size,
                                "Monthly collection",
                                 "0"),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        //top: size.height * .2 / 100,
                        bottom: size.width * .2 / 100,
                      ),
                      child: Row(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                                margin: EdgeInsets.only(
                                  top: size.height * 1.5 / 100,
                                  left: size.width * 9 / 100,
                                  right: size.width * 9 / 100,
                                ),
                                child: const Text(
                                  "Todays payments",
                                  style: Styles.myWalletTitleText03,
                                )),
                          ),
                          const Spacer(),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                                margin: EdgeInsets.only(
                                  top: size.height * 1.5 / 100,
                                  //left: size.width * 9 / 100,
                                  right: size.width * 10.5 / 100,
                                ),
                                child: Text(
                                  "100",
                                  //"- ₦ 15000",
                                  style: Styles.myWalletTitleText04,
                                )),
                          ),
                        ],
                      ),
                    ),

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
