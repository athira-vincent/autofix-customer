import 'dart:async';

import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/UI/Common/add_more_service_list_screen.dart';
import 'package:auto_fix/UI/Mechanic/WorkFlowScreens/customer_approved_screen.dart';
import 'package:auto_fix/UI/Mechanic/WorkFlowScreens/mechanic_start_service_bloc.dart';
import 'package:auto_fix/UI/Mechanic/BottomBar/MyProfile/profile_Mechanic_Models/mechanic_profile_mdl.dart';
import 'package:auto_fix/Widgets/mechanicWorkTimer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MechanicStartServiceScreen extends StatefulWidget {


  MechanicStartServiceScreen();

  @override
  State<StatefulWidget> createState() {
    return _MechanicStartServiceScreenState();
  }
}

class _MechanicStartServiceScreenState extends State<MechanicStartServiceScreen> with TickerProviderStateMixin{

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool isExpanded = false;

  String authToken="", bookingId = "";
  String isCustomerApproved = "0";

  String customerDiagonsisApproval = "0";
  Timer? timerObjVar;
  Timer? timerObj;

  List allData = [];
  String selectedServiceName = "", additionalServiceNames = "" ;
  String serviceTotalCostForFirebase = "", serviceTotalTimeForFirebase = "";

  late AnimationController _controller;
  int levelClock = 0;
  int  selectedServiceTime = 0, timeInMinutes = 0;
  Timer? timerForCouterTime;
  Timer? timerCouterTime;

  bool isWaiting = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPrefData();

