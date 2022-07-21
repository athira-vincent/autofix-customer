import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/home_Bloc/home_customer_bloc.dart';
import 'package:auto_fix/UI/Customer/MainLandingPageCustomer/customer_main_landing_screen.dart';
import 'package:auto_fix/Widgets/input_validator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RateMechanicScreen extends StatefulWidget {

  RateMechanicScreen();

  @override
  State<StatefulWidget> createState() {
    return _RateMechanicScreenState();
  }
}

class _RateMechanicScreenState extends State<RateMechanicScreen> {

  double _rating = 1.0;
  double _initialRating = 1.0;
  int textTotalCount = 350,textCount = 0;

  var scaffoldKey = GlobalKey<ScaffoldState>();
  String authToken="";
  String userName="";
  String bookingIdEmergency="";
  String mechanicName="";
  String totalEstimatedTime = "0";
  String totalEstimatedCost = "0";
  final HomeCustomerBloc _homeCustomerBloc = HomeCustomerBloc();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var _firestoreData ;

  TextEditingController _feedBackController = TextEditingController();


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
      bookingIdEmergency = shdPre.getString(SharedPrefKeys.bookingIdEmergency).toString();
      print('authToken authToken>>>>>>>>> ' + authToken.toString());
    });
    await _firestore.collection("ResolMech").doc('$bookingIdEmergency').snapshots().listen((event) {
      setState(() {
        totalEstimatedTime = event.get('totalTimeTakenByMechanic');
        totalEstimatedCost = event.get('updatedServiceCost');
        mechanicName = event.get('mechanicName');
        print('mechanicName authToken>>>>>>>>> ' + mechanicName.toString());

      });
    });
  }


  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                          rateMechanicScreenTimeCostWidget(size,"Work completed in","Min "," $totalEstimatedTime",true),
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
                          rateMechanicScreenTimeCostWidget(size,"Amount you paid","₦ ","$totalEstimatedCost",false),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
              Container(
                // color: Colors.purpleAccent,
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
                      child: Text("How was your experience with",
                        style: TextStyle(
                            fontSize: 10.7,
                            fontFamily: "Samsung_SharpSans_Medium",
                            fontWeight: FontWeight.w400,
                            color: CustColors.light_navy
                        ),),
                    ),
                    Container(
                      child: Text("$mechanicName",
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
                          Text("$textCount/$textTotalCount"),
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
                        onChanged: (val){
                          setState(() {
                            //print(val);
                            if(val.length <= textTotalCount ) {
                              textCount = val.length;
                            }
                          });
                        },
                        //maxLength: 350,
                        textAlignVertical: TextAlignVertical.center,
                        maxLines: 4,
                        style: Styles.reviewTextStyle01,
                        // focusNode: _userNameFocusNode,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(350)
                        ],
                        keyboardType: TextInputType.multiline,
                        validator: InputValidator(ch: "text",).emptyChecking,
                        controller: _feedBackController,
                        cursorColor: CustColors.light_navy,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                          hintText: "Specify your feedback ",
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 12.8,
                            horizontal: 6.0,
                          ),
                          hintStyle: Styles.reviewTextStyle01,),
                      ),
                    ),
                    InkWell(
                      child: postReviewButton(size),
                      onTap: (){
                        print("On Press Continue");
                        print("${_feedBackController.text}");
                        print("${bookingIdEmergency}");
                        print("${_rating}");

                        _homeCustomerBloc. postAddMechanicReviewAndRatingRequest(
                            authToken,_rating, _feedBackController.text, bookingIdEmergency, );

                        setDeactivate();

                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                            CustomerMainLandingScreen()), (Route<dynamic> route) => false);
                      },
                    ),
                    SizedBox(height: 20,)
                  ],
                ),

              ),
            ],
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
            Text(dataText,
              style: TextStyle(
                  fontFamily: "SharpSans_Bold",
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  letterSpacing: .5
              ),),
            SizedBox(width: 5,),
            Text(postDataText,style: TextStyle(
                fontSize: 28,
                fontFamily: "SharpSans_Bold",
                fontWeight: FontWeight.bold,
                color: CustColors.light_navy,
                letterSpacing: .5
            ),),

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


  void setDeactivate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(SharedPrefKeys.bookingIdEmergency, "");
    prefs.setString(SharedPrefKeys.serviceIdEmergency, "");
    prefs.setString(SharedPrefKeys.mechanicIdEmergency, "");

  }

}