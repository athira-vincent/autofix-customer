import 'dart:async';

import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/home_Bloc/home_customer_bloc.dart';
import 'package:auto_fix/UI/Customer/WorkFlowScreens/WorkFlow/mechanic_work_progress_screen.dart';
import 'package:auto_fix/UI/Customer/WorkFlowScreens/WorkFlow/picked_up_vehicle_screen.dart';
import 'package:auto_fix/UI/Mechanic/WorkFlowScreens/mechanic_start_service_bloc.dart';
import 'package:auto_fix/Widgets/screen_size.dart';
import 'package:auto_fix/firestoreProvider/fireStoreProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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


  Timer? timerObjVar;
  Timer? timerObj;
  String mechanicDiagonsisState = "0";

  String authToken="";
  String userName="";
  String serviceIdEmergency="";
  String mechanicIdEmergency="";
  String bookingIdEmergency="";

  String totalEstimatedTime = "0";
  String totalEstimatedCost = "0";

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

  void listenToCloudFirestoreDB() {
    DocumentReference reference = FirebaseFirestore.instance.collection('ResolMech').doc("$bookingIdEmergency");
        reference.snapshots().listen((querySnapshot) {
          setState(() {
            isWorkStarted = querySnapshot.get("isWorkStarted");
            print('isWorkStarted ++++ $isWorkStarted');
            if(isWorkStarted == "1")
            {
              //Navigator.of(context, rootNavigator: true).pop();

              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MechanicWorkProgressScreen(workStatus: "2",)));

            }
        });
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

      // bookingIdEmergency = '95';

      print('ExtraServiceDiagonsisScreen bookingIdEmergency ++++ ${bookingIdEmergency} ');
      _firestoreData = _firestore.collection("ResolMech").doc('$bookingIdEmergency').snapshots();
    });
    await _firestore.collection("ResolMech").doc('$bookingIdEmergency').snapshots().listen((event) {
      setState(() {
        isWorkStarted = event.get("isWorkStarted");
        totalEstimatedTime = event.get('updatedServiceTime');
        totalEstimatedCost = event.get('updatedServiceCost');
        mechanicName = event.get('mechanicName');

        List allData = event.get('updatedServiceList').toList();
        print('allData StreamBuilder ++++ ${allData.length} ');
        print('allData StreamBuilder ++++ ${allData[0]['serviceCost']} ');

        for(int i = 0; i< allData.length ; i++)
          serviceIds.add('${allData[i]['serviceId']}');

        print('StreamBuilder serviceIds ++++ $serviceIds ');
        print('_firestoreData>>>>>>>>> ' + event.get('serviceName'));
      });
    });
  }



  void updateToCloudFirestoreDB() {

    _firestore
        .collection("ResolMech")
        .doc('${bookingIdEmergency}')
        .update({
            'customerDiagonsisApproval': "1",
            'customerFromPage': 'MechanicWorkProgressScreen(workStatus: "2",)'

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
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(

              children: [
                appBarCustomUi(size),
                infoText(),
                bagroundBgText(size),

                selectedRepairDetailsUi(size),
                estimatedAndTimeTakenUi(size),
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
                                widget.isEmergency ?
                                'assets/image/MechanicType/mechanic_work_clock.svg'
                                :
                                'assets/image/ic_calendar_blue.svg',
                                fit: BoxFit.contain,
                              )
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            widget.isEmergency ?
                            "${totalEstimatedTime} Min"
                            :
                            "12 Jan 2022",
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
                            "\$ ${totalEstimatedCost}",
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
                                    Row(
                                      children: [
                                        Text('${allData[index]['serviceName']}',
                                          maxLines: 1,
                                          textAlign: TextAlign.start,
                                          overflow: TextOverflow.visible,
                                          style: Styles.textLabelTitle_12,
                                        ),
                                      ],
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
                                            "\$ ${allData[index]['serviceCost']}",
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
    return InkWell(
      onTap: (){

        if(widget.isEmergency){

          print('RequestButton ++++ $serviceIds ');

          updateToCloudFirestoreDB();

          _showMechanicAcceptanceDialog( context);



          _addMoreServiceBloc. postCustomerAddMoreServiceUpdate(authToken, bookingIdEmergency, serviceIds,totalEstimatedCost, totalEstimatedTime);


        }else{
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => PickedUpVehicleScreen()));
        }

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
                "Agree & continue",
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
                            "Wait for the response from $mechanicName!",
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
  }
}
