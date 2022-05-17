import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/UI/Customer/MainLandingPageCustomer/customer_main_landing_screen.dart';
import 'package:auto_fix/UI/Mechanic/WorkFlowScreens/MechanicWorkComleted/mechanic_work_completed_screen.dart';
import 'package:auto_fix/Widgets/count_down_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerApprovedScreen extends StatefulWidget {

  final String serviceModel;

  CustomerApprovedScreen({required this.serviceModel});

  @override
  State<StatefulWidget> createState() {
    return _CustomerApprovedScreenState();
  }
}

class _CustomerApprovedScreenState extends State<CustomerApprovedScreen> with TickerProviderStateMixin{

  bool isStartedWork = false;
  bool _isLoading = false;

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late AnimationController _controller;
  int levelClock = 10;
  double per = .10;
  String authToken = "", bookingId = "", extendedTime = "0";

  double _setValue(double value) {
    return value * per + value;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPrefData();
    _controller = AnimationController(
        vsync: this,
        duration: Duration(
            seconds: levelClock) // gameData.levelClock is a user entered number elsewhere in the applciation
    );

  }


  Future<void> getSharedPrefData() async {
    print('getSharedPrefData');
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    setState(() {
      authToken = shdPre.getString(SharedPrefKeys.token).toString();
      bookingId = shdPre.getString(SharedPrefKeys.bookingIdEmergency).toString();
    });
  }


  void updateToCloudFirestoreDB(String isWorkStarted, String isWorkCompleted, String extendedTime ) {
    _firestore
        .collection("ResolMech")
        .doc('${bookingId}')
        .update({
        'isWorkStarted': "$isWorkStarted",
        'isWorkCompleted': "$isWorkCompleted",
        "extendedTime": "$extendedTime",
      //===================== code for send the list of additional services =========
    })
        .then((value) => print("Location Added"))
        .catchError((error) =>
        print("Failed to add Location: $error"));

  }


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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customerApprovedScreenTitle(size),

                  customerApprovedScreenSubTitle(size),

                  customerApprovedScreenTitleImage(size),

                  customerApprovedScreenStartWorkText(size),

                  customerApprovedScreenWarningText(size),

                  customerApprovedScreenTimer(size),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      isStartedWork ? mechanicAddMoreTimeButton(size) : Container(),
                      mechanicStartServiceButton(size),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  Widget customerApprovedScreenTitle(Size size){
    return Container(
      margin: EdgeInsets.only(
        left: size.width * 6 /100,
        // bottom: size.height * 1 /100,
        top: size.height * 3.4 / 100,
      ),
      child: Text("Customer approved ! ",style: TextStyle(
        fontSize: 16,
        fontFamily: "Samsung_SharpSans_Medium",
        fontWeight: FontWeight.w400,
        color: CustColors.light_navy,
      ),),
    );
  }

