import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Widgets/screen_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../Constants/cust_colors.dart';
import '../../../../../Constants/styles.dart';

class MyJobAppoinmentScreen extends StatefulWidget {




  MyJobAppoinmentScreen();

  @override
  State<StatefulWidget> createState() {
    return _MyJobAppoinmentScreenState();
  }
}

class _MyJobAppoinmentScreenState extends State<MyJobAppoinmentScreen> {


  double per = .10;
  double perfont = .10;
  double height = 0;
  String selectedService = "1";

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

                Container(
                  height: 40,
                  child: Row(
                    children: [
                      Container(
                        width: 125,
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: (){
                            setState(() {
                              selectedService="1";
                            });
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  alignment: Alignment.center,
                                  height: 30,
                                  child: Text('Upcoming Services')
                              ),
                              selectedService == "1"
                              ? Container(
                                height: 10,
                                decoration: BoxDecoration(
                                  color: CustColors.light_navy,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30))
                                ),
                              )
                              : Container(
                                height: 10,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30))
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 130,
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: (){
                            setState(() {
                              selectedService="2";
                            });
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  alignment: Alignment.center,
                                  height: 30,
                                  child: Text('Completed Services')
                              ),
                              selectedService == "2"
                                  ? Container(
                                    height: 10,
                                    decoration: BoxDecoration(
                                        color: CustColors.light_navy,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(30),
                                            topRight: Radius.circular(30))
                                    ),
                                  )
                                  : Container(
                                    height: 10,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(30),
                                            topRight: Radius.circular(30))
                                    ),
                                  ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.center,
                            child: InkWell(
                              onTap: (){
                                setState(() {
                                  selectedService="3";
                                });
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      alignment: Alignment.center,
                                      height: 30,
                                      child: Text('All Services')
                                  ),
                                  selectedService == "3"
                                      ? Container(
                                    height: 10,
                                    decoration: BoxDecoration(
                                        color: CustColors.light_navy,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(30),
                                            topRight: Radius.circular(30))
                                    ),
                                  )
                                      : Container(
                                    height: 10,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(30),
                                            topRight: Radius.circular(30))
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
          'My Job Appointments',
          textAlign: TextAlign.center,
          style: Styles.appBarTextBlack,
        ),
        Spacer(),

      ],
    );
  }
}
