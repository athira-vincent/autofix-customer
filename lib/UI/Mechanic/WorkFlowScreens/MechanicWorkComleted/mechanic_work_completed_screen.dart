import 'dart:async';

import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/UI/Common/direct_payment_screen.dart';
import 'package:auto_fix/UI/Mechanic/BottomBar/Home/mechanic_home_bloc.dart';
import 'package:auto_fix/UI/Mechanic/WorkFlowScreens/OrderStatusUpdateApi/order_status_update_bloc.dart';
import 'package:auto_fix/Widgets/screen_size.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../Constants/cust_colors.dart';
import '../../../../../Constants/styles.dart';
import '../../../../../Widgets/CurvePainter.dart';

class MechanicWorkCompletedScreen extends StatefulWidget {


  MechanicWorkCompletedScreen();

  @override
  State<StatefulWidget> createState() {
    return _MechanicWorkCompletedScreenState();
  }
}

class _MechanicWorkCompletedScreenState extends State<MechanicWorkCompletedScreen> {

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final MechanicOrderStatusUpdateBloc _mechanicOrderStatusUpdateBloc = MechanicOrderStatusUpdateBloc();
  HomeMechanicBloc _mechanicHomeBloc = HomeMechanicBloc();
  var _firestoreData ;

  double per = .10;
  double perfont = .10;
  double height = 0;
  String selectedState = "";

  double totalFees = 0.0;
  String authToken="", userId = "", bookingId = "", paymentStatus = "", text = "Request payment", customerDiagonsisApproval = "";
  String totalEstimatedTime = "", totalExtendedTime = "", mechanicName = "", totalEstimatedCost = "";

  double _setValue(double value) {
    return value * per + value;
  }

