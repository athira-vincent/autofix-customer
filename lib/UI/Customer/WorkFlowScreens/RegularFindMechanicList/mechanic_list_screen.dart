import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/home_Bloc/home_customer_bloc.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/home_Customer_Models/mechaniclist_for_services_Mdl.dart';
import 'package:auto_fix/UI/Customer/WorkFlowScreens/MechanicProfileView/mechanic_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MechanicListScreen extends StatefulWidget {

  final String bookingId;
  final String authToken;
  final List<String> serviceIds;
  final String serviceType;
  final String serviceModel;

  MechanicListScreen({required this.bookingId,
    required this.authToken,required this.serviceIds,
    required this.serviceType,required this.serviceModel});


  @override
  State<StatefulWidget> createState() {
    return _MechanicListScreenState();
  }
}

class _MechanicListScreenState extends State<MechanicListScreen> {


  final HomeCustomerBloc _homeCustomerBloc = HomeCustomerBloc();

  List<MechaniclistForService>? mechanicListForServices = [
    MechaniclistForService(id: "1",
      userCode: "012",firstName: "athira",
      lastName: "a",phoneNo: "123454676",emailId: "athira@gmail.com",
      state: "kerala",accountType: 1,userType: 1,isProfileCompleted: 1,profilePic: "",status: 1,
      mechanicService: [new MechanicService(id: "1",status: 1, fee: "2000", serviceId: 1, userId: 1)],
      mechanicVehicle: [new MechanicVehicle(status: 1, id: "1", makeId: 1)]
    ),
    MechaniclistForService(id: "12",
        userCode: "014",firstName: "Ammu",
        lastName: "a",phoneNo: "123454676",emailId: "ammu@gmail.com",
        state: "kerala",accountType: 1,userType: 1,isProfileCompleted: 1,profilePic: "",status: 1,
        mechanicService: [new MechanicService(id: "2",status: 1, fee: "2010", serviceId: 2, userId: 12)],
        mechanicVehicle: [new MechanicVehicle(status: 1, id: "3", makeId: 2)]
    ),
    MechaniclistForService(id: "12",
        userCode: "014",firstName: "BBB",
        lastName: "a",phoneNo: "123454676",emailId: "ammu@gmail.com",
        state: "kerala",accountType: 1,userType: 1,isProfileCompleted: 1,profilePic: "",status: 1,
        mechanicService: [new MechanicService(id: "2",status: 1, fee: "2010", serviceId: 2, userId: 12)],
        mechanicVehicle: [new MechanicVehicle(status: 1, id: "3", makeId: 2)]
    ),
    MechaniclistForService(id: "12",
        userCode: "014",firstName: "CCCCCC",
        lastName: "a",phoneNo: "123454676",emailId: "ammu@gmail.com",
        state: "kerala",accountType: 1,userType: 1,isProfileCompleted: 1,profilePic: "",status: 1,
        mechanicService: [new MechanicService(id: "2",status: 1, fee: "2010", serviceId: 2, userId: 12)],
        mechanicVehicle: [new MechanicVehicle(status: 1, id: "3", makeId: 2)]
    ),
  ];

  String waitingMechanic="1";

