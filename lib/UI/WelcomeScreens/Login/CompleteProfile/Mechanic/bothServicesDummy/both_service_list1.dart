import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/AddServices/add_services_bloc.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/ServiceList/service_list_bloc.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/ServiceList/service_list_mdl.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/bothServicesDummy/categoryListMdl.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/bothServicesDummy/serviceListAllBothMdl.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/wait_admin_approval_screen.dart';
import 'package:auto_fix/Widgets/screen_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'service_list_Both_bloc.dart';



class BothServiceList1Screen extends StatefulWidget {

  BothServiceList1Screen();

  @override
  State<StatefulWidget> createState() {
    return _BothServiceList1ScreenState();
  }
}

class _BothServiceList1ScreenState extends State<BothServiceList1Screen> {


  final ServiceListBothBloc _serviceListBloc = ServiceListBothBloc();
  final MechanicAddServiceListBloc _addServiceListBloc = MechanicAddServiceListBloc();


  List<CategoryList> allServiceList = [];
  List<CategoryList> emergencyServiceList = [];
  List<CategoryList> regularServiceList = [];

  List<ServiceListAll> regularServiceList1 = [];


  List<CategoryList> selectedRegularServiceList = [];
  List<CategoryList> selectedEmergencyServiceList = [];

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
    isRegularSelected = true;
    getSharedPrefData();
    _listenServiceListResponse();

