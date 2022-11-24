import 'dart:async';

import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/UI/Mechanic/EmergencyServiceMechanicFlow/CustomerApproved/additional_time_bloc.dart';
import 'package:auto_fix/UI/Mechanic/EmergencyServiceMechanicFlow/MechanicWorkComleted/mechanic_work_completed_screen.dart';
import 'package:auto_fix/UI/Mechanic/EmergencyServiceMechanicFlow/OrderStatusUpdateApi/order_status_update_bloc.dart';
import 'package:auto_fix/Widgets/mechanicWorkTimer.dart';
import 'package:auto_fix/Widgets/mechanicWorkTimer02.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerApprovedScreen extends StatefulWidget {
  final String remaintime, starttime, endtime;

  CustomerApprovedScreen({
    required this.remaintime,
    required this.starttime,
    required this.endtime,
  });

  @override
  State<StatefulWidget> createState() {
    return _CustomerApprovedScreenState();
  }
}

class _CustomerApprovedScreenState extends State<CustomerApprovedScreen>
    with TickerProviderStateMixin {
  bool isStartedWork = false,
      isEnableAddMoreBtn = false,
      isEnableAddMoreBtnFirstTym = false;
  bool _isLoading = false;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final MechanicOrderStatusUpdateBloc _mechanicOrderStatusUpdateBloc =
      MechanicOrderStatusUpdateBloc();
  final MechanicAddMoreTimeBloc _addMoreTimeBloc = MechanicAddMoreTimeBloc();
  late AnimationController _controller;
  double per = .10;
  String authToken = "",
      bookingId = "",
      extendedTime = "0",
      customerName = "",
      mechanicName = "",
      updatedServiceTime = "00.00";
  int levelClock = 0;
  int extendedTimeVal = 00;
  String extendedTimeText = "";
  String listenToFirestoreTime = "0",
      customerDiagonsisApproval = "",
      mechanicDiagonsisState = "",
      mechanicStartedOrNot = "";

  double _setValue(double value) {
    return value * per + value;
  }

  late StateSetter extraTimeStateSetter;
  Timer? timerObj;
  Timer? timerObjVar;
  int timeCounter = 0;
  Timer? totalTimerObj;
  int totalTimeTaken = 0;

  String tdata = "";

  String remaintime = "";

  String totalservicetimereturn = "";

  String currenttime = "";

  bool apivalue = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("widgetstarttime");
    print("widgetendtime");
    print(widget.starttime);
    print(widget.endtime);

    int remtime = int.parse(widget.remaintime);

    levelClock = remtime;
    print("levelclock");
    print(levelClock);
    //storetime(widget.starttime, widget.endtime);
    _controller = AnimationController(
        vsync: this, duration: Duration(seconds: levelClock));
    getSharedPrefData();
  }

  Future<void> getSharedPrefData() async {
    print('getSharedPrefData');
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    setState(() {
      authToken = shdPre.getString(SharedPrefKeys.token).toString();
      bookingId =
          shdPre.getString(SharedPrefKeys.bookingIdEmergency).toString();
      print('CustomerApprovedScreen bookingId >>>> $bookingId');
      updateToCloudFirestoreMechanicCurrentScreenDB();
    });
    await _firestore
        .collection("ResolMech")
        .doc('$bookingId')
        .snapshots()
        .listen((event) {
      setState(() {
        mechanicName = event.get('mechanicName');
        customerName = event.get('customerName');
        updatedServiceTime = event.get('updatedServiceTime');
        customerDiagonsisApproval = event.get('customerDiagonsisApproval');
        mechanicDiagonsisState = event.get('mechanicDiagonsisState');
        if (listenToFirestoreTime == "0") {
          levelClock = int.parse('${updatedServiceTime.split(":").first}');
          int sec = Duration(minutes: int.parse('$levelClock')).inSeconds;
          levelClock = sec;
          _controller = AnimationController(
              vsync: this, duration: Duration(seconds: levelClock));
          listenToFirestoreTime = "1";
          if (mechanicDiagonsisState == "2") {
            setState(() {
              print("updateToCloudFirestoreDB isStartedWork $isStartedWork");
              print("updateToCloudFirestoreDB extendedTime $extendedTime");
              print("levelClock $levelClock");
              updateToCloudFirestoreDB("1", "0", "0", "0");
            });
            _controller.forward();
            _totalTimeCounter();
            _updateTimerListener(int.parse(updatedServiceTime));
            isStartedWork = true;
            _mechanicOrderStatusUpdateBloc.postMechanicOrderStatusUpdateRequest(
                authToken, bookingId, "5");
          }
        }
      });
    });
  }

  void updateToCloudFirestoreDB(String isWorkStarted, String isWorkCompleted,
      String time, String currentUpdatedTime) {
    print("updateToCloudFirestoreDB totalTimeTaken clock2222222222 >>>> " +
        totalTimeTaken.toString());
    if (currentUpdatedTime == "0") {
      _firestore
          .collection("ResolMech")
          .doc('${bookingId}')
          .update({
            'isWorkStarted': "$isWorkStarted",
            'isWorkCompleted': "$isWorkCompleted",
            "extendedTime": "$time",
            "totalTimeTakenByMechanic": "${totalTimeTaken.toString()}",
          })
          .then((value) => print("Location Added"))
          .catchError((error) => print("Failed to add Location: $error"));
    } else {
      _firestore
          .collection("ResolMech")
          .doc('${bookingId}')
          .update({
            'isWorkStarted': "$isWorkStarted",
            'isWorkCompleted': "$isWorkCompleted",
            "extendedTime": "$time",
            "timerCounter": "$currentUpdatedTime",
            "totalTimeTakenByMechanic": "${totalTimeTaken.toString()}",
          })
          .then((value) => print("Location Added"))
          .catchError((error) => print("Failed to add Location: $error"));
    }
  }

  void updateToCloudFirestoreMechanicCurrentScreenDB() {
    _firestore
        .collection("ResolMech")
        .doc('${bookingId}')
        .update({
          "mechanicFromPage": "M3",
        })
        .then((value) => print("Location Added"))
        .catchError((error) => print("Failed to add Location: $error"));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                  isEnableAddMoreBtnFirstTym
                      ? Container()
                      : isEnableAddMoreBtn
                          ? mechanicAddMoreTimeButton(size)
                          : Container(),
                  mechanicStartServiceButton(size),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget customerApprovedScreenTitle(Size size) {
    return Container(
      margin: EdgeInsets.only(
        left: size.width * 6 / 100,
        // bottom: size.height * 1 /100,
        top: size.height * 3.4 / 100,
      ),
      child: Text(
        "Customer approved ! ",
        style: TextStyle(
          fontSize: 16,
          fontFamily: "Samsung_SharpSans_Medium",
          fontWeight: FontWeight.w400,
          color: CustColors.light_navy,
        ),
      ),
    );
  }

  Widget customerApprovedScreenSubTitle(Size size) {
    return Container(
      margin: EdgeInsets.only(
        left: size.width * 6 / 100,
        // bottom: size.height * 1 /100,
        top: size.height * 4 / 100,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Hi... ",
                style: TextStyle(),
              ),
              Text(
                mechanicName,
                // "George Dola",
                style: TextStyle(color: CustColors.light_navy),
              )
            ],
          ),
          Row(
            children: [
              /*Text("Customer ", style: TextStyle(

              ),),
              Text(
                customerName,
                //"John Eric ",
                style: TextStyle(
                color: CustColors.light_navy
              ),),
              Text(
                customerDiagonsisApproval == "-1" ?
                " rejected the services you added." :
                " approved the services you added.",style: TextStyle(

              ),),*/

              Text(
                "Continue with the approved services",
                style: TextStyle(),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget customerApprovedScreenTitleImage(Size size) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(
          //left: size.width * 20 /100,
          // right: size.width * 20 / 100,
          // bottom: size.height * 1 /100,
          top: size.height * 3.3 / 100,
        ),
        child: SvgPicture.asset(
          'assets/image/img_customer_approved.svg',
          width: size.width * 60 / 100,
          height: size.height * 30 / 100,
        ),
      ),
    );
  }

  Widget customerApprovedScreenStartWorkText(Size size) {
    return Container(
      decoration: Styles.boxDecorationStyle,
      padding: EdgeInsets.only(
          top: size.width * 3 / 100, bottom: size.width * 3 / 100),
      margin: EdgeInsets.only(
          left: size.width * 6 / 100,
          right: size.width * 6 / 100,
          top: size.height * 3.3 / 100),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(
                top: size.width * 3 / 100, bottom: size.width * 3 / 100),
            margin: EdgeInsets.only(
                left: size.width * 5 / 100, right: size.width * 2 / 100),
            child: SvgPicture.asset(
              "assets/image/ic_info_blue_white.svg",
              height: size.height * 3 / 100,
              width: size.width * 3 / 100,
            ),
          ),
          Expanded(
            child: Text(
              "Go ahead with requested service.",
              style: warningTextStyle01,
            ),
            /*Text(
              customerDiagonsisApproval == "-1"
              ? "Customer disagree with the diagnostic test report and estimated cost. Go ahead with requested service."
              : mechanicDiagonsisState == "2"
                  ? "Go ahead with requested service."
                  : "Customer agree with the diagnostic test report and estimated cost . So you can start repair ",
              style: warningTextStyle01
            ),*/
          )
        ],
      ),
    );
  }

  Widget customerApprovedScreenWarningText(Size size) {
    return Container(
      decoration: Styles.boxDecorationStyle,
      padding: EdgeInsets.only(
          top: size.width * 3 / 100, bottom: size.width * 3 / 100),
      margin: EdgeInsets.only(
          left: size.width * 6 / 100,
          right: size.width * 6 / 100,
          top: size.height * 2.2 / 100),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(
                top: size.width * 3 / 100, bottom: size.width * 3 / 100),
            margin: EdgeInsets.only(
                left: size.width * 5 / 100, right: size.width * 2 / 100),
            child: SvgPicture.asset(
              "assets/image/ic_info_blue_white.svg",
              height: size.height * 3 / 100,
              width: size.width * 3 / 100,
            ),
          ),
          Expanded(
            child: Text(
              isStartedWork
                  ? "Note: If you click the ‘Work Finished’ button, it will stop the timer countdown & end work."
                  : "Note:  If you click the ‘Start repair’ button, it will enables the timer countdown feature also.",
              style: warningTextStyle01,
            ),
          )
        ],
      ),
    );
  }

  Widget customerApprovedScreenTimer(Size size) {
    return Container(
      margin: EdgeInsets.only(top: size.height * 6 / 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/image/ic_alarm.svg',
                  width: size.width * 4 / 100,
                  height: size.height * 4 / 100,
                ),
                SizedBox(
                  width: 10,
                ),
                CountdownMechanicTimer(
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
                border: Border.all(color: CustColors.light_navy02, width: 0.3)),
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
    );
  }

  Widget mechanicStartServiceButton(Size size) {
    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: () async {
          if (isStartedWork == false) {
            setState(() {
              print("updateToCloudFirestoreDB isStartedWork $isStartedWork");
              //isStartedWork = !isStartedWork;
              print("updateToCloudFirestoreDB extendedTime $extendedTime");
              print("levelClock $levelClock");
              updateToCloudFirestoreDB("1", "0", "0", "0");
            });
            _controller.forward();
            _totalTimeCounter();
            _updateTimerListener(int.parse(updatedServiceTime));
            isStartedWork = true;
            _mechanicOrderStatusUpdateBloc.postMechanicOrderStatusUpdateRequest(
                authToken, bookingId, "5");
            storetime(widget.starttime, widget.endtime);

          } else {
            SharedPreferences sharedPreferences =
                await SharedPreferences.getInstance();
            sharedPreferences.remove("starttime");
            sharedPreferences.remove("endtime");
            setState(() {
              print("updateToCloudFirestoreDB extendedTime $extendedTime");
              print("timerCountr11111111111 ${timeCounter}");

              updateToCloudFirestoreDB("1", "1", extendedTime, "0");
              _mechanicOrderStatusUpdateBloc
                  .postMechanicOrderStatusUpdateRequest(
                      authToken, bookingId, "6");

              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MechanicWorkCompletedScreen()));
            });
          }
        },
        child: Container(
          margin: EdgeInsets.only(
              right: size.width * 6.2 / 100, top: size.height * 3.7 / 100),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(6),
              ),
              color: CustColors.light_navy),
          padding: EdgeInsets.only(
            left: size.width * 5.8 / 100,
            right: size.width * 5.8 / 100,
            top: size.height * 1 / 100,
            bottom: size.height * 1 / 100,
          ),
          child: Text(
            //widget.serviceModel == "1" ? "Back to home" :
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

  void _updateTimerListener(int count) {
    print('_updateTimerListener >>>>>000 ${count}');
    timeCounter = count;
    timerObj = Timer.periodic(Duration(minutes: 1), (Timer t) {
      timerObjVar = t;
      print('Timer timerObj ++++++' + timerObjVar.toString());
      if (timeCounter == 0) {
        timeCounter = 0;
      } else {
        timeCounter = timeCounter - 1;
      }
      print("timeCounter >>>>>> " + timeCounter.toString());
      if (timeCounter < 6) {
        setState(() {
          isEnableAddMoreBtn = true;
        });
      }
    });
  }

  void _totalTimeCounter() {
    totalTimerObj = Timer.periodic(Duration(minutes: 1), (Timer t) {
      totalTimeTaken = totalTimeTaken + 1;
      print('Timer totalTimerObj ++++++' + totalTimerObj.toString());
      print("totalTimeTaken >>>>>> " + totalTimeTaken.toString());
    });
  }

  Widget mechanicAddMoreTimeButton(Size size) {
    return Align(
      alignment: Alignment.centerLeft,
      child: InkWell(
        onTap: () {
          setState(() {
            isEnableAddMoreBtnFirstTym = true;
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    contentPadding: EdgeInsets.all(0.0),
                    content: StatefulBuilder(builder: (BuildContext context,
                        StateSetter extraTimeStateSetter1) {
                      extraTimeStateSetter = extraTimeStateSetter1;
                      return setupAlertDialogAddExtraTime(size);
                    }),
                  );
                });
          });
        },
        child: Container(
          margin: EdgeInsets.only(
              left: size.width * 6.2 / 100, top: size.height * 3.7 / 100),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(6),
              ),
              color: CustColors.light_navy),
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

  Widget setupAlertDialogAddExtraTime(Size size) {
    return Container(
      height: 300.0, // Change as per your requirement
      child: Column(
        children: [
          Container(
              width: double.infinity,
              height: 50,
              color: CustColors.light_navy,
              alignment: Alignment.center,
              child: Text(
                "Add Extra time",
                style: Styles.textButtonLabelSubTitle,
              )),
          Container(
            padding: EdgeInsets.only(
                top: size.height * 2.5 / 100,
                bottom: size.height * 2 / 100,
                left: size.width * 4 / 100,
                right: size.width * 4 / 100),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.only(
                      top: size.height * 1.5 / 100,
                      bottom: size.height * 1.5 / 100,
                      left: size.width * 2 / 100,
                      right: size.width * 2 / 100),
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
                      Text(
                        "Extend time",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontFamily: "Samsung_SharpSans_Medium",
                            fontWeight: FontWeight.w600,
                            letterSpacing: .6,
                            height: 1.7),
                      ),
                      Row(
                        children: [
                          Text(
                            extendedTimeVal.toString() + " : 00",
                            style: TextStyle(
                                fontSize: 22,
                                color: Colors.black,
                                fontFamily: "SharpSans_Bold",
                                fontWeight: FontWeight.w600,
                                letterSpacing: .6,
                                height: 1.7),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 8),
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    extraTimeStateSetter(() {
                                      if (extendedTimeVal < 30) {
                                        extendedTimeVal = extendedTimeVal + 1;
                                      }
                                    });
                                  },
                                  child: Container(
                                    child: Icon(
                                      Icons.keyboard_arrow_up,
                                    ),
                                    //color: Colors.purple,
                                    //child: Text("aaaaaaaa"),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    extraTimeStateSetter(() {
                                      if (extendedTimeVal > 00) {
                                        extendedTimeVal = extendedTimeVal - 1;
                                      }
                                    });
                                  },
                                  child: Container(
                                    //color: Colors.tealAccent,
                                    child: Icon(
                                      Icons.keyboard_arrow_down,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
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
                top: size.height * 1.5 / 100),
            child: _isLoading
                ? Center(
                    child: Container(
                      height: _setValue(28),
                      width: _setValue(28),
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(CustColors.peaGreen),
                      ),
                    ),
                  )
                : MaterialButton(
                    onPressed: () async {
                      int newTime;
                      int newTimeSec;
                      setState(() {
                        _controller.stop();
                        print("level extendedTimeVal clock1 >>>> " +
                            extendedTimeVal.toString());
                        print("level extendedTime clock1 >>>> " +
                            extendedTime.toString());
                        print("level levelClock clock1 >>>> " +
                            levelClock.toString());
                        print("level timeCounter clock1 >>>> " +
                            timeCounter.toString());
                        newTime = int.parse('$extendedTime') +
                            int.parse('${extendedTimeVal.toString()}');
                        extendedTime = newTime.toString();
                        newTimeSec = Duration(
                                minutes: int.parse('$extendedTimeVal') +
                                    int.parse('$timeCounter'))
                            .inSeconds;
                        levelClock = newTimeSec;
                        _controller = AnimationController(
                            vsync: this,
                            duration: Duration(
                                seconds:
                                    newTimeSec) // gameData.levelClock is a user entered number elsewhere in the applciation
                            );
                        print("level extendedTimeVal clock2 >>>> " +
                            extendedTimeVal.toString());
                        print("level extendedTime clock2 >>>> " +
                            extendedTime.toString());
                        print("level newTimeSec clock2 >>>> " +
                            newTimeSec.toString());
                        print("level levelClock clock2 >>>> " +
                            levelClock.toString());
                        print("level timeCounter clock2 >>>> " +
                            timeCounter.toString());
                        print("clock2 _controller ${_controller.status}");
                        print(
                            "clock2 _controller.duration!.inMinutes ${_controller.duration!.inMinutes}");
                        isEnableAddMoreBtn = false;
                        _controller.forward();
                        _updateTimerListener(int.parse(
                            (int.parse(levelClock.toString()) / 60)
                                .toInt()
                                .toString()));
                        updateToCloudFirestoreDB(
                            "1",
                            "0",
                            extendedTimeVal.toString(),
                            "${_controller.duration!.inMinutes}");
                        _addMoreTimeBloc.postMechanicSetAddTimeRequest(
                            authToken,
                            extendedTimeVal.toString() + ":00",
                            bookingId);
                      });
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(
                          left: size.width * 2.5 / 100,
                          right: size.width * 2.5 / 100,
                          top: size.height * 1 / 100,
                          bottom: size.height * 1 / 100),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(6),
                          ),
                          color: CustColors.light_navy),
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

  Widget InfoTextWidget(Size size) {
    return Container(
      decoration: Styles.boxDecorationStyle,
      margin: EdgeInsets.only(
          left: size.width * 4 / 100,
          right: size.width * 4 / 100,
          top: size.height * 1 / 100,
          bottom: size.height * .7 / 100),
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
            child: SvgPicture.asset(
              "assets/image/ic_info_blue_white.svg",
              height: size.height * 2.5 / 100,
              width: size.width * 2.5 / 100,
            ),
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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _mechanicOrderStatusUpdateBloc.dispose();
    _addMoreTimeBloc.dispose();
    cancelTimer();
    print("dispose");
  }

  cancelTimer() {
    if (timerObjVar != null) {
      timerObjVar?.cancel();
      timerObjVar = null;
    }

    if (timerObj != null) {
      timerObj?.cancel();
      timerObj = null;
    }

    if (totalTimerObj != null) {
      totalTimerObj?.cancel();
      totalTimerObj = null;
    }
  }

  void storetime(String starttime, String endtime) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("starttime", starttime);

    preferences.setString("endtime", endtime);
  }
}
