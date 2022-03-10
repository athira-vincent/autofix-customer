import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/ServiceList/service_list_bloc.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/ServiceList/service_list_mdl.dart';
import 'package:auto_fix/Widgets/screen_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class RegularServiceListScreen extends StatefulWidget {

  RegularServiceListScreen();

  @override
  State<StatefulWidget> createState() {
    return _RegularServiceListScreenState();
  }
}

class _RegularServiceListScreenState extends State<RegularServiceListScreen> {


  final ServiceListBloc _serviceListBloc = ServiceListBloc();

  late List<EmeregencyOrRegularServiceList> regularServiceList ;

  /*List regularServiceList = [
    "Service 1",
    "Service 2",
    "Service 3",
    "Service 4",
    "Service 5",
    "Service 6",
    "Service 7",
    "Service 8",
    "Service 9",
    "Service 10",
    "Service 11",
    "Service 12",
  ];*/
  String title = "";
  List selectedServiceList = [];
  List<bool>? _regularIsChecked;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _serviceListBloc.postServiceListRequest("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NzIsImlhdCI6MTY0NjkxMDcwNCwiZXhwIjoxNjQ2OTk3MTA0fQ.9i53B_oDKlP7ZXJJCG9fsY4RTopHcMKFp0cdxqhiMGA", "1");

