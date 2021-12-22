import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/UI/Customer/Home/SideBar/MyVehicle/Add/Make/all_make_bloc.dart';
import 'package:auto_fix/UI/Customer/Home/SideBar/MyVehicle/Add/Make/all_make_mdl.dart';
import 'package:auto_fix/UI/Customer/Home/SideBar/MyVehicle/Add/Model/all_model_bloc.dart';
import 'package:auto_fix/UI/Customer/Home/SideBar/MyVehicle/Add/Model/all_model_mdl.dart';
import 'package:auto_fix/UI/Mechanic/Login/SignUp/SignUpScreen2/specialization_selection_bloc.dart';
import 'package:auto_fix/UI/Mechanic/Login/SignUp/SignUpScreen3/work_selection_screen.dart';
import 'package:auto_fix/Widgets/input_validator.dart';
import 'package:auto_fix/Widgets/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MechanicSpecializationSelectionScreen extends StatefulWidget {
  const MechanicSpecializationSelectionScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MechanicSpecializationSelectionScreenState();
  }
}

class _MechanicSpecializationSelectionScreenState
    extends State<MechanicSpecializationSelectionScreen> {
  List<String> _mechanicYearList = [];

  TextEditingController _mechanicExperienceController = TextEditingController();

  FocusNode _mechanicExperienceFocusNode = FocusNode();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  final MechanicSpecializationSelectionBloc _signupBloc = MechanicSpecializationSelectionBloc();
  final AllMakeBloc _allMakeBloc = AllMakeBloc();
  final AllModelBloc _allModelBloc = AllModelBloc();
  bool _isLoading = false;
  final ScrollController _scrollController = ScrollController();

  List<MakeDetails>? makeDetailsList = [];
  List<MakeDetails>? selectedMakeList = [];

  List<ModelDetails>? modelDetailsList = [];
  List<ModelDetails>? selectedModelList = [];


  @override
  void initState() {
    super.initState();
    _getAllModel();
    _getAllMake();
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
    _allModelBloc.dispose();
    _allMakeBloc.dispose();
    _signupBloc.dispose();
  }

  _getAllMake() async {
    _allMakeBloc.postAllMake.listen((value) {
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
        _allMakeBloc.postMakeData.listen((data) {
          setState(() {
            makeDetailsList = data;
            // print("c"+value.data.acceptInvitations.message.toString()+"c");
            print(">>>>>Brand Data" +
                value.data!.makeDetails!.length.toString() +
                ">>>>>>>>>");
          });
        });
      }
    });
  }

  _getAllModel() async {
    _allModelBloc.postAllModel.listen((value) {
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
        _allModelBloc.postModelData.listen((data) {
          setState(() {
            modelDetailsList = data;
            print(">>>>>Brand Data" +
                value.data!.modelDetails!.length.toString() +
                ">>>>>>>>>");
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
                            'Expertize Selection',
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

                        /*Container(
                          margin: EdgeInsets.only(
                              top: ScreenSize().setValue(20),
                              left: ScreenSize().setValue(34),
                              right: ScreenSize().setValue(34)),
                          child: TextFormField(
                            textAlignVertical: TextAlignVertical.center,
                            maxLines: 1,
                            onTap: () {
                              //showYearSelectionDialog();
                            },
                            readOnly: true,
                            autofocus: false,
                            style: TextStyle(
                              fontFamily: 'Corbel_Light',
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontSize: ScreenSize().setValueFont(13),
                            ),
                            //focusNode: _mechanicExperienceFocusNode,
                            keyboardType: TextInputType.text,
                            validator:
                            InputValidator(ch: "Experience").emptyChecking,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp('[a-zA-Z0-9]')),
                            ],
                            //controller: _mechanicExperienceController,
                            decoration: InputDecoration(
                                disabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: .3,
                                  ),
                                ),
                                isDense: true,
                                hintText: 'Select Car brands',
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
                        ),*/

                        /*Container(
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
                               ),*/

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
                                                const MechanicWorkSelectionScreen()));

                                        _signupBloc.postSignUpSpecializationSelectionRequest(
                                          "1 year","1,2", "1,2","workshop"
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


}
