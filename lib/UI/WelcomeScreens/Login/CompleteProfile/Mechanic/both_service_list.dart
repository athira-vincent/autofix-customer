import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/AddServices/add_services_bloc.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/ServiceList/service_list_bloc.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/ServiceList/service_list_mdl.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/wait_admin_approval_screen.dart';
import 'package:auto_fix/Widgets/screen_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';



class BothServiceListScreen extends StatefulWidget {

  BothServiceListScreen();

  @override
  State<StatefulWidget> createState() {
    return _BothServiceListScreenState();
  }
}

class _BothServiceListScreenState extends State<BothServiceListScreen> {


  final ServiceListBloc _serviceListBloc = ServiceListBloc();
  final MechanicAddServiceListBloc _addServiceListBloc = MechanicAddServiceListBloc();


  List<EmeregencyOrRegularServiceList> allServiceList = [];
  List<EmeregencyOrRegularServiceList> emergencyServiceList = [];
  List<EmeregencyOrRegularServiceList> regularServiceList = [];

  List<EmeregencyOrRegularServiceList> selectedRegularServiceList = [];
  List<EmeregencyOrRegularServiceList> selectedEmergencyServiceList = [];

  String title = "";
  late bool isRegularSelected;

  List<bool>? _regularIsChecked;
  List<bool>? _emergencyIsChecked;
  List<SelectedServicesMdl> selectedServiceMdlRegularList=[];
  List<SelectedServicesMdl> selectedServiceMdlEmergencyList=[];

  String authToken="";
  bool _isLoading = false;
  double per = .10;
  double _setValue(double value) {
    return value * per + value;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isRegularSelected = false;
    getSharedPrefData();
    _listenServiceListResponse();
    _listenAddServiceListResponse();

    _regularIsChecked = List<bool>.filled(regularServiceList.length, false);
    _emergencyIsChecked = List<bool>.filled(emergencyServiceList.length, false);
  }

  Future<void> getSharedPrefData() async {
    print('getSharedPrefData');
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    setState(() {
      authToken = shdPre.getString(SharedPrefKeys.token).toString();
      print('authToken >>>>>>> '+authToken.toString());
      _serviceListBloc.postServiceListRequest(authToken, "3");
    });
  }

  _listenServiceListResponse() {
    _serviceListBloc.postServiceList.listen((value) {
      if (value.status == "error") {
        setState(() {
          //SnackBarWidget().setMaterialSnackBar( "${value.message}", _scaffoldKey);
          print("message postServiceList >>>>>>>  ${value.message}");
          print("errrrorr postServiceList >>>>>>>  ${value.status}");
          //_isLoading = false;
        });

      } else {

        setState(() {
          print("success postServiceList >>>>>>>  ${value.status}");
          //print("success Auth token >>>>>>>  ${value.data!.customersSignUpIndividual!.token.toString()}");

          //_isLoading = false;
          print(value.data!.emeregencyOrRegularServiceList!.length);
          allServiceList = value.data!.emeregencyOrRegularServiceList!;

          for(int i=0;i<allServiceList.length;i++){
            if(allServiceList[i].type.toString() == "1"){
              emergencyServiceList.add(allServiceList[i]);
              selectedServiceMdlEmergencyList.add(SelectedServicesMdl(allServiceList[i].id,allServiceList[i].minAmount, "00:30", false));
            }else{
              regularServiceList.add(allServiceList[i]);
              selectedServiceMdlRegularList.add(SelectedServicesMdl(allServiceList[i].id,allServiceList[i].minAmount, "00:30", false));
            }
          }
          _emergencyIsChecked = List<bool>.filled(emergencyServiceList.length, false);
          _regularIsChecked = List<bool>.filled(regularServiceList.length, false);
          print(_emergencyIsChecked!.length);
          print(_regularIsChecked!.length);

          //_serviceListBloc.userDefault(value.data!.customersSignUpIndividual!.token.toString());
          //SnackBarWidget().setMaterialSnackBar( "Successfully Registered", _scaffoldKey);

        });
      }
    });
  }

