import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/home_Bloc/home_customer_bloc.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/home_Customer_Models/serviceSearchListAll_Mdl.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/AddServices/add_services_bloc.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/ServiceList/category_service_list_mdl.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/wait_admin_approval_screen.dart';
import 'package:auto_fix/Widgets/screen_size.dart';
import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';


class EmergencyServiceListScreen extends StatefulWidget {

  EmergencyServiceListScreen();

  @override
  State<StatefulWidget> createState() {
    return _EmergencyServiceListScreenState();
  }
}

class _EmergencyServiceListScreenState extends State<EmergencyServiceListScreen> {

  final MechanicAddServiceListBloc _addServiceListBloc = MechanicAddServiceListBloc();
  final HomeCustomerBloc _homeCustomerBloc = HomeCustomerBloc();


  List<ServiceListAll> emergencyServiceList = [];
  List<ServiceListAll> selectedServiceList = [];

  String title = "";
  List<bool>? _emergencyIsChecked;

  String selectedService = "";
  List<Service> serviceSpecialisationList =[];
  List<SelectedServicesMdl> selectedServiceMdlList=[];
  bool _isLoadingPage = true;
  String authToken="", userCode = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPrefData();
    _listenServiceListResponse();
    _listenAddServiceListResponse();
    _emergencyIsChecked = List<bool>.filled(emergencyServiceList.length, false);
  }

  Future<void> getSharedPrefData() async {
    print('getSharedPrefData');
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    setState(() {
      authToken = shdPre.getString(SharedPrefKeys.token).toString();
      userCode = shdPre.getString(SharedPrefKeys.userCode).toString();
      print('authToken >>>>>>> '+authToken.toString());
      _homeCustomerBloc.postSearchServiceRequest("$authToken", null, null, null, "1");
      //_serviceListBloc.postServiceListRequest(authToken, null, null, "1" );
    });
  }

  _listenServiceListResponse() {
    _homeCustomerBloc.postSearchService.listen((value) {
      if (value.status == "error") {
        setState(() {
          //SnackBarWidget().setMaterialSnackBar( "${value.message}", _scaffoldKey);
          print("message postServiceList >>>>>>>  ${value.message}");
          print("errrrorr postServiceList >>>>>>>  ${value.status}");
          _isLoadingPage = false;
          //_isLoading = false;
        });
      } else {

        setState(() {
          print("success postServiceList >>>>>>>  ${value.status}");
          //print("success Auth token >>>>>>>  ${value.data!.customersSignUpIndividual!.token.toString()}");
          _isLoadingPage = false;
          //_isLoading = false;
          print(value.data!.serviceListAll!.length);
          emergencyServiceList = value.data!.serviceListAll!;

          for(int i=0;i<emergencyServiceList.length;i++){
            selectedServiceMdlList.add(SelectedServicesMdl(
                emergencyServiceList[i].id.toString(),
                emergencyServiceList[i].minPrice,
                emergencyServiceList[i].minPrice,
                "10:00", false));
          }
          _emergencyIsChecked = List<bool>.filled(emergencyServiceList.length, false);
          print(_emergencyIsChecked!.length);

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
          Fluttertoast.showToast(
            msg: "select preferred services!!",
            backgroundColor: CustColors.light_navy,
            timeInSecForIosWeb: 1,
          );
          //SnackBarWidget().setMaterialSnackBar( "${value.message}", _scaffoldKey);
          print("message postServiceList >>>>>>>  ${value.message}");
        });

      } else {

        setState(() async {
          print("success postServiceList >>>>>>>  ${value.status}");
          //print("success Auth token >>>>>>>  ${value.data!.customersSignUpIndividual!.token.toString()}");

          //_isLoading = false;
          print("success refNumber: userCode, >>>>>>>  ${userCode}");
          SharedPreferences _shdPre = await SharedPreferences.getInstance();
          _shdPre.setInt(SharedPrefKeys.isWorkProfileCompleted, 3);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => WaitAdminApprovalScreen(refNumber: '$userCode',) ));
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
    return  MaterialApp(
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
                        6.0,6.0,6.0,4.0
                    ),
                    child: Container(
                        alignment: Alignment.centerLeft,
                        child: const Text("Select Emergency Services",
                          style: Styles.serviceSelectionTitle01Style,)),
                  ),

                  Container(
                    margin: EdgeInsets.only(
                      top: size.height * 0.025,
                      /*left: size.width * 0.025,
                        right: size.width * 0.078,*/
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
                                onChanged: (val){
                                  print(val);
                                  if(val.isNotEmpty){
                                    _homeCustomerBloc.postSearchServiceRequest("$authToken", val, null, "25","1");
                                  }else{
                                    _homeCustomerBloc.postSearchServiceRequest("$authToken", null,null, null, "1");
                                  }
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

                  _isLoadingPage == true
                      ?
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    child: const Center(
                      child: CircularProgressIndicator(color: CustColors.light_navy,),),
                  )
                      :
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
                            left: size.width * 0.010,
                            right: size.width * 0.030,
                            //top: size.height * 0.03,
                            bottom: size.height * 0.030
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
                                    //_rateController.text = emergencyServiceList[index].minPrice.toString();
                                    _rateController.text = selectedServiceMdlList[index].fee.toString();
                                    _timeController.text = selectedServiceMdlList[index].time;
                                    _rateController.addListener(() {
                                      var temp =   SelectedServicesMdl(
                                          selectedServiceMdlList[index].serviceId,
                                          selectedServiceMdlList[index].amount,
                                          _rateController.text,
                                          selectedServiceMdlList[index].time,
                                          selectedServiceMdlList[index].isEnable);
                                      selectedServiceMdlList.removeAt(index);
                                      selectedServiceMdlList.insert(index,temp);
                                    });
                                    _timeController.addListener(() {
                                      var temp =   SelectedServicesMdl(selectedServiceMdlList[index].serviceId,
                                          selectedServiceMdlList[index].amount,
                                          selectedServiceMdlList[index].fee,
                                          _timeController.text,
                                          selectedServiceMdlList[index].isEnable);
                                      selectedServiceMdlList.removeAt(index);
                                      selectedServiceMdlList.insert(index,temp);
                                    });
                                    //_rateController.text = regularServiceList![index].minAmount.toString();
                                    return Container(
                                      child: Row(
                                        children: [
                                          Transform.scale(
                                            scale: .5,
                                            child: Checkbox(
                                              activeColor: CustColors.light_navy,
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
                                                    var temp =   SelectedServicesMdl(selectedServiceMdlList[index].serviceId,
                                                        selectedServiceMdlList[index].amount,
                                                        selectedServiceMdlList[index].fee,
                                                        selectedServiceMdlList[index].time, val);
                                                    selectedServiceMdlList.removeAt(index);
                                                    selectedServiceMdlList.insert(index,
                                                        temp);
                                                  }else{
                                                    //serviceSpecialisationList.remove(regularServiceList[index]);
                                                    var temp= SelectedServicesMdl(
                                                        selectedServiceMdlList[index].serviceId,
                                                        selectedServiceMdlList[index].amount,
                                                        selectedServiceMdlList[index].fee,
                                                        selectedServiceMdlList[index].time, val);
                                                    selectedServiceMdlList.removeAt(index);
                                                    selectedServiceMdlList.insert(index,temp
                                                    );
                                                  }
                                                  print(">>>>>>>>> Selected Make List data " + emergencyServiceList.length.toString());
                                                });
                                              },
                                            ),
                                          ),

                                          Expanded(
                                            flex: 3,
                                            child: Text(
                                              '${emergencyServiceList[index].serviceName.toString()}',
                                              style: Styles.searchTextStyle02,
                                            ),
                                          ),

                                          Container(
                                            width: size.width * 18 / 100,
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
                                                decoration: const InputDecoration(
                                                  border: InputBorder.none,
                                                  contentPadding: EdgeInsets.symmetric(
                                                    vertical: 12,
                                                    horizontal: 6.0,
                                                  ),
                                                  errorStyle: TextStyle(
                                                    fontFamily: "Samsung_SharpSans_Medium",
                                                    fontSize: 5,
                                                    letterSpacing: .3,
                                                  )
                                                ),
                                                validator: (value){
                                                  if(value!.trim().isEmpty){
                                                    return "Fill field";
                                                  }
                                                  else if(int.parse(value) < int.parse(emergencyServiceList[index].minPrice) ){
                                                    return emergencyServiceList[index].minPrice + " - " + emergencyServiceList[index].maxPrice;
                                                  }
                                                  else if( int.parse(value) > int.parse(emergencyServiceList[index].maxPrice)){
                                                    return emergencyServiceList[index].minPrice + " - " + emergencyServiceList[index].maxPrice;
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
                                          ),

                                          SizedBox(
                                            width: size.width / 100 * 4,
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
                                              child: InkWell(
                                                onTap: ()async{

                                                  if(_emergencyIsChecked![index]){
                                                    Duration? _durationResult = await showDurationPicker(
                                                        snapToMins: 5.0,
                                                        context: context,
                                                        initialTime: Duration(
                                                          //hours: 2,
                                                            minutes: int.parse(_timeController.text.toString().replaceAll(":00", "")),
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
                                                  }
                                                },
                                                child: TextFormField(
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    contentPadding: EdgeInsets.symmetric(
                                                      vertical: 12,
                                                      horizontal: 6.0,
                                                    ),
                                                  ),
                                                  validator: (value){
                                                    if(value!.isEmpty){
                                                      return "Fill field";
                                                    }
                                                    else{
                                                      return null;
                                                    }
                                                  },
                                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                                  controller: _timeController,
                                                  style: Styles.searchTextStyle02,
                                                  enabled: false,
                                                  showCursor: false,
                                                ),
                                              ),
                                            ),
                                          ),

                                        ],
                                      ),
                                    );
                                  },
                                  separatorBuilder: (BuildContext context, int index) {
                                    return Container(
                                      /* margin: EdgeInsets.only(
                                                  top: ScreenSize().setValue(10),
                                                  left: 5,
                                                  right: 5,
                                                  bottom: ScreenSize().setValue(10)),*/
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

                  _isLoadingPage == true
                      ?
                  Container()
                      :
                  InkWell(
                    onTap: (){
                      // Map<List<AllServiceFeeData>?, String> myData = new Map();
                      //SelectedData data = SelectedData(selectedServiceList,"rate");

                      print(">>>>>>> selectedServiceMdlList.length ${selectedServiceMdlList.length}");
                      List<SelectedServicesMdl> selectedService=[];

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

                      String serviceId="";
                      String feeList = "[";
                      String timeList = "[";

                      for(int m = 0 ; m< selectedService.length; m++){
                        if( m != selectedService.length-1){
                          serviceId = serviceId + "${selectedService[m].serviceId}" + ", ";
                          feeList = feeList + """ "${selectedService[m].fee}",""";
                          timeList = timeList + """ "${selectedService[m].time}",""";
                        }else{
                          serviceId = serviceId + "${selectedService[m].serviceId}" ;
                          feeList = feeList + """ "${selectedService[m].fee}" """;
                          timeList = timeList + """ "${selectedService[m].time}" """;
                        }
                      }
                      serviceId = serviceId ;
                      feeList = feeList + "]";
                      timeList = timeList + "]";

                      print(" >>>> serviceId " +serviceId + " >>>> feeList " + feeList + " >>>>>>>> timeList" + timeList);

                      _addServiceListBloc.postMechanicAddServicesRequest(
                          authToken,
                          serviceId,  feeList, timeList, 1);

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
}

class SelectedServicesMdl{
  final String serviceId;
  final String amount;
  final String fee;
  final String time;
  final bool isEnable;
  SelectedServicesMdl(this.serviceId, this.amount,this.fee, this.time,this.isEnable);
}