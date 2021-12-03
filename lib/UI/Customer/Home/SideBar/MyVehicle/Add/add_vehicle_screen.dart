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
  final AllModelBloc _allModelBloc = AllModelBloc();
  final AllMakeBloc _allMakeBloc = AllMakeBloc();
  final AllEngineBloc _allEngineBloc = AllEngineBloc();
  int make_id = 0;
  int model_id = 0;
  int engine_id = 0;
  String make_name = "";
  String model_name = "";
  String engine_name = "";
  bool _isLoading = false;
  double? _mileageData = 0;
  bool errorBrand = false;
  bool errorModel = false;
  bool errorEngine = false;
  String brandName = "";
  String modelName = "";
  @override
  void initState() {
    super.initState();
    _addToken();
    _yearController.addListener(onFocusChange);
    _maintenanceController.addListener(onFocusChange);
    //_allModelBloc.postAllModelRequest(make_id);
    //_allEngineBloc.postAllEngineRequest(model_id);
    _getAllModel();
    _getAllMake();
    _getAllEngine();
    _addVehicle();
    selectedDate = initialDate;
    selectedYear = initialYear;
  }

  _addToken() async {
    SharedPreferences _shdPre = await SharedPreferences.getInstance();
    token = _shdPre.getString(SharedPrefKeys.token)!;
    print("Token : " + token);
    GqlClient.I.config(token: token);
    _allMakeBloc.postAllMakeRequest(token);
  }

  @override
  void dispose() {
    super.dispose();
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
          modelDetails = value.data!.modelDetails;
        });
      }
    });
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
        setState(() {
          makeDetails = value.data!.makeDetails;
          // print("c"+value.data.acceptInvitations.message.toString()+"c");
          print(">>>>>Brand Data" +
              value.data!.makeDetails!.length.toString() +
              ">>>>>>>>>");
        });
      }
    });
  }

  _getAllEngine() async {
    _allEngineBloc.postAllEngine.listen((value) {
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
          print(">>>>>Brand Data" +
              value.data!.engineDetails!.length.toString() +
              ">>>>>>>>>");
          engineDetails = value.data!.engineDetails;
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
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const HomeScreen()));
          FocusScope.of(context).unfocus();
          setIsSignedIn();
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
            margin: EdgeInsets.all(10.0),
            child: Column(
              children: [
                AspectRatio(
                  aspectRatio: 1.64,
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
                                      "Add Your Car",
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
                                            "Upload Your Car Photos",
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            margin: EdgeInsets.only(top: 21),
                            padding: EdgeInsets.only(
                                left: 17.5, right: 7.3, top: 14, bottom: 14),
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
                            child: TextFormField(
                              textAlignVertical: TextAlignVertical.center,
                              maxLines: 1,
                              enabled: false,
                              style: TextStyle(
                                fontSize: ScreenSize().setValueFont(14.5),
                                color: CustColors.blue,
                                fontFamily: 'Corbel_Regular',
                              ),
                              keyboardType: TextInputType.text,
                              validator:
                                  InputValidator(ch: "Brand").emptyChecking,
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
                                    height: 30,
                                    width: 30,
                                    child: Image.asset(
                                      'assets/images/icon_dropdown_arrow.png',
                                    ),
                                  ),
                                ),
                                isDense: true,
                                hintText: 'Select Your Brand',
                                errorStyle: TextStyle(
                                  fontSize: ScreenSize().setValueFont(10),
                                  color: Colors.red,
                                  fontFamily: 'Corbel_Regular',
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 0,
                                ),
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                  fontSize: ScreenSize().setValueFont(14.5),
                                  color: CustColors.blue,
                                  fontFamily: 'Corbel_Regular',
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Container(
                        //   margin: EdgeInsets.only(top: 21),
                        //   height: 45.8,
                        //   padding: EdgeInsets.only(left: 17.5, right: 7.3),
                        //   decoration: BoxDecoration(
                        //     color: Colors.white,
                        //     boxShadow: [
                        //       BoxShadow(
                        //         color: CustColors.cloudy_blue,
                        //         spreadRadius: 0,
                        //         blurRadius: 1.5,
                        //         offset: Offset(0, .8),
                        //       ),
                        //     ],
                        //     borderRadius: BorderRadius.circular(24.5),
                        //   ),
                        //   child: DropdownButton<MakeDetails>(
                        //     onChanged: (value) {
                        //       setState(() {
                        //         this.value = value;
                        //         _allModelBloc.postAllModelRequest(
                        //             int.parse(value!.id!), token);
                        //         print(value);
                        //       });
                        //     },
                        //     value: value,
                        //     underline: Container(),
                        //     hint: Align(
                        //       alignment: Alignment.centerLeft,
                        //       child: Text(
                        //         "Select Your Brand",
                        //         style: TextStyle(
                        //           fontSize: ScreenSize().setValueFont(14.5),
                        //           color: CustColors.blue,
                        //           fontFamily: 'Corbel_Regular',
                        //         ),
                        //       ),
                        //     ),
                        //     icon: Image.asset(
                        //       "assets/images/icon_dropdown_arrow.png",
                        //       height: 30,
                        //       width: 30,
                        //     ),
                        //     isExpanded: true,
                        //     items: makeDetails!.map(buildMenuItem).toList(),
                        //     selectedItemBuilder: (BuildContext context) =>
                        //         makeDetails!.map(
                        //       (e) {
                        //         brandName = e.makeName.toString();
                        //         modelName = "";
                        //         return Align(
                        //           alignment: Alignment.centerLeft,
                        //           child: Text(
                        //             e.makeName.toString(),
                        //             style: TextStyle(
                        //                 fontSize: 18,
                        //                 color: CustColors.blue,
                        //                 fontFamily: 'Corbel_Regular',
                        //                 fontWeight: FontWeight.w700),
                        //           ),
                        //         );
                        //       },
                        //     ).toList(),
                        //   ),
                        // ),
                        // errorBrand
                        //     ? Text("Brand is empty",
                        //         style: TextStyle(color: Colors.red))
                        //     : Container(width: 0, height: 0),
                        Container(
                          margin: EdgeInsets.all(2),
                          padding: EdgeInsets.only(
                              top: 4, bottom: 4, left: 10, right: 10),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                              color: CustColors.cloudy_blue,
                              style: BorderStyle.solid,
                              width: 0.70,
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: DropdownButton<ModelDetails>(
                            onChanged: (value) {
                              setState(() {
                                this.modelValue = value;
                                _allEngineBloc.postAllEngineRequest(
                                    int.parse(value!.id!), token);
                                print(modelValue);
                              });
                            },
                            value: modelValue,
                            underline: Container(),
                            hint: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Car Model",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: CustColors.blue,
                                  fontFamily: 'Corbel_Regular',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            icon: Image.asset(
                              "assets/images/icon_dropdown_arrow.png",
                              height: 30,
                              width: 30,
                            ),
                            isExpanded: true,
                            items: modelDetails!
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(
                                      e.modelName.toString(),
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: CustColors.blue,
                                        fontFamily: 'Corbel_Regular',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                            selectedItemBuilder: (BuildContext context) =>
                                modelDetails!
                                    .map(
                                      (e) => Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          e.modelName.toString(),
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: CustColors.blue,
                                              fontFamily: 'Corbel_Regular',
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    )
                                    .toList(),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(2),
                          padding: EdgeInsets.only(
                              top: 4, bottom: 4, left: 10, right: 10),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                              color: CustColors.cloudy_blue,
                              style: BorderStyle.solid,
                              width: 0.70,
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: DropdownButton<EngineDetails>(
                            onChanged: (value) {
                              setState(() {
                                this.engineValue = value;
                                print(value);
                              });
                            },
                            value: engineValue,
                            underline: Container(),
                            hint: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Select Engine Type",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: CustColors.blue,
                                  fontFamily: 'Corbel_Regular',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            icon: Image.asset(
                              "assets/images/icon_dropdown_arrow.png",
                              height: 30,
                              width: 30,
                            ),
                            isExpanded: true,
                            items: engineDetails!
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(
                                      e.engineName.toString(),
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: CustColors.blue,
                                        fontFamily: 'Corbel_Regular',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                            selectedItemBuilder: (BuildContext context) =>
                                engineDetails!
                                    .map(
                                      (e) => Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          e.engineName.toString(),
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: CustColors.blue,
                                              fontFamily: 'Corbel_Regular',
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    )
                                    .toList(),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(2),
                          padding: EdgeInsets.only(
                              top: 4, bottom: 4, left: 10, right: 10),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                              color: CustColors.cloudy_blue,
                              style: BorderStyle.solid,
                              width: 0.70,
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              showMonthPicker(
                                context: context,
                                firstDate: DateTime(
                                  DateTime.now().year - 20,
                                ),
                                lastDate: DateTime(DateTime.now().year),
                                initialDate: selectedYear ?? initialYear,
                                locale: Locale("en"),
                              ).then((date) {
                                if (date != null) {
                                  setState(() {
                                    this.selectedYear = date;
                                  });
                                }
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text(
                                    selectedYear?.year != initialYear.year
                                        ? '${selectedYear?.year}'
                                        : "Select Year",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: CustColors.blue,
                                      fontFamily: 'Corbel_Regular',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerRight,
                                  child: Image.asset(
                                    "assets/images/icon_dropdown_arrow.png",
                                    height: 30,
                                    width: 30,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(2),
                          padding: EdgeInsets.only(
                              top: 4, bottom: 4, left: 10, right: 10),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                              color: CustColors.cloudy_blue,
                              style: BorderStyle.solid,
                              width: 0.70,
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              showMonthPicker(
                                context: context,
                                firstDate: DateTime(
                                  DateTime.now().year - 15,
                                  1,
                                ),
                                lastDate: DateTime(DateTime.now().year,
                                    DateTime.now().month - 3),
                                initialDate: selectedDate ?? initialDate,
                                locale: Locale("en"),
                              ).then((date) {
                                if (date != null) {
                                  setState(() {
                                    selectedDate = date;
                                  });
                                }
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text(
                                    selectedDate != initialDate
                                        ? '${selectedDate?.month}-${selectedDate?.year}'
                                        : "Last maintenance",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: CustColors.blue,
                                      fontFamily: 'Corbel_Regular',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerRight,
                                  child: Image.asset(
                                    "assets/images/icon_dropdown_arrow.png",
                                    height: 30,
                                    width: 30,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(2),
                          padding: EdgeInsets.only(
                              top: 4, bottom: 4, left: 10, right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Approximate Mileage",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: CustColors.blue,
                                  fontFamily: 'Corbel_Regular',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                // padding: EdgeInsets.all(5),
                                child: FlutterSlider(
                                  values: [_mileageData!],
                                  max: 100,
                                  min: 0,
                                  step: FlutterSliderStep(step: 2),
                                  handler: FlutterSliderHandler(
                                      child: Image.asset(
                                          "assets/images/icon_seekbar.png")),
                                  trackBar: FlutterSliderTrackBar(
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
                                    rightSuffix: Text(
                                      " km / ltr",
                                      style: TextStyle(
                                          fontSize: 10, color: CustColors.blue),
                                    ),
                                    textStyle: TextStyle(
                                        fontSize: 10, color: CustColors.blue),
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
                                  margin: EdgeInsets.all(4),
                                  padding: EdgeInsets.only(
                                      top: 2, bottom: 2, left: 30, right: 30),
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
                                          fontSize: 15,
                                          fontWeight: FontWeight.w800),
                                    ),
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        // if (brandName == "") {
                                        //   errorBrand = true;
                                        //   setState(() {});
                                        // }
                                        // if (modelValue)

                                        // if (value != null &&
                                        //     modelValue != null &&
                                        //     engineValue != null) {
                                        _addVehicleBloc.postAddVehicleRequest(
                                            token,
                                            _yearController.text,
                                            "10.551123",
                                            "76.066753",
                                            _mileageData.toString(),
                                            _maintenanceController.text,
                                            "3",
                                            int.parse(value!.id!),
                                            int.parse(modelValue!.id!),
                                            int.parse(engineValue!.id!)
                                            /* _userNameController.text,
                                    _passwordController.text*/
                                            );
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
                  // Divider(
                  //   height: 1.0,
                  //   color: Colors.grey,
                  // ),
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

  void setIsSignedIn() async {
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
}
