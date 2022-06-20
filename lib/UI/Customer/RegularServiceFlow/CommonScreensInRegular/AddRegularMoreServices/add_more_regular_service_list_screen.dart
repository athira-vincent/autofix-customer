import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/home_Bloc/home_customer_bloc.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/home_Customer_Models/category_list_home_mdl.dart';
import 'package:auto_fix/UI/Mechanic/BottomBar/MyProfile/profile_Mechanic_Bloc/mechanic_profile_bloc.dart';
import 'package:auto_fix/Widgets/screen_size.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddMoreRegularServicesListScreen extends StatefulWidget {

  final bool isAddService;
  bool isMechanicApp;
  final CategoryList? categoryList;


  AddMoreRegularServicesListScreen({ required this.isAddService,required this.isMechanicApp,required this.categoryList});

  @override
  State<StatefulWidget> createState() {
    return _AddMoreRegularServicesListScreenState();
  }
}

class _AddMoreRegularServicesListScreenState extends State<AddMoreRegularServicesListScreen> {

  String authToken="", userId = "";
  String  bookingId = "";
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Service> selectedCategoryList =[];
  HomeCustomerBloc _homeCustomerBloc = HomeCustomerBloc();
  MechanicProfileBloc _mechanicProfileBloc = MechanicProfileBloc();



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('init>>>>>>');
    for(int i=0;i<widget.categoryList!.service!.length;i++)
      {
        print('init>>>>>> ${i}');
        print('init>>>>>> ${widget.categoryList!.service!.length}');
        if(widget.categoryList!.service![i].isChecked == true)
          {
            selectedCategoryList.add(widget.categoryList!.service![i]);
          }
      }
    getSharedPrefData();
  }

  Future<void> getSharedPrefData() async {
    print('getSharedPrefData');
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    setState(() {
      authToken = shdPre.getString(SharedPrefKeys.token).toString();
      userId = shdPre.getString(SharedPrefKeys.userID).toString();
      bookingId = shdPre.getString(SharedPrefKeys.bookingIdEmergency).toString();
    });
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Container(
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

              mainRegularSubServiceList(),

              widget.isAddService
                  ? InkWell(
                      onTap: (){
                        Navigator.pop(context,selectedCategoryList);
                      },
                      child: nextButton(size)
                  )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  Widget mainRegularSubServiceList(){
    return Expanded(
      child: Container(
        child:  widget.categoryList!.service!.length != 0 && widget.categoryList!.service!.length != null
            ? ListView.builder(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount:widget.categoryList!.service!.length,
                itemBuilder: (context, index) {
                  return  Column(
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
                                          value: widget.categoryList!.service![index].isChecked,
                                          onChanged: (bool? val){
                                            setState(() {
                                              this.widget.categoryList!.service![index].isChecked = val!;
                                              val
                                              ? selectedCategoryList.add(widget.categoryList!.service![index])
                                              : selectedCategoryList.remove(widget.categoryList!.service![index]);
                                              print("val 001 >>>>>  $val");
                                              print("selectedCategoryList 002 >>>>>  ${selectedCategoryList}");
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

                                },
                                child: Container(
                                  padding: EdgeInsets.only(
                                      top: 2,bottom: 2.5
                                  ),
                                  child: Text(
                                    '${widget.categoryList!.service![index].serviceName}',
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
                          ],
                        ),
                      ),
                      Container(
                          child: Divider(
                            height: 1,
                          ))
                    ],
                  ) ;
                },
              )
            : Center(
          child: Text("No Results found."),
        ),
      ),
    );
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

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

}
