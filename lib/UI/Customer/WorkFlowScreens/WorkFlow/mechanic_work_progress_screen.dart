import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/UI/Customer/WorkFlowScreens/WorkFlow/extra_Service_Diagnosis_Screen.dart';
import 'package:auto_fix/UI/Customer/WorkFlowScreens/WorkFlow/mechanic_waiting_payment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MechanicWorkProgressScreen extends StatefulWidget {

  final String workStatus;

  MechanicWorkProgressScreen({required this.workStatus,});

  @override
  State<StatefulWidget> createState() {
    return _MechanicWorkProgressScreenState();
  }
}

class _MechanicWorkProgressScreenState extends State<MechanicWorkProgressScreen> {


  String workStatus = "";     // 1 - arrived - screen 075,
                              // 2 - started working - screen 078,
                              // 3 - completed - screen 079,
                              // 4 - ready to pickup vehicle - screen 094

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    workStatus = widget.workStatus.toString();
  }

  void changeScreen(){
    if(workStatus == "1"){
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => ExtraServiceDiagonsisScreen()));
    }else if(workStatus == "2"){
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => MechanicWorkProgressScreen(workStatus: "3",)));
    }else if(workStatus == "3"){
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => MechanicWaitingPaymentScreen()));
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
              child: Container(
                width: size.width,
                height: size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      startedWorkScreenTitle(size),

                      startedWorkScreenTitleImage(size),

                      startedWorkScreenBottomCurve(size),

                      workStatus == "2"
                          ?
                      startedWorkScreenTimer(size)
                          :
                      workStatus == "3"
                          ?
                      startedWorkScreenSuccess(size)
                          :
                      startedWorkScreenWarningText(size) ,
                    ],
                ),
              ),
            ),
          ),
        ),
    );

  }

  Widget startedWorkScreenTitle(Size size){
    return Container(
      margin: EdgeInsets.only(
        left: size.width * 6 /100,
        // bottom: size.height * 1 /100,
        top: size.height * 3 / 100,
      ),
      child: Text(
        workStatus == "1" ?
          "Mechanic arrived"
            :
            workStatus == "2" ?
              "Mechanic start repair"
                :
            workStatus == "3"?
            "Job completed"
                :
            "Ready to pick up your vehicle ",
        style: TextStyle(
        fontSize: 16,
        fontFamily: "Samsung_SharpSans_Medium",
        fontWeight: FontWeight.w400,
        color: CustColors.light_navy,
      ),),
    );
  }

  Widget startedWorkScreenTitleImage(Size size){
    return Center(
      child: Container(
        margin: EdgeInsets.only(
           left: size.width * 6 /100,
           right: size.width * 6 / 100,
          // bottom: size.height * 1 /100,
          top: size.height * 3.5 / 100,
        ),
        child: Image.asset('assets/image/img_started_work_bg.png',),
      ),
    );
  }

  Widget startedWorkScreenBottomCurve(Size size){
    return Center(
      child: Container(
        margin: EdgeInsets.only(
          //left: size.width * 6 /100,
          //right: size.width * 6 / 100,
          // bottom: size.height * 1 /100,
          top: size.height * 3.4 / 100,
        ),
        child: Stack(
          children: [
            curvedBottomContainer(
              size,
              "1",
              size.height * 14 / 100,
              Text(
                workStatus == "1" ?
                  "Hi.. John Eric congratulations! Your mechanic reached near you. \nHe fix your vehicle faults."
                    :
                    workStatus == "2" ?
                      "Hi.. John Eric congratulations! Your mechanic started repair your vehicle. \nWait for the count down stop."
                    :
                        workStatus == "3" ?
                          "Hi.. John Eric congratulations!  Your mechanic completed his Work wait for the payment process"
                    :
                      "Hi.. John Eric congratulations!  Your mechanic reached near you. He list your vehicle faults.Then read the estimate. if you can afford the service charge  then agree. ",

                style: TextStyle(
                  fontSize: 13,
                  color: Colors.white,
                ),
              )
            ),

            Container(
              margin: EdgeInsets.only(
                top: size.height * 9.3 / 100
              ),
              child: curvedBottomContainer(
                  size,
                  "2",
                  size.height * 19 / 100,
                  mechanicImageAndName(size)
              ),
            )

          ],
        ),
      ),
    );
  }

  Widget curvedBottomContainer(Size size,String colorsInt,double height, Widget child){
    return Container(
      height: height,
      width: size.width,
      padding: EdgeInsets.only(
        left: size.width * 6 / 100,
        right: size.width * 8 / 100,
        top: size.width * 6 / 100
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
        ),
        color: colorsInt == '1' ? CustColors.light_navy : CustColors.pale_grey,
      ),
      child: child,
    );
  }

  Widget mechanicImageAndName(Size size){
    return Container(
      margin: EdgeInsets.only(
        left: size.width * 2 / 100
      ),
      child: Row(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 75,
                height: 75,
                decoration: BoxDecoration(
                  color: CustColors.light_navy,
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      70,
                    ),
                  ),
                ),
              ),
              ClipRRect(
                child: Container(
                  margin: EdgeInsets.only(
                      right: 2
                  ),
                  color: Colors.white,
                  child: Image.network(
                    'http://www.londondentalsmiles.co.uk/wp-content/uploads/2017/06/person-dummy.jpg',
                    fit: BoxFit.cover,
                    width: 70,
                    height: 70,
                  ),
                ),
                borderRadius: BorderRadius.circular(40),
              ),
            ],
          ),
          SizedBox(
            width: size.width * 10 / 100,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "George Dola",
                  style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontFamily: "Samsung_SharpSans_Medium",
                  fontWeight: FontWeight.bold,
                ),),
              Text(
               //workStatus == "1" ? "Started diagnostic test!" :
                workStatus == "2" ? "Started repair" :
                workStatus == "3" ? "Completed his work" : "Started diagnostic test!",
                style: TextStyle(
                fontSize: 8,
                color: CustColors.light_navy,
                fontFamily: "Samsung_SharpSans_Medium",
                fontWeight: FontWeight.w400,
              ),)
            ],
          ),

          //customerApprovedScreenTimer(size)
        ],
      ),
    );
  }

  Widget startedWorkScreenWarningText(Size size){
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          border: Border.all(
              color: CustColors.greyish,
              width: 0.3
          )
      ),
      margin: EdgeInsets.only(
          left: size.width * 6 / 100,
          right: size.width * 6 / 100,
          top: size.height * 4.8 / 100
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
          Text(
            "Wait for some time. Mechanic started diagnostic test. \nHe will finalise the service you needed",
            style: TextStyle(
              fontSize: 12,
              fontFamily: "Samsung_SharpSans_Regular",
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }

  /*Widget startedWorkScreenWarningText(Size size){
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          border: Border.all(
              color: CustColors.greyish,
              width: 0.3
          )
      ),
      margin: EdgeInsets.only(
          left: size.width * 6 / 100,
          right: size.width * 6 / 100,
          top: size.height * 4.8 / 100
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
          Text("Wait for some time. Mechanic started diagnostic test. \nHe will finalise the service you needed",
            style: TextStyle(
              fontSize: 12,
              fontFamily: "Samsung_SharpSans_Regular",
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }*/

  Widget startedWorkScreenTimer(Size size){
    return Container(
      margin: EdgeInsets.only(
          left: size.width * 27.5 / 100,
          right: size.width * 27.5 / 100,
          top: size.height * 3.3 / 100
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

  Widget startedWorkScreenSuccess(Size size){
    return Container(
     child: Column(
       children: [
         Container(
           margin: EdgeInsets.only(
             left: size.width * 2.5 / 100,
             right: size.width * 2.5 / 100
           ),
             child: SvgPicture.asset(
               "assets/image/img_success_bg.svg",
               height: size.height * 28 / 100,
               width:size.width * 90 / 100,)),

         Container(
           alignment: Alignment.bottomCenter,
           child: Text("Job Completed successfully!",
             style: TextStyle(
               fontSize: 20,
               color: CustColors.light_navy
             ),
           ),
         ),
       ],
     ),
    );
  }

}