  _listenAddServiceListResponse() {
    _addServiceListBloc.postAddServiceList.listen((value) {
      if (value.status == "error") {
        setState(() {
          //SnackBarWidget().setMaterialSnackBar( "${value.message}", _scaffoldKey);
          print("message postServiceList >>>>>>>  ${value.message}");
          print("errrrorr postServiceList >>>>>>>  ${value.status}");
          //_isLoading = false;
        });

      } else {

        setState(() {
          print("success postServiceList >>>>>>>  ${value.status}");
          //print("success Auth token >>>>>>>  ${value.data!.customersSignUpIndividual!.token.toString()}");

          //_isLoading = false;
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => WaitAdminApprovalScreen(refNumber: '123456',) ));
          FocusScope.of(context).unfocus();
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
        body: SafeArea(
          child: Container(
            height: size.height,
            width:  size.width,
            color: Colors.white,
            child: Container(
              margin: EdgeInsets.only(
                left: size.width * 6 /100,
                right: size.width * 5.9 / 100,
                bottom: size.height * 2.7 / 100,
                top: size.height * 3.4 / 100,
              ),
              child: Column(
                children: [

                  InkWell(
                    onTap: () {
                      setState(() {
                        isRegularSelected = !isRegularSelected ;
                        print("isRegularSelected >>>>>> " +isRegularSelected.toString());
                      });
                  },
                    child: Container(
                      margin: EdgeInsets.only(
                          left: size.width * 29 / 100 ,
                          right: size.width * 29 / 100,
                        bottom: size.height * 0.9 / 100
                      ),
                      child: Text(isRegularSelected ? "Emergency " : "Regular",
                          softWrap: true,
                          style: Styles.hiddenTextBlack,
                      ),
                    ),
                  ),

                  Expanded(
                      child: isRegularSelected ? regularServiceListUi(size) : emergencyServiceListUi(size)
                  ),

                  nextButtons(size),

                ],
              ),


            ),
      ),
        ),
      ),
    );
  }

  Widget regularServiceListUi(Size size) {
   return Container(
     color: CustColors.pale_grey,
     child: Column(
       children: [
         Container(
             margin: EdgeInsets.only(
                 left: size.width * 30 / 100 ,
                 right: size.width * 30 / 100,
                 top: size.height * 4 / 100
             ),
             child: Text("Regular",
                softWrap: true,
                style: Styles.TitleTextBlack,
             )
         ),
         Container(
           margin: EdgeInsets.only(
             top: size.height * 3.6 / 100,
             left: size.width * 5.6 / 100,
             right: size.width * 5.6 / 100,
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

                           TextEditingController _rateController=TextEditingController();
                           TextEditingController _timeController = TextEditingController();
                           _rateController.text = regularServiceList[index].minAmount.toString();
                           _timeController.text = "30:00";
                           _rateController.addListener(() {
                             var temp =   SelectedServicesMdl(selectedServiceMdlRegularList[index].serviceId,_rateController.text,  selectedServiceMdlRegularList[index].time, selectedServiceMdlRegularList[index].isEnable);
                             selectedServiceMdlRegularList.removeAt(index);
                             selectedServiceMdlRegularList.insert(index,temp);
                           });
                           _timeController.addListener(() {
                             var temp =   SelectedServicesMdl(selectedServiceMdlRegularList[index].serviceId,selectedServiceMdlRegularList[index].amount, _timeController.text, selectedServiceMdlRegularList[index].isEnable);
                             selectedServiceMdlRegularList.removeAt(index);
                             selectedServiceMdlRegularList.insert(index,temp);
                           });
                           //print(regularServiceList[index].minAmount.toString() + ">>>Min amt");
                           //print(regularServiceList[index].isEditable.toString() + ">>>isEditable amt");
                           //_rateController.text = regularServiceList![index].minAmount.toString();
                           return InkWell(
                               onTap: () {
                                 final brandName = emergencyServiceList[index];
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
                                             /* val ?
                                                  selectedServiceList.add(emergencyServiceList[index])
                                                      :
                                                  selectedServiceList.remove(emergencyServiceList[index]);*/
                                             print("sgsjhgj 001 $val");
                                             if(val){
                                               var temp =   SelectedServicesMdl(selectedServiceMdlRegularList[index].serviceId,selectedServiceMdlRegularList[index].amount, selectedServiceMdlRegularList[index].time, val);
                                               selectedServiceMdlRegularList.removeAt(index);
                                               selectedServiceMdlRegularList.insert(index,
                                                   temp);
                                             }else{
                                               //serviceSpecialisationList.remove(regularServiceList[index]);
                                               var temp= SelectedServicesMdl(selectedServiceMdlRegularList[index].serviceId,selectedServiceMdlRegularList[index].amount, selectedServiceMdlRegularList[index].time, val);
                                               selectedServiceMdlRegularList.removeAt(index);
                                               selectedServiceMdlRegularList.insert(index,temp
                                               );
                                             }
                                             print(">>>>>>>>> Selected Make List data " + emergencyServiceList.length.toString());
                                           });
                                         },
                                       ),
                                     ),

                                     Text(
                                       '${regularServiceList[index].serviceName.toString()}',
                                     ),
                                     SizedBox(
                                       width: size.width / 100 * 18,
                                     ),
                                     Flexible(
                                       child: TextFormField(
                                         validator: (value){
                                           if(value!.isEmpty){
                                             return "Fill field";
                                           }
                                           else if(int.parse(value) < int.parse(regularServiceList[index].minAmount) || int.parse(value) > int.parse(regularServiceList[index].maxAmount)){
                                             return regularServiceList[index].minAmount + " - " + regularServiceList[index].maxAmount;
                                           }
                                           else{
                                             return null;
                                           }
                                         },
                                         cursorColor: CustColors.light_navy,
                                         keyboardType: TextInputType.number,
                                         inputFormatters: <TextInputFormatter>[
                                           FilteringTextInputFormatter.digitsOnly,
                                         ],
                                         autovalidateMode: AutovalidateMode.onUserInteraction,
                                         //initialValue: '${regularServiceList[index].serviceName.toString()}',
                                         controller: _rateController,
                                         style: Styles.searchTextStyle02,
                                         enabled: _regularIsChecked![index],
                                         //readOnly: _regularIsChecked![index],
                                       ),
                                     ),
                                     SizedBox(
                                       width: size.width / 100 * 5,
                                     ),
                                     //Text("00 : 30")
                                     Flexible(
                                       child: TextFormField(
                                         validator: (value){
                                           if(value!.isEmpty){
                                             return "Fill field";
                                           }
                                           /*else if(int.parse(value) < int.parse(regularServiceList[index].minAmount) || int.parse(value) > int.parse(regularServiceList[index].maxAmount)){
                                                    return regularServiceList[index].minAmount + " - " + regularServiceList[index].maxAmount;
                                                  }*/
                                           else{
                                             return null;
                                           }
                                         },
                                         cursorColor: CustColors.light_navy,
                                         inputFormatters: <TextInputFormatter>[
                                           FilteringTextInputFormatter.digitsOnly,
                                         ],
                                         autovalidateMode: AutovalidateMode.onUserInteraction,
                                         keyboardType: TextInputType.datetime,
                                         //initialValue: '${regularServiceList[index].serviceName.toString()}',
                                         controller: _timeController,
                                         style: Styles.searchTextStyle02,
                                         enabled: _regularIsChecked![index],
                                         //readOnly: _regularIsChecked![index],
                                       ),
                                     ),

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
       ],
     ),
   );
  }