    timerObj = Timer.periodic(Duration(seconds: 5), (Timer t) {
      timerObjVar = t;
      print('Timer listenToCloudFirestoreDB ++++++');
      listenToCloudFirestoreDB();
    });
    _controller = AnimationController(
        vsync: this,
        duration: Duration(
            seconds:
            levelClock) // gameData.levelClock is a user entered number elsewhere in the applciation
    );
  }

  @override
  void didUpdateWidget(covariant MechanicStartServiceScreen oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    getSharedPrefData();
  }

  Future<void> getSharedPrefData() async {
    print('getSharedPrefData >>> ');
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    setState(() {
      authToken = shdPre.getString(SharedPrefKeys.token).toString();
      bookingId = shdPre.getString(SharedPrefKeys.bookingIdEmergency).toString();
      print('MechanicStartServiceScreen bookingId ++++ ${bookingId} ');

    });
    await _firestore.collection("ResolMech").doc('${bookingId}').snapshots().listen((event) {
    //await _firestore.collection("ResolMech").doc('100').snapshots().listen((event) {
      setState(() {
        allData = event.get('serviceModel').toList();
        selectedServiceName = allData[0]['serviceName'];
        serviceTotalTimeForFirebase = allData[0]['serviceTime'];
        serviceTotalCostForFirebase = allData[0]['serviceCost'];

        selectedServiceTime = Duration(minutes: int.parse('${allData[0]['serviceTime'].split(".").first}')).inSeconds;
        levelClock =  selectedServiceTime + 1;
        _controller = AnimationController(
            vsync: this,
            duration: Duration(
                seconds:
                levelClock) // gameData.levelClock is a user entered number elsewhere in the applciation
        );
      });
      setState(() {

      });
      print('_firestoreData>>>>>>>>> ' + selectedServiceName);
    });
  }

  void listenToCloudFirestoreDB() {
    DocumentReference reference = FirebaseFirestore.instance.collection('ResolMech').doc('${bookingId}');
    reference.snapshots().listen((querySnapshot) {
      setState(() {
        customerDiagonsisApproval = querySnapshot.get("customerDiagonsisApproval");

        print('customerDiagonsisApproval ++++ $customerDiagonsisApproval');
        if(customerDiagonsisApproval =="1")
        {
          isCustomerApproved = "1";
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>  CustomerApprovedScreen()
              )).then((value){
          });
        }/*else{
          setState(() {
            isWaiting = true;
          });
        }*/
      });
    });
  }

  void updateToCloudFirestoreDB() {

    print("allData >>>>>" + allData.toString());
    int time =   Duration(seconds: int.parse(serviceTotalTimeForFirebase)).inMinutes;
    print("time >>>>>" + time.toString());

    if(allData.isNotEmpty){
      _firestore
          .collection("ResolMech")
          .doc('${bookingId}')
          .update({
              'mechanicDiagonsisState': "1",
              'updatedServiceList' : FieldValue.arrayUnion(allData),
              'updatedServiceCost': "$serviceTotalCostForFirebase",
              'updatedServiceTime': "$time",
              "customerFromPage" : "ExtraServiceDiagonsisScreen(isEmergency: true,)",
              "mechanicFromPage" : "CustomerApprovedScreen",
              //===================== code for send the list of additional services =========
            })
          .then((value) => print("updatedServiceList Added"))
          .catchError((error) =>
          print("Failed to add updatedServiceList: $error"));
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: size.width,
                  height: size.height,
                  color: Colors.white,
                  child: Container(
                    margin: EdgeInsets.only(
                      left: size.width * 2 / 100,
                      top: size.height * 2 / 100,
                      right: size.width * 2 / 100
                    ),

                    child: isWaiting
                        ? mechanicNotFountWidget(size)
                        : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                mechanicStartServiceTitle(size),
                                mechanicStartServiceImage(size),
                                mechanicEditSelectedService(size, "$selectedServiceName"),
                                mechanicAdditionalFaultService(size, "" ),
                                InkWell(
                                  onTap: (){
                                    print(" on Tap - Add More _awaitReturnValueFromSecondScreenOnAdd");
                                    _awaitReturnValueFromSecondScreenOnAdd(context);
                                  },
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                      child: Container(
                                        margin: EdgeInsets.only(
                                          right: size.width * 8 / 100,
                                          top: size.height * 1.2 / 100
                                        ),
                                          child: Text("Add more",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontFamily: "SharpSans_Bold",
                                              fontWeight: FontWeight.w700,
                                              color: CustColors.light_navy,
                                            ),
                                          ))),
                                ),

                                Container(
                                  margin: EdgeInsets.only(
                                    left: size.width * 27.5 / 100,
                                    right: size.width * 27.5 / 100,
                                    top: size.height * 6 / 100
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset('assets/image/ic_alarm.svg',
                                              width: size.width * 4 / 100,
                                              height: size.height * 4 / 100,),
                                            SizedBox(width: 20,),
                                            /*Expanded(
                                child: Text("$totalEstimatedTime",
                                  style: TextStyle(
                                      fontSize: 36,
                                      fontFamily: "SharpSans_Bold",
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      letterSpacing: .7
                                  ),
                                ),
                              ),*/
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
                                            border: Border.all(
                                                color: CustColors.light_navy02,
                                                width: 0.3
                                            )
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Total estimated time "),
                                        ),
                                      )
                                    ],
                                  ),
                                ),

                                mechanicStartServiceButton(size),
                              ],
                            ) ,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget mechanicStartServiceTitle(Size size){
    return Container(
      margin: EdgeInsets.only(
        left: size.width * 4 /100,
       // bottom: size.height * 1 /100,
        top: size.height * 1.5 / 100,
      ),
      child: Text("Start your work.. ",style: TextStyle(
        fontSize: 16,
        fontFamily: "Samsung_SharpSans_Medium",
        fontWeight: FontWeight.w400,
        color: CustColors.light_navy,
      ),),
    );
  }

  Widget mechanicStartServiceImage(Size size){
    return Container(
      margin: EdgeInsets.only(
        left: size.width * 11.5 /100,
        right: size.width * 15.6 /100,
        bottom: size.height * 1 /100,
        top: size.height * 3.3 / 100,
      ),
      child: Image.asset("assets/image/img_start_service_bg.png"),
    );
  }

  Widget mechanicEditSelectedService(Size size,String selectedService){
    return InkWell(
      onTap: (){
        print(" on Tap - Add More _awaitReturnValueFromSecondScreenOnChange");
        _awaitReturnValueFromSecondScreenOnChange(context);
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
            border: Border.all(
                color: CustColors.light_navy,
                width: 0.3
            )
        ),
        margin: EdgeInsets.only(
            left: size.width * 4 / 100,
            right: size.width * 4 / 100,
            top: size.height * 2.8 / 100
        ),
        padding: EdgeInsets.only(
          left: size.width * 4 / 100,
          right: size.width * 3.5 / 100,
          top: size.height * 1.3 / 100,
          bottom: size.height * 1 / 100,
        ),
        child: Column(
          children: [
            Align(
                alignment: Alignment.centerLeft ,
                child: Text("Change selected service",
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: "Samsung_SharpSans_Medium",
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                )),
            Row(
              children: [
                Text(selectedService,
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: "Samsung_SharpSans_Regular",
                    fontWeight: FontWeight.w400,
                    color: CustColors.warm_grey03,
                  ),
                ),
                Spacer(),
                Container(
                    height: size.height * 3.5 /100,
                    width: size.width * 3.5 / 100,
                    child: Image.asset("assets/image/ic_edit_pen.png",
                    )
                ),
              ],
            ),
            Divider(
              color: CustColors.greyish,
              height: 5,
            ),
          ],
        ),
      ),
    );
  }

  Widget mechanicAdditionalFaultService(Size size,String selectedService){
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          border: Border.all(
              color: CustColors.light_navy,
              width: 0.3
          )
      ),
      margin: EdgeInsets.only(
          left: size.width * 4 / 100,
          right: size.width * 4 / 100,
          top: size.height * 2.8 / 100
      ),
      padding: EdgeInsets.only(
        left: size.width * 4 / 100,
        right: size.width * 3.5 / 100,
        top: size.height * 1.3 / 100,
        bottom: size.height * 1 / 100,

      ),
      child: Column(
        children: [
          Row(
            children: [
              Text("Add additional fault",
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: "Samsung_SharpSans_Medium",
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              Spacer(),
              Container(
                  height: size.height * 4 /100,
                  width: size.width * 4 / 100,
                  margin: EdgeInsets.only(
                    right: size.width * 1.5 / 100
                  ),
                  child: IconButton(
                    icon: Icon(
                        isExpanded ? Icons.keyboard_arrow_down :  Icons.keyboard_arrow_right,
                      color: CustColors.warm_grey03,
                    ),
                    onPressed: (){
                      print("Expand / Collapse");
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                  ),
              ),
            ],
          ),
          isExpanded ? Align(
            alignment: Alignment.centerLeft,
            child: Text(additionalServiceNames,
              style: TextStyle(
                fontSize: 12,
                fontFamily: "Samsung_SharpSans_Regular",
                fontWeight: FontWeight.w400,
                color: CustColors.warm_grey03,
              ),
            ),
          ) : Container(),
          Divider(
            color: CustColors.greyish,
            height: 5,
          ),
        ],
      ),
    );
  }

  Widget mechanicStartServiceButton(Size size){
    return InkWell(
      onTap: (){
        updateToCloudFirestoreDB();
        //isWaiting = true;
        setState(() {
          isCustomerApproved = "1";
        });
      },
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          margin: EdgeInsets.only(
              right: size.width * 4 / 100,
              top: size.height * 5.2 / 100
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
            isCustomerApproved == "0" ? "Update Services" : "Waiting For Customer Approval"  ,
            //"Start work",
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

  void _awaitReturnValueFromSecondScreenOnAdd(BuildContext context) async {

    List<MechanicService>? serviceList = [];
    serviceList.clear();
    additionalServiceNames = "";
    int totalCost = 0;

    serviceList = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddMoreServicesListScreen(isAddService: true, isMechanicApp: true,),
        ));

    if(serviceList!.isNotEmpty){

      totalCost = int.parse(serviceTotalCostForFirebase);
      setState(() {
        for(int i = 0; i<serviceList!.length ; i++){
          allData.add({
            'isDefault' : '0',
            'serviceId' : '${serviceList[i].service!.id.toString()}',
            'serviceName' : '${serviceList[i].service!.serviceName.toString()}',
            'serviceCost' : '${serviceList[i].fee.toString()}',
            'serviceTime' : '${serviceList[i].time.split(":").last.toString()}'
          });

          if(serviceList.length - 1 == i){
            additionalServiceNames = additionalServiceNames + serviceList[i].service!.serviceName.toString();
          }
          else{
            additionalServiceNames = additionalServiceNames + serviceList[i].service!.serviceName.toString() + " \n";
          }

          setState(() {

            totalCost = totalCost + int.parse('${serviceList![i].fee}');
            serviceTotalCostForFirebase =  totalCost.toString();

            selectedServiceTime = selectedServiceTime + Duration(minutes: int.parse('${serviceList[0].time.split(":").last}')).inSeconds;
            serviceTotalTimeForFirebase = selectedServiceTime.toString();

          });
        }
        setState(() {
          levelClock =  selectedServiceTime + 1;
          _controller = AnimationController(
              vsync: this,
              duration: Duration(
                  seconds:
                  levelClock) // gameData.levelClock is a user entered number elsewhere in the applciation
          );
          print(" serviceTotalCostForFirebase >>>>>>>>  " + serviceTotalCostForFirebase);
          print(" additionalServiceNames >>>>>>>>>> " + additionalServiceNames
              + " selectedServiceTime >>>>>>>> " + selectedServiceTime.toString()
              + " levelClock >>>>>>>>>>>> " + levelClock.toString()
          );
        });
      });
    }
    // setState(() {
    //   for(int i = 0; i<serviceList!.length ; i++){
    //     //totalTime  = totalTime + double.parse(serviceList[i].time.replaceAll(":", "."));
    //     totalTime  = totalTime + double.parse(serviceList[i].time.toString().split(':').first) ;
    //     totalCost = totalCost + int.parse(serviceList[i].fee);
    //     //totalServiceTime = totalServiceTime + serviceList[i].
    //   }
    //   print("MechanicStartServiceScreen serviceTotalTimeForFirebase1 >>>>>" + serviceTotalTimeForFirebase);
    //
    //   serviceTotalCostForFirebase = totalCost.toString();
    //   serviceTotalTimeForFirebase = totalTime.toString().split(':').first;
    //
    //   ///     Add extra time to level clock     ///
    //   print('MechanicStartServiceScreen  in totalTime ++++ $totalTime');
    //   print("MechanicStartServiceScreen serviceTotalTimeForFirebase2 >>>>>" + serviceTotalTimeForFirebase);
    //
    //   int sec = Duration(minutes: int.parse('${serviceTotalTimeForFirebase.toString().split(".").first}')).inSeconds;
    //   print('MechanicStartServiceScreen  in sec1 ++++ $sec');
    //   levelClock = levelClock + sec + 1;
    //   print('MechanicStartServiceScreen levelClock1 ++++ ${levelClock} ');
    //   _controller = AnimationController(
    //       vsync: this,
    //       duration: Duration(
    //           seconds:
    //           levelClock) // gameData.levelClock is a user entered number elsewhere in the applciation
    //   );
    //
    //   print("additionalServiceForFirebase >>>>>" + serviceItemList.toString());
    //   print("serviceTotalCostForFirebase >>>>>" + serviceTotalCostForFirebase);
    //   print("serviceTotalTimeForFirebase >>>>>" + serviceTotalTimeForFirebase);
    // });
    //
  }

  void _awaitReturnValueFromSecondScreenOnChange(BuildContext context) async {

    List<MechanicService> result = [];
    result.clear();
    result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddMoreServicesListScreen(isAddService: false, isMechanicApp: true),
        ));

    print(">>>>> widget.isAddService == false ");
    print(">>>>> widget.isAddService == false === $result");

    if(result.isNotEmpty){
        setState(() {
          allData.removeAt(0);
          allData.add({
            'isDefault' : '1',
            'serviceId' : '${result[0].service!.id.toString()}',
            'serviceName' : '${result[0].service!.serviceName.toString()}',
            'serviceCost' : '${result[0].fee.toString()}',
            'serviceTime' : '${result[0].time.split(":").last.toString()}'
          });
          setState(() {
            selectedServiceName = '${result[0].service!.serviceName.toString()}';
            serviceTotalTimeForFirebase = int.parse('${result[0].time.split(":").last}').toString() ;
            serviceTotalCostForFirebase = result[0].fee.toString();
            print(" result[0].fee.toString() >>>>>>>>  " + serviceTotalCostForFirebase);
            selectedServiceTime = Duration(minutes: int.parse('${result[0].time.split(":").last}')).inSeconds;
            levelClock =  selectedServiceTime + 1;
            _controller = AnimationController(
                vsync: this,
                duration: Duration(
                    seconds:
                    levelClock) // gameData.levelClock is a user entered number elsewhere in the applciation
            );
            print(" selectedServiceName >>>>>>>>>> " + selectedServiceName
                + " selectedServiceTime >>>>>>>> " + selectedServiceTime.toString()
                + " levelClock >>>>>>>>>>>> " + levelClock.toString()
            );
          });
        });
      }
  }

  Widget mechanicNotFountWidget(Size size) {
    return Expanded(
      child: Container(
        //color: Colors.lightGreen,
        margin: EdgeInsets.only(
            left: size.width * 6 / 100,
            right: size.width * 6 / 100,
            top: size.height * 8 / 100,
            bottom: size.height * 3.5 / 100
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              child: SvgPicture.asset(
                'assets/image/img_oops_mechanic_bg.svg',
                height: size.height * 27 / 100,
                fit: BoxFit.cover,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                margin: EdgeInsets.only(
                    left: size.width * 1 / 100,
                    right: size.width * 1 / 100,
                    top: size.height * 7 / 100
                ),
                height: size.height * 18 / 100,
                width: size.width,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                  color: CustColors.pale_grey,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Oops!! Customer not found!",
                      style: Styles.oopsmechanicNotFoundStyle01,
                    ),
                    Text("Confirmation is Mandatory",
                      style: Styles.smallTitleStyle3,
                    ),
                    Text("Wait for Customer Response...!",
                      style: Styles.TryAfterSomeTimetyle01,
                    ),
                  ],
                ),
              ),
            ),
            tryAgainButtonWidget(size),
          ],
        ),
      ),
    );
  }

  Widget tryAgainButtonWidget(Size size){
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        margin: EdgeInsets.only(
          //right: size.width * 6.2 / 100,
            top: size.height * 22 / 100
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(6),
            ),
            color: CustColors.light_navy
        ),
        padding: EdgeInsets.only(
          left: size.width * 4 / 100,
          right: size.width * 4 / 100,
          top: size.height * 1 / 100,
          bottom: size.height * 1 / 100,
        ),
        child: InkWell(
          onTap: (){
            //Navigator.of(context, rootNavigator: true).pop();
            setState(() {
              isWaiting = false;
            });
          },
          child: Text(
            "Try again",
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