  double _setValueFont(double value) {
    return value * perfont + value;
  }
  Timer? timerObjVar;
  Timer? timerObj;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getSharedPrefData();
    _listenServiceListResponse();
    timerObj = Timer.periodic(Duration(seconds: 5), (Timer t) {
      timerObjVar = t;
      print('Timer listenToCloudFirestoreDB ++++++');
      listenToCloudFirestoreDB();
    });

  }

  Future<void> getSharedPrefData() async {
    print('getSharedPrefData');
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    setState(() {
      userId = shdPre.getString(SharedPrefKeys.userID).toString();
      authToken = shdPre.getString(SharedPrefKeys.token).toString();
      print('userFamilyId ' + authToken.toString());
      bookingId = shdPre.getString(SharedPrefKeys.bookingIdEmergency).toString();
      //bookingId = "100";

      _firestoreData = _firestore.collection("ResolMech").doc('$bookingId').snapshots();
      _firestore.collection("ResolMech").doc('$bookingId').snapshots().listen((event) {

        customerDiagonsisApproval = event.get("customerDiagonsisApproval");
        mechanicName = event.get('mechanicName');
        totalEstimatedCost = event.get("updatedServiceCost");
        totalEstimatedTime = event.get('updatedServiceTime');
        //totalExtendedTime = event.get('extendedTime');
        String extendedTime = event.get('extendedTime');
        int time = int.parse(totalEstimatedTime) + int.parse(extendedTime);
        totalExtendedTime = time.toString();
        print('_firestoreData>>>>>>>>> ' + event.get('serviceName'));

        print('_firestoreData>>>>>>>>> ' + totalEstimatedCost);
        setState(() {

        });
      });
    });
  }

  void listenToCloudFirestoreDB() {
    DocumentReference reference = FirebaseFirestore.instance.collection('ResolMech').doc("${bookingId}");
    reference.snapshots().listen((querySnapshot) {
      setState(() {
        paymentStatus = querySnapshot.get("paymentStatus");
        print('paymentStatus ++++ $paymentStatus');
        if(paymentStatus =="1")
        {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>  DirectPaymentScreen(isMechanicApp: true, isPaymentFailed: true,)
              )).then((value){

          });
        }
      });
    });
  }

  void updateToCloudFirestoreDB( ) {
    _firestore
        .collection("ResolMech")
        .doc('${bookingId}')
        .update({
      'isPaymentRequested': "1",
      "customerFromPage" : "MechanicWorkProgressScreen(workStatus: '3',)",
      "mechanicFromPage" : "DirectPaymentScreen",
      //===================== code for send the list of additional services =========
    })
        .then((value) => print("Location Added"))
        .catchError((error) =>
        print("Failed to add Location: $error"));
  }

  _listenServiceListResponse() {

  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
        /*IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),*/
        Container(
          margin: EdgeInsets.only(
            left: size.width * 6 / 100,
            top: size.height * 3 / 100,
            bottom: size.height * 1 / 100
          ),
          child: Text(
            'Congratulations!! ',
            textAlign: TextAlign.center,
            style: Styles.appBarTextBlue2,
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              //left: size.width * 6 / 100,
              top: size.height * 3 / 100,
              bottom: size.height * 1 / 100
          ),
          child: Text(
            ' ${mechanicName}',
            textAlign: TextAlign.center,
            style: Styles.appBarTextBlack,
          ),
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

  Widget estimatedAndTimeTakenUi(Size size) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20,10,20,10),
      child: Container(
        alignment: Alignment.center,
        child:Padding(
          padding: const EdgeInsets.fromLTRB(0,5,0,5),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  height: 72,
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
                                "$totalEstimatedTime" + " : 00",
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
                  height: 72,
                  decoration: BoxDecoration(
                      color: CustColors.cloudy_blue,
                      borderRadius: BorderRadius.circular(11.0)
                  ),
                  child:  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          //"Estimated Cost",
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
                                "$totalExtendedTime" + ": 00",
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
                child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  stream: _firestoreData,
                  builder: (_, snapshot) {


                    if (snapshot.hasError) return Text('Error = ${snapshot.error}');

                    if (snapshot.hasData) {
                      List allData = [];
                      if(customerDiagonsisApproval == "1"){
                        allData = snapshot.data?.data()!['updatedServiceList'].toList();
                        //allData.add(snapshot.data?.data()!['updatedServiceList'].toList()) ;
                      }else if(customerDiagonsisApproval == "-1"){
                        allData = snapshot.data?.data()!['serviceModel'].toList();
                        //allData.add(snapshot.data?.data()!['serviceModel'].toList()) ;
                      }

                      print('StreamBuilder ++++ ${allData.length} ');
                      print('StreamBuilder ++++ ${allData[0]['serviceCost'].toString()} ');


                      return  ListView.builder(
                        itemCount: allData.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context,index,) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(10,10,10,10),
                            child: Container(
                              alignment: Alignment.center,
                              child:Row(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        '${allData[index]['serviceName']}',
                                        maxLines: 2,
                                        textAlign: TextAlign.start,
                                        overflow: TextOverflow.visible,
                                        style: Styles.textLabelTitle_12,
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Row(
                                    children: [
                                      Text(
                                        '₦ ${allData[index]['serviceCost']}',
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
                          );
                        },
                      );
                    }

                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(10,10,10,10),
                child: Row(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Total price',
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
                        Text(
                          '₦ $totalEstimatedCost',
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

  Widget listItem(Size size, data){
    return Padding(
      padding: const EdgeInsets.fromLTRB(10,10,10,10),
      child: Container(
        alignment: Alignment.center,
        child:Row(
          children: [
            Row(
              children: [
                Text(
                  '${data['serviceName'].toString()}',
                  maxLines: 2,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.visible,
                  style: Styles.textLabelTitle_12,
                ),
              ],
            ),
            Spacer(),
            Row(
              children: [
                Text(
                  '${data['serviceCost'].toString()}',
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
    );
  }

  Widget RequestButton(Size size, BuildContext context) {
    return InkWell(
      onTap: (){
        updateToCloudFirestoreDB();
        setState(() {
          text = "Waiting response";
        });
        _mechanicOrderStatusUpdateBloc.postMechanicOrderStatusUpdateRequest(
            authToken, bookingId, "7");
        _mechanicHomeBloc.postMechanicOnlineOfflineRequest("$authToken", "3", userId, );
        /*Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => DirectPaymentScreen(isMechanicApp: true,isPaymentFailed: true,)));*/
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
                text,
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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("dispose");
    _mechanicOrderStatusUpdateBloc.dispose();
    cancelTimer();
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
  }
}
