import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/UI/Mechanic/BottomBar/Home/mechanic_home_bloc.dart';
import 'package:auto_fix/Widgets/CurvePainter.dart';
import 'package:auto_fix/Widgets/screen_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../Constants/cust_colors.dart';
import '../../../../Constants/styles.dart';
import 'package:auto_fix/UI/Mechanic/BottomBar/Home/upcoming_services_mdl.dart';


class MechanicMyServicesScreen extends StatefulWidget {

  MechanicMyServicesScreen();

  @override
  State<StatefulWidget> createState() {
    return _MechanicMyServicesScreenState();
  }
}

class _MechanicMyServicesScreenState extends State<MechanicMyServicesScreen> {


  double per = .10;
  double perfont = .10;
  double height = 0;
  String selectedService = "1";

  double totalFees = 0.0;
  String authToken="",mechanicId = "";

  bool isLoadingCompletedServices = true,isLoadingUpcomingServices = true,isLoadingAllServices = true;

  Data? CustomerCompletedServicesList,CustomerUpcomingServicesList,CustomerAllServicesList;

  HomeMechanicBloc _mechanicHomeBloc = HomeMechanicBloc();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
      mechanicId = shdPre.getString(SharedPrefKeys.userID).toString();

      print('userFamilyId'+authToken.toString());
      _mechanicHomeBloc.postMechanicUpComingServiceRequest("$authToken", "0", mechanicId);
      _mechanicHomeBloc.postMechanicCompletedServiceRequest("$authToken", "0", mechanicId);
      _mechanicHomeBloc.postMechanicAllServiceRequest("$authToken", "0", mechanicId);
    });
  }

  _listenServiceListResponse() {
    _mechanicHomeBloc.postMechanicCompletedServiceResponse.listen((value) {
      if (value.status == "error") {
        setState(() {
          isLoadingCompletedServices = false;
        });
      } else {

        setState(() {
          isLoadingCompletedServices = false;
          CustomerCompletedServicesList = value.data;
        });

      }

    });
    _mechanicHomeBloc.postMechanicUpComingServiceResponse.listen((value) {
      if (value.status == "error") {
        setState(() {
          isLoadingUpcomingServices = false;
        });

      } else {

        setState(() {
          isLoadingUpcomingServices = false;
          CustomerUpcomingServicesList = value.data;
        });
      }

    });
    _mechanicHomeBloc.postMechanicAllServiceResponse.listen((value) {
      if (value.status == "error") {

        setState(() {
          isLoadingAllServices = false;
        });
      } else {
        setState(() {
          isLoadingAllServices = false;
          CustomerAllServicesList = value.data;
        });

      }

    });
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: [
                appBarCustomUi(size),
                tabTitleBarCustomUi(size),
                tabBodyCustomUi(size),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget appBarCustomUi(Size size) {
    return Padding(
      padding: const EdgeInsets.only(left: 20,top: 10),
      child: Row(
        children: [
          Text(
            'My Services',
            textAlign: TextAlign.center,
            style: Styles.appBarTextBlack,
          ),
          Spacer(),

        ],
      ),
    );
  }

  Widget tabTitleBarCustomUi(Size size) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15,5,15,0),
      child: Container(
        height: 40,
        child: Row(
          children: [
            Container(
              width: 120,
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
                        child: Text('Upcoming Services',
                          style: selectedService == "1" ? Styles.textLabelSubTitlenavy : Styles.textLabelSubTitlegrey,
                        )
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
            SizedBox(width: 2,),
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
                        child: Text('Completed Services',
                          style: selectedService == "2" ? Styles.textLabelSubTitlenavy : Styles.textLabelSubTitlegrey,)
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
            SizedBox(width: 2,),
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
                          child: Text('All Services',
                            style: selectedService == "3" ? Styles.textLabelSubTitlenavy : Styles.textLabelSubTitlegrey,
                          )
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
    );
  }

  Widget tabBodyCustomUi(Size size) {

    return selectedService == "1"
        ? CustomerUpcomingServices(size)
        : selectedService == "2"
        ? CustomerCompletedServices(size)
        : CustomerAllServices(size);


  }


  Widget CustomerUpcomingServices(Size size) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10,0,10,0),
      child: Container(
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
            color: CustColors.whiteBlueish,
            borderRadius: BorderRadius.circular(11.0)
        ),
        height: MediaQuery.of(context).size.height * 0.80,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5,5,5,5),
          child:
          isLoadingUpcomingServices == true
              ? progressBarDarkBlue()
              : Container(
                 child: CustomerUpcomingServicesList?.upcomingCompletedServices?.length == 0 || CustomerUpcomingServicesList?.upcomingCompletedServices?.length == null
                ? Container(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: double.infinity,
                      height: 200,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                              color:CustColors.materialBlue, spreadRadius: 1),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 220,
                            height: 170,
                            child: SvgPicture.asset(
                              "assets/image/NoSerivice.svg",
                              fit: BoxFit.contain,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                : ListView.builder(
                  itemCount:CustomerUpcomingServicesList?.upcomingCompletedServices?.length,
                  shrinkWrap: true,
                  // physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context,index,) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(0,10,0,10),
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(11.0)
                        ),
                        child:Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Text('Customer',
                                        maxLines: 2,
                                        textAlign: TextAlign.start,
                                        overflow: TextOverflow.visible,
                                        style: Styles.textLabelTitle_12,
                                      ),
                                    ),
                                    SizedBox(height: 5,),
                                    Container(
                                      child: Text('${CustomerUpcomingServicesList?.upcomingCompletedServices?[index].customer?.firstName} ${CustomerUpcomingServicesList?.upcomingCompletedServices?[index].customer?.lastName}',
                                        maxLines: 2,
                                        textAlign: TextAlign.start,
                                        overflow: TextOverflow.visible,
                                        style: Styles.textLabelSubTitlegrey11,
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                    /*Container(
                                                child: Text('Address',
                                                  maxLines: 2,
                                                  textAlign: TextAlign.start,
                                                  overflow: TextOverflow.visible,
                                                  style: Styles.textLabelTitle_12,
                                                ),
                                              ),
                                              SizedBox(height: 5,),
                                              Container(
                                                width: 150,
                                                child: Text('Elenjikkal House '
                                                    'Empyreal Garden '
                                                    'Opposite of Ceevees International Auditorium Anchery'
                                                    'Anchery P.O'
                                                    'Thrissur - 680006',
                                                  maxLines: 4,
                                                  textAlign: TextAlign.start,
                                                  overflow: TextOverflow.visible,
                                                  style: Styles.textLabelSubTitlegrey11,
                                                ),
                                              ),*/
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      color: CustColors.greyText1,
                                      width: 1,
                                      height: 100,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              child: Text('Car',
                                                maxLines: 2,
                                                textAlign: TextAlign.start,
                                                overflow: TextOverflow.visible,
                                                style: Styles.textLabelTitle_12,
                                              ),
                                            ),
                                            SizedBox(height: 5,),
                                            Container(
                                              width: 100,
                                              child: Text('${CustomerUpcomingServicesList?.upcomingCompletedServices?[index].vehicle?.brand}',
                                                maxLines: 2,
                                                textAlign: TextAlign.start,
                                                overflow: TextOverflow.visible,
                                                style: Styles.textLabelSubTitlegrey11,
                                              ),
                                            ),
                                            SizedBox(height: 5,),
                                            Container(
                                              child: Text('Cost',
                                                maxLines: 2,
                                                textAlign: TextAlign.start,
                                                overflow: TextOverflow.visible,
                                                style: Styles.textLabelTitle_12,
                                              ),
                                            ),
                                            SizedBox(height: 5,),
                                            Container(
                                              child: Text('${CustomerUpcomingServicesList?.upcomingCompletedServices?[index].totalPrice}',
                                                maxLines: 2,
                                                textAlign: TextAlign.start,
                                                overflow: TextOverflow.visible,
                                                style: Styles.textLabelSubTitlegrey11,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.only(left:15),
                                          child: Padding(
                                            padding: const EdgeInsets.all(0),
                                            child: Column(
                                              children: [
                                                Container(
                                                  height: 25,
                                                  width: 50,
                                                  alignment: Alignment.center,
                                                  color: CustColors.blue,
                                                  child: Text('Emergency Service',
                                                    textAlign: TextAlign.center,
                                                    style: Styles.badgeTextStyle2,
                                                  ),
                                                ),
                                                SizedBox(height: 5,),
                                                Stack(
                                                  alignment: Alignment.topCenter,
                                                  children: [
    
                                                    Container(
                                                      height: 50,
                                                      width: 50,
                                                      color: Colors.white,
                                                      child: CustomPaint(
                                                        painter: CurvePainter(),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Text(
                                                        '22/03/22',
                                                        textAlign: TextAlign.center,
                                                        style: Styles.badgeTextStyle1,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5,),
                                  ],
                                ),
                              ),
    
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
          ),
        ),
      ),
    );
  }

  Widget CustomerCompletedServices(Size size) {
    return  Padding(
      padding: const EdgeInsets.fromLTRB(10,0,10,0),
      child: Container(
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
            color: CustColors.whiteBlueish,
            borderRadius: BorderRadius.circular(11.0)
        ),
        height: MediaQuery.of(context).size.height * 0.80,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5,5,5,5),
          child:
          isLoadingCompletedServices == true
              ? progressBarDarkBlue()
              : Container(
            child:
            CustomerCompletedServicesList?.upcomingCompletedServices?.length == 0 || CustomerCompletedServicesList?.upcomingCompletedServices?.length == null
                ? Container(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: double.infinity,
                  height: 200,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                          color:CustColors.materialBlue, spreadRadius: 1),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 220,
                        height: 170,
                        child: SvgPicture.asset(
                          "assets/image/NoSerivice.svg",
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
                : ListView.builder(
              itemCount:CustomerCompletedServicesList?.upcomingCompletedServices?.length,
              shrinkWrap: true,
              // physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context,index,) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(0,10,0,10),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(11.0)
                    ),
                    child:Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text('Customer',
                                    maxLines: 2,
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.visible,
                                    style: Styles.textLabelTitle_12,
                                  ),
                                ),
                                SizedBox(height: 5,),
                                Container(
                                  child: Text('${CustomerCompletedServicesList?.upcomingCompletedServices?[index].customer?.firstName} ${CustomerUpcomingServicesList?.upcomingCompletedServices?[index].customer?.lastName}',
                                    maxLines: 2,
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.visible,
                                    style: Styles.textLabelSubTitlegrey11,
                                  ),
                                ),
                                SizedBox(height: 10,),
                                /*Container(
                                            child: Text('Address',
                                              maxLines: 2,
                                              textAlign: TextAlign.start,
                                              overflow: TextOverflow.visible,
                                              style: Styles.textLabelTitle_12,
                                            ),
                                          ),
                                          SizedBox(height: 5,),
                                          Container(
                                            width: 150,
                                            child: Text('Elenjikkal House '
                                                'Empyreal Garden '
                                                'Opposite of Ceevees International Auditorium Anchery'
                                                'Anchery P.O'
                                                'Thrissur - 680006',
                                              maxLines: 4,
                                              textAlign: TextAlign.start,
                                              overflow: TextOverflow.visible,
                                              style: Styles.textLabelSubTitlegrey11,
                                            ),
                                          ),*/
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  color: CustColors.greyText1,
                                  width: 1,
                                  height: 100,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Text('Car',
                                            maxLines: 2,
                                            textAlign: TextAlign.start,
                                            overflow: TextOverflow.visible,
                                            style: Styles.textLabelTitle_12,
                                          ),
                                        ),
                                        SizedBox(height: 5,),
                                        Container(
                                          width: 100,
                                          child: Text('${CustomerCompletedServicesList?.upcomingCompletedServices?[index].vehicle?.brand}',
                                            maxLines: 2,
                                            textAlign: TextAlign.start,
                                            overflow: TextOverflow.visible,
                                            style: Styles.textLabelSubTitlegrey11,
                                          ),
                                        ),
                                        SizedBox(height: 5,),
                                        Container(
                                          child: Text('Cost',
                                            maxLines: 2,
                                            textAlign: TextAlign.start,
                                            overflow: TextOverflow.visible,
                                            style: Styles.textLabelTitle_12,
                                          ),
                                        ),
                                        SizedBox(height: 5,),
                                        Container(
                                          child: Text('${CustomerCompletedServicesList?.upcomingCompletedServices?[index].totalPrice}',
                                            maxLines: 2,
                                            textAlign: TextAlign.start,
                                            overflow: TextOverflow.visible,
                                            style: Styles.textLabelSubTitlegrey11,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.only(left:15),
                                      child: Padding(
                                        padding: const EdgeInsets.all(0),
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 25,
                                              width: 50,
                                              alignment: Alignment.center,
                                              color: CustColors.blue,
                                              child: Text('Emergency Service',
                                                textAlign: TextAlign.center,
                                                style: Styles.badgeTextStyle2,
                                              ),
                                            ),
                                            SizedBox(height: 5,),
                                            Stack(
                                              alignment: Alignment.topCenter,
                                              children: [

                                                Container(
                                                  height: 50,
                                                  width: 50,
                                                  color: Colors.white,
                                                  child: CustomPaint(
                                                    painter: CurvePainter(),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    '22/03/22',
                                                    textAlign: TextAlign.center,
                                                    style: Styles.badgeTextStyle1,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5,),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget CustomerAllServices(Size size) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10,0,10,0),
      child: Container(
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
            color: CustColors.whiteBlueish,
            borderRadius: BorderRadius.circular(11.0)
        ),
        height: MediaQuery.of(context).size.height * 0.80,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5,5,5,5),
          child:
          isLoadingAllServices == true
              ? progressBarDarkBlue()
              : Container(
            child: CustomerAllServicesList?.upcomingCompletedServices?.length == 0 || CustomerAllServicesList?.upcomingCompletedServices?.length == null
                ? Container(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: double.infinity,
                  height: 200,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                          color:CustColors.materialBlue, spreadRadius: 1),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 220,
                        height: 170,
                        child: SvgPicture.asset(
                          "assets/image/NoSerivice.svg",
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
                : ListView.builder(
              itemCount:CustomerAllServicesList?.upcomingCompletedServices?.length,
              shrinkWrap: true,
              // physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context,index,) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(0,10,0,10),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(11.0)
                    ),
                    child:Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text('Customer',
                                    maxLines: 2,
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.visible,
                                    style: Styles.textLabelTitle_12,
                                  ),
                                ),
                                SizedBox(height: 5,),
                                Container(
                                  child: Text('${CustomerAllServicesList?.upcomingCompletedServices?[index].customer?.firstName} ${CustomerAllServicesList?.upcomingCompletedServices?[index].customer?.lastName}',
                                    maxLines: 2,
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.visible,
                                    style: Styles.textLabelSubTitlegrey11,
                                  ),
                                ),
                                SizedBox(height: 10,),
                                /*Container(
                                                  child: Text('Address',
                                                    maxLines: 2,
                                                    textAlign: TextAlign.start,
                                                    overflow: TextOverflow.visible,
                                                    style: Styles.textLabelTitle_12,
                                                  ),
                                                ),
                                                SizedBox(height: 5,),
                                                Container(
                                                  width: 150,
                                                  child: Text('Elenjikkal House '
                                                      'Empyreal Garden '
                                                      'Opposite of Ceevees International Auditorium Anchery'
                                                      'Anchery P.O'
                                                      'Thrissur - 680006',
                                                    maxLines: 4,
                                                    textAlign: TextAlign.start,
                                                    overflow: TextOverflow.visible,
                                                    style: Styles.textLabelSubTitlegrey11,
                                                  ),
                                                ),*/
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  color: CustColors.greyText1,
                                  width: 1,
                                  height: 100,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Text('Car',
                                            maxLines: 2,
                                            textAlign: TextAlign.start,
                                            overflow: TextOverflow.visible,
                                            style: Styles.textLabelTitle_12,
                                          ),
                                        ),
                                        SizedBox(height: 5,),
                                        Container(
                                          width: 100,
                                          child: Text('${CustomerAllServicesList?.upcomingCompletedServices?[index].vehicle?.brand}',
                                            maxLines: 2,
                                            textAlign: TextAlign.start,
                                            overflow: TextOverflow.visible,
                                            style: Styles.textLabelSubTitlegrey11,
                                          ),
                                        ),
                                        SizedBox(height: 5,),
                                        Container(
                                          child: Text('Cost',
                                            maxLines: 2,
                                            textAlign: TextAlign.start,
                                            overflow: TextOverflow.visible,
                                            style: Styles.textLabelTitle_12,
                                          ),
                                        ),
                                        SizedBox(height: 5,),
                                        Container(
                                          child: Text('${CustomerAllServicesList?.upcomingCompletedServices?[index].totalPrice}',
                                            maxLines: 2,
                                            textAlign: TextAlign.start,
                                            overflow: TextOverflow.visible,
                                            style: Styles.textLabelSubTitlegrey11,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.only(left:15),
                                      child: Padding(
                                        padding: const EdgeInsets.all(0),
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 25,
                                              width: 50,
                                              alignment: Alignment.center,
                                              color: CustColors.blue,
                                              child: Text('Emergency Service',
                                                textAlign: TextAlign.center,
                                                style: Styles.badgeTextStyle2,
                                              ),
                                            ),
                                            SizedBox(height: 5,),
                                            Stack(
                                              alignment: Alignment.topCenter,
                                              children: [

                                                Container(
                                                  height: 50,
                                                  width: 50,
                                                  color: Colors.white,
                                                  child: CustomPaint(
                                                    painter: CurvePainter(),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    '22/03/22',
                                                    textAlign: TextAlign.center,
                                                    style: Styles.badgeTextStyle1,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5,),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget progressBarDarkBlue() {
    return Container(
      height: 60.0,
      child: new Center(
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(CustColors.blue),
          )),
    );
  }


}
