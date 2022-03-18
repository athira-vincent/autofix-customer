import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/Widgets/CurvePainter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
                          padding: const EdgeInsets.fromLTRB(0,40,0,0),
                          child: Container(
                            height: 120,
                            margin: EdgeInsets.only(
                              left: size.width * 9 / 100,
                              right: size.width * 9 / 100,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SubTitleTextRound(size,"Total job done","135"),
                                SubTitleTextRound(size,"All payments","5000"),
                                SubTitleTextRound(size,"Mothly collection","2000"),
                              ],
                            ),
                          ),
                        )
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

  Widget profileImageAndKmAndReviewCount1(Size size) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10,10,10,10),
      child: Container(
        alignment: Alignment.center,
        child: Wrap(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10,10,10,10),
              child: Stack(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0,75,155,0),
                        child: Image.asset(
                          'assets/image/mechanicProfileView/curvedGray.png',
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0,75,155,0),
                        child: Text('1200 Km',
                          style: Styles.appBarTextBlack17,),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0,110,155,0),
                        child: Text('Away',
                          style: Styles.awayTextBlack,),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(90,10,0,0),
                    child: Container(
                      width: 125.0,
                      height: 125.0,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child:Container(
                              child:CircleAvatar(
                                  radius: 50,
                                  backgroundColor: Colors.white,
                                  child: ClipOval(
                                    child:  SvgPicture.asset('assets/image/MechanicType/work_selection_avathar.svg'),
                                  )))

                      ),
                    ),
                  ),

                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(155,75,0,0),
                        child: Image.asset(
                          'assets/image/mechanicProfileView/curvedWhite.png',
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(155,75,10,0),
                        child: Text('Reviews',
                          style: Styles.appBarTextBlack17,),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(155,110,10,0),
                        child: RatingBar.builder(
                          initialRating: 3.5,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 10,
                          itemPadding: EdgeInsets.symmetric(horizontal: 1),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: CustColors.blue,
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        ),
                      )
                    ],
                  ),

                ],
              ),
            ),
          ],

        ),
      ),
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
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: "Samsung_SharpSans_ um",
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                      ),)
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
                                child: Text("₦ 5000",style: TextStyle(
                                  fontSize: 25,
                                  fontFamily: "Samsung_SharpSans_Medium",
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),)
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
             // color: CustColors.whiteBlueish,
              color: CustColors.whiteBlueish
            ),
            //child:  widget.child,
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
              style: TextStyle(
                color: Colors.black,
                fontSize: 12.5,
                fontWeight: FontWeight.w200,
                fontFamily: "Samsung_SharpSans_Medium",
               // overflow: ,
              ),)),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0,5,0,0),
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.white,
                child: Text(
                  circleText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18,
                      color: CustColors.light_navy,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Samsung_SharpSans_Bold"
                  ),
                ),
              ),
            ),
          )
          /*Stack(
                                      children: [
                                        Container(
                                          color: Colors.red,
                                            margin: EdgeInsets.only(
                                              left: 3,
                                              right: 3,
                                              top: 3,
                                              bottom: 3,
                                            ),
                                            child: Image.asset("assets/image/bg_round_white.png",
                                              width: size.width * 20 /100,
                                            )),
                                        Center(child: Text("135"))
                                      ],
                                    )*/
        ],
      ),
    );
  }

}