  String authToken = "";

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
     // _homeCustomerBloc.postFindMechanicsListEmergencyRequest("$authToken", widget.bookingId,widget.serviceIds,"regular");
    });
  }

  _listenServiceListResponse() {
    _homeCustomerBloc.findMechanicsListEmergencyResponse.listen((value) {
      if (value.status == "error") {
        setState(() {
          print("message postServiceList >>>>>>>  ${value.message}");
          print("errrrorr postServiceList >>>>>>>  ${value.status}");
          waitingMechanic = "0";
        });

      } else {

        setState(() {

          if(value.data?.mechaniclistForServices?.length==0)
          {
            waitingMechanic = "0";
          }
          else
          {
            waitingMechanic = "1";
          }

          print("message postServiceList >>>>>>>  ${value.message}");
          print("success postServiceList >>>>>>>  ${value.status}");

        });
      }
    });

  }


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
              //color: Colors.purpleAccent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    titleWidget(size),

                    waitingMechanic=="0" ? mechanicNotFountWidget(size) : mechanicListWidget(size),

                  ],
              ),
            ),
          ),
        ),
    );
  }

  Widget titleWidget(Size size){
    return Container(
      margin: EdgeInsets.only(
        left: size.width * 6 /100,
        // bottom: size.height * 1 /100,
        top: size.height * 3.4 / 100,
      ),
      child: Row(
        children: [
          InkWell(
            onTap:()
            {
              Navigator.pop(context);
            },
            child: Container(
              child: Icon(Icons.arrow_back, color: Colors.black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15,0,15,0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  waitingMechanic=="0" ? "Mechanic not found" : "Mechanic found",
                  textAlign: TextAlign.start,
                  style: Styles.waitingTextBlack17,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget mechanicNotFountWidget(Size size) {
    return Expanded(
      child: Container(
        //color: Colors.lightGreen,
        margin: EdgeInsets.only(
          left: size.width * 6 / 100,
          right: size.width * 6 / 100,
          top: size.height * 8 / 100,
          bottom: size.height * 3.5 / 100
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
                child: SvgPicture.asset(
                  'assets/image/img_oops_mechanic_bg.svg',
                  height: size.height * 27 / 100,
                  fit: BoxFit.cover,
                ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                margin: EdgeInsets.only(
                  left: size.width * 1 / 100,
                  right: size.width * 1 / 100,
                  top: size.height * 7 / 100
                ),
                height: size.height * 18 / 100,
                width: size.width,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                  color: CustColors.pale_grey,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Oops!! Mechanic not found!",
                      style: Styles.oopsmechanicNotFoundStyle01,
                    ),
                    Text("No mechanic in your region",
                      style: Styles.smallTitleStyle3,
                    ),
                    Text("Try after sometime!",
                      style: Styles.TryAfterSomeTimetyle01,
                    ),
                  ],
                ),
              ),
            ),
            tryAgainButtonWidget(size),
          ],
        ),
      ),
    );
  }

  Widget mechanicListWidget(Size size){
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            child: StreamBuilder(
                stream:  _homeCustomerBloc.findMechanicsListEmergencyResponse,
                builder: (context, AsyncSnapshot<MechaniclistForServicesMdl> snapshot) {
                  print("${snapshot.hasData}");
                  print("${snapshot.connectionState}");
                  switch (snapshot.connectionState) {
                  /*case ConnectionState.waiting: return progressBarLightRose();*/
                    default:
                      return
                        //snapshot.data?.data?.mechaniclistForServices?.length != 0 && snapshot.data?.data?.mechaniclistForServices?.length != null
                        mechanicListForServices!.length != 0 && mechanicListForServices!.length != null
                            ? ListView.builder(
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              //itemCount:snapshot.data?.data?.mechaniclistForServices?.length,
                              itemCount:mechanicListForServices?.length,
                              itemBuilder: (context, index) {
                              return InkWell(
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>  MechanicProfileViewScreen(
                                            //mechanicId: '${snapshot.data?.data?.mechaniclistForServices![index].id}',
                                            //mechaniclistForService: snapshot.data!.data!.mechaniclistForServices![index],
                                            authToken: '$authToken',
                                            isEmergency: false,
                                            mechaniclistForService: mechanicListForServices![0],
                                            mechanicId: "1",serviceModel: widget.serviceModel,

                                          )));

                                },
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(10,6,10,0),
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: CustColors.whiteBlueish,
                                        borderRadius: BorderRadius.circular(11.0)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(0),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(10,10,10,10),
                                            child: Container(
                                              width: 75.0,
                                              height: 75.0,
                                              child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(20.0),
                                                  child:Container(
                                                      child:CircleAvatar(
                                                          radius: 45,
                                                          backgroundColor: Colors.white,
                                                          child: ClipOval(
                                                            child:  SvgPicture.asset('assets/image/MechanicType/work_selection_avathar.svg'),
                                                          )))

                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(2),
                                                    child: Text('${mechanicListForServices![index].firstName}',
                                                      style: Styles.mechanicNameStyle,
                                                      maxLines: 1,
                                                      textAlign: TextAlign.start,
                                                      overflow: TextOverflow.visible,),
                                                  ),

                                                  Container(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [

                                                        Padding(
                                                          padding: const EdgeInsets.fromLTRB(0,0,0,0),
                                                          child: RatingBar.builder(
                                                            initialRating: 3.5,
                                                            minRating: 1,
                                                            direction: Axis.horizontal,
                                                            allowHalfRating: true,
                                                            itemCount: 5,
                                                            itemSize: 12,
                                                            itemPadding: EdgeInsets.symmetric(horizontal: 1),
                                                            itemBuilder: (context, _) => Icon(
                                                              Icons.star,
                                                              color: CustColors.blue,
                                                            ),
                                                            onRatingUpdate: (rating) {
                                                              print(rating);
                                                            },
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.fromLTRB(0,0,0,0),
                                                          child: Text('1280 Reviews',
                                                            style: Styles.smallTitleStyle1,),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 100,
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.fromLTRB(0,0,0,0),
                                                        child: Text('120 km',
                                                          style: Styles.smallTitleStyle1,),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.fromLTRB(0,0,0,0),
                                                        child: Text('12 min',
                                                          style: Styles.smallTitleStyle1,),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.fromLTRB(0,3,0,3),
                                                        child: Text('₦ 1245',
                                                          style: Styles.totalAmountStyle,),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                              },
                            )
                            : mechanicNotFountWidget(size);
                  }
                }),
          ),
        ],
      ),
    );
  }

  Widget tryAgainButtonWidget(Size size){
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        margin: EdgeInsets.only(
            //right: size.width * 6.2 / 100,
            top: size.height * 22 / 100
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(6),
            ),
            color: CustColors.light_navy
        ),
        padding: EdgeInsets.only(
          left: size.width * 4 / 100,
          right: size.width * 4 / 100,
          top: size.height * 1 / 100,
          bottom: size.height * 1 / 100,
        ),
        child: Text(
          "Try again",
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

  Widget progressBarLightRose() {
    return Container(
      height: 60.0,
      child: new Center(
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(CustColors.blue),
          )),
    );
  }

}