import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/grapgh_ql_client.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/UI/Customer/Home/SideBar/MyVehicle/Add/Make/all_make_bloc.dart';
import 'package:auto_fix/UI/Customer/Home/SideBar/MyVehicle/Add/Make/all_make_mdl.dart';
import 'package:auto_fix/UI/Customer/Home/SideBar/MyVehicle/Add/Model/all_model_bloc.dart';
import 'package:auto_fix/UI/Customer/Home/SideBar/MyVehicle/Add/Model/all_model_mdl.dart';
import 'package:auto_fix/UI/Mechanic/Login/SignUp/SignUpScreen2/specialization_selection_bloc.dart';
import 'package:auto_fix/UI/Mechanic/Login/SignUp/SignUpScreen3/work_selection_screen.dart';
import 'package:auto_fix/UI/Mechanic/Login/SignUp/Widgets/select_brand_screen.dart';
import 'package:auto_fix/UI/Mechanic/Login/SignUp/Widgets/select_model_screen.dart';
import 'package:auto_fix/Widgets/indicator_widget.dart';
import 'package:auto_fix/Widgets/input_validator.dart';
import 'package:auto_fix/Widgets/screen_size.dart';
import 'package:auto_fix/Widgets/snackbar_widget.dart';
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
  FocusNode _mechanicBrandFocusNode = FocusNode();
  FocusNode _mechanicModelFocusNode = FocusNode();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  final MechanicSpecializationSelectionBloc _signupBloc =
      MechanicSpecializationSelectionBloc();
  final AllMakeBloc _allMakeBloc = AllMakeBloc();
  final AllModelBloc _allModelBloc = AllModelBloc();
  bool _isLoading = false;
  final ScrollController _scrollController = ScrollController();

  List<MakeDetails>? makeDetailsList = [];
  List<MakeDetails>? selectedMakeList = [];

  List<ModelDetails>? modelDetailsList = [];
  List<ModelDetails>? selectedModelList = [];

  String token = "";
  String selectedBrandId = "";
  String selectedModelId = "";

  var jobValues = {
    'Freelancer': false,
    'Work shop': false,
  };

  @override
  void initState() {
    super.initState();
    _addToken();
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

  _addToken() async {
    SharedPreferences _shdPre = await SharedPreferences.getInstance();
    token = _shdPre.getString(SharedPrefKeys.token)!;
    print("Token : +++++ " + token);
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
    //_mechanicBrandController.dispose();
    //_mechanicModelController.dispose();
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
        /*_allMakeBloc.postMakeData.listen((data) {});*/
        setState(() {
          makeDetailsList = value.data!.makeDetails!.toList();
          // print("c"+value.data.acceptInvitations.message.toString()+"c");
          print(">>>>>Brand Data length" +
              value.data!.makeDetails!.length.toString() +
              ">>>>>>>>>");
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

        setState(() {
          modelDetailsList = value.data!.modelDetails;
          print(">>>>>Brand Data" +
              value.data!.modelDetails!.length.toString() +
              ">>>>>>>>>");
        });

        /*_allModelBloc.postModelData.listen((data) {
        });*/
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
        setState(()  {
          print("success 01");
          _isLoading = false;

          setSignUpWorkSelectionData();


          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Successfully Registered",
                style: TextStyle(fontFamily: 'Roboto_Regular', fontSize: 14)),
            duration: Duration(seconds: 2),
            backgroundColor: CustColors.peaGreen,
          ));

          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                  const MechanicWorkSelectionScreen()));
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
                        IndicatorWidget(
                          isFirst: true,
                          isSecond: true,
                          isThird: false,
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
                            'YOUR SPECIALIZATION',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: ScreenSize().setValueFont(18),
                                fontWeight: FontWeight.w200,
                                fontFamily: 'Corbel_Bold'),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: ScreenSize().setValue(15),
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

                                //suffixIcon: Image.asset("assets/images/arrow_down.png",height: 1,width: 1,),
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
                              top: ScreenSize().setValue(12),
                              left: ScreenSize().setValue(34),
                              right: ScreenSize().setValue(34)),
                          child: TextFormField(
                            textAlignVertical: TextAlignVertical.center,
                            maxLines: 1,
                            onTap: () async {
                              _allMakeBloc.postAllMakeDataRequest(token);

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
                              });
                            },
                            readOnly: true,
                            autofocus: false,
                            style: TextStyle(
                              fontFamily: 'Corbel_Light',
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontSize: ScreenSize().setValueFont(13),
                            ),
                            focusNode: _mechanicBrandFocusNode,
                            keyboardType: TextInputType.text,
                            /*validator: InputValidator(ch: "Brand").emptyChecking,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp('[a-zA-Z0-9]')),
                            ],
                            controller: _mechanicBrandController,*/
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
                                hintText: 'Specialized brand',
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
                        selectedMakeList!.isNotEmpty
                            ? Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: ScreenSize().setValue(12),
                                        left: ScreenSize().setValue(34),
                                        right: ScreenSize().setValue(34)),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Selected Brand',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize:
                                              ScreenSize().setValueFont(15),
                                          fontWeight: FontWeight.w200,
                                          fontFamily: 'Corbel_Regular'),
                                    ),
                                  ),
                                  SingleChildScrollView(
                                    child: Container(
                                      height: selectedMakeList!.length > 8
                                          ? 70
                                          : selectedMakeList!.length > 4
                                              ? 70
                                              : 35,
                                      margin: EdgeInsets.only(
                                          top: ScreenSize().setValue(12),
                                          left: ScreenSize().setValue(33),
                                          right: ScreenSize().setValue(33)),
                                      child: GridView.builder(
                                        itemCount: selectedMakeList!.length,
                                        shrinkWrap: true,
                                        //semanticChildCount: 5,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          selectedBrandId += index + 1 <
                                                  selectedMakeList!.length
                                              ? selectedMakeList![index].id! +
                                                  ","
                                              : selectedMakeList![index].id!;

                                          return Stack(
                                            children: [
                                              Chip(
                                                shape: RoundedRectangleBorder(
                                                  side: BorderSide(
                                                      color: Colors.white,
                                                      width: .3),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                backgroundColor:
                                                    CustColors.blue,
                                                label: Center(
                                                    child: Text(
                                                  " " +
                                                      selectedMakeList![index]
                                                          .makeName! +
                                                      " ",
                                                  style: TextStyle(
                                                    color: CustColors.blue,
                                                  ),
                                                )),
                                              ),
                                              Center(
                                                  child: Text(
                                                " " +
                                                    selectedMakeList![index]
                                                        .makeName!,
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
                                            ],
                                          );
                                        },
                                        padding: EdgeInsets.zero,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          crossAxisSpacing: 8,
                                          mainAxisSpacing: 10,
                                          childAspectRatio:
                                              MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  (MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      8),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Container(
                                height: 5,
                              ),
                        Container(
                          margin: EdgeInsets.only(
                              top: ScreenSize().setValue(12),
                              left: ScreenSize().setValue(34),
                              right: ScreenSize().setValue(34)),
                          child: TextFormField(
                            textAlignVertical: TextAlignVertical.center,
                            maxLines: 1,
                            onTap: () async {
                              _allModelBloc.postAllModelDataRequest(
                                  selectedBrandId, token);
                              selectedBrandId = "";
                              print(
                                  "checking model 0001 : ${modelDetailsList!.length}");

                              selectedModelList = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SelectModelScreen(
                                            modelData: modelDetailsList!,
                                            type: "1",
                                          )));
                              print(
                                  "checking model 0002 ${selectedModelList!.length}");

                              setState(() {
                                selectedModelId = "";
                              });
                            },
                            readOnly: true,
                            autofocus: false,
                            style: TextStyle(
                              fontFamily: 'Corbel_Light',
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontSize: ScreenSize().setValueFont(13),
                            ),
                            focusNode: _mechanicModelFocusNode,
                            /*keyboardType: TextInputType.text,
                             validator:
                            InputValidator(ch: "Model").emptyChecking,
                            controller: _mechanicModelController,*/
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
                                      Icons.keyboard_arrow_down,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {},
                                  ),
                                ),
                                hintText: 'Specialized model',
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
                        selectedModelList!.isNotEmpty
                            ? Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: ScreenSize().setValue(12),
                                        left: ScreenSize().setValue(34),
                                        right: ScreenSize().setValue(34)),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Selected Brand',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize:
                                              ScreenSize().setValueFont(15),
                                          fontWeight: FontWeight.w200,
                                          fontFamily: 'Corbel_Regular'),
                                    ),
                                  ),
                                  SingleChildScrollView(
                                    child: Container(
                                      height: selectedModelList!.length > 8
                                          ? 65
                                          : selectedModelList!.length > 4
                                              ? 65
                                              : 35,
                                      margin: EdgeInsets.only(
                                          top: ScreenSize().setValue(12),
                                          left: ScreenSize().setValue(33),
                                          right: ScreenSize().setValue(33)),
                                      child: GridView.builder(
                                        itemCount: selectedModelList!.length,
                                        shrinkWrap: true,
                                        semanticChildCount: 5,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          selectedModelId += index + 1 <
                                                  selectedModelList!.length
                                              ? selectedModelList![index].id! +
                                                  ","
                                              : selectedModelList![index].id!;
                                          return Stack(
                                            children: [
                                              Chip(
                                                shape: RoundedRectangleBorder(
                                                  side: BorderSide(
                                                      color: Colors.white,
                                                      width: .3),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                backgroundColor:
                                                    CustColors.blue,
                                                label: Center(
                                                    child: Text(
                                                  " " +
                                                      selectedModelList![index]
                                                          .modelName! +
                                                      " ",
                                                  style: TextStyle(
                                                    color: CustColors.blue,
                                                  ),
                                                )),
                                              ),
                                              Center(
                                                  child: Text(
                                                " " +
                                                    selectedModelList![index]
                                                        .modelName!,
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
                                            ],
                                          );
                                        },
                                        padding: EdgeInsets.zero,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 4,
                                          crossAxisSpacing: 8,
                                          mainAxisSpacing: 10,
                                          childAspectRatio:
                                              MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  (MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      6),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Container(
                                height: 20,
                              ),
                        Container(
                          margin: EdgeInsets.only(
                              top: ScreenSize().setValue(15),
                              left: ScreenSize().setValue(34),
                              right: ScreenSize().setValue(34)),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'JOB TYPE',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: ScreenSize().setValueFont(18),
                                fontWeight: FontWeight.w200,
                                fontFamily: 'Corbel_Bold'),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: ScreenSize().setValue(6),
                              left: ScreenSize().setValue(34),
                              right: ScreenSize().setValue(30)),
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                  children: [
                                    Text(jobValues.keys.elementAt(0),style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Corbel_Regular'
                                    ),),
                                    Theme(
                                      data: ThemeData(unselectedWidgetColor: Colors.white),
                                      child: Checkbox(
                                        //activeColor: CustColors.blue,
                                        value: jobValues.values.elementAt(0),
                                        onChanged: (bool? val){
                                          setState(() {
                                            //jobValues.values.elementAt(0) = val!;
                                            if(jobValues.values.elementAt(1)){
                                              jobValues['Work shop'] = false;
                                            }
                                            jobValues['Freelancer'] = val!;
                                            print(">>>>>>>>> Freelancer " + val.toString());
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              Row(
                                children: [
                                  Text(jobValues.keys.elementAt(1),style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Corbel_Regular'
                                  ),),
                                  Theme(
                                    data: ThemeData(unselectedWidgetColor: Colors.white),
                                    child: Checkbox(
                                      value: jobValues.values.elementAt(1),
                                      onChanged: (bool? val){
                                        setState(() {
                                          if(jobValues.values.elementAt(0)){
                                            jobValues['Freelancer'] = false;
                                          }
                                          jobValues['Work shop'] = val!;
                                        });
                                        print(">>>>>>>>> Work shop " + val.toString());
                                      },
                                    ),
                                  ),
                                ],
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

                                      validateForm();

                                      /*if (_formKey.currentState!.validate()) {

                                        validateForm();
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                const MechanicWorkSelectionScreen()));
                                      } else {
                                        setState(() => _autoValidate =
                                            AutovalidateMode.always);
                                      }*/
                                    },
                                    child: Container(
                                      child: Center(
                                        child: Text(
                                          'Next',
                                          style: TextStyle(
                                            color: CustColors.blue,
                                            fontFamily: 'Corbel_Regular',
                                            fontWeight: FontWeight.w600,
                                            fontSize:
                                                ScreenSize().setValueFont(11.5),
                                          ),
                                        ),
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

  void validateForm(){

    if(selectedMakeList!.isEmpty){
      setSnackBar("Brand is required");
    }else if(selectedModelList!.isEmpty){
      setSnackBar("Model is required");
    }else if(!jobValues.values.contains(true)){
      setSnackBar("Select Job Type");
    }else{

      SnackBarWidget().setSnackBar("Success.... !", context);

      var brandId;var modelId;
      brandId = selectedMakeList!.map((e) => e.id);
      modelId = selectedModelList!.map((e) => e.id);

      var data = jobValues.entries.firstWhere((element) => element.value == true);
      print(">>>>>>>>>>> Data " +data.key);
      brandId = brandId.toString().replaceAll("(", "") ;
      brandId = brandId.toString().replaceAll(")", "") ;
      modelId = modelId.toString().replaceAll("(", "");
      modelId = modelId.toString().replaceAll(")", "");

      _signupBloc
          .postSignUpSpecializationSelectionRequest(
           token,
          _mechanicExperienceController.text,
          brandId, modelId,
          data.key);
      setState(() {
        _isLoading = true;
      });

    }

  }

  void setSnackBar(String msg){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('$msg',
          style: TextStyle(fontFamily: 'Roboto_Regular', fontSize: 14)),
      duration: Duration(seconds: 2),
      backgroundColor: CustColors.peaGreen,
    ));
  }
}
