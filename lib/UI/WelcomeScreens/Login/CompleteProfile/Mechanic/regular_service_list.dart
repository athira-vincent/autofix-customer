import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/AddServices/add_services_bloc.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/ServiceList/category_service_list_mdl.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/ServiceList/service_list_bloc.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/wait_admin_approval_screen.dart';
import 'package:auto_fix/Widgets/screen_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:duration_picker/duration_picker.dart';


class RegularServiceListScreen extends StatefulWidget {

  RegularServiceListScreen();

  @override
  State<StatefulWidget> createState() {
    return _RegularServiceListScreenState();
  }
}

class _RegularServiceListScreenState extends State<RegularServiceListScreen> {

  final ServiceListBloc _serviceListBloc = ServiceListBloc();
  final MechanicAddServiceListBloc _addServiceListBloc = MechanicAddServiceListBloc();


  List<CategoryList> regularServiceList = [];
  List<Service> selectedServiceList = [];
  List<bool>? _regularIsChecked;

  String title = "";
  String selectedService = "";
  //List<ServiceListAll> serviceSpecialisationList =[];
  List<SelectedServicesMdl> selectedServiceMdlList=[];

  String authToken="", userCode = "";

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
          print(value.data!.categoryList!.length);
          regularServiceList = value.data!.categoryList!;

          for(int i = 0; i < regularServiceList.length;i++){
            for(int x = 0; x < regularServiceList[i].service!.length; x++){
              selectedServiceMdlList.add(SelectedServicesMdl(i,x,
                  regularServiceList[i].service![x].id.toString(),
                  regularServiceList[i].service![x].minPrice,
                  regularServiceList[i].service![x].maxPrice,
                  "10:00", false));
            }
          }

          print("selectedServiceMdlList.length >>> "+ selectedServiceMdlList.length.toString());

          _regularIsChecked = List<bool>.filled(selectedServiceMdlList.length, false);
          print("_regularIsChecked!.length >>> " + _regularIsChecked!.length.toString());

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

        setState(() async {
          print("success postServiceList >>>>>>>  ${value.status}");
          //print("success Auth token >>>>>>>  ${value.data!.customersSignUpIndividual!.token.toString()}");

          //_isLoading = false;
          SharedPreferences _shdPre = await SharedPreferences.getInstance();
          _shdPre.setInt(SharedPrefKeys.isWorkProfileCompleted, 3);
          print("success refNumber: userCode, >>>>>>>  ${userCode}");
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => WaitAdminApprovalScreen(refNumber: userCode,) ));
          FocusScope.of(context).unfocus();
          //_serviceListBloc.userDefault(value.data!.customersSignUpIndividual!.token.toString());
          //SnackBarWidget().setMaterialSnackBar( "Successfully Registered", _scaffoldKey);

        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getSharedPrefData();

