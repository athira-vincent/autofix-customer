import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RateMechanicScreen extends StatefulWidget {

  RateMechanicScreen();

  @override
  State<StatefulWidget> createState() {
    return _RateMechanicScreenState();
  }
}

class _RateMechanicScreenState extends State<RateMechanicScreen> {

  late double _rating;
  double _initialRating = 0.5;

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              width: size.width,
              height: size.height,
              //color: Colors.green,
              child: Column(
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        rateMechanicScreenTitle(size),
                        rateMechanicScreenImage(size),

                        Container(
                          margin: EdgeInsets.only(
                            top: size.height * 2 / 100,
                            left: size.width * 6.5 / 100,
                            right: size.width * 6.5 / 100
                          ),
                          child: Row(
                            children: [
                              rateMechanicScreenTimeCostWidget(size,"Work completed in","Min "," 20:15",true),
                              Spacer(),
                              Container(
                                height: size.height * 5 /100,
                                child: VerticalDivider(
                                  color: CustColors.pale_grey01,
                                  width: 20,
                                  thickness: 2,
                                ),
                              ),
                              Spacer(),
                              rateMechanicScreenTimeCostWidget(size,"Amount you paid","₦ ","1600",false),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                  Expanded(
                      child: Container(
                        margin: EdgeInsets.only(
                          top: size.height * 2.1 / 100
                        ),
                        //color: Colors.purpleAccent,
                        color: CustColors.white_02,
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                top: size.height * 3.5 / 100,
                                left: size.width * 39 / 100,
                                right: size.width * 39 / 100
                              ),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0),
                                  child:Container(
                                      child:CircleAvatar(
                                          radius: 50,
                                          backgroundColor: Colors.white,
                                          child: ClipOval(
                                            child:  SvgPicture.asset('assets/image/MechanicType/work_selection_avathar.svg'),
                                          ),),),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                left: size.width * 30 / 100,
                                right: size.width * 30 / 100,
                                top: size.height * 1.5 / 100
                              ),
                              child: Text("How was your experience with",
                                style: TextStyle(
                                  fontSize: 10.7,
                                  fontFamily: "Samsung_SharpSans_Medium",
                                  fontWeight: FontWeight.w400,
                                  color: CustColors.light_navy
                                ),),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  left: size.width * 30 / 100,
                                  right: size.width * 30 / 100,
                                  top: size.height * .25 / 100
                              ),
                              child: Text("George Dola?",
                                 style: TextStyle(
                                  fontSize: 19,
                                  fontFamily: "Samsung_SharpSans_Medium",
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black
                              ),),
                            ),

                            Container(
                              margin: EdgeInsets.only(
                                  left: size.width * 10 / 100,
                                  right: size.width * 10 / 100,
                                  top: size.height * 2.5 / 100
                              ),
                              child: RatingBar(
                                initialRating: _initialRating,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                ratingWidget: RatingWidget(
                                  full: _image('assets/image/IconsRatingBar/star_active.png'),
                                  half: _image('assets/image/IconsRatingBar/star_half.png'),
                                  empty: _image('assets/image/IconsRatingBar/star_inactive.png'),
                                ),
                                itemPadding: EdgeInsets.symmetric(horizontal: 8.1),
                                onRatingUpdate: (rating) {
                                  setState(() {
                                    _rating = rating;
                                  });
                                },
                                updateOnDrag: true,
                              ),
                            ),

                            Container(
                              margin: EdgeInsets.only(
                                  left: size.width * 6 / 100,
                                  right: size.width * 6 / 100,
                                  top: size.height * 4 / 100
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Write a review",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: "Samsung_SharpSans_Medium",
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black
                                    ),
                                  ),
                                  Text("32/450"),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  left: size.width * 6 / 100,
                                  right: size.width * 5 / 100,
                                top: size.height * 1.4 / 100,
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                  border: Border.all(
                                      color: CustColors.pinkish_grey02,
                                      width: 0.3
                                  )
                              ),
                              child: TextFormField(
                                //text color : greyish_brown
                                minLines: 3,
                                maxLines: 5,  // allow user to enter 5 line in textfield
                                keyboardType: TextInputType.multiline,  // user keyboard will have a button to move cursor to next line
                                //controller: _Textcontroller,
                              ),
                            ),

                            InkWell(
                              child: postReviewButton(size),
                              onTap: (){
                                print("On Press Continue");
                              },
                            ),
                          ],
                        ),

                      ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget rateMechanicScreenTitle(Size size){
    return Container(
      margin: EdgeInsets.only(
        left: size.width * 5.8 /100,
        // bottom: size.height * 1 /100,
        top: size.height * 3.4 / 100,
      ),
      child: Text("Rate your mechanic! ",style: TextStyle(
        fontSize: 16,
        fontFamily: "Samsung_SharpSans_Medium",
        fontWeight: FontWeight.w400,
        color: CustColors.light_navy,
      ),),
    );
  }

  Widget rateMechanicScreenImage(Size size){
    return Container(
      margin: EdgeInsets.only(
        left: size.width * 4.9 /100,
        right: size.width * 4.9 /100,
        //bottom: size.height * 4 /100,
        top: size.height * 2.5 / 100,
      ),
      child: Image.asset("assets/image/img_rate_mechanic_bg.png"),
    );
  }

  Widget rateMechanicScreenTimeCostWidget(Size size, String titleText, String postDataText, String dataText,bool isTime){
    return Column(
      // mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: isTime ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        Text(titleText,
          style: TextStyle(
              fontSize: 12,
              fontFamily: "Samsung_SharpSans_Medium",
              fontWeight: FontWeight.w400,
              color: Colors.black
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(postDataText,style: TextStyle(
                fontSize: 28,
                fontFamily: "SharpSans_Bold",
                fontWeight: FontWeight.bold,
                color: CustColors.light_navy
            ),),
            Text(dataText,
              style: TextStyle(
                  fontFamily: "SharpSans_Bold",
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  letterSpacing: .5
              ),)
          ],
        ),
      ],
    );
  }

  Widget postReviewButton(Size size){
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.only(
            right: size.width * 6 / 100,
            top: size.height * 3.2 / 100
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(6),
            ),
            color: CustColors.light_navy
        ),
        padding: EdgeInsets.only(
          left: size.width * 4.5 / 100,
          right: size.width * 4.5 / 100,
          top: size.height * 1 / 100,
          bottom: size.height * 1 / 100,
        ),
        child: Text(
          "Post review",
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

  Widget _image(String asset) {
    return Image.asset(
      asset,
      height: 30.0,
      width: 30.0,
      //color: Colors.amber,
    );
  }
}