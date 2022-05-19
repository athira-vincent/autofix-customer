import 'dart:async';

import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/UI/Common/add_more_service_list_screen.dart';
import 'package:auto_fix/UI/Mechanic/WorkFlowScreens/customer_approved_screen.dart';
import 'package:auto_fix/UI/Mechanic/WorkFlowScreens/mechanic_start_service_bloc.dart';
import 'package:auto_fix/UI/Mechanic/BottomBar/MyProfile/profile_Mechanic_Models/mechanic_profile_mdl.dart';
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

class _MechanicStartServiceScreenState extends State<MechanicStartServiceScreen> {

  bool isExpanded = true;

  List<String> selectedServiceList = [];
  final MechanicAddMoreServiceBloc _addMoreServiceBloc = MechanicAddMoreServiceBloc();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String additionalServiceNames = "", selectedServiceName = "",
      serviceTotalCostForFirebase = "", serviceTotalTimeForFirebase = "";
  List serviceItemList = [];
  String additionalServiceIds = "";
  String totalServiceTime = "";
  var _firestoreData ;

  String authToken="", bookingId = "";
  bool isCustomerApproved = false;

  String customerDiagonsisApproval = "0";
  Timer? timerObjVar;
  Timer? timerObj;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPrefData();
    _listenServiceListResponse();
    additionalServiceNames = "Flat tyre";
    selectedServiceName = "Lost /Locked keys";

    timerObj = Timer.periodic(Duration(seconds: 5), (Timer t) {
      timerObjVar = t;
      print('Timer listenToCloudFirestoreDB ++++++');
      //listenToCloudFirestoreDB();
    });
  }

  Future<void> getSharedPrefData() async {
    print('getSharedPrefData >>> ');
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    setState(() {
      authToken = shdPre.getString(SharedPrefKeys.token).toString();
      bookingId = shdPre.getString(SharedPrefKeys.bookingIdEmergency).toString();
      _firestoreData = _firestore.collection("ResolMech").doc('$bookingId').snapshots();

    });
  }

  void listenToCloudFirestoreDB() {
    DocumentReference reference = FirebaseFirestore.instance.collection('ResolMech').doc("${bookingId}");
    reference.snapshots().listen((querySnapshot) {
      setState(() {
        customerDiagonsisApproval = querySnapshot.get("customerDiagonsisApproval");

        print('customerDiagonsisApproval ++++ $customerDiagonsisApproval');
        if(customerDiagonsisApproval =="1")
        {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>  CustomerApprovedScreen(serviceModel: "",)
              )).then((value){
          });
        }
      });
    });
  }

  void updateToCloudFirestoreDB() {
    _firestore
        .collection("ResolMech")
        .doc('${bookingId}')
        .update({
      'mechanicDiagonsisState': "1",
      'updatedServiceList' : FieldValue.arrayUnion(serviceItemList),
      'updatedServiceCost': "$serviceTotalCostForFirebase",
      'updatedServiceTime': "$serviceTotalTimeForFirebase",
      //===================== code for send the list of additional services =========
    })
        .then((value) => print("updatedServiceList Added"))
        .catchError((error) =>
        print("Failed to add updatedServiceList: $error"));

  }

  _listenServiceListResponse() {
    _addMoreServiceBloc.postMechanicAddMoreServiceRequest.listen((value) {
      if (value.status == "error") {
        setState(() {

        });

      } else {
        setState(() {

        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Container(
            width: size.width,
            height: size.height,
            color: Colors.white,
            child: Container(
              margin: EdgeInsets.only(
                left: size.width * 2 / 100,
                top: size.height * 2 / 100,
                right: size.width * 2 / 100
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  mechanicStartServiceTitle(size),
                  mechanicStartServiceImage(size),
                  InkWell(
                    onTap: (){
                      print(" on Tap - Add More _awaitReturnValueFromSecondScreenOnChange");
                      _awaitReturnValueFromSecondScreenOnChange(context);
                    },
                      child: mechanicEditSelectedService(size, "$selectedServiceName")),
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
                          child: Row(
                            children: [
                              SvgPicture.asset('assets/image/ic_alarm.svg',
                              width: size.width * 4 / 100,
                              height: size.height * 4 / 100,),
                              Spacer(),
                              Text("25:00 ",
                                style: TextStyle(
                                  fontSize: 36,
                                  fontFamily: "SharpSans_Bold",
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  letterSpacing: .7
                                ),
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
              ),
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
        isCustomerApproved = true;
        updateToCloudFirestoreDB();
        _addMoreServiceBloc.postAddMoreServiceRequest(authToken, bookingId, additionalServiceIds);
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
            isCustomerApproved ? "Waiting For Customer Approval" : "Update Services" ,
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

    // start the SecondScreen and wait for it to finish with a result
    List<MechanicService>? serviceList = [];
    serviceList.clear();
    additionalServiceNames = "";
    serviceTotalCostForFirebase = "";
    serviceTotalTimeForFirebase = "";

    //_chooseVechicleSpecializedController.text="";
    serviceList = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddMoreServicesListScreen(isAddService: true,isMechanicApp: true,),
        ));

    setState(() {

      additionalServiceIds = "[";

      for(int i = 0; i<serviceList!.length ; i++){

        //totalServiceTime = totalServiceTime + serviceList[i].
        if(serviceList.length - 1 == i){
          additionalServiceNames = additionalServiceNames + serviceList[i].service!.serviceName.toString();
          additionalServiceIds =  additionalServiceIds + serviceList[i].id.toString();
        }
        else{
          additionalServiceNames = additionalServiceNames + serviceList[i].service!.serviceName.toString() + " \n";
          additionalServiceIds =  additionalServiceIds + serviceList[i].id.toString() + ", ";
        }

        serviceItemList.add({
          'isDefault' : '0',
          'serviceId' : '${serviceList[i].id.toString()}',
          'serviceName' : '${serviceList[i].service!.serviceName.toString()}',
          'serviceCost' : '${serviceList[i].fee.toString()}',
          'serviceTime' : '10:00'
        });

      }
      additionalServiceIds = additionalServiceIds + "]";
      serviceTotalCostForFirebase = "1000";
      serviceTotalTimeForFirebase = "25.30";
      //selectedState = result;

      print("additionalServiceIds >>>>>" + additionalServiceIds);
      print("additionalServiceForFirebase >>>>>" + serviceItemList.toString());
      print("serviceTotalCostForFirebase >>>>>" + serviceTotalCostForFirebase);
      print("serviceTotalTimeForFirebase >>>>>" + serviceTotalTimeForFirebase);

      if(serviceList!='[]')
      {
        /*_chooseVechicleSpecializedController.text = selectedVehicles;
        print ("Selected state @ sign up: " + selectedState );
        print ("Selected selectedVehicleId @ sign up: " + selectedVehicleId );
        print ("Selected selectedVehicles @ sign up: " + selectedVehicles );
        if (_formKey.currentState!.validate()) {
        } else {
        }*/
      }

    });
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
          serviceItemList.add({
            'isDefault' : '1',
            'serviceId' : '${result[0].id.toString()}',
            'serviceName' : '${result[0].service!.serviceName.toString()}',
            'serviceCost' : '${result[0].fee.toString()}',
            'serviceTime' : '${result[0].time.toString()}'
          });
          selectedServiceName = '${result[0].service!.serviceName.toString()}';
        });

      }

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