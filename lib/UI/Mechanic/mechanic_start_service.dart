import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MechanicStartServiceScreen extends StatefulWidget {

  MechanicStartServiceScreen();

  @override
  State<StatefulWidget> createState() {
    return _MechanicStartServiceScreenState();
  }
}

class _MechanicStartServiceScreenState extends State<MechanicStartServiceScreen> {

  bool isExpanded = true;

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
                  mechanicEditSelectedService(size,"Timing  belt replacement"),
                  mechanicAdditionalFaultService(size,"Breakpad replacement"),
                  InkWell(
                    onTap: (){
                      print(" on Tap - Add More");
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
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.alarm_rounded,
                                color: CustColors.light_navy,
                              ),
                              onPressed: (){
                                print("Alarm");
                              },
                            ),
                            Text("25:00 ",
                              style: TextStyle(
                                fontSize: 36,
                                fontFamily: "SharpSans_Bold",
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
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
                            right: size.width * 3.5 / 100,
                            top: size.height * 1.3 / 100,
                            bottom: size.height * 1 / 100,
                          ),
                          child: Text("Total estimated time "),
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
          InkWell(
            child: Row(
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
            onTap: (){
              print("onTap mechanicEditSelectedServices ");
            },
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
            child: Text(selectedService,
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
    return Align(
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
          "Start work",
          style: TextStyle(
            fontSize: 14.3,
            fontWeight: FontWeight.w600,
            fontFamily: "Samsung_SharpSans_Medium",
            color: Colors.white,
          ),
        ),
      ),
    );
  }

}