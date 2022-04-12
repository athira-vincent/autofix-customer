import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:flutter/material.dart';

class CustomerApprovedScreen extends StatefulWidget {

  CustomerApprovedScreen();

  @override
  State<StatefulWidget> createState() {
    return _CustomerApprovedScreenState();
  }
}

class _CustomerApprovedScreenState extends State<CustomerApprovedScreen> {
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              width: size.width,
              height: size.height,
              color: Colors.green,
              child: Column(
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customerApprovedScreenTitle(size),
                        //rateMechanicScreenImage(size),

                        /*Container(
                          margin: EdgeInsets.only(
                              top: size.height * 2 / 100,
                              left: size.width * 6.5 / 100,
                              right: size.width * 6.5 / 100
                          ),
                          child: Row(
                            children: [
                              rateMechanicScreenTimeCostWidget(size,"Work completed in","Min "," 20:15",true),
                              Spacer(),
                              Container(
                                height: size.height * 5 /100,
                                child: VerticalDivider(
                                  color: CustColors.pale_grey01,
                                  width: 20,
                                  thickness: 2,
                                ),
                              ),
                              Spacer(),
                              rateMechanicScreenTimeCostWidget(size,"Amount you paid","₦ ","1600",false),
                            ],
                          ),
                        ),*/

                      ],
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


  Widget customerApprovedScreenTitle(Size size){
    return Container(
      margin: EdgeInsets.only(
        left: size.width * 5.8 /100,
        // bottom: size.height * 1 /100,
        top: size.height * 3.4 / 100,
      ),
      child: Text("Rate your mechanic! ",style: TextStyle(
        fontSize: 16,
        fontFamily: "Samsung_SharpSans_Medium",
        fontWeight: FontWeight.w400,
        color: CustColors.light_navy,
      ),),
    );
  }

}