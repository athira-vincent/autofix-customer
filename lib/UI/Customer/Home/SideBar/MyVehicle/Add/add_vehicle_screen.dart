import 'dart:io';

import 'package:another_xlider/another_xlider.dart';
import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/grapgh_ql_client.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';

import 'package:auto_fix/UI/Customer/Home/SideBar/MyVehicle/Add/Engine/all_engine_bloc.dart';
import 'package:auto_fix/UI/Customer/Home/SideBar/MyVehicle/Add/Engine/all_engine_mdl.dart';
import 'package:auto_fix/UI/Customer/Home/SideBar/MyVehicle/Add/Make/all_make_bloc.dart';
import 'package:auto_fix/UI/Customer/Home/SideBar/MyVehicle/Add/Model/all_model_bloc.dart';
import 'package:auto_fix/UI/Customer/Home/SideBar/MyVehicle/Add/Model/all_model_mdl.dart';
import 'package:auto_fix/UI/Customer/Home/SideBar/MyVehicle/Add/add_vehicle_bloc.dart';
import 'package:auto_fix/UI/Customer/Home/home_screen.dart';
import 'package:auto_fix/Widgets/input_validator.dart';
import 'package:auto_fix/Widgets/screen_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Make/all_make_mdl.dart';

class AddVehicleScreen extends StatefulWidget {
  const AddVehicleScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AddVehicleScreenState();
  }
}

class _AddVehicleScreenState extends State<AddVehicleScreen> {
  final picker = ImagePicker();
  File? _images;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  TextEditingController _brandController = TextEditingController();
  TextEditingController _modelController = TextEditingController();
  TextEditingController _engineController = TextEditingController();
  TextEditingController _yearController = TextEditingController();
  TextEditingController _maintenanceController = TextEditingController();

  String token = "";
  final DateTime initialDate = DateTime.now();
  DateTime? selectedDate;

  final DateTime initialYear = DateTime.now();
  DateTime? selectedYear;

  List<MakeDetails>? makeDetails = [];
  MakeDetails? value;

  List<ModelDetails>? modelDetails = [];
  ModelDetails? modelValue;

  List<EngineDetails>? engineDetails = [];
  EngineDetails? engineValue;

  final AddVehicleBloc _addVehicleBloc = AddVehicleBloc();
  final AllMakeBloc _allMakeBloc = AllMakeBloc();
  final AllModelBloc _allModelBloc = AllModelBloc();
  final AllEngineBloc _allEngineBloc = AllEngineBloc();

  bool _isLoading = false;
  bool isloading = false;
  bool _loadingBrand = false;
  bool _loadingModel = false;
  bool _loadingEngineType = false;
  double _mileageData = 1000;
  String brandName = "";
  String modelName = "";
  int? selectedBrandId;
  int? selectedModelId;
  int? selectedEngineId;

  double per = .10;
  double perfont = .10;
  double _setValue(double value) {
    return value * per + value;
  }

  double _setValueFont(double value) {
    return value * perfont + value;
  }

  @override
  void initState() {
    super.initState();
    _addToken();
    //_allModelBloc.postAllModelRequest(make_id);
    //_allEngineBloc.postAllEngineRequest(model_id);
    _getAllModel();
    _getAllMake();
    _getAllEngine();
    _addVehicle();
    selectedBrandId = 0;
    selectedDate = initialDate;
    selectedYear = initialYear;
  }

  _addToken() async {
    SharedPreferences _shdPre = await SharedPreferences.getInstance();
    token = _shdPre.getString(SharedPrefKeys.token)!;
    print("Token : " + token);
    GqlClient.I.config(token: token);
    _allMakeBloc.postAllMakeDataRequest(token);
  }

  @override
  void dispose() {
    super.dispose();
    _brandController.dispose();
    _modelController.dispose();
    _engineController.dispose();
    _yearController.dispose();
    _maintenanceController.dispose();
    _addVehicleBloc.dispose();
    _allModelBloc.dispose();
    _allMakeBloc.dispose();
    _allEngineBloc.dispose();
  }

  void onFocusChange() {
    setState(() {});
  }

