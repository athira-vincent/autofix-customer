import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MechanicStartedServiceScreen extends StatefulWidget {

  MechanicStartedServiceScreen();

  @override
  State<StatefulWidget> createState() {
    return _MechanicStartedServiceScreenState();
  }
}

class _MechanicStartedServiceScreenState extends State<MechanicStartedServiceScreen> {

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
        top: size.height * 3.4 / 100,
      ),
      child: Text("Mechanic start repair",style: TextStyle(
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
                "Hi.. John Eric congratulations!  Your mechanic started repair your vehicle . Wait for the count down stop.",
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
      color: Colors.lightGreen,
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
              Text("George Dola", style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontFamily: "Samsung_SharpSans_Medium",
                fontWeight: FontWeight.bold,
              ),),
              Text("Started repair", style: TextStyle(
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

  /*Widget customerApprovedScreenTimer(Size size){
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
  }*/

}