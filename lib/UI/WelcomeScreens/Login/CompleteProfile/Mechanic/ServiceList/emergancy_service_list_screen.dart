import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/home_Bloc/home_customer_bloc.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/home_Customer_Models/serviceSearchListAll_Mdl.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/AddServices/add_services_bloc.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/ServiceList/category_service_list_mdl.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/wait_admin_approval_screen.dart';
import 'package:auto_fix/Widgets/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  String authToken="";

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
      print('authToken >>>>>>> '+authToken.toString());
      _homeCustomerBloc.postSearchServiceRequest("$authToken", "", null, "1");
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
          //_isLoading = false;
        });

      } else {

        setState(() {
          print("success postServiceList >>>>>>>  ${value.status}");
          //print("success Auth token >>>>>>>  ${value.data!.customersSignUpIndividual!.token.toString()}");

          //_isLoading = false;
          print(value.data!.serviceListAll!.length);
          emergencyServiceList = value.data!.serviceListAll!;

          for(int i=0;i<emergencyServiceList.length;i++){
            selectedServiceMdlList.add(SelectedServicesMdl(emergencyServiceList[i].id.toString(),emergencyServiceList[i].minPrice, "10:00", false));
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
    return  SafeArea(
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
                      child: Text("Select Emergency Services",
                        style: Styles.serviceSelectionTitle01Style,)),
                ),

                Container(
                  margin: EdgeInsets.only(
                    top: size.height * 0.026,
                    /*left: size.width * 0.025,
                      right: size.width * 0.078,*/
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
                              onChanged: (val){
                                print(val);
                                if(val.isNotEmpty){
                                  _homeCustomerBloc.postSearchServiceRequest("$authToken", val, "25","1");
                                }else{
                                  _homeCustomerBloc.postSearchServiceRequest("$authToken", null, null, "1");
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

                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                        top: size.height * 0.023,
                        bottom: size.height * 0.019
                    ),
                    color: CustColors.pale_grey,
                    height: size.height * 0.80, //0.764
                    child: Container(
                      margin: EdgeInsets.only(
                          left: size.width * 0.049,
                          right: size.width * 0.049,
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
                                  _rateController.text = emergencyServiceList[index].minPrice.toString();
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
                                  //print(regularServiceList[index].minAmount.toString() + ">>>Min amt");
                                  //print(regularServiceList[index].isEditable.toString() + ">>>isEditable amt");
                                  //_rateController.text = regularServiceList![index].minAmount.toString();
                                  return Container(
                                    child: Row(
                                      children: [
                                        Transform.scale(
                                          scale: .4,
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
                                                print(">>>>>>>>> Selected Make List data " + emergencyServiceList.length.toString());
                                              });
                                            },
                                          ),
                                        ),

                                        Expanded(
                                          flex: 3,
                                          child: Text(
                                            '${emergencyServiceList[index].serviceName.toString()}',
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
                                                  horizontal: 6.0,
                                                ),
                                              ),
                                              validator: (value){
                                                if(value!.isEmpty){
                                                  return "Fill field";
                                                }
                                                else if(int.parse(value) < int.parse(emergencyServiceList[index].minPrice) || int.parse(value) > int.parse(emergencyServiceList[index].maxPrice)){
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
                                              enabled: _emergencyIsChecked![index],
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

                    print(" >>>> serviceId " +serviceId + " >>>> feeList " + feeList + " >>>>>>>> timeList" + timeList);

                    _addServiceListBloc.postMechanicAddServicesRequest(
                        authToken,
                        serviceId,  feeList, timeList);

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
    );
  }

}

class SelectedServicesMdl{
  final String serviceId;
  final String amount;
  final String time;
  final bool isEnable;
  SelectedServicesMdl(this.serviceId, this.amount, this.time,this.isEnable);
}