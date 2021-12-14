import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/UI/Mechanic/Login/SignUp/SignUpScreen2/work_selection_bloc.dart';
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
  bool _isLoading = false;
  final ScrollController _scrollController = ScrollController();

  List<String> regularServiceDataList = ['abc', 'bcd', 'cde', 'def'];
  List<String> emergencyServiceDataList = ['abcd', 'bcde', 'cdef', 'defg'];

  List<String> regularServiceSelectedList = [];
  List<String> emergencyServiceSelectedList = [];
  bool isEmergencyEnabled = false;

  @override
  void initState() {
    super.initState();
    _getSignUpRes();
    for (int i = 1; i <= 10; i++) {
      i <= 9
          ? _mechanicYearList.add(i.toString())
          : _mechanicYearList.add(i.toString() + "+");
      // _walletTypeList.add(i.toString());
    }
  }

  _setSignUpVisitFlag() async {
    SharedPreferences _shdPre = await SharedPreferences.getInstance();
    _shdPre.setBool(SharedPrefKeys.isMechanicSignUp, true);
  }

  @override
  void dispose() {
    super.dispose();
    _mechanicExperienceController.dispose();

    _signupBloc.dispose();
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

          setSignUpWorkSelectionData();

          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Successfully Registered",
                style: TextStyle(fontFamily: 'Roboto_Regular', fontSize: 14)),
            duration: Duration(seconds: 2),
            backgroundColor: CustColors.peaGreen,
          ));
          // Navigator.pushReplacement(context,
          //     MaterialPageRoute(builder: (context) => const LoginScreen()));
          FocusScope.of(context).unfocus();
        });
      }
    });
  }

  void setSignUpWorkSelectionData() async {
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    shdPre.setInt(SharedPrefKeys.mechanicSignUpStatus, 1);
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
        //textValue = 'Switch Button is ON';
      });
      print('Switch Button is ON');
    } else {
      setState(() {
        emergencyServiceSelectedList = [];
        isEmergencyEnabled = false;
        //textValue = 'Switch Button is OFF';
      });
      print('Switch Button is OFF');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //backgroundColor: CustColors.blue,
        body: Theme(
          data: ThemeData(
            disabledColor: Colors.white,
          ),
          child: Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
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
                        Container(
                          margin: EdgeInsets.only(
                              top: ScreenSize().setValue(26),
                              left: ScreenSize().setValue(34),
                              right: ScreenSize().setValue(34)),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Work Selection',
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
                          child: TextFormField(
                            textAlignVertical: TextAlignVertical.center,
                            maxLines: 1,
                            onTap: () {
                              showYearSelectionDialog();
                            },
                            readOnly: true,
                            autofocus: false,
                            style: TextStyle(
                              fontFamily: 'Corbel_Light',
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontSize: ScreenSize().setValueFont(13),
                            ),
                            focusNode: _mechanicExperienceFocusNode,
                            keyboardType: TextInputType.text,
                            validator:
                                InputValidator(ch: "Experience").emptyChecking,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp('[a-zA-Z0-9]')),
                            ],
                            controller: _mechanicExperienceController,
                            decoration: InputDecoration(
                                disabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: .3,
                                  ),
                                ),
                                isDense: true,
                                hintText: 'Year of Experience',
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
                        Container(
                          margin: EdgeInsets.only(
                              top: ScreenSize().setValue(20),
                              left: ScreenSize().setValue(34),
                              right: ScreenSize().setValue(34)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Do you wish to provide Emergency Services ?",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.5,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Corbel_Regular"),
                              ),
                              Switch(
                                onChanged: toggleIsEmergencyEnabled,
                                value: isEmergencyEnabled,
                                activeColor: Colors.white,
                                activeTrackColor: Colors.white70,
                                inactiveThumbColor: Colors.black26,
                                inactiveTrackColor: Colors.black12,
                              ),
                            ],
                          ),
                        ),
                        isEmergencyEnabled
                            ? (emergencyServiceSelectedList.isEmpty
                                ? Container(
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          top: ScreenSize().setValue(20),
                                          left: ScreenSize().setValue(34),
                                          right: ScreenSize().setValue(34)),
                                      child: TextFormField(
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        maxLines: 1,
                                        onTap: () {
                                          showAllServicesSelectionDialog();
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
                                        validator: InputValidator(
                                                ch: "Select Services")
                                            .emptyChecking,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp('[a-zA-Z]')),
                                        ],
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
                                            hintText: 'Select Services',
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
                                  )
                                : Container(
                                    margin: EdgeInsets.only(
                                        top: ScreenSize().setValue(20),
                                        left: ScreenSize().setValue(34),
                                        right: ScreenSize().setValue(34)),
                                    child: GridView.builder(
                                      itemCount:
                                          emergencyServiceSelectedList.length,
                                      shrinkWrap: true,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        //return Text(emergencyServiceSelectedList[index]);
                                        return _serviceDataItem(
                                            emergencyServiceSelectedList[index],
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
                              )
                            : (regularServiceSelectedList.isEmpty
                                ? Container(
                                    child: Container(
                                margin: EdgeInsets.only(
                                    top: ScreenSize().setValue(20),
                                    left: ScreenSize().setValue(34),
                                    right: ScreenSize().setValue(34)),
                                child: TextFormField(
                                  textAlignVertical:
                                  TextAlignVertical.center,
                                  maxLines: 1,
                                  onTap: () {
                                    showRegularServicesSelectionDialog();
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
                                  validator: InputValidator(
                                      ch: "Services List")
                                      .emptyChecking,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp('[a-zA-Z]')),
                                  ],
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
                                      hintText: 'Select Services',
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
                                  )
                                : Container(
                                    margin: EdgeInsets.only(
                                        top: ScreenSize().setValue(20),
                                        left: ScreenSize().setValue(34),
                                        right: ScreenSize().setValue(34)),
                                    child: GridView.builder(
                            itemCount:
                            regularServiceSelectedList.length,
                            shrinkWrap: true,
                            itemBuilder:
                                (BuildContext context, int index) {
                              //return Text(emergencyServiceSelectedList[index]);
                              return _serviceDataItem(
                                  regularServiceSelectedList[index],
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
                                        _signupBloc.postSignUpRequest(
                                          _mechanicExperienceController.text,
                                          isEmergencyEnabled,
                                          "abcd"
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

                        IntrinsicHeight(
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            fit: StackFit.expand,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                //margin: EdgeInsets.only(top: 40),
                                alignment: Alignment.topCenter,

                                child: Column(
                                  children: [
                                    Image.asset(
                                      'assets/images/signup_arc.png',
                                      fit: BoxFit.fitHeight,
                                      width: MediaQuery.of(context).size.width,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                  width: double.infinity,
                                  alignment: Alignment.topCenter,
                                  margin: EdgeInsets.only(
                                      left: ScreenSize().setValue(66),
                                      top: ScreenSize().setValue(119.6),
                                      right: ScreenSize().setValue(78)),
                                  child: Image.asset(
                                    'assets/images/autofix_logo.png',
                                  )),
                            ],
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
            regularServiceDataList,
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


  /*void checkPassWord(String pwds, String cndpwd) {
    if (pwds != cndpwd) {
      //toastMsg.toastMsg(msg: "Passwords are different!");
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Passwords are different!",
            style: TextStyle(fontFamily: 'Roboto_Regular', fontSize: 14)),
        duration: Duration(seconds: 2),
        backgroundColor: CustColors.peaGreen,
      ));
      setState(() {
        _passwordController.text = "";
        _confirmPwdController.text = "";
      });
    } else {
      print("firstNameController.text : "+ _firstNameController.text+
            "emailController.text : " + _emailController.text +
            "phoneController.text : " + _phoneController.text +
            "address : " + _addressController.text +
            "passwordController.text : " + _passwordController.text);
      _signupBloc.postSignUpRequest(
        _firstNameController.text,
          _emailController.text,
          _phoneController.text,
          _addressController.text,
          10.397118,76.140387,
          _walletIdController.text,
          _passwordController.text
      );
      setState(() {
        _isLoading = true;
      });
    }
  }*/

  /*void showDialCodeSelector() {
    _signupBloc.searchStates("");
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return BottomSheet(
                onClosing: () {},
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20))),
                builder: (BuildContext context) {
                  return SingleChildScrollView(
                    child: Container(
                      height: 421,
                      child: Stack(
                        children: <Widget>[
                          Container(
                              width: double.maxFinite,
                              child: Column(children: [
                                Container(
                                  height: ScreenSize().setValue(36.3),
                                  margin: EdgeInsets.only(
                                      left: ScreenSize().setValue(41.3),
                                      right: ScreenSize().setValue(41.3),
                                      top: ScreenSize().setValue(20.3)),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(
                                        ScreenSize().setValue(20),
                                      ),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black38,
                                        spreadRadius: 0,
                                        blurRadius: 1.5,
                                        offset: Offset(0, 1),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              left: _setValue(23.4)),
                                          alignment: Alignment.center,
                                          height: _setValue(36.3),
                                          child: Center(
                                            child: TextFormField(
                                              keyboardType:
                                              TextInputType.visiblePassword,
                                              textAlignVertical:
                                              TextAlignVertical.center,
                                              onChanged: (text) {
                                                setState(() {
                                                  _countryData.clear();
                                                  isloading = true;
                                                });
                                                _signupBloc.searchStates(text);
                                              },
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: 'Corbel_Regular',
                                                  fontWeight: FontWeight.w600,
                                                  color: CustColors.blue),
                                              decoration: InputDecoration(
                                                hintText: "Search Your  State",
                                                border: InputBorder.none,
                                                contentPadding:
                                                new EdgeInsets.only(
                                                    bottom: 15),
                                                hintStyle: TextStyle(
                                                  color: CustColors.greyText,
                                                  fontSize: 12,
                                                  fontFamily: 'Corbel-Light',
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                            width: _setValue(25),
                                            height: _setValue(25),
                                            margin: EdgeInsets.only(
                                                right: _setValue(19)),
                                            decoration: BoxDecoration(
                                              color: CustColors.blue,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                  20,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                right: _setValue(19)),
                                            child: Image.asset(
                                              'assets/images/search.png',
                                              width: _setValue(10.4),
                                              height: _setValue(10.4),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 421 - 108,
                                  padding:
                                  EdgeInsets.only(top: _setValue(22.4)),
                                  child: _countryData.length != 0
                                      ? ListView.separated(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: _countryData.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                          onTap: () {
                                            final dial_Code =
                                                _countryData[index].name;

                                            setState(() {
                                              _stateController.text =
                                                  dial_Code.toString();
                                            });

                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(
                                              left: _setValue(41.3),
                                              right: _setValue(41.3),
                                            ),
                                            child: Text(
                                              '${_countryData[index].name}',
                                              style: TextStyle(
                                                  fontSize:
                                                  _setValueFont(12),
                                                  fontFamily:
                                                  'Corbel-Light',
                                                  fontWeight:
                                                  FontWeight.w600,
                                                  color:
                                                  Color(0xff0b0c0d)),
                                            ),
                                          ));
                                    },
                                    separatorBuilder:
                                        (BuildContext context,
                                        int index) {
                                      return Container(
                                          margin: EdgeInsets.only(
                                              top: _setValue(12.7),
                                              left: _setValue(41.3),
                                              right: _setValue(41.3),
                                              bottom: _setValue(12.9)),
                                          child: Divider(
                                            height: 0,
                                          ));
                                    },
                                  )
                                      : Center(
                                    child: Text('No Results found.'),
                                  ),
                                ),
                              ])),
                          Center(
                            child: isloading
                                ? CircularProgressIndicator()
                                : Text(''),
                          )
                        ],
                      ),
                    ),
                  );
                });
          });
        });
  }*/

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
