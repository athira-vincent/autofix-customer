import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/UI/Common/add_more_service_list_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ScheduleRegularServiceScreen extends StatefulWidget {

  ScheduleRegularServiceScreen();

  @override
  State<StatefulWidget> createState() {
    return _ScheduleRegularServiceScreenState();
  }
}

class _ScheduleRegularServiceScreenState extends State<ScheduleRegularServiceScreen> {

  List<String> selectedServiceList = [];

  List<String> serviceTypeList = [
    "Mobile Mechanic",
    "Pick up & Drop off"
  ];

  String additionalServiceNames = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedServiceList.add("Car spray");
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
                  child: Stack(
                    children: [
                      Image.asset("assets/image/img_schedule_service_bg.png"),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            appBarUiWidget(size),
                            serviceCartWidget(size),
                            totalEstimateWidget(size),

                          ],
                      ),
                    ],
                  )
               ),
           )
         ),
        ),
    );
  }

  Widget appBarUiWidget(Size size){
    return Container(
      margin: EdgeInsets.only(
        left: size.width * 5 /100,
        // bottom: size.height * 1 /100,
        top: size.height * 2.5 / 100,
      ),
      child: Row(
        children: [
          InkWell(
            onTap:()
            {
              Navigator.pop(context);
            },
            child: Container(
              child: Icon(Icons.arrow_back, color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10,0,15,0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Schedule your service",
                  textAlign: TextAlign.start,
                  style: Styles.appBarTextWhite01,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget serviceCartWidget(Size size){
    return Container(
      margin: EdgeInsets.only(
        left: size.width * 6 /100,
        right: size.width * 6 /100,
        // bottom: size.height * 1 /100,
        top: size.height * 1 / 100,
      ),
      padding: EdgeInsets.only(
          left: size.width * 4 / 100,
          right: size.width * 2.5 / 100,
          top: size.height * 2.5 / 100,
          bottom: size.height * 2.5 / 100
      ),
          decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
              Radius.circular(1),
            ),
            boxShadow: [
              BoxShadow(
                color: CustColors.pinkish_grey03,
                spreadRadius: 0,
                blurRadius: 1.5,
              ),
            ],
            border: Border.all(
            color: CustColors.pinkish_grey03,
            width: 0.3,
          ),
        ),
      child: Column(
        children: [
          listHeaderWidget(size),

          selectedServiceList.length != 0
              ?
          ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: selectedServiceList.length,
            itemBuilder: (context, index) {
              return serviceListItemWidget(size,index);
            },
          )
              :
          Container(),

        ],

      ),
    );
  }

  Widget totalEstimateWidget(Size size){
    return Container(
      margin: EdgeInsets.only(
        left: size.width * 6 /100,
        right: size.width * 6 /100,
        // bottom: size.height * 1 /100,
        top: size.height * 1 / 100,
      ),
      padding: EdgeInsets.only(
          left: size.width * 4 / 100,
          right: size.width * 2.5 / 100,
          top: size.height * 2.5 / 100,
          bottom: size.height * 2.5 / 100
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(1),
        ),
        boxShadow: [
          BoxShadow(
            color: CustColors.pinkish_grey03,
            spreadRadius: 0,
            blurRadius: 1.5,
          ),
        ],
        border: Border.all(
          color: CustColors.pinkish_grey03,
          width: 0.3,
        ),
      ),
      child: Container(
        padding: EdgeInsets.only(
            bottom: size.height * 2.5 / 100
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text("Total service estimate"),
            ),
            Row(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: size.height * 8 / 100,
                  width: size.width * 12 / 100,
                  decoration: BoxDecoration(
                    color: CustColors.white_02,
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                    border: Border.all(
                      color: CustColors.pinkish_grey03,
                      width: 0.3,
                    ),
                  ),
                ),
                Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "abc",
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: "Samsung_SharpSans_Medium",
                        fontWeight: FontWeight.w200,
                        color: Colors.black,
                        wordSpacing: .5,
                        letterSpacing: .7,
                        height: 1.7,
                      ),
                    ),
                    SizedBox(
                      height: size.height * .3 / 100,
                    ),
                    Text("Estimated time",
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: "Samsung_SharpSans_Medium",
                        fontWeight: FontWeight.w200,
                        color: Colors.black,
                        wordSpacing: .5,
                        letterSpacing: .7,
                        height: 1.3,
                      ),
                    ),
                    Text("20:00 Min",
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: "SharpSans_Bold",
                        fontWeight: FontWeight.w200,
                        color: Colors.black,
                        wordSpacing: .5,
                        letterSpacing: .2,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
                Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: size.height * 2.5 / 100,
                    ),
                    Text("Estimated price",
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: "Samsung_SharpSans_Medium",
                        fontWeight: FontWeight.w200,
                        color: Colors.black,
                        wordSpacing: .5,
                        letterSpacing: .7,
                        height: 1.3,
                      ),
                    ),
                    Text("₦ 80",
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: "SharpSans_Bold",
                        fontWeight: FontWeight.w200,
                        color: Colors.black,
                        wordSpacing: .5,
                        letterSpacing: .2,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget listHeaderWidget(Size size){
    return Container(
      padding: EdgeInsets.only(
          bottom: size.height * 2.5 / 100
      ),
      child: Row(
        children: [
          Container(
            child: Text("Service cart ",
              style: TextStyle(
                  fontSize: 15,
                  fontFamily: "SharpSans_Bold",
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  letterSpacing: .4,
                  wordSpacing: .5
              ),
            ),
          ),
          Spacer(),
          Container(
            child: Text("Add more services",
              style: TextStyle(
                  fontSize: 12,
                  fontFamily: "Samsung_SharpSans_Medium",
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  letterSpacing: .4,
                  wordSpacing: .4
              ),
            ),
          ),
          SizedBox(
            width: size.width * .7 / 100,
          ),
          InkWell(
            onTap: (){
              print(" on Tap - Add More");
              _awaitReturnValueFromSecondScreenOnAdd(context);
            },
            child: SvgPicture.asset("assets/image/CustomerType/add_car_plus.svg",
              height: size.height * 4 / 100,),
          ),
        ],
      ),
    );
  }

  Widget serviceListItemWidget(Size size, int index){
    return Container(
      padding: EdgeInsets.all(2.5),
      margin:  EdgeInsets.only(top: 1,bottom: 1),
      color: CustColors.azure,
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset("assets/image/ic_delete_blue_white.png",
            height: size.height * 3.5 / 100,
          ),
          Container(
            height: size.height * 8 / 100,
            width: size.width * 12 / 100,
            decoration: BoxDecoration(
              color: CustColors.white_02,
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
              border: Border.all(
                color: CustColors.pinkish_grey03,
                width: 0.3,
              ),
            ),
          ),
          Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                selectedServiceList[index],
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: "Samsung_SharpSans_Medium",
                  fontWeight: FontWeight.w200,
                  color: Colors.black,
                  wordSpacing: .5,
                  letterSpacing: .7,
                  height: 1.7,
                ),
              ),
              SizedBox(
                height: size.height * .3 / 100,
              ),
              Text("Estimated time",
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: "Samsung_SharpSans_Medium",
                  fontWeight: FontWeight.w200,
                  color: Colors.black,
                  wordSpacing: .5,
                  letterSpacing: .7,
                  height: 1.3,
                ),
              ),
              Text("20:00 Min",
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: "SharpSans_Bold",
                  fontWeight: FontWeight.w200,
                  color: Colors.black,
                  wordSpacing: .5,
                  letterSpacing: .2,
                  height: 1.3,
                ),
              ),
            ],
          ),
          Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 2.5 / 100,
              ),
              Text("Estimated price",
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: "Samsung_SharpSans_Medium",
                  fontWeight: FontWeight.w200,
                  color: Colors.black,
                  wordSpacing: .5,
                  letterSpacing: .7,
                  height: 1.3,
                ),
              ),
              Text("₦ 80",
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: "SharpSans_Bold",
                  fontWeight: FontWeight.w200,
                  color: Colors.black,
                  wordSpacing: .5,
                  letterSpacing: .2,
                  height: 1.3,
                ),

              ),
            ],
          ),
          Divider(
            color: CustColors.pinkish_grey04,
            height: 15,
          )
        ],
      ),
    );
  }

  void _awaitReturnValueFromSecondScreenOnAdd(BuildContext context) async {

    // start the SecondScreen and wait for it to finish with a result
    List<String> serviceList = [];
    serviceList.clear();
    additionalServiceNames = "";

    //_chooseVechicleSpecializedController.text="";
    serviceList = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddMoreServicesListScreen(isAddService: true,isMechanicApp: false,),
        ));

    setState(() {
      for(int i = 0; i < serviceList.length ; i++){

        selectedServiceList.add(serviceList[i]);

      }
      //selectedState = result;
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

}