    _regularIsChecked = List<bool>.filled(regularServiceList.length, false);
    _emergencyIsChecked = List<bool>.filled(emergencyServiceList.length, false);

  }

  Future<void> getSharedPrefData() async {
    print('getSharedPrefData');
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    setState(() {
      authToken = shdPre.getString(SharedPrefKeys.token).toString();
      print('authToken >>>>>>> '+authToken.toString());
      _serviceListBloc.postCatListEmergencyRequest(authToken, "1");
      _serviceListBloc.postCatListRegularRequest(authToken, "2");
    });
  }

  _listenServiceListResponse() {
    _serviceListBloc.postServiceList.listen((value) {
      if (value.status == "error") {
        setState(() {
          print("message postServiceList >>>>>>>  ${value.message}");
          print("errrrorr postServiceList >>>>>>>  ${value.status}");
        });

      } else {

        setState(() {

          allServiceList = value.data!.categoryList!;

          for(int i=0;i<allServiceList.length;i++){
            if(allServiceList[i].catType.toString() == "1"){
              emergencyServiceList.add(allServiceList[i]);
              selectedServiceMdlEmergencyList.add(SelectedServicesMdl(allServiceList[i].id.toString(),allServiceList[i].minAmount, "00:30", false));
            }
          }
          _emergencyIsChecked = List<bool>.filled(emergencyServiceList.length, false);

        });
      }
    });
    _serviceListBloc.postServiceRegularList.listen((value) {
      if (value.status == "error") {
        setState(() {
          print("message postServiceList >>>>>>>  ${value.message}");
          print("errrrorr postServiceList >>>>>>>  ${value.status}");
        });

      } else {

        setState(() {
          allServiceList = value.data!.categoryList!;
          _regularIsChecked = List<bool>.filled(allServiceList.length, false);
          for(int i=0;i<allServiceList.length;i++){


            if(allServiceList[i].type.toString() == "1"){
              emergencyServiceList.add(allServiceList[i]);
              selectedServiceMdlEmergencyList.add(SelectedServicesMdl(allServiceList[i].id.toString(),allServiceList[i].minAmount, "00:30", false));
            }else{
              regularServiceList.add(allServiceList[i]);
              selectedServiceMdlRegularList.add(SelectedServicesMdl(allServiceList[i].id.toString(),allServiceList[i].minAmount, "00:30", false));

            }
          }

        });
      }
    });
    _serviceListBloc.postServiceAllRegularListResponse.listen((value) {
      if (value.status == "error") {
        setState(() {
          print("message postServiceList >>>>>>>  ${value.message}");
          print("errrrorr postServiceList >>>>>>>  ${value.status}");
        });

      } else {

        setState(() {
          regularServiceList1 = value.data!.serviceListAll!;
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
              child: StreamBuilder(
                  stream:  _serviceListBloc.serviceListResponse,
                  builder: (context, AsyncSnapshot<CategoryListMdl> snapshot) {
                    print("${snapshot.hasData}");
                    print("${snapshot.connectionState}");

                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return CircularProgressIndicator();
                      default:
                        return
                          snapshot.data?.data?.categoryList?.length != 0 && snapshot.data?.data?.categoryList?.length != null
                              ? ListView.builder(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: snapshot.data?.data?.categoryList?.length,
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
                                                  '${emergencyServiceList[index].catName.toString()}',
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
                                  )
                              : Center(
                                  child: Text('No Results found.'),
                                );
                    }
                  }),
            ),
          )
        ],
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
              child: StreamBuilder(
                  stream:  _serviceListBloc.serviceListResponse,
                  builder: (context, AsyncSnapshot<CategoryListMdl> snapshot) {
                    print("${snapshot.hasData}");
                    print("${snapshot.connectionState}");

                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return CircularProgressIndicator();
                      default:
                        return
                          snapshot.data?.data?.categoryList?.length != 0 && snapshot.data?.data?.categoryList?.length != null
                              ? ListView.builder(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: snapshot.data?.data?.categoryList?.length,
                                  itemBuilder: (context, index) {

                                    return   InkWell(
                                        onTap: () {
                                          print(">>>>>");
                                        },
                                        child: Column(
                                          children: [
                                            Container(
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
                                                            _serviceListBloc.postserviceListAllBothRequest(authToken,selectedServiceMdlRegularList[index].serviceId);
                                                            var temp =   SelectedServicesMdl(selectedServiceMdlRegularList[index].serviceId,selectedServiceMdlRegularList[index].amount, selectedServiceMdlRegularList[index].time, val);
                                                            selectedServiceMdlRegularList.removeAt(index);
                                                            selectedServiceMdlRegularList.insert(index, temp);
                                                          }else{
                                                            //serviceSpecialisationList.remove(regularServiceList[index]);
                                                            var temp= SelectedServicesMdl(selectedServiceMdlRegularList[index].serviceId,selectedServiceMdlRegularList[index].amount, selectedServiceMdlRegularList[index].time, val);
                                                            selectedServiceMdlRegularList.removeAt(index);
                                                            selectedServiceMdlRegularList.insert(index,temp);
                                                          }
                                                          print(">>>>>>>>> Selected Make List data " + emergencyServiceList.length.toString());
                                                        });
                                                      },
                                                    ),
                                                  ),

                                                  Text(
                                                    '${regularServiceList[index].catName.toString()}',
                                                  ),
                                                  SizedBox(
                                                    width: size.width / 100 * 18,
                                                  ),

                                                ],
                                              ),
                                            ),
                                            _regularIsChecked![index] == true
                                            ? Container(
                                                  child: StreamBuilder(
                                                      stream:  _serviceListBloc.postServiceAllRegularListResponse,
                                                      builder: (context, AsyncSnapshot<ServiceListAllBothMdl> snapshot) {
                                                        print("${snapshot.hasData}");
                                                        print("${snapshot.connectionState}");

                                                        switch (snapshot.connectionState) {
                                                          case ConnectionState.waiting:
                                                            return CircularProgressIndicator();
                                                          default:
                                                            return
                                                              snapshot.data?.data?.serviceListAll?.length != 0 && snapshot.data?.data?.serviceListAll?.length != null
                                                                  ? ListView.builder(
                                                                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                                                        scrollDirection: Axis.vertical,
                                                                        shrinkWrap: true,
                                                                        itemCount: snapshot.data?.data?.serviceListAll?.length,
                                                                        itemBuilder: (context, index) {
                                                                          TextEditingController _rateController=TextEditingController();
                                                                          TextEditingController _timeController = TextEditingController();
                                                                          _rateController.text = regularServiceList1[index].minPrice.toString();
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
                                                                          return   InkWell(
                                                                              onTap: () {
                                                                                print(">>>>>");
                                                                              },
                                                                              child: Column(
                                                                                children: [
                                                                                  Container(
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
                                                                                                  selectedServiceMdlRegularList.insert(index, temp);
                                                                                                }else{
                                                                                                  //serviceSpecialisationList.remove(regularServiceList[index]);
                                                                                                  var temp= SelectedServicesMdl(selectedServiceMdlRegularList[index].serviceId,selectedServiceMdlRegularList[index].amount, selectedServiceMdlRegularList[index].time, val);
                                                                                                  selectedServiceMdlRegularList.removeAt(index);
                                                                                                  selectedServiceMdlRegularList.insert(index,temp);
                                                                                                }
                                                                                                print(">>>>>>>>> Selected Make List data " + emergencyServiceList.length.toString());
                                                                                              });
                                                                                            },
                                                                                          ),
                                                                                        ),

                                                                                        Text(
                                                                                          '${regularServiceList1[index].serviceName.toString()}',
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
                                                                                              else if(int.parse(value) < int.parse(regularServiceList1[index].minPrice) || int.parse(value) > int.parse(regularServiceList1[index].maxPrice)){
                                                                                                return regularServiceList1[index].minPrice + " - " + regularServiceList1[index].maxPrice;
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
                                                                                  ),
                                                                                ],
                                                                              ));
                                                                        },
                                                                      )
                                                                  : Center(
                                                                      child: Text('No Results found.'),
                                                                    );
                                                        }
                                                      }),
                                                )
                                            :Container(),
                                          ],
                                        ));
                                  },
                                )
                              : Center(
                                  child: Text('No Results found.'),
                                );
                    }
                  }),
            ),
          )
        ],
      ),
    );
  }

  Widget nextButtons(Size size) {
    return InkWell(
      onTap: (){
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
        }

        for(int i=0;i<selectedServiceMdlEmergencyList.length;i++){
          print("time 001 ${selectedServiceMdlEmergencyList[i].isEnable}");
          if(selectedServiceMdlEmergencyList[i].isEnable){
            selectedService.add(selectedServiceMdlEmergencyList[i]);
          }else{
            print("no data to print");
          }
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