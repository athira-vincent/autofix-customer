import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/text_strings.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/home_Bloc/home_customer_bloc.dart';
import 'package:auto_fix/UI/Customer/RegularServiceFlow/CommonScreensInRegular/ServiceDetailsScreens/cust_service_regular_details_screen.dart';
import 'package:auto_fix/Widgets/CurvePainter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../Constants/cust_colors.dart';
import '../../../../../Constants/styles.dart';
import '../../../../Models/customer_models/cust_completed_orders_model/customerCompletedOrdersListMdl.dart';

class CustomerMyServicesScreen extends StatefulWidget {

  CustomerMyServicesScreen();

  @override
  State<StatefulWidget> createState() {
    return _CustomerMyServicesScreenState();
  }
}

class _CustomerMyServicesScreenState extends State<CustomerMyServicesScreen> {


  double per = .10;
  double perfont = .10;
  double height = 0;
  String selectedService = "1";

  double totalFees = 0.0;
  String authToken="",userID="";

  bool isLoadingCompletedServices = true,isLoadingUpcomingServices = true,isLoadingAllServices = true;

  Data? CustomerCompletedServicesList,CustomerUpcomingServicesList,CustomerAllServicesList;

  final HomeCustomerBloc _homeCustomerBloc = HomeCustomerBloc();


  double _setValue(double value) {
    return value * per + value;
  }

  double _setValueFont(double value) {
    return value * perfont + value;
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    getSharedPrefData();
    super.didChangeDependencies();
    getSharedPrefData();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getSharedPrefData();
    _listenServiceListResponse();
  }

  @override
  void didUpdateWidget(covariant CustomerMyServicesScreen oldWidget) {
    // TODO: implement didUpdateWidget
    getSharedPrefData();
    super.didUpdateWidget(oldWidget);
  }

  Future<void> getSharedPrefData() async {
    print('getSharedPrefData');
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    setState(() {
      authToken = shdPre.getString(SharedPrefKeys.token).toString();
      userID = shdPre.getString(SharedPrefKeys.userID).toString();

      print('userFamilyId'+authToken.toString());
      _homeCustomerBloc.postCustomerCompletedOrdersRequest(authToken, 300, "0", "$userID");
      _homeCustomerBloc.postCustomerUpcomingOrdersRequest(authToken, 300, "1", "$userID");
      _homeCustomerBloc.postCustomerAllServicesOrdersRequest(authToken, 300, null, "$userID");

    });
  }