    _listenServiceListResponse();
    _listenAddServiceListResponse();

  }

  Future<void> getSharedPrefData() async {
    print('getSharedPrefData');
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    setState(() {
      authToken = shdPre.getString(SharedPrefKeys.token).toString();
      userCode = shdPre.getString(SharedPrefKeys.userCode).toString();
      print('authToken >>>>>>> '+authToken.toString());
      _serviceListBloc.postServiceListRequest(authToken, "", null, "2", "" );
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: CustColors.materialBlue,
      ),
      home: SafeArea(
        child: Scaffold(
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
                    padding: const EdgeInsets.fromLTRB(
                        6.0,6.0,6.0,6.0
                    ),
                    child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text("Select regular Services",
                          style: Styles.serviceSelectionTitle01Style,)),
                  ),

                  Container(
                    margin: EdgeInsets.only(
                      top: size.height * 0.026,
                     /* left: size.width * 6 / 100,
                      right: size.width * 6 / 100,*/
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
                                onChanged: (text) {
                                             setState(() {
                                               if(text.isNotEmpty){
                                                 _serviceListBloc.postServiceListRequest(authToken, text, null, "2", text );
                                               }else{
                                                 _serviceListBloc.postServiceListRequest(authToken, "", null, "2", "" );
                                               }
                                             });
                                             //_allMakeBloc.searchMake(text);
                                           },
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
                          top: size.height * 0.020,
                          bottom: size.height * 0.019
                      ),
                      color: CustColors.pale_grey,
                      height: size.height * 0.80, //0.764
                      child: Container(
                        margin: EdgeInsets.only(
                          left: size.width * 0.045,
                          right: size.width * 0.045,
                          //top: size.height * 0.03,
                          bottom: size.height * 0.030
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: regularServiceList.length != 0
                                  ? ListView.builder(
                                    itemBuilder: (BuildContext context, int index) =>
                                        _buildTiles(regularServiceList[index],size, index),
                                    itemCount: regularServiceList.length,
                                  )
                                  :
                              Center(
                                child: Text('No Results found.'),
                              ),

                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  InkWell(
                    onTap: (){
                      // Map<List<AllServiceFeeData>?, String> myData = new Map();
                      //SelectedData data = SelectedData(selectedServiceList,"rate");
                      //Navigator.pop(context, "data");

                      print(">>>>>>> selectedServiceMdlList.length ${selectedServiceMdlList.length}");


                      List<SelectedServicesMdl> selectedService=[];

                      String serviceId="";
                      String feeList = "[";
                      String timeList = "[";

                      for(int i=0;i<selectedServiceMdlList.length;i++){
                        print("time 001 ${selectedServiceMdlList[i].isEnable}");
                        if(selectedServiceMdlList[i].isEnable){
                          selectedService.add(selectedServiceMdlList[i]);
                        }else{
                          print("no data to print");
                        }
                        //print("fgdhj 001 ${selectedServiceMdlList[i].amount}");
                        //print("time 001 ${selectedServiceMdlList[i].time}");
                        //print("time 001 ${selectedServiceMdlList[i].isEnable}");
                      }

                      print(selectedService);

                      for(int m = 0 ; m< selectedService.length; m++){
                        if( m != selectedService.length-1){
                          serviceId = serviceId + "${selectedService[m].serviceId}" + ", ";
                          feeList = feeList + """ "${selectedService[m].minAmount}",""";
                          timeList = timeList + """ "${selectedService[m].time}",""";
                        }else{
                          serviceId = serviceId + "${selectedService[m].serviceId}" ;
                          feeList = feeList + """ "${selectedService[m].minAmount}" """;
                          timeList = timeList + """ "${selectedService[m].time}" """;
                        }
                      }

                      serviceId = serviceId ;
                      feeList = feeList + "]";
                      timeList = timeList + "]";

                      //print(serviceSpecialisationList);

                     /* for(int i=0;i<serviceSpecialisationList.length;i++){
                        serviceId = serviceId +""" "${serviceSpecialisationList[i].id}", """;
                      }

                      for(int i = 0 ; i < serviceSpecialisationList.length; i++){
                        feeList = feeList + """ "${serviceSpecialisationList[i].minAmount}",""";
                      }
                      */

                      print(" >>>> serviceId " +serviceId + " >>>> feeList " + feeList + " >>>>>>>> timeList" + timeList);

                      _addServiceListBloc.postMechanicAddServicesRequest(
                          authToken,
                          serviceId,  feeList, timeList, 2);
                    },
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        height: size.height * 0.045,
                        width: size.width * 0.246,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(
                          right: size.width * 7 / 100,
                          top: size.height * 1.9 / 100
                        ),
                        //margin: EdgeInsets.only(top: 8, bottom: 6,left: 75,right: 75),
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
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTiles(CategoryList root, Size size,int parentIndex) {

    print('parentIndex >>>>>>>>>>>>>>>>>>root.service!.length. $parentIndex');

    print('root >>>>>>>>>>>>>>>>>>root.service!.length. $root');


    if (root.service!.isEmpty) return ListTile(title: Text(root.catName));
    return ExpansionTile(
      key: PageStorageKey<CategoryList>(root),
      iconColor: CustColors.light_navy,
      textColor: CustColors.light_navy,
      title: Text(
        root.catName,
      ),
      children: <Widget>[
        root.service!.length != 0
            ? ListView.builder(
                  key: PageStorageKey<CategoryList>(root),
                  physics: ClampingScrollPhysics(),
                  //controller: _scrollController,
                  shrinkWrap: true,
                  //scrollDirection: Axis.vertical,
                  itemCount:  root.service!.length,
                  itemBuilder: (context, index) {
                    print('index >>>>>>>>>>>>>>>>>>root.service!.length. $index');

                    TextEditingController _rateController = TextEditingController();
                    TextEditingController _timeController = TextEditingController();
                    _rateController.text = root.service![index].minPrice.toString();
                    _timeController.text = selectedServiceMdlList[getItemIndex(parentIndex,index)].time;
                    _rateController.addListener(() {
                      int itemIndex = getItemIndex(parentIndex,index);
                      var temp =   SelectedServicesMdl(parentIndex, index,
                          selectedServiceMdlList[itemIndex].serviceId,
                          _rateController.text,
                          selectedServiceMdlList[itemIndex].maxAmount,
                          selectedServiceMdlList[itemIndex].time,
                          selectedServiceMdlList[itemIndex].isEnable);
                      selectedServiceMdlList.removeAt(itemIndex);
                      selectedServiceMdlList.insert(itemIndex,temp);
                    });
                    _timeController.addListener(() {
                      int itemIndex = getItemIndex(parentIndex,index);
                      var temp =   SelectedServicesMdl(parentIndex, index,
                          selectedServiceMdlList[itemIndex].serviceId,
                          selectedServiceMdlList[itemIndex].minAmount,
                          selectedServiceMdlList[itemIndex].maxAmount,
                          _timeController.text, selectedServiceMdlList[itemIndex].isEnable);
                      selectedServiceMdlList.removeAt(itemIndex);
                      selectedServiceMdlList.insert(itemIndex,temp);
                    });

                    return Container(
                      child: Row(
                        children: [
                          Transform.scale(
                            scale: .6,
                            child: Checkbox(
                              activeColor: CustColors.light_navy,
                              value: _regularIsChecked![getItemIndex(parentIndex,index)],
                              //value: false,
                              onChanged: (bool? val){
                                setState(() {
                                  this._regularIsChecked![getItemIndex(parentIndex,index)] = val!;

                                  print("sgsjhgj 001 $val");
                                  if(val){
                                    int itemIndex = getItemIndex(parentIndex,index);
                                    print("Checkbox itemIndex >>>>>>>>>> " + itemIndex.toString());
                                    var temp =   SelectedServicesMdl(parentIndex,index,
                                        selectedServiceMdlList[itemIndex].serviceId,
                                        selectedServiceMdlList[itemIndex].minAmount,
                                        selectedServiceMdlList[itemIndex].maxAmount,
                                        selectedServiceMdlList[itemIndex].time, val);
                                    selectedServiceMdlList.removeAt(itemIndex);
                                    selectedServiceMdlList.insert(itemIndex, temp);
                                  }else{
                                    int itemIndex = getItemIndex(parentIndex,index);
                                    print("Checkbox itemIndex >>>>>>>>>> " + itemIndex.toString());
                                    //serviceSpecialisationList.remove(regularServiceList[index]);
                                    var temp= SelectedServicesMdl(parentIndex,index,
                                        selectedServiceMdlList[itemIndex].serviceId,
                                        selectedServiceMdlList[itemIndex].minAmount,
                                        selectedServiceMdlList[itemIndex].maxAmount,
                                        selectedServiceMdlList[itemIndex].time, val);
                                    selectedServiceMdlList.removeAt(itemIndex);
                                    selectedServiceMdlList.insert(itemIndex,temp);
                                  }
                                  //print(">>>>>>>>> Selected Make List data " + emergencyServiceList.length.toString());
                                });
                              },
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              '${root.service![index].serviceName.toString()}',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            width: size.width * 15 / 100,
                            height: size.height * 4 / 100,
                            padding: EdgeInsets.only(
                                top: size.height * 1 / 100,
                                bottom: size.width * 1 / 100
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(2.8),
                              ),
                              border: Border.all(
                                  color: CustColors.pinkish_grey02,
                                  width: 0.3
                              ),
                              //color: Colors.redAccent,
                            ),
                            child: Center(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 12.5,
                                    horizontal: 5.0,
                                  ),
                                    errorStyle: TextStyle(
                                      color: Colors.red,
                                      fontSize: 7,
                                    )
                                ),
                                validator: (value){
                                  if(value!.isEmpty){
                                    return "Fill field";
                                  }
                                  else if(int.parse(value) < int.parse(selectedServiceMdlList[getItemIndex(parentIndex,index)].minAmount) ){
                                    return selectedServiceMdlList[getItemIndex(parentIndex,index)].minAmount + "-" + selectedServiceMdlList[getItemIndex(parentIndex,index)].maxAmount;
                                  }
                                  else if(int.parse(value) > int.parse(selectedServiceMdlList[getItemIndex(parentIndex,index)].maxAmount)){
                                    return selectedServiceMdlList[getItemIndex(parentIndex,index)].minAmount + "-" + selectedServiceMdlList[getItemIndex(parentIndex,index)].maxAmount;
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
                                enabled: _regularIsChecked![getItemIndex(parentIndex,index)],
                                //readOnly: _regularIsChecked![getItemIndex(parentIndex,index)],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: size.width / 100 * 5,
                          ),
                          Container(
                            width: size.width * 15 / 100,
                            height: size.height * 4 / 100,
                            padding: EdgeInsets.only(
                                top: size.height * 1 / 100,
                                bottom: size.width * 1 / 100
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(2.8),
                              ),
                              border: Border.all(
                                  color: CustColors.pinkish_grey02,
                                  width: 0.3
                              ),
                              //color: Colors.redAccent,
                            ),
                            child: Center(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 12.5,
                                    horizontal: 6.0,
                                  ),
                                ),
                                /*validator: (value){
                                  if(value!.isEmpty){
                                    return "Fill field";
                                  }
                                  *//*else if(value.length >= 3){
                                    _timeController.text = value.toString() + ":00";
                                  }*//*
                                  else{
                                    return null;
                                  }
                                },*/
                                /*inputFormatters: <TextInputFormatter>[
                                  LengthLimitingTextInputFormatter(5),
                                ],*/
                                cursorColor: CustColors.light_navy,
                                //autovalidateMode: AutovalidateMode.onUserInteraction,
                                keyboardType: TextInputType.datetime,
                                controller: _timeController,
                                style: Styles.searchTextStyle02,
                                enabled: _regularIsChecked![getItemIndex(parentIndex,index)],
                                //readOnly: true,
                                //initialValue: '${selectedServiceMdlList[getItemIndex(parentIndex,index)].time}',
                                onChanged: (val) async{
                                  Duration? _durationResult = await showDurationPicker(
                                      snapToMins: 5.0,
                                      context: context,
                                      initialTime: Duration(
                                        //hours: 2,
                                          minutes: 10,
                                          seconds: 00,
                                          milliseconds: 0)
                                  );
                                  print("_durationResult >>>" + _durationResult!.inMinutes.toString() + ":00");
                                  if(_durationResult != null){
                                    setState(() {
                                      _timeController.text = "";
                                      _timeController.text = _durationResult.inMinutes.toString() + ":00";
                                    });
                                  }
                                },
                               /* onTap: () async {
                                  print(" _timeController.text >>> ${_timeController.text}" );
                                  Duration? _durationResult = await showDurationPicker(
                                    snapToMins: 5.0,
                                    context: context,
                                    initialTime: Duration(
                                        //hours: 2,
                                        minutes: 10,
                                        seconds: 00,
                                        milliseconds: 0)
                                  );
                                  print("_durationResult >>>" + _durationResult!.inMinutes.toString() + ":00");
                                  print(" _timeController.text02 >>> ${_timeController.text}" );
                                  if(_durationResult != null){
                                    setState(() {
                                      _timeController.text = "";
                                      _timeController.text = _durationResult.inMinutes.toString() + ":00";
                                      print(" _timeController.text03 >>> ${_timeController.text}" );
                                    });
                                  }

                                  print(" _timeController.text04 >>> ${_timeController.text}" );

                                  int itemIndex = getItemIndex(parentIndex,index);
                                  var temp =   SelectedServicesMdl(parentIndex, index,
                                      selectedServiceMdlList[itemIndex].serviceId,
                                      selectedServiceMdlList[itemIndex].minAmount,
                                      selectedServiceMdlList[itemIndex].maxAmount,
                                      _timeController.text, selectedServiceMdlList[itemIndex].isEnable);
                                  selectedServiceMdlList.removeAt(itemIndex);
                                  selectedServiceMdlList.insert(itemIndex,temp);

                                },*/
                                //readOnly: _regularIsChecked![index],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                )
            : Container(),
          ],

    );
  }


  int getItemIndex(int parentIndex, int childIndex){
    int itemIndex = selectedServiceMdlList.indexWhere((item) => item.parentIndex == parentIndex && item.childIndex == childIndex);
    print("itemIndex >>>>>>>> " + itemIndex.toString());
    return itemIndex;
  }


}

class SelectedServicesMdl{
  final int parentIndex;
  final int childIndex;
  final String serviceId;
  final String minAmount;
  final String maxAmount;
  final String time;
  final bool isEnable;
  SelectedServicesMdl(this.parentIndex, this.childIndex,this.serviceId, this.minAmount, this.maxAmount, this.time,this.isEnable);
}



/*
*
* child: Container(
                                child:  regularServiceList.length != 0
                                    ? ListView.separated(
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        itemCount: regularServiceList.length,
                                        itemBuilder: (context, index) {

                                      TextEditingController _rateController=TextEditingController();
                                      TextEditingController _timeController = TextEditingController();
                                      //print(regularServiceList[index].minAmount.toString() + ">>>Min amt");
                                      //print(regularServiceList[index].isEditable.toString() + ">>>isEditable amt");
                                      //_rateController.text = regularServiceList![index].minAmount.toString();
                                      _rateController.text = regularServiceList[index].minPrice.toString();
                                      _timeController.text = "10:00";
                                      _rateController.addListener(() {
                                        var temp =   SelectedServicesMdl(selectedServiceMdlList[index].serviceId,_rateController.text,  selectedServiceMdlList[index].time, selectedServiceMdlList[index].isEnable);
                                        selectedServiceMdlList.removeAt(index);
                                        selectedServiceMdlList.insert(index,temp);
                                        });
                                      _timeController.addListener(() {
                                        var temp =   SelectedServicesMdl(selectedServiceMdlList[index].serviceId,selectedServiceMdlList[index].amount, _timeController.text, selectedServiceMdlList[index].isEnable);
                                        selectedServiceMdlList.removeAt(index);
                                        selectedServiceMdlList.insert(index,temp);
                                      });
                                      return Container(

                                        child: Row(
                                          children: [
                                              Transform.scale(
                                                scale: .4,
                                                child: Checkbox(
                                                  value: _regularIsChecked![index],
                                                  onChanged: (bool? val){
                                                    setState(() {
                                                      this._regularIsChecked![index] = val!;
                                                      //isChecked ? false : true;

                                                     // serviceSpecialisationList.add(regularServiceList[index].minAmount = "1000");
                                                      print("sgsjhgj 001 $val");
                                                      if(val){
                                                        var temp =   SelectedServicesMdl(selectedServiceMdlList[index].serviceId,selectedServiceMdlList[index].amount, selectedServiceMdlList[index].time, val);
                                                        selectedServiceMdlList.removeAt(index);
                                                        selectedServiceMdlList.insert(index,
                                                            temp);
                                                      }else{
                                                        //serviceSpecialisationList.remove(regularServiceList[index]);
                                                       var temp= SelectedServicesMdl(selectedServiceMdlList[index].serviceId,selectedServiceMdlList[index].amount, selectedServiceMdlList[index].time, val);
                                                        selectedServiceMdlList.removeAt(index);
                                                        selectedServiceMdlList.insert(index,temp
                                                           );
                                                      }

                                                     /* val ?
                                                      selectedServiceMdlList.
                                                     // selectedServiceList.add(regularServiceList[index])
                                                      serviceSpecialisationList.add(regularServiceList[index])
                                                          :*/

                                                      //selectedServiceList.remove(regularServiceList[index]);
                                                      print(">>>>>>>>> Selected Make List data " + serviceSpecialisationList.length.toString());
                                                    });
                                                  },
                                                ),
                                              ),

                                              Text('${regularServiceList[index].serviceName.toString()}',),

                                              SizedBox(
                                                width: size.width / 100 * 18,
                                              ),

                                              Container(
                                                width: size.width * 15 / 100,
                                                height: size.height * 4 / 100,
                                                padding: EdgeInsets.only(
                                                  top: size.height * 1 / 100,
                                                  bottom: size.width * 1 / 100
                                                ),
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.all(
                                                      Radius.circular(2.8),
                                                    ),
                                                    border: Border.all(
                                                        color: CustColors.pinkish_grey02,
                                                        width: 0.3
                                                    ),
                                                    //color: Colors.redAccent,
                                                  ),
                                                child:  Center(
                                                  child: TextFormField(
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      contentPadding: EdgeInsets.symmetric(
                                                        vertical: 12.5,
                                                        horizontal: 6.0,
                                                      ),
                                                    ),
                                                    validator: (value){
                                                      if(value!.isEmpty){
                                                        return "Fill field";
                                                      }
                                                      else if(int.parse(value) < int.parse(regularServiceList[index].minPrice) || int.parse(value) > int.parse(regularServiceList[index].maxPrice)){
                                                        return regularServiceList[index].minPrice + "-" + regularServiceList[index].maxPrice;
                                                      }
                                                      else{
                                                        return null;
                                                      }
                                                    },
                                                    cursorColor: CustColors.light_navy,
                                                    keyboardType: TextInputType.number,
                                                    inputFormatters: <TextInputFormatter>[
                                                      FilteringTextInputFormatter.digitsOnly,
                                                      // InputValidator(ch: "cost").serviceCostValidation(100, 2000, 2050)
                                                      // CustomRangeTextInputFormatter().formatEditUpdate(regularServiceList[index]., newValue),
                                                    ],
                                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                                    //initialValue: '${regularServiceList[index].serviceName.toString()}',
                                                    controller: _rateController,
                                                    style: Styles.searchTextStyle02,
                                                    enabled: _regularIsChecked![index],
                                                    //readOnly: _regularIsChecked![index],
                                                  ),
                                                ),
                                              ),

                                              SizedBox(
                                                width: size.width / 100 * 5,
                                              ),

                                              Container(
                                                width: size.width * 15 / 100,
                                                height: size.height * 4 / 100,
                                                padding: EdgeInsets.only(
                                                    top: size.height * 1 / 100,
                                                    bottom: size.width * 1 / 100
                                                ),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.all(
                                                    Radius.circular(2.8),
                                                  ),
                                                  border: Border.all(
                                                      color: CustColors.pinkish_grey02,
                                                      width: 0.3
                                                  ),
                                                  //color: Colors.redAccent,
                                                ),
                                                child: Center(
                                                  child: TextFormField(
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      contentPadding: EdgeInsets.symmetric(
                                                        vertical: 12.5,
                                                        horizontal: 6.0,
                                                      ),
                                                    ),
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
                                         ),
                                        ],
                                      ),
                                    );
                                  },
                                  separatorBuilder: (BuildContext context, int index) {
                                      return Container(
                                        /*margin: EdgeInsets.only(
                                            //top: ScreenSize().setValue(2),
                                            left: 2.5,
                                            right: 2.5,
                                            bottom: ScreenSize().setValue(2)),*/
                                        child: Divider(
                                          height: 0,
                                        ));
                                  },
                                )
                                    : Center(
                                    child: Text('No Results found.'),
                                ),
                            ),
*
* */




