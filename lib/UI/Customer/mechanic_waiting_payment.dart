import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MechanicWaitingPaymentScreen extends StatefulWidget {

  MechanicWaitingPaymentScreen();

  @override
  State<StatefulWidget> createState() {
    return _MechanicWaitingPaymentScreenState();
  }
}

class _MechanicWaitingPaymentScreenState extends State<MechanicWaitingPaymentScreen> {

  bool isExpanded = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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

// ------------------ this Column widget will be replaced by list ---- item builder will return serviceDetailListItem()

                              isExpanded ? Column(
                                children: [
                                  serviceDetailListItem(size,"Timing belt replacement","₦ 200"),
                                  serviceDetailListItem(size,"Breakpad replacement","₦ 700"),
                                  serviceDetailListItem(size,"Oil port leaking","₦ 500"),
                                ],
                              ) : Container(),


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
                                    Text("₦ 1600",style: TextStyle(
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

                  Align(
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

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget mechanicWaitingTitle(Size size){
    return Container(
      margin: EdgeInsets.only(
        left: size.width * 3 /100,
        right: size.width * 5 /100,
        bottom: size.height * 1 /100,
        top: size.height * 1 / 100,
      ),
      child: Row(
        children: [
          Text("Afamefuna ",style: TextStyle(
            fontSize: 20,
            fontFamily: "Samsung_SharpSans_Medium",
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),),
          Text("is waiting for payment..",style: TextStyle(
            fontSize: 20,
            fontFamily: "Samsung_SharpSans_Medium",
            fontWeight: FontWeight.w400,
            color: CustColors.light_navy
          ),)
        ],
      ),
    );
  }

  Widget totalCostSection(Size size){
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("₦ ",style: TextStyle(
              fontSize: 30,
              fontFamily: "Samsung_SharpSans_Medium",
              fontWeight: FontWeight.bold,
              color: CustColors.light_navy
          ),),
          Text("1600",
            style: TextStyle(
                fontFamily: "Samsung_SharpSans_Medium",
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                letterSpacing: .5
            ),)
        ],
      ),
    );
  }

  Widget serviceDetailListItem(Size size,String serviceName, String serviceCost){
    return Container(
      margin: EdgeInsets.only(
          top: size.height * 1.2 / 100,
          bottom: size.height * 1.2 / 100
      ),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(serviceName,style: TextStyle(
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
            child: Text(serviceCost,style: TextStyle(
                fontSize: 12,
                fontFamily: "Samsung_SharpSans_Regular",
                fontWeight: FontWeight.w400,
                color: Colors.black
            ),
            ),
          ),
        ],
      ),
    );
  }
}