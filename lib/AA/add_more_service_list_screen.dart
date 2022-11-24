import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/Models/mechanic_models/mechanic_Services_List_Mdl/mechanicServicesListMdl.dart';
import 'package:auto_fix/UI/Mechanic/BottomBar/MyProfile/profile_Mechanic_Bloc/mechanic_profile_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../Widgets/screen_size.dart';

class AddMoreServicesListScreen extends StatefulWidget {

  final bool isAddService;
  bool isMechanicApp;


  AddMoreServicesListScreen({ required this.isAddService,required this.isMechanicApp});

  @override
  State<StatefulWidget> createState() {
    return _AddMoreServicesListScreenState();
  }
}

class _AddMoreServicesListScreenState extends State<AddMoreServicesListScreen> {

  String authToken="", userId = "";
  String  bookingId = "";
  FirebaseFirestore _firestore = FirebaseFirestore.instance;


  //final HomeCustomerBloc _homeCustomerBloc = HomeCustomerBloc();
  MechanicProfileBloc _mechanicProfileBloc = MechanicProfileBloc();

  List<bool>? _serviceIsChecked;
  List<Datum>? selectedServiceList = [];


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
      userId = shdPre.getString(SharedPrefKeys.userID).toString();
      bookingId = shdPre.getString(SharedPrefKeys.bookingIdEmergency).toString();
      _mechanicProfileBloc.fetchServiceListOfMechanic(
          authToken,
          userId,
          "0",
          "200",
          "");

    });
    await _firestore.collection("ResolMech").doc('${bookingId}').snapshots().listen((event) {
      setState(() {

      });
    });
  }

  _listenServiceListResponse() {
    _mechanicProfileBloc.MechanicServicesBasedListResponse.listen((value) {
      if (value.status == "error") {
        setState(() {
          print("message postServiceList >>>>>>>  ${value.message}");
          print("errrrorr postServiceList >>>>>>>  ${value.status}");
        });
      } else {
        setState(() {

          _serviceIsChecked = List<bool>.filled(value.data!.mechanicServicesList!.data!.length, false);
          print("message postServiceList >>>>>>>  ${value.message}");
          print("errrrorr postServiceList >>>>>>>  ${value.status}");

        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Container(
          height: size.height,
          width: size.width,
          child: Container(
            margin: EdgeInsets.only(
              left: size.width * 6 / 100,
              right: size.width * 6 / 100,
              top: size.height * 3.3 / 100,
              bottom: size.height * 2 / 100,
            ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Add additional service",
                    style: TextStyle(
                      fontSize: 15.3,
                      fontFamily: "Samsung_SharpSans_Medium",
                      fontWeight: FontWeight.w600,
                      color: CustColors.light_navy,
                    ),
                  ),
                ),

                addServicesSearchArea(size),

                servicesListArea(size,context),

                widget.isAddService
                    ? InkWell(
                    onTap: (){
                      print("selected service list - length >>>>>>>>" + selectedServiceList!.length.toString());
                      Navigator.pop(context,selectedServiceList);
                    },
                    child: nextButton(size)
                )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget addServicesSearchArea(Size size,){
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(
          top: size.height * 0.026,
          left: size.width * 0.025,
          right: size.width * 0.078,
        ),
        height: ScreenSize().setValue(35),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(
              ScreenSize().setValue(5),
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: CustColors.pinkish_grey,
              spreadRadius: 0,
              blurRadius: 1.5,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(left: ScreenSize().setValue(18)),
              child: Icon(
                Icons.search,
                size: 18,
                color: CustColors.light_navy,
              ),
            ),
            Flexible(
              child: Container(
                margin: EdgeInsets.only(left: ScreenSize().setValue(14)),
                alignment: Alignment.center,
                height: ScreenSize().setValue(35),
                child: Center(
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    textAlignVertical: TextAlignVertical.center,
                    textAlign: TextAlign.left,
                    style: Styles.searchTextStyle01,
                    onChanged: (text) {

                      if (text != null && text.isNotEmpty && text != "" ) {
                        setState(() {
                          print('First text field: $text');
                          _mechanicProfileBloc.fetchServiceListOfMechanic(
                              authToken,
                              userId,
                              "0",
                              "200",
                              "$text");
                        });
                      }
                      else
                        {
                          setState(() {
                            print('no text field: $text');
                            _mechanicProfileBloc.fetchServiceListOfMechanic(
                                authToken,
                                userId,
                                "0",
                                "200",
                                "");
                          });
                        }

                    },
                    decoration: InputDecoration(
                        hintText: "Search Your  additional services ",
                        border: InputBorder.none,
                        contentPadding: new EdgeInsets.only(bottom: 16),
                        hintStyle: Styles.searchTextStyle01
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      /*child: Container(
                      margin: EdgeInsets.only(
                        left: size.width * 2.5 / 100,
                       // right: size.width * ,
                        top: size.height * 2.1 / 100,
                        //bottom: size.height * ,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                          border: Border.all(
                              color: CustColors.pinkish_grey,
                              width: 0.3
                          )
                      ),
                     // color: Colors.green,
                      child: Row(
                        children: [
                          SvgPicture.asset("assets/image/search_service.svg"),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            textAlignVertical: TextAlignVertical.center,
                            textAlign: TextAlign.left,
                            style: Styles.searchTextStyle01,
                            decoration: InputDecoration(
                                hintText: "Search Your Service",
                                border: InputBorder.none,
                                contentPadding: new EdgeInsets.only(bottom: 15),
                                hintStyle: Styles.searchTextStyle01
                            ),
                          ),
                        ],
                      ),

                    ),*/
    );
  }

  Widget servicesListArea(Size size, BuildContext context){
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(
         // left: size.width * 6 / 100,
        //  right: size.width * 6 / 100,
          top: size.height * 2.6 / 100,
          //bottom: size.height * 1.9 / 100,
        ),
        color: CustColors.pale_grey,
        child: StreamBuilder(
            stream:  _mechanicProfileBloc.MechanicServicesBasedListResponse,
            builder: (context, AsyncSnapshot<MechanicServicesBasedListMdl> snapshot) {
              print("${snapshot.hasData}");
              print("${snapshot.connectionState}");
              print("+++++++++++++++${snapshot.data?.data?.mechanicServicesList?.data?.length}++++++++++++++++");

              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator(color: CustColors.light_navy,));
                default:
                  return
                    snapshot.data?.data?.mechanicServicesList?.data?.length != 0 && snapshot.data?.data?.mechanicServicesList?.data?.length != null
                        ? mainServiceList(size, snapshot,context)
                        : Container();
              }
            }
        ),
      ),
    );
  }

  Widget mainServiceList(Size size, AsyncSnapshot<MechanicServicesBasedListMdl> snapshot, BuildContext context1,){
    return Container(
      margin: EdgeInsets.only(
        left: size.width * 5.9 / 100,
        right: size.width * 5.9 / 100,
        top: size.height * 3.7 / 100,
        // bottom: size.height * ,
      ),
      child:  snapshot.data?.data?.mechanicServicesList?.data?.length != 0 && snapshot.data?.data?.mechanicServicesList?.data?.length != null
          ? ListView.builder(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                //physics: NeverScrollableScrollPhysics(),
                itemCount:snapshot.data!.data!.mechanicServicesList?.data!.length,
                itemBuilder: (context, index) {
                  return serviceListItems(size, index, snapshot.data!.data!.mechanicServicesList?.data![index]);
                },
              )
          : Center(
             child: Text("No Results found."),
      ),
    );
  }

  Widget serviceListItems(Size size, int index, Datum? service,  ){
    return Column(
      children: [
        Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              widget.isAddService
                  ? Transform.scale(
                    scale: .6,
                    child: widget.isAddService
                        ? Checkbox(
                          activeColor: CustColors.light_navy,
                          value: _serviceIsChecked![index],
                          onChanged: (bool? val){
                            setState(() {
                              this._serviceIsChecked![index] = val!;
                              //isChecked ? false : true;
                              val
                                  ?
                                    selectedServiceList!.add(service!)
                                  : selectedServiceList!.remove(service);
                              print("sgsjhgj 001 $val");
                              print(">>>>>>>>> Selected Make List data " + selectedServiceList!.length.toString());
                            });
                          },
                        )
                        : Container(),
                  )
                  : Container(),

              Expanded(
                flex: 3,
                child: InkWell(
                  onTap: (){
                    print(">>>>> ");
                    if(widget.isAddService == false){
                      print(">>>>> widget.isAddService == false ");
                      selectedServiceList!.add(service!);
                       Navigator.pop(context,selectedServiceList);
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                      top: 2,bottom: 2.5
                    ),
                    child: Text(
                      '${service?.service?.serviceName}',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: "Samsung_SharpSans_Medium",
                        fontWeight: FontWeight.w400,
                        color: CustColors.almost_black
                      ),
                    ),
                  ),
                ),
              ),
              /*SizedBox(
                width: size.width / 100 * 18,
              ),*/


            ],
          ),
        ),
        Container(
            margin: EdgeInsets.only(
              top:5,
              bottom: 5,
              left: size.width * 3 / 100,
              right: size.width * 1 / 100,
              //bottom: ScreenSize().setValue(1),
            ),
            child: Divider(
              height: 1,
            ))
      ],
    ) ;
  }

  Widget nextButton(Size size){
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.only(
            right: size.width * 11.5 / 100,
            top: size.height * 1.9 / 100,
            bottom: size.height * .7 / 100
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(6),
            ),
            color: CustColors.light_navy
        ),
        padding: EdgeInsets.only(
          left: size.width * 5.9 / 100,
          right: size.width * 5.9 / 100,
          top: size.height * 1 / 100,
          bottom: size.height * 1 / 100,
        ),
        child: Text(
          "Next",
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
