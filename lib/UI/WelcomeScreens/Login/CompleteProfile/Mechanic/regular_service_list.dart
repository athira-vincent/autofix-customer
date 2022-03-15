import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/AddServices/add_services_bloc.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/ServiceList/service_list_bloc.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/ServiceList/service_list_mdl.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/wait_admin_approval_screen.dart';
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
  final MechanicAddServiceListBloc _addServiceListBloc = MechanicAddServiceListBloc();

  List<EmeregencyOrRegularServiceList> regularServiceList = [];
  List<EmeregencyOrRegularServiceList> selectedServiceList = [];
  List<bool>? _regularIsChecked;

  String title = "";
  String selectedService = "";
  List<EmeregencyOrRegularServiceList> serviceSpecialisationList =[];
  List<SelectedServicesMdl> selectedServiceMdlList=[];


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
          regularServiceList = value.data!.emeregencyOrRegularServiceList!;

          for(int i=0;i<regularServiceList.length;i++){
            selectedServiceMdlList.add(SelectedServicesMdl(regularServiceList[i].id,regularServiceList[i].minAmount, "00:30", false));
          }
          _regularIsChecked = List<bool>.filled(regularServiceList.length, false);
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
  void initState() {
    super.initState();
    _serviceListBloc.postServiceListRequest("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ODQsImlhdCI6MTY0NzM0MTEzMCwiZXhwIjoxNjQ3NDI3NTMwfQ.W1JWynpzAXTcSXcZo8gdrEmMlY69yUVhKhdiLdM-_IE", "1");

    _listenServiceListResponse();
    _listenAddServiceListResponse();


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

                                    TextEditingController _rateController=TextEditingController();
                                    TextEditingController _timeController = TextEditingController();
                                    //print(regularServiceList[index].minAmount.toString() + ">>>Min amt");
                                    //print(regularServiceList[index].isEditable.toString() + ">>>isEditable amt");
                                    //_rateController.text = regularServiceList![index].minAmount.toString();
                                    _rateController.text=regularServiceList[index].minAmount.toString();
                                    _timeController.text = "30:00";
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

                                              // Container(
                                              //   child: TextFormField(
                                              //     initialValue: '${regularServiceList[index].serviceName.toString()}',
                                              //     style: Styles.searchTextStyle02,
                                              //     enabled: _regularIsChecked![index],
                                              //     readOnly: _regularIsChecked![index],
                                              //   ),
                                              // ),
                                              SizedBox(
                                                width: size.width / 100 * 20,
                                              ),
                                              //Text('${regularServiceList[index].minAmount.toString()}'),
                                              Flexible(
                                                child: TextFormField(
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

                    for(int m = 0 ; m< selectedService.length; m++){
                      if( m != selectedService.length-1){
                        serviceId = serviceId + "${selectedServiceMdlList[m].serviceId}" + ", ";
                        feeList = feeList + """ "${selectedServiceMdlList[m].amount}",""";
                        timeList = timeList + """ "${selectedServiceMdlList[m].time}",""";
                      }else{
                        serviceId = serviceId + "${selectedServiceMdlList[m].serviceId}" ;
                        feeList = feeList + """ "${selectedServiceMdlList[m].amount}" """;
                        timeList = timeList + """ "${selectedServiceMdlList[m].time}" """;
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

                    print(" >>>> serviceId" +serviceId + " >>>> feeList " + feeList + " >>>>>>>> timeList" + timeList);

                    _addServiceListBloc.postMechanicAddServicesRequest(
                        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ODQsImlhdCI6MTY0NzM0MTEzMCwiZXhwIjoxNjQ3NDI3NTMwfQ.W1JWynpzAXTcSXcZo8gdrEmMlY69yUVhKhdiLdM-_IE",
                        serviceId,  feeList, "12:50,50:00,30:00");
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