import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/grapgh_ql_client.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/UI/Mechanic/Login/SignUp/SignUpScreen3/services_fee_list/service_fee_bloc.dart';
import 'package:auto_fix/UI/Mechanic/Login/SignUp/SignUpScreen3/services_fee_list/service_fee_mdl.dart';
import 'package:auto_fix/UI/Mechanic/Login/SignUp/SignUpScreen3/work_selection_bloc.dart';
import 'package:auto_fix/UI/Mechanic/Login/SignUp/SignUpScreen3/work_selection_mdl.dart';
import 'package:auto_fix/UI/Mechanic/Login/SignUp/Widgets/select_brand_screen.dart';
import 'package:auto_fix/UI/Mechanic/Login/SignUp/Widgets/select_service_screen.dart';
import 'package:auto_fix/UI/Mechanic/Login/admin_approval_screen.dart';
import 'package:auto_fix/Widgets/indicator_widget.dart';
import 'package:auto_fix/Widgets/input_validator.dart';
import 'package:auto_fix/Widgets/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MechanicWorkSelectionScreen extends StatefulWidget {
  const MechanicWorkSelectionScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MechanicWorkSelectionScreenState();
  }
}

class _MechanicWorkSelectionScreenState
    extends State<MechanicWorkSelectionScreen> {
  List<String> _mechanicYearList = [];

  TextEditingController _mechanicExperienceController = TextEditingController();

  FocusNode _mechanicExperienceFocusNode = FocusNode();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  final MechanicWorkSelectionBloc _signupBloc = MechanicWorkSelectionBloc();
  final AllServiceFeeBloc _allServiceBloc = AllServiceFeeBloc();
  bool _isLoading = false;
  final ScrollController _scrollController = ScrollController();

  List<String> regularServiceDataList = ['abc', 'bcd', 'cde', 'def'];
  List<String> emergencyServiceDataList = ['abcd', 'bcde', 'cdef', 'defg'];

  List<String> regularServiceSelectedList = [];
  List<String> emergencyServiceSelectedList = [];

  List<AllServiceFeeData> serviceList =[];
  List<AllServiceFeeData> selectedRegularServiceList =[];
  List<AllServiceFeeData> selectedEmergencyServiceList =[];

  /*List<MakeDetails>? makeDetailsList = [];
  List<MakeDetails>? selectedMakeList = [];

  List<ModelDetails>? modelDetailsList = [];
  List<ModelDetails>? selectedModelList = [];*/

  String token = "";
  bool isEmergencyEnabled = false;

  TimeOfDay _startTime = TimeOfDay(hour: 00, minute: 00);
  TimeOfDay _endTime = TimeOfDay(hour: 00, minute: 00);

  void _selectStartTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _startTime,
      initialEntryMode: TimePickerEntryMode.input,
    );
    if (newTime != null) {
      setState(() {
        _startTime = newTime;
      });
    }
  }

  void _selectEndTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _startTime,
      initialEntryMode: TimePickerEntryMode.input,
    );
    if (newTime != null) {
      setState(() {
        //_startTime = newTime;
        _endTime = newTime;
      });
    }
  }
  @override
  void initState() {
    super.initState();
    _addToken();
    _getAllService();
    _getSignUpRes();
    for (int i = 1; i <= 10; i++) {
      i <= 9
          ? _mechanicYearList.add(i.toString())
          : _mechanicYearList.add(i.toString() + "+");
      // _walletTypeList.add(i.toString());
    }
    _allServiceBloc.postAllServiceDataRequest(1, 25, 1, token);
  }

  _addToken() async {
    SharedPreferences _shdPre = await SharedPreferences.getInstance();
    token = _shdPre.getString(SharedPrefKeys.token)!;
    print("Token : " + token);
    GqlClient.I.config(token: token);
  }
  _setSignUpVisitFlag() async {
    SharedPreferences _shdPre = await SharedPreferences.getInstance();
    _shdPre.setBool(SharedPrefKeys.isMechanicSignUp, true);
  }

  @override
  void dispose() {
    super.dispose();
    _mechanicExperienceController.dispose();
    _allServiceBloc.dispose();
    _signupBloc.dispose();
  }

  _getAllService() async {
    _allServiceBloc.postAllServiceFee.listen((value) {
      if (value.status == "error") {
        setState(() {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(value.message.toString(),
                style: const TextStyle(
                    fontFamily: 'Roboto_Regular', fontSize: 14)),
            duration: const Duration(seconds: 2),
            backgroundColor: CustColors.peaGreen,
          ));
        });
      } else {
        _allServiceBloc.postServiceData.listen((data) {
          setState(() {
            serviceList = data;
            // print("c"+value.data.acceptInvitations.message.toString()+"c");
            print(">>>>>Brand Data length" +
                value.data!.serviceList!.allServiceFeeData!.length.toString() +
                //value.data!.makeDetails!.length.toString() +
                ">>>>>>>>>");
            print(serviceList.length);
          });
        });
      }
    });
  }

  _getSignUpRes() {
    _signupBloc.postSignUp.listen((value) {
      if (value.status == "error") {
        setState(() {
          print("errrrorr 02");
          _isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(value.message.toString(),
                style: const TextStyle(
                    fontFamily: 'Roboto_Regular', fontSize: 14)),
            duration: const Duration(seconds: 2),
            backgroundColor: CustColors.peaGreen,
          ));
        });
      } else {
        setState(() async {
          print("errrrorr 01");
          _isLoading = false;

          setSignUpWorkSelectionData(value);

          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Successfully Registered",
                style: TextStyle(fontFamily: 'Roboto_Regular', fontSize: 14)),
            duration: Duration(seconds: 2),
            backgroundColor: CustColors.peaGreen,
          ));

          /*Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                  const AdminApprovalScreen()));*/
          FocusScope.of(context).unfocus();
        });
      }
    });
  }

  void setSignUpWorkSelectionData(MechanicWorkSelectionMdl value) async {
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    shdPre.setInt(SharedPrefKeys.mechanicSignUpStatus, 3);
    shdPre.setString(SharedPrefKeys.mechanicCode, value.data!.mechanicSignUpWorkSelection!.mechanicCode!);
    /*shdPre.setString(SharedPrefKeys.userProfilePic,
              value.data!.customerSignUp!.customer!.profilePic.toString());
          shdPre.setInt(SharedPrefKeys.isDefaultVehicleAvailable,
              value.data!.customerSignUp!.customer!.isProfileCompleted!);
          shdPre.setString(
              SharedPrefKeys.token, value.data!.customerSignUp!.token!);
          shdPre.setString(
              SharedPrefKeys.userName,
              value.data!.customerSignUp!.customer!.firstName.toString() +
                  " " +
                  value.data!.customerSignUp!.customer!.lastName.toString());
          shdPre.setString(SharedPrefKeys.userEmail,
              value.data!.customerSignUp!.customer!.emailId.toString());
          shdPre.setInt(SharedPrefKeys.userID,
              int.parse(value.data!.customerSignUp!.customer!.id!));*/
  }

  void toggleIsEmergencyEnabled(bool value) {
    if (isEmergencyEnabled == false) {
      setState(() {
        isEmergencyEnabled = true;
        regularServiceSelectedList = [];
      });
      print('Switch Button is ON');
    } else {
      setState(() {
        emergencyServiceSelectedList = [];
        isEmergencyEnabled = false;
      });
      print('Switch Button is OFF');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustColors.blue,
        body: Theme(
          data: ThemeData(
            disabledColor: Colors.white,
          ),
          child: Container(
            height: MediaQuery.of(context).size.height,
            //color: Colors.white,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              controller: _scrollController,
              child: Container(
                // height: double.infinity,
                child: Form(
                  autovalidateMode: _autoValidate,
                  key: _formKey,
                  child: Container(
                    color: CustColors.blue,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IndicatorWidget(
                          isFirst: true,
                          isSecond: true,
                          isThird: true,
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: ScreenSize().setValue(10),
                              left: ScreenSize().setValue(34),
                              right: ScreenSize().setValue(34)),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Sign up',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: ScreenSize().setValueFont(19.5),
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Corbel_Bold'),
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.only(
                              top: ScreenSize().setValue(20),
                              left: ScreenSize().setValue(34),
                              right: ScreenSize().setValue(34)),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'YOUR SERVICE SKILLS',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: ScreenSize().setValueFont(18),
                                fontWeight: FontWeight.w200,
                                fontFamily: 'Corbel_Bold'),
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.only(
                              top: ScreenSize().setValue(20),
                              left: ScreenSize().setValue(34),
                              right: ScreenSize().setValue(34)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Do you wish to enable emergency service",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Corbel_Regular"),
                              ),
                              Switch(
                                onChanged: toggleIsEmergencyEnabled,
                                value: isEmergencyEnabled,
                                activeColor: Colors.white,
                                activeTrackColor: Colors.white70,
                                inactiveThumbColor: Colors.white70,
                                inactiveTrackColor: CustColors.borderColor,
                              ),
                            ],
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.only(
                              top: ScreenSize().setValue(20),
                              left: ScreenSize().setValue(34),
                              right: ScreenSize().setValue(34)),
                          child: TextFormField(
                            textAlignVertical: TextAlignVertical.center,
                            maxLines: 1,
                            onTap: () async {

                              print("checking 0001 Regular ${serviceList.length}");

                              SelectedData data = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SelectServiceScreen(
                                        serviceList: serviceList,
                                        type: "2",
                                      )));

                              selectedRegularServiceList = data.services!;
                              print("checking 0002 Regular ${data.services!.length}");

                              /*_allMakeBloc.postAllMakeDataRequest(token);

                              print("checking 0001 ${makeDetailsList!.length}");

                              selectedMakeList = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SelectBrandScreen(
                                        brandData: makeDetailsList!,
                                        type: "1",
                                      )));
                              print(
                                  "checking 0002 ${selectedMakeList!.length}");
                              setState(() {
                                selectedBrandId = "";
                                selectedModelId = "";
                                modelDetailsList = [];
                                selectedModelList = [];
                              });*/
                            },
                            readOnly: true,
                            autofocus: false,
                            style: TextStyle(
                              fontFamily: 'Corbel_Light',
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontSize: ScreenSize().setValueFont(13),
                            ),
                            //focusNode: _mechanicBrandFocusNode,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                disabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: .3,
                                  ),
                                ),
                                isDense: true,
                                suffixIconConstraints: BoxConstraints(
                                  minWidth: 30,
                                  minHeight: 30,
                                ),
                                suffixIcon: Container(
                                  width: 3,
                                  alignment: Alignment.centerRight,
                                  child: IconButton(
                                    iconSize: 20,
                                    icon: Icon(
                                      // Based on passwordVisible state choose the icon
                                      Icons.keyboard_arrow_down,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {},
                                  ),
                                ),
                                hintText: 'Select Emergency Services',
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: .3,
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: .3,
                                  ),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: .3,
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: ScreenSize().setValue(7.8),
                                ),
                                hintStyle: TextStyle(
                                  fontFamily: 'Corbel_Light',
                                  color: Colors.white.withOpacity(.60),
                                  fontWeight: FontWeight.w600,
                                  fontSize: ScreenSize().setValueFont(12),
                                )),
                          ),
                        ),

                        selectedRegularServiceList.isNotEmpty
                            ? Container(
                              margin: EdgeInsets.only(
                                  top: ScreenSize().setValue(20),
                                  left: ScreenSize().setValue(34),
                                  right: ScreenSize().setValue(34)),
                              child: GridView.builder(
                                itemCount:
                                selectedRegularServiceList.length,
                                shrinkWrap: true,
                                itemBuilder:
                                (BuildContext context, int index) {
                              //return Text(emergencyServiceSelectedList[index]);
                              return _serviceDataItem(
                                  selectedRegularServiceList[index].serviceName.toString(),
                                  index);
                              //return _generalServiceListItem(generalServiceList![index], index);
                            },
                            padding: EdgeInsets.zero,
                            gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              //crossAxisSpacing: 40.0,
                              // mainAxisSpacing: 13.9,
                              childAspectRatio:
                              MediaQuery.of(context).size.width /
                                  (MediaQuery.of(context)
                                      .size
                                      .height /
                                      5),
                            ),
                          ),
                        )
                            : Container(),

                        isEmergencyEnabled ? Container(
                          child: Container(
                            margin: EdgeInsets.only(
                                top: ScreenSize().setValue(20),
                                left: ScreenSize().setValue(34),
                                right: ScreenSize().setValue(34)),
                            child: TextFormField(
                              textAlignVertical:
                              TextAlignVertical.center,
                              maxLines: 1,
                              onTap: () async {
                                print("checking 0001 Regular ${serviceList.length}");

                                SelectedData data = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SelectServiceScreen(
                                          serviceList: serviceList,
                                          type: "1",
                                        )));

                                selectedEmergencyServiceList = data.services!;
                                print("checking 0002 Regular ${data.services!.length}");
                              },
                              readOnly: true,
                              autofocus: false,
                              style: TextStyle(
                                fontFamily: 'Corbel_Light',
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                fontSize:
                                ScreenSize().setValueFont(13),
                              ),
                              //focusNode: _mechanicExperienceFocusNode,
                              keyboardType: TextInputType.text,
                              /*validator: InputValidator(
                                  ch: "Select Services")
                                  .emptyChecking,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp('[a-zA-Z]')),
                              ],*/
                              //controller: _mechanicExperienceController,
                              decoration: InputDecoration(
                                  disabledBorder:
                                  UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: .3,
                                    ),
                                  ),
                                  isDense: true,
                                  hintText: 'Select Emergency Services',
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: .3,
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: .3,
                                    ),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: .3,
                                    ),
                                  ),
                                  contentPadding:
                                  EdgeInsets.symmetric(
                                    vertical:
                                    ScreenSize().setValue(7.8),
                                  ),
                                  hintStyle: TextStyle(
                                    fontFamily: 'Corbel_Light',
                                    color:
                                    Colors.white.withOpacity(.60),
                                    fontWeight: FontWeight.w600,
                                    fontSize:
                                    ScreenSize().setValueFont(12),
                                  )),
                            ),
                          ),
                        ) : Container(),
                        selectedEmergencyServiceList.isNotEmpty
                            ? Container(
                                margin: EdgeInsets.only(
                                    top: ScreenSize().setValue(20),
                                    left: ScreenSize().setValue(34),
                                    right: ScreenSize().setValue(34)),
                                  child: GridView.builder(
                                    itemCount:
                                    selectedEmergencyServiceList.length,
                                    shrinkWrap: true,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      //return Text(emergencyServiceSelectedList[index]);
                                      return _serviceDataItem(
                                          selectedEmergencyServiceList[index].serviceName.toString(),
                                          index);
                                      //return _generalServiceListItem(generalServiceList![index], index);
                                    },
                                    padding: EdgeInsets.zero,
                                    gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  //crossAxisSpacing: 40.0,
                                  // mainAxisSpacing: 13.9,
                                  childAspectRatio:
                                  MediaQuery.of(context).size.width /
                                      (MediaQuery.of(context)
                                          .size
                                          .height /
                                      5),
                              ),
                            ),
                        )
                            : Container(),

                        Container(
                          margin: EdgeInsets.only(
                              top: ScreenSize().setValue(20),
                              left: ScreenSize().setValue(34),
                              right: ScreenSize().setValue(34)),
                          child: Text(
                            "Set Your Regular Working Time",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Corbel_Regular"),
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.only(
                              top: ScreenSize().setValue(20),
                              left: ScreenSize().setValue(34),
                              right: ScreenSize().setValue(34)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Start Time",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Corbel_Regular"),
                              ),
                              Text(
                                "End Time",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Corbel_Regular"),
                              ),
                            ],
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.only(
                              top: ScreenSize().setValue(20),
                              left: ScreenSize().setValue(34),
                              right: ScreenSize().setValue(34)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                onPressed: _selectStartTime,
                                child: Text('SELECT TIME'),
                              ),
                              ElevatedButton(
                                onPressed: _selectEndTime,
                                child: Text('SELECT TIME'),
                              ),
                            ],
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.only(
                              top: ScreenSize().setValue(15),
                              left: ScreenSize().setValue(5),
                              right: ScreenSize().setValue(5)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextFormField(
                                //initialValue: regularServiceList![index].minAmount.toString(),
                                /*validator:
                                                    InputValidator(ch: "Phone number")
                                                           .phoneNumChecking,
                                                    inputFormatters: [
                                                     LengthLimitingTextInputFormatter(15),
                                                        ],*/
                                maxLines: 1,
                                //focusNode: _phoneFocusNode,
                                textAlignVertical:
                                TextAlignVertical.center,
                                keyboardType: TextInputType.number,
                                //controller: _rateController,
                                style: TextStyle(
                                  fontFamily: 'Corbel_Light',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                  fontSize:
                                  ScreenSize().setValueFont(10
                                  ),
                                ),
                                enableSuggestions: false,
                                decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding:
                                    EdgeInsets.symmetric(
                                      vertical:
                                      ScreenSize().setValue(7.8),
                                    ),
                                    hintStyle: TextStyle(
                                      fontFamily: 'Corbel_Light',
                                      //color: Colors.white.withOpacity(.60),
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize:
                                      ScreenSize().setValueFont(12),
                                    )),
                              ),
                              /*TextFormField(
                                //initialValue: regularServiceList![index].minAmount.toString(),
                                *//*validator:
                                                        InputValidator(ch: "Phone number")
                                                            .phoneNumChecking,
                                                        inputFormatters: [
                                                          LengthLimitingTextInputFormatter(15),
                                                        ],*//*
                                maxLines: 1,
                                //focusNode: _phoneFocusNode,
                                textAlignVertical:
                                TextAlignVertical.center,
                                keyboardType: TextInputType.phone,
                                //controller: _rateController,
                                style: TextStyle(
                                  fontFamily: 'Corbel_Light',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                  fontSize:
                                  ScreenSize().setValueFont(10
                                  ),
                                ),
                                enableSuggestions: false,
                                decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding:
                                    EdgeInsets.symmetric(
                                      vertical:
                                      ScreenSize().setValue(7.8),
                                    ),
                                    hintStyle: TextStyle(
                                      fontFamily: 'Corbel_Light',
                                      //color: Colors.white.withOpacity(.60),
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize:
                                      ScreenSize().setValueFont(12),
                                    )),
                              )*/
                            ],
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.only(
                              top: ScreenSize().setValue(20),
                              left: ScreenSize().setValue(34),
                              right: ScreenSize().setValue(34)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${_startTime.format(context)}',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                '${_endTime.format(context)}',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Container(
                          height: ScreenSize().setValue(28),
                          width: ScreenSize().setValue(98),
                          margin: EdgeInsets.only(
                              top: ScreenSize().setValue(25),
                              left: ScreenSize().setValue(34),
                              right: ScreenSize().setValue(34)),
                          child: _isLoading
                              ? Center(
                                  child: Container(
                                    height: ScreenSize().setValue(28),
                                    width: ScreenSize().setValue(28),
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          CustColors.peaGreen),
                                    ),
                                  ),
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                        color: CustColors.darkBlue,
                                        blurRadius: 5,
                                        offset: Offset(0, 3.3),
                                      ),
                                    ],
                                  ),
                                  child: MaterialButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        /*validateForm(
                                        );*/
                                        // checkPassWord(
                                        // _passwordController.text,
                                        //_confirmPwdController.text);

                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                const AdminApprovalScreen()));

                                        _signupBloc.postSignUpWorkSelectionRequest(
                                            isEmergencyEnabled?1:0, "1,2,3",
                                          "100,150,120",
                                          _startTime.toString(), _endTime.toString()
                                        );
                                      } else {
                                        setState(() => _autoValidate =
                                            AutovalidateMode.always);
                                      }
                                    },
                                    child: Container(
                                      child: Row(
                                        children: [
                                          Text(
                                            'Save',
                                            style: TextStyle(
                                              color: CustColors.blue,
                                              fontFamily: 'Corbel_Regular',
                                              fontWeight: FontWeight.w600,
                                              fontSize: ScreenSize()
                                                  .setValueFont(11.5),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                              left: ScreenSize().setValue(16.6),
                                            ),
                                            child: Image.asset(
                                              'assets/images/arrow_forword.png',
                                              width:
                                                  ScreenSize().setValue(12.5),
                                              height:
                                                  ScreenSize().setValue(12.5),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            ScreenSize().setValue(16))),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showYearSelectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: CustColors.blue,
          title: Text(
            " Select Year",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          titlePadding: EdgeInsets.all(20),
          contentPadding: EdgeInsets.only(left: 0, right: 0, bottom: 0),
          content: Container(
            color: Colors.white,
            height: 400,
            width: 400,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _mechanicYearList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  child: ListTile(
                      title: Text(_mechanicYearList[index]),
                      onTap: () {
                        final yearSelected =
                            _mechanicYearList[index].toString();
                        setState(() {
                          _mechanicExperienceController.text =
                              " " + yearSelected.toString() + " Year";
                        });
                        Navigator.pop(context);
                      }),
                );
              },
            ),
          ),
        );
      },
    );
  }

  void showAllServicesSelectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Select Services"),
          content: MultiSelectChip(
            emergencyServiceDataList,
            onSelectionChanged: (selectedList) {
              setState(() {
                emergencyServiceSelectedList = selectedList;
                //emergencyServiceSelectedList.add(selectedList.toString());
              });
            },
          ),
          actions: <Widget>[
            FlatButton(
              child: const Text("OK"),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        );
      },
    );
  }

  void showRegularServicesSelectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Select Services"),
          content: MultiSelectChip(
            regularServiceSelectedList,
            onSelectionChanged: (selectedList) {
              setState(() {
                regularServiceSelectedList = selectedList;
                //emergencyServiceSelectedList.add(selectedList.toString());
              });
            },
          ),
          actions: <Widget>[
            FlatButton(
              child: const Text("OK"),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        );
      },
    );
  }


  /*Widget _generalServiceListItem(String data, int index) {
    return Container(
        width: double.infinity,
        child: Column(
          children: [
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(top: 10),
                      child: Text(
                        searchData.serviceName!.replaceAll('\n', ""),
                        softWrap: true,
                        maxLines: 2,
                        style: TextStyle(
                            color: CustColors.black01,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            fontFamily: "Corbel_Light"),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _searchData!.removeAt(index);
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(top: 10),
                      child: Image.asset('assets/images/close_circle.png',
                          width: _setValue(9.2), height: _setValue(9.2)),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 20, right: 10),
                      height: 10,
                      child: VerticalDivider(
                        thickness: 1,
                        width: 0,
                      )),
                ],
              ),
            ),
          ],
        ));
  }*/

  Widget _serviceDataItem(String serviceData, int index) {
    return Container(
        width: double.infinity,
        child: Column(
          children: [
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(top: 10),
                      child: Text(
                        serviceData.replaceAll(' , ', ""),
                        style: TextStyle(
                          fontFamily: 'Corbel_Light',
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: ScreenSize().setValueFont(13),
                        ),
                        // serviceData.serviceName!.replaceAll('\n', ""),
                        softWrap: true,
                        maxLines: 2,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      emergencyServiceSelectedList.removeAt(index);
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(top: 10),
                      child: Image.asset('assets/images/close_circle.png',
                          //width: _setValue(9.2), height: _setValue(9.2)),
                          width: 9.2,
                          height: 9.2),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 20, right: 10),
                      height: 10,
                      child: VerticalDivider(
                        thickness: 1,
                        width: 0,
                      )),
                ],
              ),
            ),
          ],
        ));
  }
}