  _getAllMake() async {
    _allMakeBloc.postAllMake.listen((value) {
      if (value.status == "error") {
        setState(() {
          _loadingBrand = false;
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
            _loadingBrand = false;
            makeDetails = data;
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
          _loadingModel = false;
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
            _loadingModel = false;
            modelDetails = data;
            print(">>>>>Brand Data" +
                value.data!.modelDetails!.length.toString() +
                ">>>>>>>>>");
          });
        });
      }
    });
  }

  _getAllEngine() async {
    _allEngineBloc.postAllEngine.listen((value) {
      if (value.status == "error") {
        setState(() {
          _loadingEngineType = false;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(value.message.toString(),
                style: const TextStyle(
                    fontFamily: 'Roboto_Regular', fontSize: 14)),
            duration: const Duration(seconds: 2),
            backgroundColor: CustColors.peaGreen,
          ));
        });
      } else {
        _allEngineBloc.postEngineData.listen((data) {
          setState(() {
            _loadingEngineType = false;
            engineDetails = data;
          });
        });
      }
    });
  }

  _addVehicle() async {
    _addVehicleBloc.postAddVehicle.listen((value) {
      if (value.status == "error") {
        setState(() {
          bool _isLoading = false;
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
          print("errrrorr 01");
          _isLoading = false;
          print(">>>>>Vehicle Api Data" +
              "id : " +
              value.data!.vehicleCreate!.id.toString() +
              "Customer Id : " +
              value.data!.vehicleCreate!.customerId.toString() +
              "Last Maintenance : " +
              value.data!.vehicleCreate!.lastMaintenance.toString() +
              ">>>>>>>>>");
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Successfully Registered",
                style: TextStyle(fontFamily: 'Roboto_Regular', fontSize: 14)),
            duration: Duration(seconds: 2),
            backgroundColor: CustColors.darkBlue,
          ));
          setIsDefaultVehicleAvailable();
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const HomeScreen()));
          FocusScope.of(context).unfocus();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Form(
          key: _formKey,
          autovalidateMode: _autoValidate,
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                AspectRatio(
                  aspectRatio: 1.75,
                  child: Container(
                    padding: EdgeInsets.only(right: 5),
                    width: double.infinity,
                    //color: Colors.red,
                    child: Stack(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 165,
                              child: Container(
                                margin: EdgeInsets.all(4),
                                padding: EdgeInsets.only(
                                    top: 15, bottom: 5, left: 8, right: 5),
                                // color: Colors.purple,
                                child: Column(
                                  children: [
                                    Text(
                                      "Add Your Vechicle",
                                      style: TextStyle(
                                        color: CustColors.blue,
                                        fontSize:
                                            ScreenSize().setValueFont(19.5),
                                        fontFamily: 'Corbel_Bold',
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 135,
                              child: Stack(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 9.5, right: 8),
                                    width: double.infinity,
                                    height: double.infinity,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: CustColors.cloudy_blue,
                                        style: BorderStyle.solid,
                                        width: 1.0,
                                      ),
                                      color: CustColors.cloudy_blue,
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: 20.8,
                                              right: 34.8,
                                              top: 18.5),
                                          child: Text(
                                            "Upload Your Vechicle Photos",
                                            style: TextStyle(
                                                color: CustColors.blue,
                                                fontFamily: 'Corbel_Regular',
                                                fontSize: ScreenSize()
                                                    .setValueFont(14),
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                left: 23,
                                                right: 32.8,
                                                top: 10.5),
                                            width: double.infinity,
                                            height: double.infinity,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: _images != null
                                                  ? Image.file(
                                                      File(_images!.path),
                                                      fit: BoxFit.cover,
                                                      /*width: 65,
                                                  height: 65,*/
                                                    )
                                                  : Container(
                                                      color: CustColors.blue),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            _showDialogSelectPhoto();
                                          },
                                          child: Container(
                                            alignment: Alignment.topRight,
                                            margin: EdgeInsets.only(
                                                top: 1,
                                                right: 9.8,
                                                bottom: 8.3),
                                            padding: EdgeInsets.all(1),
                                            child: Image.asset(
                                              "assets/images/icon_add.png",
                                              width: ScreenSize().setValue(25),
                                              height: ScreenSize().setValue(25),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: 18.4, top: 77.9, right: 120.4),
                          width: double.infinity,
                          child: AspectRatio(
                            aspectRatio: 1.75,
                            child: Image.asset(
                              "assets/images/car_image.png",
                              width: double.infinity,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: Container(
                    margin: EdgeInsets.only(left: 10.8, right: 10.8),
                    padding: EdgeInsets.all(2),
                    //color: Colors.green,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: InkWell(
                              onTap: () {
                                showBrandSelector();
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 19),
                                    //padding: EdgeInsets.only(left: 17.5, right: 7.3, top: 10, bottom: 14),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: CustColors.cloudy_blue,
                                          spreadRadius: 0,
                                          blurRadius: 1.5,
                                          offset: Offset(0, .8),
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    height: 40.8,
                                  ),
                                  Container(
                                    color: Colors.transparent,
                                    margin: EdgeInsets.only(top: 18),
                                    padding: EdgeInsets.only(
                                        left: 17.5,
                                        right: 8,
                                        top: 8,
                                        bottom: 14),
                                    child: TextFormField(
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      maxLines: 1,
                                      enabled: false,
                                      style: TextStyle(
                                        fontSize:
                                            ScreenSize().setValueFont(14.5),
                                        color: CustColors.blue,
                                        fontFamily: 'Corbel_Regular',
                                      ),
                                      keyboardType: TextInputType.text,
                                      validator: InputValidator(ch: "Brand")
                                          .emptyChecking,
                                      controller: _brandController,
                                      decoration: InputDecoration(
                                        suffixIconConstraints: BoxConstraints(
                                          minWidth: 30,
                                          minHeight: 30,
                                        ),
                                        suffixIcon: Container(
                                          width: 5,
                                          alignment: Alignment.centerLeft,
                                          child: SizedBox(
                                            height: 28,
                                            width: 28,
                                            child: Image.asset(
                                              'assets/images/icon_dropdown_arrow.png',
                                            ),
                                          ),
                                        ),
                                        isDense: true,
                                        hintText: 'Select Your Brand',
                                        hintStyle: TextStyle(
                                          fontSize:
                                              ScreenSize().setValueFont(14.5),
                                          color: CustColors.blue,
                                          fontFamily: 'Corbel_Regular',
                                        ),
                                        errorStyle: TextStyle(
                                          fontSize: 10,
                                          color: Colors.red,
                                          fontFamily: 'Corbel_Regular',
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                          vertical: 0,
                                        ),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            child: InkWell(
                              onTap: () {
                                showModelSelector();
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 19),
                                    //padding: EdgeInsets.only(left: 17.5, right: 7.3, top: 10, bottom: 14),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: CustColors.cloudy_blue,
                                          spreadRadius: 0,
                                          blurRadius: 1.5,
                                          offset: Offset(0, .8),
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    height: 40.8,
                                  ),
                                  Container(
                                    color: Colors.transparent,
                                    margin: EdgeInsets.only(top: 18),
                                    padding: EdgeInsets.only(
                                        left: 17.5,
                                        right: 8,
                                        top: 8,
                                        bottom: 14),
                                    child: TextFormField(
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      maxLines: 1,
                                      enabled: false,
                                      style: TextStyle(
                                        fontSize:
                                            ScreenSize().setValueFont(14.5),
                                        color: CustColors.blue,
                                        fontFamily: 'Corbel_Regular',
                                      ),
                                      keyboardType: TextInputType.text,
                                      validator: InputValidator(ch: "Model")
                                          .emptyChecking,
                                      controller: _modelController,
                                      decoration: InputDecoration(
                                        suffixIconConstraints: BoxConstraints(
                                          minWidth: 30,
                                          minHeight: 30,
                                        ),
                                        suffixIcon: Container(
                                          width: 5,
                                          alignment: Alignment.centerLeft,
                                          child: SizedBox(
                                            height: 28,
                                            width: 28,
                                            child: Image.asset(
                                              'assets/images/icon_dropdown_arrow.png',
                                            ),
                                          ),
                                        ),
                                        isDense: true,
                                        hintText: 'Vechicle Model',
                                        hintStyle: TextStyle(
                                          fontSize:
                                              ScreenSize().setValueFont(14.5),
                                          color: CustColors.blue,
                                          fontFamily: 'Corbel_Regular',
                                        ),
                                        errorStyle: TextStyle(
                                          fontSize: 10,
                                          color: Colors.red,
                                          fontFamily: 'Corbel_Regular',
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                          vertical: 0,
                                        ),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            child: InkWell(
                              onTap: () {
                                showEngineSelector();
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 19),
                                    //padding: EdgeInsets.only(left: 17.5, right: 7.3, top: 10, bottom: 14),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: CustColors.cloudy_blue,
                                          spreadRadius: 0,
                                          blurRadius: 1.5,
                                          offset: Offset(0, .8),
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    height: 40.8,
                                  ),
                                  Container(
                                    color: Colors.transparent,
                                    margin: EdgeInsets.only(top: 18),
                                    padding: EdgeInsets.only(
                                        left: 17.5,
                                        right: 8,
                                        top: 8,
                                        bottom: 14),
                                    child: TextFormField(
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      maxLines: 1,
                                      enabled: false,
                                      style: TextStyle(
                                        fontSize:
                                            ScreenSize().setValueFont(14.5),
                                        color: CustColors.blue,
                                        fontFamily: 'Corbel_Regular',
                                      ),
                                      keyboardType: TextInputType.text,
                                      validator: InputValidator(ch: "Engine")
                                          .emptyChecking,
                                      controller: _engineController,
                                      decoration: InputDecoration(
                                        suffixIconConstraints: BoxConstraints(
                                          minWidth: 30,
                                          minHeight: 30,
                                        ),
                                        suffixIcon: Container(
                                          width: 5,
                                          alignment: Alignment.centerLeft,
                                          child: SizedBox(
                                            height: 28,
                                            width: 28,
                                            child: Image.asset(
                                              'assets/images/icon_dropdown_arrow.png',
                                            ),
                                          ),
                                        ),
                                        isDense: true,
                                        hintText: 'Select Engine Type',
                                        hintStyle: TextStyle(
                                          fontSize:
                                              ScreenSize().setValueFont(14.5),
                                          color: CustColors.blue,
                                          fontFamily: 'Corbel_Regular',
                                        ),
                                        errorStyle: TextStyle(
                                          fontSize: 10,
                                          color: Colors.red,
                                          fontFamily: 'Corbel_Regular',
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                          vertical: 0,
                                        ),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            child: InkWell(
                              onTap: () {
                                /*showDatePicker(
                                  context: context,
                                  initialDatePickerMode: DatePickerMode.year,

                                  firstDate: DateTime(DateTime.now().year - 15),
                                  initialDate: DateTime(DateTime.now().year),
                                  //initialDate: selectedYear ?? initialYear,
                                  lastDate: DateTime(DateTime.now().year),
                                ).then((date) {
                                  if (date != null) {
                                    setState(() {
                                      this.selectedYear = date;
                                      _yearController.text =
                                          selectedYear!.year.toString();
                                    });
                                  }
                                });
                                */
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
                                      contentPadding: EdgeInsets.only(left: 0,right: 0,bottom: 0),
                                      content: Container(
                                        color: Colors.white,
                                        height: 300,
                                        width: 300,
                                        // Need to use container to add size constraint.
                                        //width: MediaQuery.of(context).size.width - 20,
                                       // height: MediaQuery.of(context).size.width - 30,
                                        child: YearPicker(
                                          firstDate: DateTime(
                                              DateTime.now().year - 25, 1),
                                          lastDate:
                                              DateTime(DateTime.now().year, 1),
                                          initialDate: selectedYear,
                                          // save the selected date to _selectedDate DateTime variable.
                                          // It's used to set the previous selected date when
                                          // re-showing the dialog.
                                          selectedDate: selectedYear!,
                                          onChanged: (DateTime dateTime) {
                                            // close the dialog when year is selected.
                                            Navigator.pop(context);
                                            setState(() {
                                              this.selectedYear = dateTime;
                                              _yearController.text =
                                                  selectedYear!.year
                                                      .toString();
                                            });
                                          },
                                        ),
                                      ),

                                    );
                                  },
                                );
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 19),
                                    //padding: EdgeInsets.only(left: 17.5, right: 7.3, top: 10, bottom: 14),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: CustColors.cloudy_blue,
                                          spreadRadius: 0,
                                          blurRadius: 1.5,
                                          offset: Offset(0, .8),
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    height: 40.8,
                                  ),
                                  Container(
                                    color: Colors.transparent,
                                    margin: EdgeInsets.only(top: 18),
                                    padding: EdgeInsets.only(
                                        left: 17.5,
                                        right: 8,
                                        top: 8,
                                        bottom: 14),
                                    child: TextFormField(
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      maxLines: 1,
                                      enabled: false,
                                      style: TextStyle(
                                        fontSize:
                                            ScreenSize().setValueFont(14.5),
                                        color: CustColors.blue,
                                        fontFamily: 'Corbel_Regular',
                                      ),
                                      keyboardType: TextInputType.text,
                                      validator: InputValidator(ch: "Year")
                                          .emptyChecking,
                                      controller: _yearController,
                                      decoration: InputDecoration(
                                        suffixIconConstraints: BoxConstraints(
                                          minWidth: 30,
                                          minHeight: 30,
                                        ),
                                        suffixIcon: Container(
                                          width: 5,
                                          alignment: Alignment.centerLeft,
                                          child: SizedBox(
                                            height: 28,
                                            width: 28,
                                            child: Image.asset(
                                              'assets/images/icon_dropdown_arrow.png',
                                            ),
                                          ),
                                        ),
                                        isDense: true,
                                        hintText: 'Select Year',
                                        hintStyle: TextStyle(
                                          fontSize:
                                              ScreenSize().setValueFont(14.5),
                                          color: CustColors.blue,
                                          fontFamily: 'Corbel_Regular',
                                        ),
                                        errorStyle: TextStyle(
                                          fontSize: 10,
                                          color: Colors.red,
                                          fontFamily: 'Corbel_Regular',
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                          vertical: 0,
                                        ),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            child: InkWell(
                              onTap: () {
                                showMonthPicker(
                                  context: context,
                                  firstDate: DateTime(
                                    DateTime.now().year - 20,
                                  ),
                                  lastDate: DateTime(DateTime.now().year),
                                  initialDate: selectedDate ?? initialDate,
                                  locale: Locale("en"),
                                ).then((date) {
                                  if (date != null) {
                                    setState(() {
                                      this.selectedDate = date;
                                      _maintenanceController.text =
                                          selectedDate!.month.toString() +
                                              "/" +
                                              selectedDate!.year.toString();
                                    });
                                  }
                                });
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 19),
                                    //padding: EdgeInsets.only(left: 17.5, right: 7.3, top: 10, bottom: 14),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: CustColors.cloudy_blue,
                                          spreadRadius: 0,
                                          blurRadius: 1.5,
                                          offset: Offset(0, .8),
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    height: 40.8,
                                  ),
                                  Container(
                                    color: Colors.transparent,
                                    margin: EdgeInsets.only(top: 18),
                                    padding: EdgeInsets.only(
                                        left: 17.5,
                                        right: 8,
                                        top: 8,
                                        bottom: 14),
                                    child: TextFormField(
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      maxLines: 1,
                                      enabled: false,
                                      style: TextStyle(
                                        fontSize:
                                            ScreenSize().setValueFont(14.5),
                                        color: CustColors.blue,
                                        fontFamily: 'Corbel_Regular',
                                      ),
                                      keyboardType: TextInputType.text,
                                      validator:
                                          InputValidator(ch: "Last maintenance")
                                              .emptyChecking,
                                      controller: _maintenanceController,
                                      decoration: InputDecoration(
                                        suffixIconConstraints: BoxConstraints(
                                          minWidth: 30,
                                          minHeight: 30,
                                        ),
                                        suffixIcon: Container(
                                          width: 5,
                                          alignment: Alignment.centerLeft,
                                          child: SizedBox(
                                            height: 28,
                                            width: 28,
                                            child: Image.asset(
                                              'assets/images/icon_dropdown_arrow.png',
                                            ),
                                          ),
                                        ),
                                        isDense: true,
                                        hintText: 'Last maintenance',
                                        hintStyle: TextStyle(
                                          fontSize:
                                              ScreenSize().setValueFont(14.5),
                                          color: CustColors.blue,
                                          fontFamily: 'Corbel_Regular',
                                        ),
                                        errorStyle: TextStyle(
                                          fontSize: 10,
                                          color: Colors.red,
                                          fontFamily: 'Corbel_Regular',
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                          vertical: 0,
                                        ),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              top: _setValue(15),
                              left: _setValue(12),
                            ),
                            padding: EdgeInsets.all(1),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Approximate Mileage",
                                  style: TextStyle(
                                    fontSize: ScreenSize().setValueFont(14.5),
                                    color: CustColors.blue,
                                    fontFamily: 'Corbel_Regular',
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  // padding: EdgeInsets.all(5),
                                  child: FlutterSlider(
                                    values: [_mileageData],
                                    max: 150000,
                                    min: 1000,
                                    step: FlutterSliderStep(step: 1000),
                                    handlerHeight: _setValue(25),
                                    handlerWidth: _setValue(25),
                                    handler: FlutterSliderHandler(
                                      child: Image.asset(
                                        "assets/images/icon_seekBar.png",
                                        fit: BoxFit.cover,
                                        height: double.infinity,
                                        width: double.infinity,
                                      ),
                                    ),
                                    trackBar: FlutterSliderTrackBar(
                                      activeTrackBarHeight: _setValue(5),
                                      activeTrackBar: BoxDecoration(
                                          color: CustColors.blue,
                                          border: Border.all(
                                            color: CustColors.light_blue_grey,
                                          )),
                                      inactiveTrackBar: BoxDecoration(
                                          color: CustColors.white01,
                                          border: Border.all(
                                            color: CustColors.cloudy_blue,
                                          )),
                                    ),
                                    tooltip: FlutterSliderTooltip(
                                      custom: (value) {
                                        int intVal =
                                            double.parse(value.toString())
                                                .round();
                                        if (intVal <= 99000) {
                                          int data = (intVal / 1000).round();
                                          return Text(
                                            '$data' + " K",
                                            style: TextStyle(
                                                fontFamily:
                                                    "Montserrat_SemiBold",
                                                fontSize: 10,
                                                color: CustColors.blue),
                                          );
                                        } else {
                                          var data = (intVal / 100000)
                                              .toStringAsFixed(1);
                                          return Text(
                                            '$data' + " L",
                                            style: TextStyle(
                                                fontFamily:
                                                    "Montserrat_SemiBold",
                                                fontSize: 10,
                                                color: CustColors.blue),
                                          );
                                        }
                                      },
                                      alwaysShowTooltip: true,
                                      boxStyle: FlutterSliderTooltipBox(
                                          decoration: BoxDecoration(
                                              color: Colors.transparent)),
                                      positionOffset:
                                          FlutterSliderTooltipPositionOffset(
                                              top: 41),
                                      textStyle: TextStyle(
                                          fontFamily: "Corbel_Regular",
                                          fontSize: 10,
                                          color: CustColors.blue),
                                    ),
                                    onDragging:
                                        (handlerIndex, lowerValue, upperValue) {
                                      setState(() {
                                        _mileageData = lowerValue;
                                        print(">>>> _mileageData ");
                                        print(_mileageData);
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: _isLoading
                                ? Center(
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          CustColors.darkBlue),
                                    ),
                                  )
                                : Container(
                                    margin: EdgeInsets.only(
                                        top: _setValue(12),
                                        bottom: _setValue(8)),
                                    padding:
                                        EdgeInsets.only(left: 30, right: 30),
                                    decoration: BoxDecoration(
                                      color: CustColors.blue,
                                      border: Border.all(
                                        color: CustColors.blue,
                                        style: BorderStyle.solid,
                                        width: 0.70,
                                      ),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: MaterialButton(
                                      child: Text(
                                        "Save",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Corbel_Regular',
                                            fontSize:
                                                ScreenSize().setValueFont(14.5),
                                            fontWeight: FontWeight.w800),
                                      ),
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          _addVehicleBloc.postAddVehicleRequest(
                                              token,
                                              _yearController.text,
                                              "10.551123",
                                              "76.066753",
                                              _mileageData.toString(),
                                              _maintenanceController.text,
                                              "3",
                                              selectedBrandId!,
                                              selectedModelId!,
                                              selectedEngineId!);
                                          setState(() {
                                            _isLoading = true;
                                          });
                                        } else {
                                          setState(() => _autoValidate =
                                              AutovalidateMode.always);
                                        }
                                      },
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
        ),
      ),
    );
  }

  _showDialogSelectPhoto() async {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20))),
        builder: (builder) {
          return Container(
              height: 115.0,
              child: ListView(
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.camera_alt,
                      color: CustColors.blue,
                    ),
                    title: Text("Camera",
                        style: TextStyle(
                            fontFamily: 'Corbel_Regular',
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                            color: Colors.black)),
                    onTap: () async {
                      Navigator.pop(context);
                      XFile? image = await picker.pickImage(
                          source: ImageSource.camera, imageQuality: 30);

                      setState(() {
                        if (image != null) {
                          _images = File(image.path);
                        }
                      });
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.image,
                      color: CustColors.blue,
                    ),
                    title: Text("Gallery",
                        style: TextStyle(
                            fontFamily: 'Corbel_Regular',
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                            color: Colors.black)),
                    onTap: () async {
                      Navigator.pop(context);
                      XFile? image = (await picker.pickImage(
                          source: ImageSource.gallery, imageQuality: 30));

                      setState(() {
                        if (image != null) {
                          _images = (File(image.path));
                        }
                      });
                    },
                  ),
                ],
              ));
        });
  }

  void setIsDefaultVehicleAvailable() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(SharedPrefKeys.isDefaultVehicleAvailable, 2);
    prefs.setBool(SharedPrefKeys.isUserLoggedIn, true);
  }

  DropdownMenuItem<MakeDetails> buildMenuItem(MakeDetails item) =>
      DropdownMenuItem(
        value: item,
        child: Text(
          item.makeName.toString(),
          style: TextStyle(
            fontSize: 18,
            color: CustColors.blue,
            fontFamily: 'Corbel_Regular',
            fontWeight: FontWeight.w700,
          ),
        ),
      );

  void showBrandSelector() {
    _allMakeBloc.searchMake("");
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
                                  height: _setValue(36.3),
                                  margin: EdgeInsets.only(
                                      left: _setValue(41.3),
                                      right: _setValue(41.3),
                                      top: _setValue(20.3)),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(
                                        _setValue(20),
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
                                                  makeDetails!.clear();
                                                  //_countryData.clear();
                                                  _loadingBrand = true;
                                                });
                                                _allMakeBloc.searchMake(text);
                                              },
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: 'Corbel_Regular',
                                                  fontWeight: FontWeight.w600,
                                                  color: CustColors.blue),
                                              decoration: InputDecoration(
                                                hintText: "Search Your Brand",
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
                                  child: makeDetails!.length != 0
                                      ? ListView.separated(
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          itemCount: makeDetails!.length,
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                                onTap: () {
                                                  final brandName =
                                                      makeDetails![index]
                                                          .makeName;
                                                  final brandId =
                                                      makeDetails![index].id;
                                                  setState(() {
                                                    _brandController.text =
                                                        brandName.toString();
                                                    selectedBrandId =
                                                        int.parse(brandId!);
                                                    _modelController.clear();
                                                    selectedModelId = 0;
                                                    _engineController.clear();
                                                    selectedEngineId = 0;
                                                    print("$selectedBrandId>>>>>>>>>>>>>>>");
                                                    _allModelBloc
                                                        .postAllModelDataRequest(
                                                            selectedBrandId!,
                                                            token);
                                                  });
                                                  print(">>>>>");
                                                  print(selectedBrandId);
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                    left: _setValue(41.3),
                                                    right: _setValue(41.3),
                                                  ),
                                                  child: Text(
                                                    '${makeDetails![index].makeName}',
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
                            child: _loadingBrand
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
  }

  void showModelSelector() {
    _allModelBloc.searchMake("");
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
                                  height: _setValue(36.3),
                                  margin: EdgeInsets.only(
                                      left: _setValue(41.3),
                                      right: _setValue(41.3),
                                      top: _setValue(20.3)),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(
                                        _setValue(20),
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
                                                  makeDetails!.clear();
                                                  //_countryData.clear();
                                                  _loadingModel = true;
                                                });
                                                _allMakeBloc.searchMake(text);
                                              },
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: 'Corbel_Regular',
                                                  fontWeight: FontWeight.w600,
                                                  color: CustColors.blue),
                                              decoration: InputDecoration(
                                                hintText: "Search Your  Model",
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
                                  child: modelDetails!.length != 0
                                      ? ListView.separated(
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          itemCount: modelDetails!.length,
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                                onTap: () {
                                                  final modelName =
                                                      modelDetails![index]
                                                          .modelName;
                                                  final modelId =
                                                      modelDetails![index].id;
                                                  setState(() {
                                                    _modelController.text =
                                                        modelName.toString();
                                                    selectedModelId =
                                                        int.parse(modelId!);
                                                    //selectedModelId = 0;
                                                    //selectedEngineId = 0;
                                                    _engineController.clear();
                                                    selectedEngineId = 0;
                                                    _allEngineBloc
                                                        .postAllEngineDataRequest(
                                                            selectedModelId!,
                                                            token);
                                                  });
                                                  print(">>>>>");
                                                  print(selectedModelId);
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                    left: _setValue(41.3),
                                                    right: _setValue(41.3),
                                                  ),
                                                  child: Text(
                                                    '${modelDetails![index].modelName}',
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
                            child: _loadingModel
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
  }

  void showEngineSelector() {
    _allEngineBloc.searchMake("");
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
                                  height: _setValue(36.3),
                                  margin: EdgeInsets.only(
                                      left: _setValue(41.3),
                                      right: _setValue(41.3),
                                      top: _setValue(20.3)),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(
                                        _setValue(20),
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
                                                  engineDetails!.clear();
                                                  //_countryData.clear();
                                                  _loadingEngineType = true;
                                                });
                                                _allEngineBloc.searchMake(text);
                                              },
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: 'Corbel_Regular',
                                                  fontWeight: FontWeight.w600,
                                                  color: CustColors.blue),
                                              decoration: InputDecoration(
                                                hintText:
                                                    "Search Your Engine Type",
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
                                  child: engineDetails!.length != 0
                                      ? ListView.separated(
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          itemCount: engineDetails!.length,
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                                onTap: () {
                                                  final engineName =
                                                      engineDetails![index]
                                                          .engineName;
                                                  final engineId =
                                                      engineDetails![index].id;
                                                  setState(() {
                                                    _engineController.text =
                                                        engineName.toString();
                                                    selectedEngineId =
                                                        int.parse(engineId!);
                                                    //selectedModelId = 0;
                                                    //selectedEngineId = 0;
                                                  });
                                                  print(
                                                      "selectedEngineId >>>>>");
                                                  print(selectedEngineId);
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                    left: _setValue(41.3),
                                                    right: _setValue(41.3),
                                                  ),
                                                  child: Text(
                                                    '${engineDetails![index].engineName}',
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
                            child: _loadingEngineType
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
  }

  void showYearSelector() {
    showDatePicker(
      context: context,
      initialDatePickerMode: DatePickerMode.year,
      firstDate: DateTime(
        DateTime.now().year - 20,
      ),
      initialDate: selectedYear ?? initialYear,
      lastDate: DateTime(DateTime.now().year),
    ).then((date) {
      if (date != null) {
        setState(() {
          this.selectedYear = date;
        });
      }
    });
  }
}
