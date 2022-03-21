import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/MechanicProfileView/mechanic_tracking_Screen.dart';
import 'package:auto_fix/Widgets/screen_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../Constants/cust_colors.dart';
import '../../../../../Constants/styles.dart';
import '../../../../../Widgets/CurvePainter.dart';

class MechanicWorkCompletedScreen extends StatefulWidget {

  final String mechanicId;
  final String authToken;


  MechanicWorkCompletedScreen({required this.mechanicId,required this.authToken,});

  @override
  State<StatefulWidget> createState() {
    return _MechanicWorkCompletedScreenState();
  }
}

class _MechanicWorkCompletedScreenState extends State<MechanicWorkCompletedScreen> {


  double per = .10;
  double perfont = .10;
  double height = 0;
  String selectedState = "";

  double totalFees = 0.0;
  String authToken="";

  double _setValue(double value) {
    return value * per + value;
  }

  double _setValueFont(double value) {
    return value * perfont + value;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getSharedPrefData();
    _listenServiceListResponse();



  }

  Future<void> getSharedPrefData() async {
    print('getSharedPrefData');
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    setState(() {
      authToken = shdPre.getString(SharedPrefKeys.token).toString();
      print('userFamilyId'+authToken.toString());

    });
  }

  _listenServiceListResponse() {

  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(

              children: [
                appBarCustomUi(size),
                jobCompletedText(size),
                estimatedAndTimeTakenUi(size),
                selectedRepairDetailsUi(size),

                RequestButton( size,context)
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
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        Text(
          'Congratulations!! minnu',
          textAlign: TextAlign.center,
          style: Styles.appBarTextBlack,
        ),
        Spacer(),

      ],
    );
  }

  Widget jobCompletedText(Size size) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10,10,10,10),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                height: 140,
                width: 160,
                child: SvgPicture.asset(
                  'assets/image/MechanicType/mechanic_work_completed.svg',
                  fit: BoxFit.contain,
                )
            ),
            Text(
              "Job Completed",
              style: Styles.textSuccessfulTitleStyle03,
            ),
          ],
        ),
      ),
    );
  }


  Widget selectedRepairDetailsUi(Size size) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20,10,20,10),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: CustColors.whiteBlueish,
            borderRadius: BorderRadius.circular(11.0)
        ),
        child:Padding(
          padding: const EdgeInsets.fromLTRB(10,5,10,5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10,10,10,0),
                child: Container(
                  child: Text('Repair Details',
                    maxLines: 2,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.visible,
                    style: Styles.appBarTextBlack,
                  ),
                ),
              ),
              Container(
                child: ListView.builder(
                  itemCount:5,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context,index,) {



                    return GestureDetector(
                      onTap:(){

                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10,10,10,10),
                        child: Container(
                          alignment: Alignment.center,
                          child:Row(
                            children: [
                              Row(
                                children: [
                                  Text('id',
                                    maxLines: 2,
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.visible,
                                    style: Styles.textLabelTitle_10,
                                  ),
                                ],
                              ),
                              Spacer(),
                              Row(
                                children: [
                                  Text('fees',
                                    maxLines: 2,
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.visible,
                                    style: Styles.textLabelTitle_10,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10,10,10,10),
                child: Row(
                  children: [
                    Row(
                      children: [
                        Text('Total price including tax',
                          maxLines: 2,
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.visible,
                          style: Styles.appBarTextBlack17,
                        ),
                      ],
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Text('$totalFees',
                          maxLines: 2,
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.visible,
                          style: Styles.appBarTextBlack17,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget estimatedAndTimeTakenUi(Size size) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20,10,20,10),
      child: Container(
        alignment: Alignment.center,
        child:Padding(
          padding: const EdgeInsets.fromLTRB(10,5,10,5),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  height: 70,
                  decoration: BoxDecoration(
                      color: CustColors.whiteBlueish,
                      borderRadius: BorderRadius.circular(11.0)
                  ),
                   child:  Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text(
                           "Estimated time",
                           style: Styles.textLabelTitleEmergencyServiceName,
                         ),
                         Padding(
                           padding: const EdgeInsets.fromLTRB(0,5,0,0),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.start,
                             crossAxisAlignment: CrossAxisAlignment.center,
                             children: [

                               Container(
                                   height: 25,
                                   width: 25,
                                   child: SvgPicture.asset(
                                     'assets/image/MechanicType/mechanic_work_clock.svg',
                                     fit: BoxFit.contain,
                                   )
                               ),
                               SizedBox(
                                 width: 10,
                               ),
                               Text(
                                 "20:02",
                                 style: Styles.textSuccessfulTitleStyle03,
                               ),
                             ],
                           ),
                         ),
                       ],
                     ),
                   ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 1,
                child: Container(
                  height: 70,
                  decoration: BoxDecoration(
                      color: CustColors.grey_02,
                      borderRadius: BorderRadius.circular(11.0)
                  ),
                  child:  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Time taken",
                          style: Styles.textLabelTitleEmergencyServiceName,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0,5,0,0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [

                              Container(
                                  height: 25,
                                  width: 25,
                                  child: SvgPicture.asset(
                                    'assets/image/MechanicType/mechanic_work_clock.svg',
                                    fit: BoxFit.contain,
                                  )
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "20:02",
                                style: Styles.textSuccessfulTitleStyle03,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }


  Widget RequestButton(Size size, BuildContext context) {
    return InkWell(
      onTap: (){

      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          children: [
            Spacer(),
            Container(
              height: 45,
              width:200,
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 8, bottom: 6,left: 20,right: 20),
              //padding: EdgeInsets.only(left: 20, right: 20),
              decoration: BoxDecoration(
                color: CustColors.light_navy,
                border: Border.all(
                  color: CustColors.blue,
                  style: BorderStyle.solid,
                  width: 0.70,
                ),
                borderRadius: BorderRadius.circular(7),
              ),
              child:  Text(
                "Request Payment",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Corbel_Bold',
                    fontSize:
                    ScreenSize().setValueFont(14.5),
                    fontWeight: FontWeight.w800),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _showMechanicAcceptanceDialog(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
                backgroundColor: Colors.white,
                insetPadding: EdgeInsets.only(left: 20, right: 20),

                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                contentPadding: const EdgeInsets.all(20),
                content: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            "Wait few minutes !",
                            style: Styles.waitingTextBlack17,
                          ),
                          Text(
                            "Wait for the response from George Dola!",
                            style: Styles.awayTextBlack,
                          ),
                          Container(
                              height: 150,
                              child: SvgPicture.asset(
                                'assets/image/mechanicProfileView/waitForMechanic.svg',
                                height: 200,
                                fit: BoxFit.cover,
                              )
                          ),
                        ],
                      ),
                    ],
                  ),
                ));
          });
        });


  }
}
