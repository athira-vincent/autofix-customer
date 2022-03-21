import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MechanicMyWalletScreen extends StatefulWidget {

  MechanicMyWalletScreen();

  @override
  State<StatefulWidget> createState() {
    return _MechanicMyWalletScreenState();
  }
}

class _MechanicMyWalletScreenState extends State<MechanicMyWalletScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
            height: size.height,
            width: size.width,
            //color: Colors.blue,
            child: SingleChildScrollView(
              child: Container(
                child: Stack(
                  children: [
                    BottomLightBackground(size),
                    
                    Column(
                      children: [
                        appBarCustomUi(size),
                        profileImageAndWalletTotal(),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0,12,0,0),
                          child: Container(
                            height: 120,
                            margin: EdgeInsets.only(
                              left: size.width * 9 / 100,
                              right: size.width * 9 / 100,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SubTitleTextRound(size,"Total job done","135"),
                                SubTitleTextRound(size,"All payments","5000"),
                                SubTitleTextRound(size,"Monthly collection","2000"),
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
                                    child: Text("Todays payments",
                                      style: Styles.myWalletTitleText03,)
                                ),
                              ),
                              Spacer(),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                    margin: EdgeInsets.only(
                                      top: size.height * 1.5 / 100,
                                     //left: size.width * 9 / 100,
                                      right: size.width * 10.5 / 100,
                                    ),
                                    child: Text("- ₦ 15000",
                                      style: Styles.myWalletTitleText04,)
                                ),
                              ),
                            ],
                          ),
                        ),

                        listTileItem(size,"John Carlo","11:30","₦ 5000"),
                        //Spacer(),
                        listTileItem(size,"John Carlo","11:30","₦ 5000"),

                        listTileItem(size,"John Carlo","11:30","₦ 5000"),

                      ],
                    ),
                  ],
                ),
              ),
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
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        Text(
          'My Wallet',
          textAlign: TextAlign.center,
          style: Styles.appBarTextBlue,
        ),
        Spacer(),
      ],
    );
  }

  Widget profileImageAndWalletTotal() {
    return Wrap(
      children: [
        Container(
          height: 292,
          width: 500,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8,26,8,0),
                child: Container(
                  child: ClipRRect(
                    //borderRadius: BorderRadius.circular(20.0),
                    child:Container(
                        child:Image.asset('assets/image/bg_wallet.png')),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(0,0,0,0),
                child: Wrap(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0,0,0,0),
                        child: Container(
                          width: 120.0,
                          height: 120.0,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child:Container(
                                  child:CircleAvatar(
                                      radius: 75,
                                      backgroundColor: Colors.white,
                                      child: ClipOval(
                                        child:  SvgPicture.asset('assets/image/MechanicType/work_selection_avathar.svg'),
                                      )))
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 29,
                            right: 33
                        ),
                        child: Container(
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child:Container(
                                child:Container(
                                    child: Text("Your balance ",
                                      style: Styles.myWalletCardText02,)
                                ),
                              )

                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(
                            top: 16,
                            right: 33
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child:Container(
                            child:Container(
                                child: Text("₦ 5000",style: Styles.myWalletCardText01,)
                            ),
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
      height: MediaQuery.of(context).size.height*.70,
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height*.28,
        left: size.width * 4 / 100,
        right: size.width * 4 / 100,
      ),
      child: Padding(
          padding: EdgeInsets.only(bottom: size.height * 3 / 100 ),
          child: Container(
            height: size.height * 70 /100,
            //height: MediaQuery.of(context).size.height * double.parse(widget.percentage.toString()),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
               Radius.circular(10),
              ),
              //color: CustColors.blackishgrey,
              color: CustColors.whiteBlueish,
            ),
          )
      ),
    );
  }

  Widget SubTitleTextRound(Size size,String titleText,String circleText) {
    return  Container(
      height: size.height * 20 / 100,
      width: size.width * 20 / 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              margin : EdgeInsets.only(
                  top: 2,
                  left: 2,
                  right: 2,
                  bottom: 0
              ),
              child: Text(titleText,
              textAlign: TextAlign.center,
              style: Styles.myWalletSubTitleTextRoundText01,)),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0,5,0,0),
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

  Widget listTileItem(Size size, String customerName, String time, String amount){
    return Container(
      padding: EdgeInsets.only(
          top: size.height * 1 / 100,
          bottom: size.height * 1 / 100,
      ),
      margin: EdgeInsets.only(
        left: size.width * 8 / 100,
        right: size.width * 8 / 100,
      ),
      child: Container(
        padding: EdgeInsets.only(
            top: size.height * 1.8 / 100,
            bottom: size.height * 1.8 / 100,
            right: size.width * 2.5 / 100,
            left: size.width * 2.5 / 100
        ),
        margin: EdgeInsets.only(
          left: size.width * 1.2 / 100,
          right: size.width * 1.2 / 100,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(6),
            ),
            color: Colors.white
        ),
        //color: CustColors.white_02,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text("Customer",style: Styles.myWalletListTileTitle01,),
                SizedBox(
                  height: size.height * .7 / 100,
                ),
                Text(customerName,style: Styles.myWalletListTileTitle02,),
              ],
            ),

            Column(
              children: [
                Text("Time",style: Styles.myWalletListTileTitle01,),
                SizedBox(
                  height: size.height * .7 / 100,
                ),
                Text(time,style: Styles.myWalletListTileTitle02,),
              ],
            ),

            Container(
              child: Text(
                amount,style: Styles.myWalletListTileTitle03,
              ),
            )

          ],
        ),
      ),

    );

  }
}
