import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/AddServices/add_services_bloc.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/ServiceList/service_list_bloc.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/ServiceList/service_list_mdl.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/wait_admin_approval_screen.dart';
import 'package:auto_fix/Widgets/screen_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



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
  bool isSelected = true;

  List<bool>? _regularIsChecked;
  List<bool>? _emergencyIsChecked;
  List<SelectedServicesMdl> selectedServiceMdlRegularList=[];
  List<SelectedServicesMdl> selectedServiceMdlEmergencyList=[];

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
            if(allServiceList[i].categoryId.toString() == 1){
              emergencyServiceList.add(allServiceList[i]);
              selectedServiceMdlEmergencyList.add(SelectedServicesMdl(emergencyServiceList[i].id,emergencyServiceList[i].minAmount, "00:30", false));
            }else{
              regularServiceList.add(allServiceList[i]);
              selectedServiceMdlRegularList.add(SelectedServicesMdl(emergencyServiceList[i].id,emergencyServiceList[i].minAmount, "00:30", false));
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
  void initState() {
    // TODO: implement initState
    super.initState();
    _serviceListBloc.postServiceListRequest("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ODQsImlhdCI6MTY0NzM0MTEzMCwiZXhwIjoxNjQ3NDI3NTMwfQ.W1JWynpzAXTcSXcZo8gdrEmMlY69yUVhKhdiLdM-_IE", "3");
    _listenServiceListResponse();
    _listenAddServiceListResponse();

    _regularIsChecked = List<bool>.filled(regularServiceList.length, false);
    _emergencyIsChecked = List<bool>.filled(emergencyServiceList.length, false);
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
              color: Colors.green,
              child: Column(
                children: [
                  Container(
                    color: Colors.blue,
                    margin: EdgeInsets.only(
                        left: size.width * 32.3 / 100 ,
                        right: size.width * 32.3 / 100,
                      bottom: size.height * 0.9 / 100
                    ),
                    child: Text("Emergency "),
                  ),
                  Expanded(
                    child: Container(
                      //color: CustColors.pale_grey,
                      color: Colors.red,
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                left: size.width * 32.3 / 100 ,
                                right: size.width * 32.3 / 100,
                                top: size.height * 4 / 100
                            ),
                              child: Text("Regular",)
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
                    ),
                  )
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
  final String time;
  final bool isEnable;
  SelectedServicesMdl(this.serviceId, this.amount, this.time,this.isEnable);
}