  Widget emergencyServiceListUi(Size size) {
    return Container(
      color: CustColors.pale_grey,
      child: Column(
        children: [
          Container(
              margin: EdgeInsets.only(
                  left: size.width * 30 / 100 ,
                  right: size.width * 30 / 100,
                  top: size.height * 4 / 100
              ),
              child: Text("Emergency",
                softWrap: true,
                style: Styles.TitleTextBlack,)
          ),
          Container(
            margin: EdgeInsets.only(
              top: size.height * 3.6 / 100,
              left: size.width * 5.6 / 100,
              right: size.width * 5.6 / 100,
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
                        child:  emergencyServiceList.length != 0
                            ? ListView.separated(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: emergencyServiceList.length,
                          itemBuilder: (context, index) {

                            TextEditingController _rateController=TextEditingController();
                            TextEditingController _timeController = TextEditingController();
                            _rateController.text = emergencyServiceList[index].minAmount.toString();
                            _timeController.text = "30:00";
                            _rateController.addListener(() {
                              var temp =   SelectedServicesMdl(selectedServiceMdlEmergencyList[index].serviceId,_rateController.text,  selectedServiceMdlEmergencyList[index].time, selectedServiceMdlEmergencyList[index].isEnable);
                              selectedServiceMdlEmergencyList.removeAt(index);
                              selectedServiceMdlEmergencyList.insert(index,temp);
                            });
                            _timeController.addListener(() {
                              var temp =   SelectedServicesMdl(selectedServiceMdlEmergencyList[index].serviceId,selectedServiceMdlEmergencyList[index].amount, _timeController.text, selectedServiceMdlEmergencyList[index].isEnable);
                              selectedServiceMdlEmergencyList.removeAt(index);
                              selectedServiceMdlEmergencyList.insert(index,temp);
                            });
                            //print(regularServiceList[index].minAmount.toString() + ">>>Min amt");
                            //print(regularServiceList[index].isEditable.toString() + ">>>isEditable amt");
                            //_rateController.text = regularServiceList![index].minAmount.toString();
                            return InkWell(
                                onTap: () {
                                  final brandName = emergencyServiceList[index];
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
                                          value: _emergencyIsChecked![index],
                                          onChanged: (bool? val){
                                            setState(() {
                                              this._emergencyIsChecked![index] = val!;
                                              //isChecked ? false : true;
                                              /* val ?
                                                  selectedServiceList.add(emergencyServiceList[index])
                                                      :
                                                  selectedServiceList.remove(emergencyServiceList[index]);*/
                                              print("sgsjhgj 001 $val");
                                              if(val){
                                                var temp =   SelectedServicesMdl(selectedServiceMdlEmergencyList[index].serviceId,selectedServiceMdlEmergencyList[index].amount, selectedServiceMdlEmergencyList[index].time, val);
                                                selectedServiceMdlEmergencyList.removeAt(index);
                                                selectedServiceMdlEmergencyList.insert(index,
                                                    temp);
                                              }else{
                                                //serviceSpecialisationList.remove(regularServiceList[index]);
                                                var temp= SelectedServicesMdl(selectedServiceMdlEmergencyList[index].serviceId,selectedServiceMdlEmergencyList[index].amount, selectedServiceMdlEmergencyList[index].time, val);
                                                selectedServiceMdlEmergencyList.removeAt(index);
                                                selectedServiceMdlEmergencyList.insert(index,temp
                                                );
                                              }
                                              print(">>>>>>>>> Selected Make List data " + emergencyServiceList.length.toString());
                                            });
                                          },
                                        ),
                                      ),

                                      Text(
                                        '${emergencyServiceList[index].serviceName.toString()}',
                                      ),
                                      SizedBox(
                                        width: size.width / 100 * 18,
                                      ),
                                      Flexible(
                                        child: TextFormField(
                                          validator: (value){
                                            if(value!.isEmpty){
                                              return "Fill field";
                                            }
                                            else if(int.parse(value) < int.parse(emergencyServiceList[index].minAmount) || int.parse(value) > int.parse(emergencyServiceList[index].maxAmount)){
                                              return emergencyServiceList[index].minAmount + " - " + emergencyServiceList[index].maxAmount;
                                            }
                                            else{
                                              return null;
                                            }
                                          },
                                          cursorColor: CustColors.light_navy,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter.digitsOnly,
                                          ],
                                          autovalidateMode: AutovalidateMode.onUserInteraction,
                                          //initialValue: '${regularServiceList[index].serviceName.toString()}',
                                          controller: _rateController,
                                          style: Styles.searchTextStyle02,
                                          enabled: _emergencyIsChecked![index],
                                          //readOnly: _regularIsChecked![index],
                                        ),
                                      ),
                                      SizedBox(
                                        width: size.width / 100 * 5,
                                      ),
                                      //Text("00 : 30")
                                      Flexible(
                                        child: TextFormField(
                                          validator: (value){
                                            if(value!.isEmpty){
                                              return "Fill field";
                                            }
                                            /*else if(int.parse(value) < int.parse(regularServiceList[index].minAmount) || int.parse(value) > int.parse(regularServiceList[index].maxAmount)){
                                                    return regularServiceList[index].minAmount + " - " + regularServiceList[index].maxAmount;
                                                  }*/
                                            else{
                                              return null;
                                            }
                                          },
                                          cursorColor: CustColors.light_navy,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter.digitsOnly,
                                          ],
                                          autovalidateMode: AutovalidateMode.onUserInteraction,
                                          keyboardType: TextInputType.datetime,
                                          //initialValue: '${regularServiceList[index].serviceName.toString()}',
                                          controller: _timeController,
                                          style: Styles.searchTextStyle02,
                                          enabled: _emergencyIsChecked![index],
                                          //readOnly: _regularIsChecked![index],
                                        ),
                                      ),

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
        ],
      ),
    );
  }

  /*Widget nextButtons(Size size) {
    return  Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: _setValue(0.5),bottom: _setValue(25.5)),
      child: Row(
        children: [
          Container(
            child: Container(
              margin: EdgeInsets.only(top: 20.8),
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
                  : Container(

                child: MaterialButton(
                  onPressed: () {
                    setState(() {
                      _isAddMore = true;
                      _isLoading = true;
                      print('true');
                    });
                    if (_formKey.currentState!.validate()) {

                      setState(() {
                        _isLoading = false;
                        print('sucess');
                        _addCarBloc. postAddCarRequest(
                            authToken,
                            selectedYearType ,
                            _plateNumberController.text,
                            selectedengine,
                            _lastMaintenanceController.text,
                            _lowerValue.toString(),
                            selectedBrand,
                            selectedmodel,
                            imageFirebaseUrl
                        );
                      });
                    } else {
                      setState(() {
                        _isLoading = false;
                        print('error');
                      });
                    }


                  },
                  child: Container(
                    height: 45,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Add More',
                          textAlign: TextAlign.center,
                          style: Styles.textButtonLabelSubTitle,
                        ),
                      ],
                    ),
                  ),
                  color: CustColors.materialBlue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          _setValue(10))),
                ),
              ),
            ),
          ),
          Spacer(),
          Container(
            child: Container(
              margin: EdgeInsets.only(top: 20.8),
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
                  : Container(
                child: MaterialButton(
                  onPressed: () {
                    print( authToken + "  " +
                        selectedYearType! + "  " +
                        'kl-34 A213' + "  " +
                        selectedengine! +  "  " +
                        _lastMaintenanceController.text + "  " +
                        _plateNumberController.text + "  " +
                        _lowerValue.toString() + "  " +
                        selectedBrand! + "  " +
                        selectedmodel! + " >>>>>>>>>>>> " +
                        _brandController.text.toString() + "  " +
                        _modelController.text + "  " +
                        _engineTypeController.text + "  " +
                        _yearController.text + "  " +
                        _lastMaintenanceController.text + "  " +
                        _plateNumberController.text + "  " +
                        _lowerValue.toString() );
                    setState(() {
                      _isLoading = true;
                      _isAddMore = false;
                      print('true');
                    });
                    if (_formKey.currentState!.validate()) {

                      setState(() {
                        _isLoading = false;
                        print('sucess');
                        _addCarBloc. postAddCarRequest(
                            authToken,
                            selectedYearType ,
                            _plateNumberController.text,
                            selectedengine,
                            _lastMaintenanceController.text,
                            _lowerValue.toString(),
                            selectedBrand,
                            selectedmodel,
                            imageFirebaseUrl
                        );
                      });
                    } else {
                      setState(() {
                        _isLoading = false;
                        print('error');
                      });
                    }
                  },
                  child: Container(
                    height: 45,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Next',
                          textAlign: TextAlign.center,
                          style: Styles.textButtonLabelSubTitle,
                        ),
                      ],
                    ),
                  ),
                  color: CustColors.materialBlue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          _setValue(10))),
                ),
              ),
            ),
          ),
        ],
      ),
    ) ;
  }*/

  Widget nextButtons(Size size) {
    return InkWell(
      onTap: (){
        // Map<List<AllServiceFeeData>?, String> myData = new Map();
        //SelectedData data = SelectedData(selectedServiceList,"rate");

        print(">>>>>>> selectedServiceMdlRegularList.length ${selectedServiceMdlRegularList.length}");
        print(">>>>>>> selectedServiceMdlEmergencyList.length ${selectedServiceMdlEmergencyList.length}");

        List<SelectedServicesMdl> selectedService=[];

        for(int i=0;i<selectedServiceMdlRegularList.length;i++){
          print("time 001 ${selectedServiceMdlRegularList[i].isEnable}");
          if(selectedServiceMdlRegularList[i].isEnable){
            selectedService.add(selectedServiceMdlRegularList[i]);
          }else{
            print("no data to print");
          }
          //print("fgdhj 001 ${selectedServiceMdlList[i].amount}");
          //print("time 001 ${selectedServiceMdlList[i].time}");
          //print("time 001 ${selectedServiceMdlList[i].isEnable}");
        }

        for(int i=0;i<selectedServiceMdlEmergencyList.length;i++){
          print("time 001 ${selectedServiceMdlEmergencyList[i].isEnable}");
          if(selectedServiceMdlEmergencyList[i].isEnable){
            selectedService.add(selectedServiceMdlEmergencyList[i]);
          }else{
            print("no data to print");
          }
          //print("fgdhj 001 ${selectedServiceMdlList[i].amount}");
          //print("time 001 ${selectedServiceMdlList[i].time}");
          //print("time 001 ${selectedServiceMdlList[i].isEnable}");
        }



        String serviceId="";
        String feeList = "[";
        String timeList = "[";

        for(int m = 0 ; m< selectedService.length; m++){
          if( m != selectedService.length-1){
            serviceId = serviceId + "${selectedService[m].serviceId}" + ", ";
            feeList = feeList + """ "${selectedService[m].amount}",""";
            timeList = timeList + """ "${selectedService[m].time}",""";
          }else{
            serviceId = serviceId + "${selectedService[m].serviceId}" ;
            feeList = feeList + """ "${selectedService[m].amount}" """;
            timeList = timeList + """ "${selectedService[m].time}" """;
          }
        }
        serviceId = serviceId ;
        feeList = feeList + "]";
        timeList = timeList + "]";

        print(" >>>> serviceId" +serviceId + " >>>> feeList " + feeList + " >>>>>>>> timeList" + timeList);

        _addServiceListBloc.postMechanicAddServicesRequest(
            authToken,
            serviceId,  feeList, timeList);

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
              fontSize: ScreenSize().setValueFont(14.5),
              fontWeight: FontWeight.w800),
        ),
      ),
    ) ;
  }

}

class SelectedServicesMdl{
  final String serviceId;
  final String amount;
  final String time;
  final bool isEnable;
  SelectedServicesMdl(this.serviceId, this.amount, this.time,this.isEnable);
}