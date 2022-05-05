import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/UI/Customer/MainLandingPageCustomer/customer_main_landing_screen.dart';
import 'package:auto_fix/UI/Mechanic/WorkFlowScreens/MechanicWorkComleted/mechanic_work_completed_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomerApprovedScreen extends StatefulWidget {

  final String serviceModel;

  CustomerApprovedScreen({required this.serviceModel});

  @override
  State<StatefulWidget> createState() {
    return _CustomerApprovedScreenState();
  }
}

class _CustomerApprovedScreenState extends State<CustomerApprovedScreen> {

  bool isStartedWork = false;
  bool _isLoading = false;

  double per = .10;

  double _setValue(double value) {
    return value * per + value;
  }

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customerApprovedScreenTitle(size),

                  customerApprovedScreenSubTitle(size),

                  customerApprovedScreenTitleImage(size),

                  customerApprovedScreenStartWorkText(size),

                  customerApprovedScreenWarningText(size),

                  InkWell(
                    onTap: (){

                      setState(() {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                contentPadding: EdgeInsets.all(0.0),
                                content: StatefulBuilder(
                                    builder: (BuildContext context, StateSetter monthYear) {
                                      return  setupAlertDialogAddExtraTime(size);
                                    }
                                ),
                              );
                            });
                      });

                    },
                      child: customerApprovedScreenTimer(size)),

                  InkWell(
                    onTap: (){

                      if(widget.serviceModel == "1"){
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CustomerMainLandingScreen()));
                      }
                      else if(isStartedWork){
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MechanicWorkCompletedScreen()));
                      }
                      else{
                        setState(() {
                          isStartedWork = !isStartedWork;
                        });
                      }

                    },
                      child: mechanicStartServiceButton(size)),
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
        left: size.width * 6 /100,
        // bottom: size.height * 1 /100,
        top: size.height * 3.4 / 100,
      ),
      child: Text("Customer approved ! ",style: TextStyle(
        fontSize: 16,
        fontFamily: "Samsung_SharpSans_Medium",
        fontWeight: FontWeight.w400,
        color: CustColors.light_navy,
      ),),
    );
  }

  Widget customerApprovedScreenSubTitle(Size size){
    return Container(
      margin: EdgeInsets.only(
        left: size.width * 6 /100,
        // bottom: size.height * 1 /100,
        top: size.height * 8.5 / 100,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text("Hi...", style: TextStyle(

              ),),
              Text("George Dola", style: TextStyle(
                color: CustColors.light_navy
              ),)
            ],
          ),
          Row(
            children: [
              Text("Customer ", style: TextStyle(

              ),),
              Text("John Eric ", style: TextStyle(
                  color: CustColors.light_navy
              ),),
              Text("approved the services you added.",style: TextStyle(

              ),)
            ],
          )
        ],
      ),
    );
  }

  Widget customerApprovedScreenTitleImage(Size size){
    return Center(
      child: Container(
        margin: EdgeInsets.only(
          //left: size.width * 20 /100,
         // right: size.width * 20 / 100,
          // bottom: size.height * 1 /100,
          top: size.height * 3.3 / 100,
        ),
        child: SvgPicture.asset('assets/image/img_customer_approved.svg',
          width: size.width * 60 / 100,
          height: size.height * 30 / 100,),
      ),
    );
  }

  Widget customerApprovedScreenStartWorkText(Size size){
    return Container(
      decoration: Styles.boxDecorationStyle,
      margin: EdgeInsets.only(
          left: size.width * 6 / 100,
          right: size.width * 6 / 100,
          top: size.height * 3.3 / 100
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(
                top: size.width * 3 / 100,
                bottom: size.width * 3 / 100
            ),
            margin: EdgeInsets.only(
                left: size.width * 5 / 100,
                right: size.width * 2 / 100
            ),
            child: SvgPicture.asset("assets/image/ic_info_blue_white.svg",
              height: size.height * 3 / 100,width: size.width * 3 / 100,),
          ),
          Text("Customer agree with the diagnostic test report \nand estimated cost . So you can start repair ",
            style: warningTextStyle01,

          )
        ],
      ),
    );
  }

  Widget customerApprovedScreenWarningText(Size size){
    return Container(
      decoration: Styles.boxDecorationStyle,
      margin: EdgeInsets.only(
          left: size.width * 6 / 100,
          right: size.width * 6 / 100,
          top: size.height * 2.2 / 100
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(
                top: size.width * 3 / 100,
                bottom: size.width * 3 / 100
            ),
            margin: EdgeInsets.only(
                left: size.width * 5 / 100,
                right: size.width * 2 / 100
            ),
            child: SvgPicture.asset("assets/image/ic_info_blue_white.svg",
              height: size.height * 3 / 100,width: size.width * 3 / 100,),
          ),
          Text("Note:  If you click the ‘Start repair’ button, it will \nenables the timer countdown feature also.",
            style: warningTextStyle01,
          )
        ],
      ),
    );
  }

  Widget customerApprovedScreenTimer(Size size){
    return Container(
      margin: EdgeInsets.only(
          left: size.width * 27.5 / 100,
          right: size.width * 27.5 / 100,
          top: size.height * 4.3 / 100
      ),
      child: Flexible(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                left: size.width * 4.5 / 100,
                right: size.width * 4.5 / 100,
                top: size.height * 1 / 100,
                bottom: size.height * 1 / 100,
              ),
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
                            /*margin: EdgeInsets.only(
                                left: size.width * 4 / 100,
                                right: size.width * 4 / 100,
                                top: size.height * 2.8 / 100
                            ),*/
              padding: EdgeInsets.only(
                left: size.width * 4 / 100,
                right: size.width * 4 / 100,
                top: size.height * 1 / 100,
                bottom: size.height * 1 / 100,
              ),
              child: Text("Total estimated time "),
            )
          ],
        ),
      ),
    );
  }

  Widget mechanicStartServiceButton(Size size){
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.only(
            right: size.width * 6.2 / 100,
            top: size.height * 3.7 / 100
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
          widget.serviceModel == "1" ? "Back to home" :
          isStartedWork ? "Work Finished" : "Start repair",
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

  Widget setupAlertDialogAddExtraTime(Size size ) {
    return Container(
      height: 280.0, // Change as per your requirement
      child: Column(
        children: [
          Container(
              width: double.infinity,
              height: 50,
              color: CustColors.light_navy,
              alignment: Alignment.center,
              child: Text("Add Extra time",
                style: Styles.textButtonLabelSubTitle,)
          ),

          Container(
            padding: EdgeInsets.only(
                top: size.height * 2.5 / 100,
                bottom: size.height * 2.5 / 100,
                left: size.width * 4 / 100,
                right: size.width * 4 / 100
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.only(
                      top: size.height * 1.5 / 100,
                      bottom: size.height * 1.5 / 100,
                      left: size.width * 2 / 100,
                      right: size.width * 2 / 100
                  ),
                  decoration: Styles.serviceIconBoxDecorationStyle,
                  child: SvgPicture.asset(
                    "assets/image/MechanicType/mechanic_work_clock.svg",
                    height: size.height * 4 / 100,
                    //width: size.width * 5 / 100,
                  ),
                ),
                SizedBox(
                  width: size.width * 8 / 100,
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Extend time",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontFamily: "Samsung_SharpSans_Medium",
                            fontWeight: FontWeight.w600,
                            letterSpacing: .6,
                            height: 1.7
                        ),
                      ),
                      Text("25:00 ",
                        style: TextStyle(
                            fontSize: 22,
                            color: Colors.black,
                            fontFamily: "SharpSans_Bold",
                            fontWeight: FontWeight.w600,
                            letterSpacing: .6,
                            height: 1.7
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),

          InfoTextWidget(size),

          Container(
            margin: EdgeInsets.only(
              //left: size.width * 4 / 100,
              //right: size.width * 4 / 100,
                top: size.height * 1.5 / 100
            ),
            child: _isLoading
                ? Center(
                  child: Container(
                    height: _setValue(28),
                    width: _setValue(28),
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          CustColors.peaGreen),
                    ),
                  ),
            )
                : MaterialButton(
              onPressed: () {

                Navigator.pop(context);
                /*setState(() {

                      _lastMaintenanceController.text = '$selectedMonthText  $selectedYearText';
                      if (_formKey.currentState!.validate()) {
                      } else {
                      }
                    });*/
                print(">>>>>>>>>> time   ");

                /*Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  FindMechanicListScreen(
                          bookingId: '01',
                          serviceIds: serviceIds,
                          serviceType: 'emergency',
                          authToken: authToken,)));*/

              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.only(
                    left: size.width * 2.5 / 100,
                    right: size.width * 2.5 / 100,
                    top: size.height * 1 / 100,
                    bottom: size.height * 1 / 100
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(6),
                    ),
                    color: CustColors.light_navy
                ),
                child: Text(
                  'Add time ',
                  textAlign: TextAlign.center,
                  style: Styles.textButtonLabelSubTitle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget InfoTextWidget(Size size){
    return Container(
      decoration: Styles.boxDecorationStyle,
      margin: EdgeInsets.only(
          left: size.width * 4 / 100,
          right: size.width * 4 / 100,
          top: size.height * 1 / 100,
          bottom: size.height * .7 / 100
      ),
      padding: EdgeInsets.only(
        top: size.height * 1.5 / 100,
        bottom: size.height * 1.5 / 100,
        right: size.width * 2.3 / 100,
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(
              left: size.width * 2 / 100,
              right: size.width * 2.5 / 100,
            ),
            child: SvgPicture.asset("assets/image/ic_info_blue_white.svg",
              height: size.height * 2.5 / 100,width: size.width * 2.5 / 100,),
          ),
          Expanded(
            child: Text(
              "Adding extra time may cause bad reviews from customer",
              textAlign: TextAlign.justify,
              style: warningTextStyle01,
            ),
          )
        ],
      ),
    );
  }

  TextStyle warningTextStyle01 = TextStyle(
      fontSize: 12,
      fontFamily: "Samsung_SharpSans_Regular",
      fontWeight: FontWeight.w600,
      color: Colors.black,
  );

}