  Widget customerApprovedScreenSubTitle(Size size){
    return Container(
      margin: EdgeInsets.only(
        left: size.width * 6 /100,
        // bottom: size.height * 1 /100,
        top: size.height * 8.5 / 100,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text("Hi...", style: TextStyle(

              ),),
              Text("George Dola", style: TextStyle(
                color: CustColors.light_navy
              ),)
            ],
          ),
          Row(
            children: [
              Text("Customer ", style: TextStyle(

              ),),
              Text("John Eric ", style: TextStyle(
                  color: CustColors.light_navy
              ),),
              Text("approved the services you added.",style: TextStyle(

              ),)
            ],
          )
        ],
      ),
    );
  }

  Widget customerApprovedScreenTitleImage(Size size){
    return Center(
      child: Container(
        margin: EdgeInsets.only(
          //left: size.width * 20 /100,
         // right: size.width * 20 / 100,
          // bottom: size.height * 1 /100,
          top: size.height * 3.3 / 100,
        ),
        child: SvgPicture.asset('assets/image/img_customer_approved.svg',
          width: size.width * 60 / 100,
          height: size.height * 30 / 100,),
      ),
    );
  }

  Widget customerApprovedScreenStartWorkText(Size size){
    return Container(
      decoration: Styles.boxDecorationStyle,
      margin: EdgeInsets.only(
          left: size.width * 6 / 100,
          right: size.width * 6 / 100,
          top: size.height * 3.3 / 100
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(
                top: size.width * 3 / 100,
                bottom: size.width * 3 / 100
            ),
            margin: EdgeInsets.only(
                left: size.width * 5 / 100,
                right: size.width * 2 / 100
            ),
            child: SvgPicture.asset("assets/image/ic_info_blue_white.svg",
              height: size.height * 3 / 100,width: size.width * 3 / 100,),
          ),
          Text("Customer agree with the diagnostic test report \nand estimated cost . So you can start repair ",
            style: warningTextStyle01,

          )
        ],
      ),
    );
  }

  Widget customerApprovedScreenWarningText(Size size){
    return Container(
      decoration: Styles.boxDecorationStyle,
      margin: EdgeInsets.only(
          left: size.width * 6 / 100,
          right: size.width * 6 / 100,
          top: size.height * 2.2 / 100
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(
                top: size.width * 3 / 100,
                bottom: size.width * 3 / 100
            ),
            margin: EdgeInsets.only(
                left: size.width * 5 / 100,
                right: size.width * 2 / 100
            ),
            child: SvgPicture.asset("assets/image/ic_info_blue_white.svg",
              height: size.height * 3 / 100,width: size.width * 3 / 100,),
          ),
          Text("Note:  If you click the ‘Start repair’ button, it will \nenables the timer countdown feature also.",
            style: warningTextStyle01,
          )
        ],
      ),
    );
  }

  Widget customerApprovedScreenTimer(Size size){
    return Container(
      margin: EdgeInsets.only(
          left: size.width * 27.5 / 100,
          right: size.width * 27.5 / 100,
          top: size.height * 4.3 / 100
      ),
      child: Flexible(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                left: size.width * 4.5 / 100,
                right: size.width * 4.5 / 100,
                top: size.height * 1 / 100,
                bottom: size.height * 1 / 100,
              ),
              child: Row(
                children: [
                  SvgPicture.asset('assets/image/ic_alarm.svg',
                    width: size.width * 4 / 100,
                    height: size.height * 4 / 100,),
                  Spacer(),
                  /*Text("25:00 ",
                    style: TextStyle(
                        fontSize: 36,
                        fontFamily: "SharpSans_Bold",
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        letterSpacing: .7
                    ),
                  ),*/
                  CountDownWidget(
                    animation: StepTween(
                      begin: levelClock, // THIS IS A USER ENTERED NUMBER
                      end: 0,
                    ).animate(_controller),

                  ),
                ],
              ),
            ),

            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(13),
                  ),
                  border: Border.all(
                      color: CustColors.light_navy02,
                      width: 0.3
                  )
              ),
                            /*margin: EdgeInsets.only(
                                left: size.width * 4 / 100,
                                right: size.width * 4 / 100,
                                top: size.height * 2.8 / 100
                            ),*/
              padding: EdgeInsets.only(
                left: size.width * 4 / 100,
                right: size.width * 4 / 100,
                top: size.height * 1 / 100,
                bottom: size.height * 1 / 100,
              ),
              child: Text("Total estimated time "),
            )
          ],
        ),
      ),
    );
  }

  Widget mechanicStartServiceButton(Size size){
    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: (){

          setState(() {
            if(isStartedWork == false){
              print("updateToCloudFirestoreDB");
              isStartedWork = !isStartedWork;
              updateToCloudFirestoreDB("1", "0", extendedTime);
              _controller.forward();
            }else{
              updateToCloudFirestoreDB("1","1", extendedTime);
              print("Else is working");
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MechanicWorkCompletedScreen()));

            }
          });

          /*if(widget.serviceModel == "1"){
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CustomerMainLandingScreen()));
                      }
                      else if(isStartedWork){
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MechanicWorkCompletedScreen()));
                      }
                      else{
                        setState(() {
                          isStartedWork = !isStartedWork;
                        });
                      }*/

        },
        child: Container(
          margin: EdgeInsets.only(
              right: size.width * 6.2 / 100,
              top: size.height * 3.7 / 100
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(6),
              ),
              color: CustColors.light_navy
          ),
          padding: EdgeInsets.only(
            left: size.width * 5.8 / 100,
            right: size.width * 5.8 / 100,
            top: size.height * 1 / 100,
            bottom: size.height * 1 / 100,
          ),
          child: Text(
            widget.serviceModel == "1" ? "Back to home" :
            isStartedWork ? "Work Finished" : "Start repair",
            style: TextStyle(
              fontSize: 14.3,
              fontWeight: FontWeight.w600,
              fontFamily: "Samsung_SharpSans_Medium",
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget mechanicAddMoreTimeButton(Size size){
    return Align(
      alignment: Alignment.centerLeft,
      child: InkWell(
        onTap: (){
          setState(() {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    contentPadding: EdgeInsets.all(0.0),
                    content: StatefulBuilder(
                        builder: (BuildContext context, StateSetter monthYear) {
                          return  setupAlertDialogAddExtraTime(size);
                        }
                    ),
                  );
                });
          });

        },
        child: Container(
          margin: EdgeInsets.only(
              left: size.width * 6.2 / 100,
              top: size.height * 3.7 / 100
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(6),
              ),
              color: CustColors.light_navy
          ),
          padding: EdgeInsets.only(
            left: size.width * 5.8 / 100,
            right: size.width * 5.8 / 100,
            top: size.height * 1 / 100,
            bottom: size.height * 1 / 100,
          ),
          child: Text(
            "Add Time",
            style: TextStyle(
              fontSize: 14.3,
              fontWeight: FontWeight.w600,
              fontFamily: "Samsung_SharpSans_Medium",
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget setupAlertDialogAddExtraTime(Size size ) {
    return Container(
      height: 280.0, // Change as per your requirement
      child: Column(
        children: [
          Container(
              width: double.infinity,
              height: 50,
              color: CustColors.light_navy,
              alignment: Alignment.center,
              child: Text("Add Extra time",
                style: Styles.textButtonLabelSubTitle,)
          ),

          Container(
            padding: EdgeInsets.only(
                top: size.height * 2.5 / 100,
                bottom: size.height * 2.5 / 100,
                left: size.width * 4 / 100,
                right: size.width * 4 / 100
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.only(
                      top: size.height * 1.5 / 100,
                      bottom: size.height * 1.5 / 100,
                      left: size.width * 2 / 100,
                      right: size.width * 2 / 100
                  ),
                  decoration: Styles.serviceIconBoxDecorationStyle,
                  child: SvgPicture.asset(
                    "assets/image/MechanicType/mechanic_work_clock.svg",
                    height: size.height * 4 / 100,
                    //width: size.width * 5 / 100,
                  ),
                ),
                SizedBox(
                  width: size.width * 8 / 100,
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Extend time",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontFamily: "Samsung_SharpSans_Medium",
                            fontWeight: FontWeight.w600,
                            letterSpacing: .6,
                            height: 1.7
                        ),
                      ),
                      Text("25:00 ",
                        style: TextStyle(
                            fontSize: 22,
                            color: Colors.black,
                            fontFamily: "SharpSans_Bold",
                            fontWeight: FontWeight.w600,
                            letterSpacing: .6,
                            height: 1.7
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),

          InfoTextWidget(size),

          Container(
            margin: EdgeInsets.only(
              //left: size.width * 4 / 100,
              //right: size.width * 4 / 100,
                top: size.height * 1.5 / 100
            ),
            child: _isLoading
                ? Center(
                  child: Container(
                    height: _setValue(28),
                    width: _setValue(28),
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          CustColors.peaGreen),
                    ),
                  ),
            )
                : MaterialButton(
              onPressed: () {


                setState(() {
                  extendedTime = "10";
                  levelClock = levelClock + 10;
                  print("level clock >>>> " + levelClock.toString());
                });

                Navigator.pop(context);
                /*setState(() {

                      _lastMaintenanceController.text = '$selectedMonthText  $selectedYearText';
                      if (_formKey.currentState!.validate()) {
                      } else {
                      }
                    });*/
                print(">>>>>>>>>> time   ");

                updateToCloudFirestoreDB("1","0", extendedTime);

                /*Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  FindMechanicListScreen(
                          bookingId: '01',
                          serviceIds: serviceIds,
                          serviceType: 'emergency',
                          authToken: authToken,)));*/

              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.only(
                    left: size.width * 2.5 / 100,
                    right: size.width * 2.5 / 100,
                    top: size.height * 1 / 100,
                    bottom: size.height * 1 / 100
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(6),
                    ),
                    color: CustColors.light_navy
                ),
                child: Text(
                  'Add time ',
                  textAlign: TextAlign.center,
                  style: Styles.textButtonLabelSubTitle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget InfoTextWidget(Size size){
    return Container(
      decoration: Styles.boxDecorationStyle,
      margin: EdgeInsets.only(
          left: size.width * 4 / 100,
          right: size.width * 4 / 100,
          top: size.height * 1 / 100,
          bottom: size.height * .7 / 100
      ),
      padding: EdgeInsets.only(
        top: size.height * 1.5 / 100,
        bottom: size.height * 1.5 / 100,
        right: size.width * 2.3 / 100,
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(
              left: size.width * 2 / 100,
              right: size.width * 2.5 / 100,
            ),
            child: SvgPicture.asset("assets/image/ic_info_blue_white.svg",
              height: size.height * 2.5 / 100,width: size.width * 2.5 / 100,),
          ),
          Expanded(
            child: Text(
              "Adding extra time may cause bad reviews from customer",
              textAlign: TextAlign.justify,
              style: warningTextStyle01,
            ),
          )
        ],
      ),
    );
  }

  TextStyle warningTextStyle01 = TextStyle(
      fontSize: 12,
      fontFamily: "Samsung_SharpSans_Regular",
      fontWeight: FontWeight.w600,
      color: Colors.black,
  );

}