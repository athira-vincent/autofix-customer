import 'dart:async';

import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/home_Bloc/home_customer_bloc.dart';
import 'package:auto_fix/UI/Customer/EmergencyServiceFlow/MechanicWorkProgressScreen/mechanic_work_progress_screen.dart';
import 'package:auto_fix/UI/Customer/RegularServiceFlow/PickAndDropOffFlow/picked_up_vehicle_screen.dart';
import 'package:auto_fix/Widgets/screen_size.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ExtraServiceDiagonsisScreen extends StatefulWidget {

  final bool isEmergency;

  ExtraServiceDiagonsisScreen({required this.isEmergency,});

  @override
  State<StatefulWidget> createState() {
    return _ExtraServiceDiagonsisScreenState();
  }
}

class _ExtraServiceDiagonsisScreenState extends State<ExtraServiceDiagonsisScreen> {


  BuildContext? contextAlert;
  double per = .10;
  double perfont = .10;
  double height = 0;
  String selectedState = "";
  List serviceIds = [];
  double totalFees = 0.0;
  bool isWorkStartedState = false;
  String mechanicName = "";
  final HomeCustomerBloc _addMoreServiceBloc = HomeCustomerBloc();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var _firestoreData ;
  String isWorkStarted = "0";
  String isWorkStartedButtonClick = "0";
  String mechanicDiagonsisState = "0";
  String authToken="";
  String userName="";
  String serviceIdEmergency="";
  String mechanicIdEmergency="";
  String bookingIdEmergency="";
  String totalEstimatedTime = "0";
  String totalEstimatedCost = "0";
  String oldTotalEstimatedTime = "0";
  String oldTotalEstimatedCost = "0";


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPrefData();
  }

  void listenToCloudFirestoreDB(BuildContext context) {
    DocumentReference reference = FirebaseFirestore.instance.collection('ResolMech').doc("$bookingIdEmergency");
        reference.snapshots().listen((querySnapshot) {
          setState(() {
            isWorkStarted = querySnapshot.get("isWorkStarted");
            print('isWorkStarted ++++ $isWorkStarted');
        });
          if(isWorkStarted == "1")
          {
            if(isWorkStartedButtonClick == "1")
            {
               Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MechanicWorkProgressScreen(workStatus: "2",)));
            }
          }
      });
  }

  Future<void> getSharedPrefData() async {
    print('getSharedPrefData');
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    setState(() {
      authToken = shdPre.getString(SharedPrefKeys.token).toString();
      userName = shdPre.getString(SharedPrefKeys.userName).toString();
      serviceIdEmergency = shdPre.getString(SharedPrefKeys.serviceIdEmergency).toString();
      mechanicIdEmergency = shdPre.getString(SharedPrefKeys.mechanicIdEmergency).toString();
      bookingIdEmergency = shdPre.getString(SharedPrefKeys.bookingIdEmergency).toString();
      print('ExtraServiceDiagonsisScreen bookingIdEmergency ++++ ${bookingIdEmergency} ');
      updateToCloudFirestoreMechanicCurrentScreenDB();
      listenToCloudFirestoreDB(context);
      _firestoreData = _firestore.collection("ResolMech").doc('$bookingIdEmergency').snapshots();
    });
    await _firestore.collection("ResolMech").doc('$bookingIdEmergency').snapshots().listen((event) {
      setState(() {
        isWorkStarted = event.get("isWorkStarted");
        totalEstimatedTime = event.get('updatedServiceTime');
        totalEstimatedCost = event.get('updatedServiceCost');
        oldTotalEstimatedTime = event.get('serviceModel')[0]['serviceTime'];
        oldTotalEstimatedCost = event.get('serviceModel')[0]['serviceCost'];
        mechanicName = event.get('mechanicName');
        List allData = event.get('updatedServiceList').toList();
        for(int i = 0; i< allData.length ; i++)
          serviceIds.add('${allData[i]['serviceId']}');
      });
    });
  }

  void updateToCloudFirestoreMechanicCurrentScreenDB() {
    _firestore
        .collection("ResolMech")
        .doc('${bookingIdEmergency}')
        .update({
            "customerFromPage" : "C3",
          })
        .then((value) => print("Location Added"))
        .catchError((error) =>
        print("Failed to add Location: $error"));
  }

  void updateToCloudFirestoreDB(String customerDiagonsisApproval) {
    if(customerDiagonsisApproval == "-1")
      {
        print('customerDiagonsisApproval11 -1');
        _firestore
            .collection("ResolMech")
            .doc('${bookingIdEmergency}')
            .update({
              'customerDiagonsisApproval': "-1",
              'updatedServiceCost': "$oldTotalEstimatedCost",
              'updatedServiceTime': "$oldTotalEstimatedTime",
               'timerCounter': "$oldTotalEstimatedTime",
            })
            .then((value) => print("Uploaded to firestore"))
            .catchError((error) =>
            print("Failed to upload: $error"));
      }
    else
    {
      print('customerDiagonsisApproval22 1');
      _firestore
          .collection("ResolMech")
          .doc('${bookingIdEmergency}')
          .update({
            'customerDiagonsisApproval': "1",
          })
          .then((value) => print("Uploaded to firestore"))
          .catchError((error) =>
          print("Failed to upload: $error"));
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  children: [
                    appBarCustomUi(size),
                    infoText(),
                    bagroundBgText(size),
                    selectedRepairDetailsUi(size),
                    estimatedAndTimeTakenUi(size),
                    RequestButton( size,context)
                  ],
                ),
                isWorkStartedButtonClick == "1"
                  ? mechanicResponseWidget(size)
                  : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget mechanicResponseWidget(Size size) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
        decoration: new BoxDecoration(
            color:Colors.black.withOpacity(0.5)
        ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              height: MediaQuery.of(context).size.width,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    offset: Offset(0, 0),
                    blurRadius: 5,
                    spreadRadius: 3,
                    color: Colors.black26,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          "Wait few minutes !",
                          style: Styles.oopsmechanicNotFoundStyle02,
                        ),
                        Text(
                          "Wait for the response from $mechanicName! to start the work",
                          textAlign: TextAlign.center,
                          style: Styles.smallTitleStyle3,
                        ),
                        Container(
                            height: 200,
                            child: SvgPicture.asset(
                              'assets/image/mechanicProfileView/waitForMechanic.svg',
                              height: 200,
                              fit: BoxFit.cover,
                            )
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget appBarCustomUi(Size size) {
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back, color:  CustColors.light_navy,),
          onPressed: () => Navigator.pop(context),
        ),
        Text(
          'Mechanic added services',
          textAlign: TextAlign.center,
          style: Styles.appBarTextBlue2,
        ),
        Spacer(),

      ],
    );
  }

  Widget infoText() {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: CustColors.pale_grey,
          border: Border.all(
              color: CustColors.grey_03
          ),
          borderRadius: BorderRadius.all(
              Radius.circular(5.0) //         <--- border radius here
          ),
        ), //       <--- BoxDecoration here
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    color: CustColors.light_navy,
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        50,
                      ),
                    ),
                  ),
                  child: SvgPicture.asset(
                    'assets/image/CustomerType/extraServiceInfo.svg',
                    fit: BoxFit.contain,
                  )
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Your mechanic added some additional services after his diagnostic test , it may cause additional cost than you expected.",
                    style: Styles.infoTextLabelTitle,
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget bagroundBgText(Size size) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10,15,10,10),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                height: 180,
                width: double.infinity,
                child: SvgPicture.asset(
                  'assets/image/CustomerType/extraServiceBgImage.svg',
                  fit: BoxFit.contain,
                )
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0,15,0,0),
              child: Text(
                "Total services added after diagnostic test",
                style: Styles.textLabelTitle001,
              ),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0,5,0,5),
                      child: Text(
                        "Total estimated time",
                        style: Styles.textLabelTitle001,
                      ),
                    ),
                    Container(
                      height: 72,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: CustColors.grey_03,
                          borderRadius: BorderRadius.circular(11.0)
                      ),
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          Container(
                              height: 25,
                              width: 25,
                              child: SvgPicture.asset(
                                widget.isEmergency
                                ? 'assets/image/MechanicType/mechanic_work_clock.svg'
                                : 'assets/image/ic_calendar_blue.svg',
                                fit: BoxFit.contain,
                              )
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            widget.isEmergency
                            ? "${totalEstimatedTime} Min"
                            : "12 Jan 2022",
                            style: Styles.textSuccessfulTitleStyle03,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0,5,0,5),
                      child: Text(
                        "Total estimated cost",
                        style: Styles.textLabelTitle001,
                      ),
                    ),
                    Container(
                      height: 72,
                      decoration: BoxDecoration(
                          color: CustColors.grey_03,
                          borderRadius: BorderRadius.circular(11.0)
                      ),
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          Container(
                              height: 25,
                              width: 25,
                              child: SvgPicture.asset(
                                'assets/image/CustomerType/extraServiceMoneyBag.svg',
                                fit: BoxFit.contain,
                              )
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "${totalEstimatedCost}",
                            style: Styles.textSuccessfulTitleStyle03,
                          ),
                        ],
                      ),
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

  Widget selectedRepairDetailsUi(Size size) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20,10,20,10),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: CustColors.pale_grey,
            borderRadius: BorderRadius.circular(11.0)
        ),
        child:Padding(
          padding: const EdgeInsets.fromLTRB(10,5,10,5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Container(
                child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  stream: _firestoreData,
                  builder: (_, snapshot) {


                    if (snapshot.hasError) return Text('Error = ${snapshot.error}');

                    if (snapshot.hasData) {

                      List allData = snapshot.data?.data()!['updatedServiceList'].toList();

                      print('StreamBuilder ++++ ${allData.length} ');
                      print('StreamBuilder ++++ ${allData[0]['serviceCost']} ');




                      return  ListView.builder(
                        itemCount:allData.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context,index,) {



                          return GestureDetector(
                            onTap:(){

                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(2,10,2,10),
                              child: Container(
                                alignment: Alignment.center,
                                child:Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Row(
                                        children: [
                                          Text('${allData[index]['serviceName']}',
                                            maxLines: 1,
                                            textAlign: TextAlign.start,
                                            overflow: TextOverflow.visible,
                                            style: Styles.textLabelTitle_12,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 5,),
                                    Expanded(
                                      flex: 1,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [

                                          Container(
                                              height: 20,
                                              width: 20,
                                              child: SvgPicture.asset(
                                                'assets/image/CustomerType/extraServiceMoneyBag.svg',
                                                fit: BoxFit.contain,
                                              )
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "${allData[index]['serviceCost']}",
                                            style: Styles.textLabelTitle_12,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 5,),
                                    Expanded(
                                      flex: 1,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [

                                          Container(
                                              height: 20,
                                              width: 20,
                                              child: SvgPicture.asset(
                                                'assets/image/MechanicType/mechanic_work_clock.svg',
                                                fit: BoxFit.contain,
                                              )
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "${allData[index]['serviceTime']} Min",
                                            style: Styles.textLabelTitle_12,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
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
            ],
          ),
        ),
      ),
    );
  }

  Widget RequestButton(Size size, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0,left: 20,right: 20),
      child: Row(
        children: [
          InkWell(
            onTap: (){
              setState(() {
                if(widget.isEmergency){
                  if(isWorkStartedButtonClick=="0")
                    {
                      isWorkStartedButtonClick = "1";
                      print('RequestButton ++++ $serviceIds ');
                      updateToCloudFirestoreDB("-1");
                      _addMoreServiceBloc. postCustomerAddMoreServiceUpdate(authToken, bookingIdEmergency, serviceIds,totalEstimatedCost, totalEstimatedTime);
                    }
                }
              });

            },
            child: Container(
              height: 45,
              width:150,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isWorkStartedButtonClick=="0" ? CustColors.light_navy : CustColors.greyText1,
                border: Border.all(
                  color: isWorkStartedButtonClick=="0" ? CustColors.blue : CustColors.greyText1,
                  style: BorderStyle.solid,
                  width: 0.70,
                ),
                borderRadius: BorderRadius.circular(7),
              ),
              child:  Text(
                "Reject and continue",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color:  isWorkStartedButtonClick=="0" ? Colors.white : CustColors.brownish_grey_02,
                    fontFamily: 'Corbel_Bold',
                    fontSize:
                    ScreenSize().setValueFont(14.5),
                    fontWeight: FontWeight.w800),
              ),
            ),
          ),
          Spacer(),
          InkWell(
          onTap: (){


            setState(() {
              if(widget.isEmergency){
                if(isWorkStartedButtonClick=="0")
                {
                  isWorkStartedButtonClick = "1";
                  print('RequestButton ++++ $serviceIds ');
                  updateToCloudFirestoreDB("1");
                  _addMoreServiceBloc. postCustomerAddMoreServiceUpdate(authToken, bookingIdEmergency, serviceIds,totalEstimatedCost, totalEstimatedTime);
                }}
            });

           },
            child: Container(
              height: 45,
              width:150,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isWorkStartedButtonClick=="0" ? CustColors.light_navy : CustColors.greyText1,
                border: Border.all(
                  color: isWorkStartedButtonClick=="0" ? CustColors.blue : CustColors.greyText1,
                  style: BorderStyle.solid,
                  width: 0.70,
                ),
                borderRadius: BorderRadius.circular(7),
              ),
              child:  Text(
                "Accept & continue",
                style: TextStyle(
                    color:  isWorkStartedButtonClick=="0" ? Colors.white : CustColors.brownish_grey_02,
                    fontFamily: 'Corbel_Bold',
                    fontSize:
                    ScreenSize().setValueFont(14.5),
                    fontWeight: FontWeight.w800),
              ),
            ),
          ),
        ],
      ),
    );
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("dispose");
  }

}