/*  FilterChip(
                          label: Text("text"),
                          backgroundColor: Colors.transparent,
                          shape: StadiumBorder(side: BorderSide()),
                          onSelected: (bool value) {print("selected");},

                        ),*/

/* Chip(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.yellow, width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: Colors.red,
                          deleteIcon: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 15,
                          ),
                          label: Text("searchController.recentSearchesList[index]", style: TextStyle(color: Colors.white),),
                          deleteButtonTooltipMessage: 'erase',
                          onDeleted: () {
                            print("deleted");
                          },
                        ),*/


class MultiSelectChip extends StatefulWidget {
  final List<String> reportList;
  final Function(List<String>) onSelectionChanged; // +added
  MultiSelectChip(this.reportList, {required this.onSelectionChanged} // +added
      );

  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}

class _MultiSelectChipState extends State<MultiSelectChip> {
  // String selectedChoice = "";
  List<String> selectedChoices = [];
  _buildChoiceList() {
    List<Widget> choices = [];
    widget.reportList.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          label: Text(item),
          selected: selectedChoices.contains(item),
          onSelected: (selected) {
            setState(() {
              selectedChoices.contains(item)
                  ? selectedChoices.remove(item)
                  : selectedChoices.add(item);
              widget.onSelectionChanged(selectedChoices); // +added
            });
          },
        ),
      ));
    });
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}
