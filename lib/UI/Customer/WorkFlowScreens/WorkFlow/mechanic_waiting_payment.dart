import 'dart:async';

import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/UI/Customer/PaymentScreens/payment_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MechanicWaitingPaymentScreen extends StatefulWidget {

  MechanicWaitingPaymentScreen();

  @override
  State<StatefulWidget> createState() {
    return _MechanicWaitingPaymentScreenState();
  }
}

class _MechanicWaitingPaymentScreenState extends State<MechanicWaitingPaymentScreen> {

  bool isExpanded = true;

  Timer? timerObjVar;
  Timer? timerObj;

  String totalEstimatedCost = "0";

  String totalEstimatedTime = "0";
  String customerDiagonsisApproval = "1";
  String mechanicName = "";

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var _firestoreData ;

  String authToken="";
  String userName="";


  String serviceIdEmergency="";
  String mechanicIdEmergency="";
  String bookingIdEmergency="";

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
      serviceIdEmergency = shdPre.getString(SharedPrefKeys.serviceIdEmergency).toString();
      mechanicIdEmergency = shdPre.getString(SharedPrefKeys.mechanicIdEmergency).toString();
      bookingIdEmergency = shdPre.getString(SharedPrefKeys.bookingIdEmergency).toString();
      _firestoreData = _firestore.collection("ResolMech").doc('$bookingIdEmergency').snapshots();
    });
    await _firestore.collection("ResolMech").doc('$bookingIdEmergency').snapshots().listen((event) {
      setState(() {
        totalEstimatedTime = event.get('updatedServiceTime');
        totalEstimatedCost = event.get('updatedServiceCost');
        customerDiagonsisApproval = event.get('customerDiagonsisApproval');

        mechanicName = event.get('mechanicName');
        print('_firestoreData>>>>>>>>> ' + event.get('serviceName'));
      });

    });
  }





  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
            height: size.height,
            width: size.width,
            child: Container(
              margin: EdgeInsets.only(
                left: size.width * 2 / 100,
                right: size.width * 2 /100,
                top: size.height * 2 / 100,
                bottom: size.height * 1 / 100
              ),
              child: Column(
                children: [
                  mechanicWaitingTitle(size),

                  Container(
                    margin: EdgeInsets.only(
                      left: size.width * 18 /100,
                      right: size.width * 18 /100,
                      bottom: size.height * 1 /100,
                      top: size.height * 4 / 100,

                    ),
                      child: Image.asset("assets/image/img_payment_waiting_bg.png"),
                  ),

                  totalCostSection(size),

                  Container(
                    margin: EdgeInsets.only(
                      left: size.width * 3 /100,
                      right: size.width * 3 /100,
                      bottom: size.height * 2 /100,
                      top: size.height * 3 / 100,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                      //color: Colors.yellow,
                      color : CustColors.whiteBlueish,
                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                              margin: EdgeInsets.only(
                                left: size.width * 3.5 /100,
                                // right: size.width * 18 /100,
                                //bottom: size.height * 5 /100,
                                top: size.height * 2 / 100,
                              ),
                              child: Text("Service invoice",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontFamily: "Samsung_SharpSans_Medium",
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black,
                              ),
                              ),
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.only(
                            left: size.width * 2 /100,
                            right: size.width * 2 /100,
                            bottom: size.height * 2 /100,
                            top: size.height * 1.5 / 100,
                          ),
                          padding: EdgeInsets.only(
                            left: size.width * 2 / 100,
                            right: size.width * 1.5 /100,
                            top: size.height * 1 /100,
                            bottom: size.height * 1 /100,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Repair Details",style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: "Samsung_SharpSans_Medium",
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black
                                  ),),
                                  Container(
                                    margin: EdgeInsets.only(
                                      right: size.width * 2.7 / 100,
                                    ),
                                    child: Text("Price",style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: "Samsung_SharpSans_Medium",
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black
                                    ),),
                                  )
                                ],
                              ),


                                 isExpanded
                                  ? Column(
                                          children: [
                                            serviceDetailListItem(size),
                                          ],
                                    )
                                 : Container(),


                              Container(
                                margin: EdgeInsets.only(
                                  top: size.height * 1.2 / 100,
                                  bottom: size.height * 1.2 / 100
                                ),
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Total price including tax ",style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: "Samsung_SharpSans_Medium",
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black
                                    ),),
                                   Spacer(),
                                    Text("₦ $totalEstimatedCost",style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: "Samsung_SharpSans_Medium",
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black
                                    ),),
                                    InkWell(
                                      onTap: (){
                                        setState(() {
                                          isExpanded = !isExpanded;
                                        });
                                      },
                                      child: Container(
                                        height: size.height * 1.5 / 100,
                                        width: size.width * 1.5 / 100,
                                        margin: EdgeInsets.only(
                                          left: size.width * .9 / 100,
                                          right: size.width * .2 / 100
                                        ),
                                        child: Image.asset(
                                          isExpanded ? "assets/image/ic_arrow_collapse.png"
                                              : "assets/image/ic_arrow_expand.png"
                                          ,),
                                      ),
                                    ),
                                    //---------- icon expand and  collapse
                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),

                      ],
                    ),

                  ),

                  InkWell(
                    onTap: (){
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PaymentScreen()));
                    },
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        margin: EdgeInsets.only(
                          right: size.width * 4 / 100
                        ),
                        padding: EdgeInsets.only(
                          top: size.height * 1 / 100,
                          bottom: size.height * 1 / 100,
                          left: size.width * 2.5 / 100,
                          right: size.width * 2.5 / 100
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                          color: CustColors.light_navy,
                        ),
                        child: Text("Payment options",
                          style: TextStyle(
                            color: Colors.white,
                        ),),
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

  Widget mechanicWaitingTitle(Size size){
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Job completed!",
              style: TextStyle(
                fontSize: 17,
                fontFamily: "Samsung_SharpSans_Medium",
                fontWeight: FontWeight.w500,
                color: CustColors.light_navy
            ),),
            Row(
              children: [
                Text("$mechanicName ",style: TextStyle(
                  fontSize: 17,
                  fontFamily: "Samsung_SharpSans_Medium",
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),),
                Text("is waiting for payment..",style: TextStyle(
                  fontSize: 16,
                  fontFamily: "Samsung_SharpSans_Medium",
                  fontWeight: FontWeight.w500,
                  color: CustColors.light_navy
                ),)
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget totalCostSection(Size size){
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("₦ ",
            style: TextStyle(
              fontSize: 30,
              fontFamily: "SharpSans_Bold",
              fontWeight: FontWeight.bold,
              color: CustColors.light_navy
          ),),
          Text("$totalEstimatedCost",
            style: TextStyle(
                fontFamily: "SharpSans_Bold",
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                letterSpacing: .5
            ),)
        ],
      ),
    );
  }

  Widget serviceDetailListItem(Size size){
    return Container(
      child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: _firestoreData,
        builder: (_, snapshot) {


          if (snapshot.hasError) return Text('Error = ${snapshot.error}');

          if (snapshot.hasData) {
            List allData;
            if(customerDiagonsisApproval=="-1")
              {
                allData = snapshot.data?.data()!['serviceModel'].toList();
              }
            else
              {
                 allData = snapshot.data?.data()!['updatedServiceList'].toList();
              }


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
                    padding: const EdgeInsets.fromLTRB(2,5,2,5),
                    child:  Container(
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${allData[index]['serviceName']}',
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: "Samsung_SharpSans_Regular",
                              fontWeight: FontWeight.w400,
                              color: Colors.black
                          ),),
                          Spacer(),
                          Container(
                            margin: EdgeInsets.only(
                              right: size.width * 2.8 / 100,
                            ),
                            child: Text('${allData[index]['serviceCost']}',
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: "Samsung_SharpSans_Regular",
                                fontWeight: FontWeight.w400,
                                color: Colors.black
                            ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ),
                );
              },
            );
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}