  _listenServiceListResponse() {
    _homeCustomerBloc.postCustomerCompletedOrdersResponse.listen((value) {
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
    _homeCustomerBloc.postCustomerUpcomingOrdersResponse.listen((value) {
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
    _homeCustomerBloc.postCustomerAllServicesOrdersResponse.listen((value) {
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
    return SafeArea(
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
          padding: const EdgeInsets.fromLTRB(5,5,5,50),
          child:
          isLoadingUpcomingServices == true
              ? progressBarDarkBlue()
              : Container(
                  child: CustomerUpcomingServicesList?.custCompletedOrders?.length == 0 || CustomerUpcomingServicesList?.custCompletedOrders?.length == null
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
                        itemCount:CustomerUpcomingServicesList?.custCompletedOrders?.length,
                        shrinkWrap: true,
                        // physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context,index,) {
                          return InkWell(
                            onTap: (){

                              /*if(CustomerUpcomingServicesList?.custCompletedOrders?[index].reqType == 1 ){
                                _firestore.collection("ResolMech").doc('${CustomerUpcomingServicesList?.custCompletedOrders?[index].id}').snapshots().listen((event) {
                                  print('_firestore');
                                  setState(() {

                                    firebaseScreen = event.get('mechanicFromPage');

                                    changeScreen();

                                  });
                                });


                              }*/


                              /*Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CustServiceRegularDetailsScreen(
                                      bookingId: '${CustomerUpcomingServicesList?.custCompletedOrders?[index].id}',
                                      firebaseCollection: CustomerUpcomingServicesList?.custCompletedOrders?[index].regularType.toString() == "1"
                                          ? TextStrings.firebase_pick_up :
                                      CustomerUpcomingServicesList?.custCompletedOrders?[index].regularType.toString() == "2"
                                          ? TextStrings.firebase_mobile_mech : TextStrings.firebase_take_vehicle,
                                    ),
                                  ));*/
                            },
                            child: Padding(
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
                                              child: Text('Mechanic',
                                                maxLines: 2,
                                                textAlign: TextAlign.start,
                                                overflow: TextOverflow.visible,
                                                style: Styles.textLabelTitle_12,
                                              ),
                                            ),
                                            SizedBox(height: 5,),
                                            Container(
                                              child: Text('${CustomerUpcomingServicesList?.custCompletedOrders?[index].mechanic?.firstName} ${CustomerUpcomingServicesList?.custCompletedOrders?[index].mechanic?.lastName}',
                                                maxLines: 2,
                                                textAlign: TextAlign.start,
                                                overflow: TextOverflow.visible,
                                                style: Styles.textLabelSubTitlegrey11,
                                              ),
                                            ),
                                            SizedBox(height: 10),
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
                                              height: 150,
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
                                                      child: Text('${CustomerUpcomingServicesList?.custCompletedOrders?[index].vehicle?.brand}',
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
                                                      child: Text('${CustomerUpcomingServicesList?.custCompletedOrders?[index].totalPrice}',
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
                                                        CustomerUpcomingServicesList?.custCompletedOrders?[index].reqType == 1 ?
                                                        Container(
                                                          height: 25,
                                                          width: 50,
                                                          alignment: Alignment.center,
                                                          color: CustColors.blue,
                                                          child: Text('Emergency Service',
                                                            textAlign: TextAlign.center,
                                                            style: Styles.badgeTextStyle2,
                                                          ),
                                                        )
                                                            :
                                                        Container(
                                                          height: 25,
                                                          width: 50,
                                                          alignment: Alignment.center,
                                                          color: CustColors.blue,
                                                          child: Text('Regular Service',
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
                                                                '${_homeCustomerBloc.dateMonthConverter02(CustomerUpcomingServicesList?.custCompletedOrders?[index].bookedDate).toString()}',
                                                                //'22/03/22',
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
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: double.infinity,
                                                  child: Text('Service',
                                                    maxLines: 2,
                                                    textAlign: TextAlign.start,
                                                    overflow: TextOverflow.visible,
                                                    style: Styles.textLabelTitle_12,
                                                  ),
                                                ),
                                                SizedBox(height: 5,),
                                                ListView.builder(
                                                  //itemCount:CustomerUpcomingServicesList?.custCompletedOrders?[index].bookService?.length != 0 ? 1 : 0,
                                                  itemCount:CustomerUpcomingServicesList?.custCompletedOrders?[index].bookService?.length,
                                                  shrinkWrap: true,
                                                  physics: NeverScrollableScrollPhysics(),
                                                  itemBuilder: (context,index001,) {
                                                    return Container(
                                                      child: Text('${CustomerUpcomingServicesList?.custCompletedOrders?[index].bookService?[index001].service?.serviceName}',
                                                        maxLines: 2,
                                                        textAlign: TextAlign.start,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: Styles.textLabelSubTitlegrey12,
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ],
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
          padding: const EdgeInsets.fromLTRB(5,5,5,50),
          child:
          isLoadingCompletedServices == true
              ? progressBarDarkBlue()
              : Container(
                  child:
                  CustomerCompletedServicesList?.custCompletedOrders?.length == 0 || CustomerCompletedServicesList?.custCompletedOrders?.length == null
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
                          itemCount:CustomerCompletedServicesList?.custCompletedOrders?.length,
                          shrinkWrap: true,
                          // physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context,index,) {
                            return InkWell(
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CustServiceRegularDetailsScreen(
                                          bookingId: '${CustomerCompletedServicesList?.custCompletedOrders?[index].id}',
                                          firebaseCollection: CustomerCompletedServicesList?.custCompletedOrders?[index].regularType.toString() == "1"
                                              ? TextStrings.firebase_pick_up :
                                          CustomerCompletedServicesList?.custCompletedOrders?[index].regularType.toString() == "2"
                                              ? TextStrings.firebase_mobile_mech : TextStrings.firebase_take_vehicle,
                                        ),
                                      ));
                                },
                              child: Padding(
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
                                                child: Text('Mechanic',
                                                  maxLines: 2,
                                                  textAlign: TextAlign.start,
                                                  overflow: TextOverflow.visible,
                                                  style: Styles.textLabelTitle_12,
                                                ),
                                              ),
                                              SizedBox(height: 5,),
                                              Container(
                                                child: Text('${CustomerCompletedServicesList?.custCompletedOrders?[index].mechanic?.firstName.toString()}',
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
                                                height: 150,
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
                                                        child: Text('${CustomerCompletedServicesList?.custCompletedOrders?[index].vehicle?.brand}',
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
                                                        child: Text('${CustomerCompletedServicesList?.custCompletedOrders?[index].totalPrice}',
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
                                                          CustomerCompletedServicesList?.custCompletedOrders?[index].reqType == 1 ?
                                                          Container(
                                                            height: 25,
                                                            width: 50,
                                                            alignment: Alignment.center,
                                                            color: CustColors.blue,
                                                            child: Text('Emergency Service',
                                                              textAlign: TextAlign.center,
                                                              style: Styles.badgeTextStyle2,
                                                            ),
                                                          )
                                                              :
                                                          Container(
                                                            height: 25,
                                                            width: 50,
                                                            alignment: Alignment.center,
                                                            color: CustColors.blue,
                                                            child: Text('Regular Service',
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
                                                                  '${_homeCustomerBloc.dateMonthConverter02(CustomerCompletedServicesList?.custCompletedOrders?[index].bookedDate).toString()}',
                                                                 // '22/03/22',
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
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: double.infinity,
                                                    child: Text('Service',
                                                      maxLines: 2,
                                                      textAlign: TextAlign.start,
                                                      overflow: TextOverflow.visible,
                                                      style: Styles.textLabelTitle_12,
                                                    ),
                                                  ),
                                                  SizedBox(height: 5,),
                                                  ListView.builder(
                                                    itemCount:CustomerCompletedServicesList?.custCompletedOrders?[index].bookService?.length !=0?1:0,
                                                    shrinkWrap: true,
                                                    physics: NeverScrollableScrollPhysics(),
                                                    itemBuilder: (context,index,) {
                                                      return Container(
                                                        child: Text('${CustomerCompletedServicesList?.custCompletedOrders?[index].bookService?[0].service?.serviceName}',
                                                          maxLines: 2,
                                                          textAlign: TextAlign.start,
                                                          overflow: TextOverflow.ellipsis,
                                                          style: Styles.textLabelSubTitlegrey11,
                                                        ),
                                                      );
                                                    },
                                                  ),

                                                ],
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
                  child: CustomerAllServicesList?.custCompletedOrders?.length == 0 || CustomerAllServicesList?.custCompletedOrders?.length == null
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
                        itemCount:CustomerAllServicesList?.custCompletedOrders?.length,
                        shrinkWrap: true,
                        // physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context,index01,) {
                          return InkWell(
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CustServiceRegularDetailsScreen(
                                        bookingId: '${CustomerAllServicesList?.custCompletedOrders?[index01].id}',
                                        firebaseCollection: CustomerAllServicesList?.custCompletedOrders?[index01].regularType.toString() == "1"
                                            ? TextStrings.firebase_pick_up :
                                        CustomerAllServicesList?.custCompletedOrders?[index01].regularType.toString() == "2"
                                            ? TextStrings.firebase_mobile_mech : TextStrings.firebase_take_vehicle,
                                      ),
                                    ));
                              },
                            child: Padding(
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
                                              child: Text('Mechanic',
                                                maxLines: 2,
                                                textAlign: TextAlign.start,
                                                overflow: TextOverflow.visible,
                                                style: Styles.textLabelTitle_12,
                                              ),
                                            ),
                                            SizedBox(height: 5,),
                                            Container(
                                              child: Text('${CustomerAllServicesList?.custCompletedOrders?[index01].mechanic?.firstName} ${CustomerAllServicesList?.custCompletedOrders?[index01].mechanic?.lastName}',
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
                                              height: 150,
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
                                                      child: Text('${CustomerAllServicesList?.custCompletedOrders?[index01].vehicle?.brand}',
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
                                                      child: Text('${CustomerAllServicesList?.custCompletedOrders?[index01].totalPrice}',
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
                                                        CustomerAllServicesList?.custCompletedOrders?[index01].reqType == 1 ?
                                                        Container(
                                                          height: 25,
                                                          width: 50,
                                                          alignment: Alignment.center,
                                                          color: CustColors.blue,
                                                          child: Text('Emergency Service',
                                                            textAlign: TextAlign.center,
                                                            style: Styles.badgeTextStyle2,
                                                          ),
                                                        )
                                                            :
                                                        Container(
                                                          height: 25,
                                                          width: 50,
                                                          alignment: Alignment.center,
                                                          color: CustColors.blue,
                                                          child: Text('Regular Service',
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
                                                                '${_homeCustomerBloc.dateMonthConverter02(CustomerAllServicesList?.custCompletedOrders?[index01].bookedDate).toString()}',
                                                               // '22/03/22',
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
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: double.infinity,
                                                  child: Text('Service',
                                                    maxLines: 2,
                                                    textAlign: TextAlign.start,
                                                    overflow: TextOverflow.visible,
                                                    style: Styles.textLabelTitle_12,
                                                  ),
                                                ),
                                                SizedBox(height: 5,),
                                                ListView.builder(
                                                  itemCount:CustomerAllServicesList?.custCompletedOrders?[index01].bookService?.length !=0?1:0,
                                                  shrinkWrap: true,
                                                  physics: NeverScrollableScrollPhysics(),
                                                  itemBuilder: (context,index,) {
                                                    return Container(
                                                      child: Text('${CustomerAllServicesList?.custCompletedOrders?[index].bookService?[0].service?.serviceName}',
                                                        maxLines: 2,
                                                        textAlign: TextAlign.start,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: Styles.textLabelSubTitlegrey11,
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ],
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
            valueColor: new AlwaysStoppedAnimation<Color>(CustColors.light_navy),
          )),
    );
  }

  /*void changeScreen(){
    if(firebaseScreen == "C1"){
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => FindYourCustomerScreen(
                latitude: firebaseCustomerLatitude*//*"10.0159"*//*,
                longitude: firebaseCustomerLongitude*//*"76.3419"*//*,
                //notificationPayloadMdl: widget.notificationPayloadMdl,
              )));
    }else if(firebaseScreen == "C2"){
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MechanicStartServiceScreen()));
    }else if(firebaseScreen == "C3"){
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>  CustomerApprovedScreen()
          )).then((value){
      });
    }else if(firebaseScreen == "C4"){
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MechanicWorkCompletedScreen()));
    }else if(firebaseScreen == "C5"){
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>  DirectPaymentScreen(isMechanicApp: true, isPaymentFailed: true,)
          )).then((value){

      });
    }else if(firebaseScreen == "C6"){
      print("Service Completed");
    }
  }*/

}