    _listenServiceListResponse();
    _regularIsChecked = List<bool>.filled(regularServiceList.length, false);
  }


  _listenServiceListResponse() {
    _serviceListBloc.postServiceList.listen((value) {
      if (value.status == "error") {
        setState(() {
          //SnackBarWidget().setMaterialSnackBar( "${value.message}", _scaffoldKey);
          print("message postSignUpCustomerIndividual >>>>>>>  ${value.message}");
          print("errrrorr postSignUpCustomerIndividual >>>>>>>  ${value.status}");
          //_isLoading = false;
        });

      } else {

        setState(() {
          print("success postSignUpCustomerIndividual >>>>>>>  ${value.status}");
          //print("success Auth token >>>>>>>  ${value.data!.customersSignUpIndividual!.token.toString()}");

          //_isLoading = false;
          regularServiceList = value.data!.emeregencyOrRegularServiceList!;
          //_serviceListBloc.userDefault(value.data!.customersSignUpIndividual!.token.toString());
          //SnackBarWidget().setMaterialSnackBar( "Successfully Registered", _scaffoldKey);

        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
        body: Container(
          height: size.height,
          width:  size.width,
          color: Colors.white,
          child: Container(
            margin: EdgeInsets.only(
                top: size.height * 0.033,
                bottom: size.height * 0.027,
                left: size.width * 0.06,
                right: size.width * 0.06,
            ),
            color: Colors.white,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text("Select regular Services",
                        style: Styles.serviceSelectionTitle01Style,)),
                ),

                Container(
                  margin: EdgeInsets.only(
                    top: size.height * 0.026,
                    left: size.width * 0.025,
                    right: size.width * 0.078,
                  ),
                  height: ScreenSize().setValue(36.3),
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
                        margin: EdgeInsets.only(left: ScreenSize().setValue(20)),
                        child: Icon(
                          Icons.search,
                          size: 20,
                          color: CustColors.light_navy,
                        ),
                      ),
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.only(left: ScreenSize().setValue(15)),
                          alignment: Alignment.center,
                          height: ScreenSize().setValue(36.3),
                          child: Center(
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              textAlignVertical: TextAlignVertical.center,
                              /*onChanged: (text) {
                                           setState(() {
                                             makeDetails!.clear();
                                             //_countryData.clear();
                                             _loadingBrand = true;
                                           });
                                           _allMakeBloc.searchMake(text);
                                         },*/
                              textAlign: TextAlign.left,
                              style: Styles.searchTextStyle01,
                              decoration: InputDecoration(
                                hintText: "Search Your Service",
                                border: InputBorder.none,
                                contentPadding: new EdgeInsets.only(bottom: 15),
                                hintStyle: Styles.searchTextStyle01
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                        top: size.height * 0.023,
                        bottom: size.height * 0.019
                    ),
                    color: CustColors.pale_grey,
                    height: size.height * 0.82, //0.764
                    child: Container(
                      margin: EdgeInsets.only(
                        left: size.width * 0.049,
                        right: size.width * 0.049,
                        //top: size.height * 0.03,
                        bottom: size.height * 0.032
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                                child:  regularServiceList.length != 0
                                    ? ListView.separated(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: regularServiceList.length,
                                  itemBuilder: (context, index) {
                                    //print(regularServiceList[index].minAmount.toString() + ">>>Min amt");
                                    //print(regularServiceList[index].isEditable.toString() + ">>>isEditable amt");
                                    //_rateController.text = regularServiceList![index].minAmount.toString();
                                    return InkWell(
                                        onTap: () {
                                          final brandName = regularServiceList[index];
                                          //final brandId = regularServiceList[index].id;
                                          /* setState(() {
                                         _brandController.text =
                                             brandName.toString();
                                         selectedBrandId =
                                             int.parse(brandId!);
                                         _modelController.clear();
                                         selectedModelId = 0;
                                         _engineController.clear();
                                         selectedEngineId = 0;
                                         _allModelBloc
                                             .postAllModelDataRequest(
                                             selectedBrandId!,
                                             token);
                                       });*/
                                          print(">>>>>");
                                          //print(brandId);
                                          //Navigator.pop(context);
                                        },
                                        child: Container(
                                          /*margin: EdgeInsets.only(
                                            left: 5,
                                            right: 5,
                                          ),*/
                                          child: Row(
                                            children: [
                                              Transform.scale(
                                                scale: .8,
                                                child: Checkbox(
                                                  value: _regularIsChecked![index],
                                                  onChanged: (bool? val){
                                                    setState(() {
                                                      this._regularIsChecked![index] = val!;
                                                      //isChecked ? false : true;
                                                      val ?
                                                      selectedServiceList.add(regularServiceList[index])
                                                          :
                                                      selectedServiceList.remove(regularServiceList[index]);
                                                      print(">>>>>>>>> Selected Make List data " + regularServiceList.length.toString());
                                                    });
                                                  },
                                                ),
                                              ),

                                              Text(
                                                '${regularServiceList[index].toString()}',
                                                style: Styles.searchTextStyle02,
                                              ),
                                              SizedBox(
                                                width: size.width / 100 * 20,
                                              ),
                                              Text("2000 "),
                                              SizedBox(
                                                width: size.width / 100 * 5,
                                              ),
                                              Text("00 : 30")
                                            ],
                                          ),
                                        ));
                                  },
                                  separatorBuilder: (BuildContext context, int index) {
                                    return Container(
                                        margin: EdgeInsets.only(
                                            top: ScreenSize().setValue(10),
                                            left: 5,
                                            right: 5,
                                            bottom: ScreenSize().setValue(10)),
                                        child: Divider(
                                          height: 0,
                                        ));
                                  },
                                )
                                    : Center(
                                    child: Text('No Results found.'),
                                ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                selectedServiceList.length >= 3
                    ?
                InkWell(
                  onTap: (){
                    // Map<List<AllServiceFeeData>?, String> myData = new Map();
                    //SelectedData data = SelectedData(selectedServiceList,"rate");
                    //Navigator.pop(context, "data");
                  },
                  child: Container(
                    height: size.height * 0.045,
                    width: size.width * 0.246,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 8, bottom: 6,left: 75,right: 75),
                    //padding: EdgeInsets.only(left: 20, right: 20),
                    decoration: BoxDecoration(
                      color: CustColors.light_navy,
                      border: Border.all(
                        color: CustColors.blue,
                        style: BorderStyle.solid,
                        width: 0.70,
                      ),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child:  Text(
                      "Next",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Corbel_Bold',
                          fontSize:
                          ScreenSize().setValueFont(14.5),
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                )
                    :
                Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }

}