import 'dart:io';
import 'dart:math';

import 'package:another_xlider/another_xlider.dart';
import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/UI/Customer/SideBar/MyVehicles/CustVehicleListMdl.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Customer/add_car_bloc.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Customer/brand_model_engine/modelDetails_Mdl.dart';
import 'package:auto_fix/Utility/check_network.dart';
import 'package:auto_fix/Utility/network_error_screen.dart';
import 'package:auto_fix/Widgets/input_validator.dart';
import 'package:auto_fix/Widgets/snackbar_widget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:path/path.dart' as path;

class EditCarScreen extends StatefulWidget {
  final CustVehicleList vehicleData;

  EditCarScreen({required this.vehicleData,});

  @override
  State<StatefulWidget> createState() {
    return _EditCarScreenState();
  }
}

class _EditCarScreenState extends State<EditCarScreen> {

  String authToken="";
  final AddCarBloc _addCarBloc = AddCarBloc();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isLoading = false;
  bool _isAddMore = false;
  String imageFirebaseUrl = "";
  FirebaseStorage storage = FirebaseStorage.instance;
  double? _progress;


  TextEditingController _brandController = TextEditingController();
  FocusNode _brandFocusNode = FocusNode();

  TextEditingController _modelController = TextEditingController();
  FocusNode _modelFocusNode = FocusNode();

  TextEditingController _engineTypeController = TextEditingController();
  FocusNode _engineTypeFocusNode = FocusNode();

  TextEditingController _yearController = TextEditingController();
  FocusNode _yearControllerFocusNode = FocusNode();

  TextEditingController _lastMaintenanceController = TextEditingController();
  FocusNode _lastMaintenanceFocusNode = FocusNode();

  TextEditingController _plateNumberController = TextEditingController();
  FocusNode _plateNumberFocusNode = FocusNode();

  TextEditingController _vehicleColorController = TextEditingController();
  FocusNode _vehicleColorFocusNode = FocusNode();
  File? _images;
  bool isloading = false;
  String? countryCode;
  double per = .10;
  double perfont = .10;
  double height = 0;
  String selectedState = "";
  final picker = ImagePicker();

  double _setValue(double value) {
    return value * per + value;
  }
  CheckInternet _checkInternet = CheckInternet();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  String userProfilePic = '';
  double _lowerValue = 100;

  var pickeddate;
  var pickedtime;

  final DateTime initialYear = DateTime.now();
  DateTime? selectedYear;
  DateTime selectedDate = DateTime.now();

  DateTime now = DateTime.now();

  StateSetter? monthYear1;
  int? selectedyearIndex = 0 ;
  int? selectedmonthIndex = 0 ;
  String? selectedMonthText = 'Jan' ;
  String? selectedYearText = '2018';
  List<String> allMonthList = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
  List<String> monthList = [];
  List<String> yearList = [];

  List<String> brandList = [];
  String? selectedBrand = '' ;
  String? selectedBrandName = '' ;



  List<String> modelList = [];
  String? selectedmodel = '' ;
  String? selectedModelName = '' ;


  List<String> engineList = [];
  String? selectedengine = '' ;
  String? selectedEngineName = '' ;


  List<String> yearTypeList = [];
  String? selectedYearType = '' ;
  String? selectedYearName = '' ;


  String location ='Null, Press Button';
  String Address = 'search';
  String latitude = '10.5075868';
  String longitude = '76.2424536';

  BuildContext? dialogContext;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(">>>> abcd ${widget.vehicleData.id + widget.vehicleData.brand}");
    _brandController.text = widget.vehicleData.brand.toString();
    _modelController.text = widget.vehicleData.model.toString();
    _engineTypeController.text = widget.vehicleData.engine.toString();
    _yearController.text = widget.vehicleData.year.toString();
    _vehicleColorController.text = widget.vehicleData.color.toString();
    _plateNumberController.text = widget.vehicleData.plateNo.toString();
    _lastMaintenanceController.text = widget.vehicleData.lastMaintenance.toString();
    _lowerValue = double.parse(widget.vehicleData.milege.toString());
    imageFirebaseUrl = widget.vehicleData.vehiclePic ;

    print(">>>> imageFirebaseUrl " + imageFirebaseUrl);

    for(int i = 0; i <= 11; i++ ){
      monthList.add(allMonthList[i]);
    }
    for(int i = now.year-12; i <= now.year; i+=1){
      yearList.add(i.toString());
      i.toString();
    }
      _getCurrentCustomerLocation();
      getSharedPrefData();
      _listenAddCarResponse();
  }


  Future<void> _getCurrentCustomerLocation() async {
    Position position = await _getGeoLocationPosition();
    location ='Lat: ${position.latitude} , Long: ${position.longitude}';
    print(location);
    setState(() {
      latitude = position.latitude.toString();
      longitude = position.longitude.toString();
    });
  }

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {

        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }


  Future<void> getSharedPrefData() async {
    print('getSharedPrefData');
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    setState(() {
      authToken = shdPre.getString(SharedPrefKeys.token).toString();
      print('userFamilyId'+authToken.toString());
    });
  }

  _listenAddCarResponse() {
    _addCarBloc.editCarResponse.listen((value) {
      if (value.status == "error") {
        setState(() {
          SnackBarWidget().setMaterialSnackBar( "${value.message}", _scaffoldKey);
          print("message postSignUpCustomerIndividual >>>>>>>  ${value.message}");
          print("errrrorr postSignUpCustomerIndividual >>>>>>>  ${value.status}");
          _isLoading = false;
          _isAddMore = false;
        });
      } else {

        setState(() async {
          print("success postSignUpCustomerIndividual >>>>>>>  ${value.status}");
          _isLoading = false;
          Navigator.pop(context);
          FocusScope.of(context).unfocus();
          _isAddMore = false;

          SnackBarWidget().setMaterialSnackBar( "Successfully Updated", _scaffoldKey);

        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print('${_images?.path}' + ">>>>>>> image from Widget");
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        body: ScrollConfiguration(
          behavior: MyBehavior(),
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  completeYourProfileText(),
                  uploadVechicleImage(size),
                  SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Form(
                            autovalidateMode: _autoValidate,
                            key: _formKey,
                            child: Container(
                              margin: EdgeInsets.only(
                                left: _setValue(20.5), right: _setValue(20.5),top: _setValue(17.5), ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: _setValue(15.5), right: _setValue(15.5)),
                                    child: Column(
                                      children: [
                                        brandTextSelection(),
                                        modelTextSelection(),
                                        engineTypeTextSelection(),
                                        yearTypeTextSelection(),
                                        vehicleColorText(),
                                        plateNumberTextSelection(),
                                        lastMaintenanceTextSelection(),
                                        approximateMilageSelection(),
                                        addMoreAndNextButtons(),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
  }

  Widget completeYourProfileText() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        child: const Text(
          'Edit Vehicle Details',
          style: Styles.textCompleteYourProfile,
        ),
      ),
    );
  }

  Widget uploadVechicleImage(Size size) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
      child: Container(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.only(right: 8.0),
                child: SvgPicture.asset('assets/image/CustomerType/customerAddCar_bg.svg',height: size.height * 0.25,width: 30,),
              ),
            ),
            Container(
              width: 150,
              height: 200,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30),
                ),
                color: CustColors.whiteBlueish,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      width: 150,
                      child: const Text(
                        'Upload your vehicle photo',
                        textAlign: TextAlign.center,
                        style: Styles.textUploadYourProfilePic,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Center(
                            child: SizedBox(
                              width: 100.0,
                              height: 100.0,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: imageFirebaseUrl == null || imageFirebaseUrl == ""
                                    ? CircleAvatar(
                                      radius: 50,
                                      backgroundColor: Colors.white,
                                      child: ClipOval(
                                      child:  SvgPicture.asset('assets/image/CustomerType/upload_car_avathar.svg'),
                                    ))
                                    : SizedBox(
                                      height: 100,
                                      width: 100,
                                      child: FadeInImage.assetNetwork(
                                        placeholder: 'assets/image/CustomerType/dummyCar.png',
                                        image:'$imageFirebaseUrl',
                                        fit: BoxFit.fill,
                                      )
                                     ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              _showDialogSelectPhoto();
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Center(
                                  child: Container(
                                    decoration: new BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    width: 30.0,
                                    height: 30.0,
                                    child: SvgPicture.asset('assets/image/CustomerType/add_car_plus.svg'),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget brandTextSelection() {
    return  Container(
      margin: EdgeInsets.only(top: _setValue(0.4)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Brand",
                  style: Styles.textLabelTitle,
                ),
                const Spacer(),
              ],
            ),
          ),
          TextFormField(
            textAlignVertical: TextAlignVertical.center,
            maxLines: 1,
            style: Styles.textLabelSubTitle,
            focusNode: _brandFocusNode,
            enabled: false,
            keyboardType: TextInputType.name,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                  RegExp('[a-zA-Z ]')),
            ],
            validator: InputValidator(
                ch : 'Brand name' ).nameCheckingWithNumeric,
            controller: _brandController,
            cursorColor: CustColors.light_navy,
            decoration: InputDecoration(
              isDense: true,
              hintText:
              "Select your vehicle brand",
              border: const UnderlineInputBorder(
                borderSide: const BorderSide(
                  color: CustColors.greyish,
                  width: .5,
                ),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: const BorderSide(
                  color: CustColors.greyish,
                  width: .5,
                ),
              ),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: CustColors.greyish,
                  width: .5,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 12.8,
                horizontal: 0.0,
              ),
              errorStyle: Styles.textLabelSubTitleRed,
              hintStyle: Styles.textLabelSubTitle,),
          ),
        ],
      ),
    );
  }

  Widget modelTextSelection() {
    return  Container(
      margin: EdgeInsets.only(top: _setValue(12.5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Model",
                  style: Styles.textLabelTitle,
                ),
                const Spacer(),
              ],
            ),
          ),
          TextFormField(
            textAlignVertical: TextAlignVertical.center,
            maxLines: 1,
            style: Styles.textLabelSubTitle,
            focusNode: _modelFocusNode,
            keyboardType: TextInputType.name,
            enabled: false,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                  RegExp('[a-zA-Z ]')),
            ],
            validator: InputValidator(
                ch :
                'Model name'  ).nameCheckingWithNumeric,
            controller: _modelController,
            cursorColor: CustColors.light_navy,
            decoration: InputDecoration(
              isDense: true,
              hintText:
              "Select your car variant",
              border: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: CustColors.greyish,
                  width: .5,
                ),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: CustColors.greyish,
                  width: .5,
                ),
              ),
              enabledBorder: const UnderlineInputBorder(
                borderSide: const BorderSide(
                  color: CustColors.greyish,
                  width: .5,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 12.8,
                horizontal: 0.0,
              ),
              errorStyle: Styles.textLabelSubTitleRed,
              hintStyle: Styles.textLabelSubTitle,),
          ),
        ],
      ),
    );
  }

  Widget engineTypeTextSelection() {
    return  Container(
      margin: EdgeInsets.only(top: _setValue(12.5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Engine Type",
            style: Styles.textLabelTitle,
          ),
          TextFormField(
            textAlignVertical: TextAlignVertical.center,
            maxLines: 1,
            style: Styles.textLabelSubTitle,
            focusNode: _engineTypeFocusNode,
            enabled: false,
            keyboardType: TextInputType.name,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                  RegExp('[a-zA-Z ]')),
            ],
            validator: InputValidator(
                ch :
                'Engine Type' ).nameCheckingWithNumericAndBracket,
            controller: _engineTypeController,
            cursorColor: CustColors.light_navy,
            decoration: const InputDecoration(
              isDense: true,
              hintText:
              "Select your engine model",
              border:  UnderlineInputBorder(
                borderSide:  BorderSide(
                  color: CustColors.greyish,
                  width: .5,
                ),
              ),
              focusedBorder:  UnderlineInputBorder(
                borderSide: BorderSide(
                  color: CustColors.greyish,
                  width: .5,
                ),
              ),
              enabledBorder:  UnderlineInputBorder(
                borderSide:  BorderSide(
                  color: CustColors.greyish,
                  width: .5,
                ),
              ),
              contentPadding:  EdgeInsets.symmetric(
                vertical: 12.8,
                horizontal: 0.0,
              ),
              errorStyle: Styles.textLabelSubTitleRed,
              hintStyle: Styles.textLabelSubTitle,),
          ),
        ],
      ),
    );
  }

  Widget yearTypeTextSelection() {
    return  Container(
      margin: EdgeInsets.only(top: _setValue(12.5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Year",
            style: Styles.textLabelTitle,
          ),
          TextFormField(
            textAlignVertical: TextAlignVertical.center,
            maxLines: 1,
            style: Styles.textLabelSubTitle,
            focusNode: _yearControllerFocusNode,
            keyboardType: TextInputType.name,
            enabled: false,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                  RegExp('[a-zA-Z ]')),
            ],
            validator: InputValidator(
                ch :
                'Year' ).nameCheckingWithNumeric,
            controller: _yearController,
            cursorColor: CustColors.light_navy,
            decoration: const InputDecoration(
              isDense: true,
              hintText:
              "Select your vehicle manufacture date",
              border: const UnderlineInputBorder(
                borderSide: const BorderSide(
                  color: CustColors.greyish,
                  width: .5,
                ),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: CustColors.greyish,
                  width: .5,
                ),
              ),
              enabledBorder: const UnderlineInputBorder(
                borderSide: const BorderSide(
                  color: CustColors.greyish,
                  width: .5,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 12.8,
                horizontal: 0.0,
              ),
              errorStyle: Styles.textLabelSubTitleRed,
              hintStyle: Styles.textLabelSubTitle,),
          ),
        ],
      ),
    );
  }

  Widget vehicleColorText() {
    return Container(
      margin: EdgeInsets.only(top: _setValue(12.5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Color",
            style: Styles.textLabelTitle,
          ),
          TextFormField(
            enabled: false,
            textAlignVertical: TextAlignVertical.center,
            maxLines: 1,
            style: Styles.textLabelSubTitle,
            focusNode: _vehicleColorFocusNode,
            keyboardType: TextInputType.name,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                  RegExp('[a-zA-Z0-9 ]')),
            ],
            validator: InputValidator(
                ch :'Vehicle color').emptyChecking,
            controller: _vehicleColorController,
            /*onChanged: (value){
              setState(() {
                if (_formKey.currentState!.validate()) {
                } else {
                }
              });
            },*/
            cursorColor: CustColors.light_navy,
            decoration: const InputDecoration(
              isDense: true,
              hintText: "Enter your Vehicle color",
              border: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: CustColors.greyish,
                  width: .5,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: CustColors.greyish,
                  width: .5,
                ),
              ),
              enabledBorder: const UnderlineInputBorder(
                borderSide: const BorderSide(
                  color: CustColors.greyish,
                  width: .5,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(
                vertical: 12.8,
                horizontal: 0.0,
              ),
              errorStyle: Styles.textLabelSubTitleRed,
              hintStyle: Styles.textLabelSubTitle,),
          ),
        ],
      ),
    );
  }

  Widget plateNumberTextSelection() {
    return Container(
      margin: EdgeInsets.only(top: _setValue(12.5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(

            "Plate number",
            style: Styles.textLabelTitle,
          ),
          TextFormField(
            enabled: false,
            textAlignVertical: TextAlignVertical.center,
            maxLines: 1,
            style: Styles.textLabelSubTitle,
            focusNode: _plateNumberFocusNode,
            keyboardType: TextInputType.name,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                  RegExp('[a-zA-Z0-9 ]')),
            ],
            validator: InputValidator(
                ch :'Plate number').nameCheckingWithNumeric,
            controller: _plateNumberController,
            /*onChanged: (value){
              setState(() {
                if (_formKey.currentState!.validate()) {
                } else {
                }
              });
            },*/
            cursorColor: CustColors.light_navy,
            decoration: const InputDecoration(
              isDense: true,
              hintText:
              "Enter your Plate number",
              border: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: CustColors.greyish,
                  width: .5,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: CustColors.greyish,
                  width: .5,
                ),
              ),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: CustColors.greyish,
                  width: .5,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(
                vertical: 12.8,
                horizontal: 0.0,
              ),
              errorStyle: Styles.textLabelSubTitleRed,
              hintStyle: Styles.textLabelSubTitle,),
          ),
        ],
      ),
    );
  }

  Widget lastMaintenanceTextSelection() {
    return InkWell(
      onTap: (){
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              dialogContext = context;
              return AlertDialog(
                contentPadding: const EdgeInsets.all(0.0),
                content: StatefulBuilder(
                    builder: (BuildContext context, StateSetter monthYear) {
                      monthYear1 = monthYear;
                      return  setupAlertDialogMonthAndYear();
                    }
                ),
              );
            });
      },
      child: Container(
        margin: EdgeInsets.only(top: _setValue(12.5)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Last maintenance",
              style: Styles.textLabelTitle,
            ),
            TextFormField(
              textAlignVertical: TextAlignVertical.center,
              maxLines: 1,
              style: Styles.textLabelSubTitle,
              focusNode: _lastMaintenanceFocusNode,
              keyboardType: TextInputType.name,
              enabled: false,
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                    RegExp('[a-zA-Z ]')),
              ],
              validator: InputValidator(
                  ch :
                  'Last maintenance date' ).nameCheckingWithNumeric,
              controller: _lastMaintenanceController,
              onChanged: (value){
                setState(() {
                  if (_formKey.currentState!.validate()) {
                  } else {
                  }
                });
              },
              cursorColor: CustColors.light_navy,
              decoration: InputDecoration(
                isDense: true,
                hintText: "Select your last service date ",
                suffixIconConstraints: const BoxConstraints(
                  minWidth: 25,
                  minHeight: 25,
                ),
                suffixIcon: Container(
                  width: 5,
                  height: 10,
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    iconSize: 22,
                    padding: EdgeInsets.zero,
                    icon: const Icon(
                      Icons.keyboard_arrow_down_sharp,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                    },
                  ),
                ),
                border: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: CustColors.greyish,
                    width: .5,
                  ),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: const BorderSide(
                    color: CustColors.greyish,
                    width: .5,
                  ),
                ),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: CustColors.greyish,
                    width: .5,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 12.8,
                  horizontal: 0.0,
                ),
                errorStyle: Styles.textLabelSubTitleRed,
                hintStyle: Styles.textLabelSubTitle,),
            ),
          ],
        ),
      ),
    );
  }

  Widget approximateMilageSelection() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: _setValue(15.5),bottom: _setValue(15.5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            child: const Text(
              "Approximate mileage",
              style: Styles.textLabelTitle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Container(
              child: const Text(
                "Select your vehicle total kilometres",
                style: Styles.textLabelSubTitle,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Center(
              // ignore: missing_required_param
                child: FlutterSlider(
                  values: [_lowerValue],
                  max: 150000,
                  min: 0,
                  step: FlutterSliderStep(step: 500),
                   handlerHeight: _setValue(25),
                   handlerWidth: _setValue(25),
                  // tooltip: FlutterSliderTooltip(
                  //     custom: (value) {
                  //       return Text(value.toString());
                  //     }
                  // ),
                  tooltip: FlutterSliderTooltip(
                    custom: (value) {
                      int intVal = double.parse(value.toString()).round();
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
                        var data = (intVal / 100000).toStringAsFixed(1);
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
                  trackBar: FlutterSliderTrackBar(
                    inactiveTrackBar: BoxDecoration(
                      borderRadius: BorderRadius.circular(0),
                      color:CustColors.whiteBlueish,
                      border: Border.all(width: 3, color: Colors.blue),
                    ),
                    activeTrackBar: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                        color:CustColors.blue
                    ),
                  ),
                  handler: FlutterSliderHandler(
                    decoration:BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      decoration:BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        elevation: 10,
                        child: Container(
                            decoration:BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: CustColors.blue
                            ),
                            padding: const EdgeInsets.all(5),
                            child: const Icon(
                              Icons.pause,
                              color: Colors.white,
                              size: 20,
                            )),
                      ),
                    ),
                  ),
                  onDragging: (handlerIndex, lowerValue, upperValue) {
                    setState(() {
                      _lowerValue = lowerValue;
                      print('$_lowerValue');
                    });
                  },
                )
            ),
          ),
        ],
      ),
    ) ;
  }

  Widget addMoreAndNextButtons() {
    return  Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: _setValue(0.5),bottom: _setValue(25.5)),
      child: Row(
        children: [
          Container(
            child: Container(
              margin: const EdgeInsets.only(top: 20.8),
              child: _isAddMore
                  ? Container(
                     height: 45,
                     width: 110,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10),
                        ),
                            color: CustColors.materialBlue,
                      ),
                    child: Center(
                        child: Container(
                          height: _setValue(25),
                          width: _setValue(25),
                          child: const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white),
                          ),
                        ),
                      ),
                  )
                  : Container(),
            ),
          ),
          const Spacer(),
          Container(
            child: Container(
              margin: const EdgeInsets.only(top: 20.8),
              child: _isLoading
                  ? Container(
                      height: 45,
                      width: 90,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10),
                        ),
                        color: CustColors.materialBlue,
                      ),
                      child: Center(
                        child: SizedBox(
                          height: _setValue(25),
                          width: _setValue(25),
                          child: const CircularProgressIndicator(
                            valueColor:  AlwaysStoppedAnimation<Color>(
                                Colors.white),
                          ),
                        ),
                      ),
                    )
                  : SizedBox(
                    height: 45,
                    width: 90,
                    child: MaterialButton(
                      onPressed: () {

                      _checkInternet.check().then((intenet) {
                        if (intenet != null && intenet) {
                          print('${authToken   + _brandController.text.toString() + _modelController.text.toString()
                              + selectedengine.toString() + selectedYearType.toString() +
                              _plateNumberController.text +
                              _lastMaintenanceController.text +
                              _lowerValue.toString() +
                              imageFirebaseUrl +
                              latitude +
                              longitude}' );
                          setState(() {
                            _isLoading = true;
                            _isAddMore = false;
                            print('true');
                          });
                          if (_formKey.currentState!.validate()) {

                            setState(() {
                              print('success');
                              _addCarBloc.postEditCarRequest(
                                authToken,
                                widget.vehicleData.id.toString(),
                                _yearController.text.toString(),
                                _lastMaintenanceController.text,
                                _lowerValue.toString(),
                                imageFirebaseUrl,
                                _vehicleColorController.text,
                              );
                            });
                          } else {
                            setState(() {
                              _isLoading = false;
                              print('error');
                            });
                          }
                        } else {

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      NetworkErrorScreen())).then((value) {
                            /// ----------- repeat the work
                          });

                        }
                      });
                      },
                      child: Container(
                        height: 45,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Update',
                              textAlign: TextAlign.center,
                              style: Styles.textButtonLabelSubTitle12,
                            ),
                          ],
                        ),
                      ),
                      color: CustColors.materialBlue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              _setValue(10))),
                    ),
                  ),
            ),
          ),
        ],
      ),
    ) ;
  }

  _showDialogSelectPhoto() async {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20))),
        builder: (builder) {
          return Container(
              height: 115.0,
              child: ListView(
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.camera_alt,
                      color: CustColors.blue,
                    ),
                    title: const Text("Camera",
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
                          uploadImageToFirebase(_images!);
                          String fileName = path.basename(image.path);
                          print(_images.toString() + ">>>>>>> image from camera");
                        }
                      });
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.image,
                      color: CustColors.blue,
                    ),
                    title: const Text("Gallery",
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
                          uploadImageToFirebase(_images!);
                          String fileName = path.basename(image.path);
                          print(_images.toString() + ">>>>>>> image from gallery");
                        }
                      });
                    },
                  ),
                ],
              ));
        });
  }

  Future uploadImageToFirebase(File images) async {
    String fileName = path.basename(images.path);
    Reference reference = FirebaseStorage.instance.ref().child("SupportChatImages").child(fileName);
    print(">>>>>>>>>>>>>>>> reference"+reference.toString());
    UploadTask uploadTask =  reference.putFile(images);
    uploadTask.whenComplete(() async{
      try{
        String fileImageurl="";
        fileImageurl = await reference.getDownloadURL();
        setState(() {
          imageFirebaseUrl = fileImageurl;
        });

      }catch(onError){
        print("Error");
      }
      print(">>>>>>>>>>>>>>>> imageFirebaseUrl "+imageFirebaseUrl.toString());
    });
  }

  _showDialogForBrands() async {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: const BorderRadius.only(
                topRight: const Radius.circular(20), topLeft: Radius.circular(20))),
        builder: (builder) {
          return Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                Container(
                  child: StreamBuilder(
                      stream:  _addCarBloc.ModelDetailResponse,
                      builder: (context, AsyncSnapshot<ModelDetailsMdl> snapshot) {
                        print("${snapshot.hasData}");
                        print("${snapshot.connectionState}");

                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return const Center(child: const CircularProgressIndicator());
                          default:
                            return
                              snapshot.data?.data?.modelDetails?.length != 0 && snapshot.data?.data?.modelDetails?.length != null
                                  ? ListView.builder(
                                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        itemCount: brandList.length,
                                        itemBuilder: (context, index) {
                                          print('brandList>>>>>>>>>> $brandList');
                                          return  InkWell(
                                            onTap: () async {
                                              Navigator.pop(context);

                                              setState(() {
                                                selectedmodel='';
                                                modelList = [];
                                                _modelController.text ='';
                                                engineList=[];_engineTypeController.text='';
                                                yearTypeList=[];_yearController.text='';
                                                selectedBrand=snapshot.data?.data!.modelDetails![index].id;
                                                selectedBrandName = "${brandList[index]}";

                                                _brandController.text = "${brandList[index]}";
                                                final modelName= "${snapshot.data?.data!.modelDetails![index].modelName}";
                                                final splitNames= modelName.split(',');
                                                for (int i = 0; i < splitNames.length; i++){
                                                  modelList.add(splitNames[i]);
                                                }

                                                if (_formKey.currentState!.validate()) {
                                                } else {
                                                }
                                              });

                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.all(13),
                                              child: Text("${brandList[index]}",
                                                  style: const TextStyle(
                                                      fontFamily: 'Corbel_Regular',
                                                      fontWeight: FontWeight.normal,
                                                      fontSize: 15,
                                                      color: Colors.black)),
                                            ),
                                          );

                                        },
                                      )
                                  : Container();
                        }
                      }),
                )
              ),);
        });
  }

  _showDialogForModel1() async {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: const BorderRadius.only(
                topRight: const Radius.circular(20), topLeft: const Radius.circular(20))),
        builder: (builder) {
          return Padding(
              padding: const EdgeInsets.all(8.0),
              child:

              StreamBuilder(
                  stream:  _addCarBloc.ModelDetailResponse,
                  builder: (context, AsyncSnapshot<ModelDetailsMdl> snapshot) {
                    print("${snapshot.hasData}");
                    print("${snapshot.connectionState}");
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return const Center(child: const CircularProgressIndicator());
                      default:
                        return
                          snapshot.data?.data?.modelDetails?.length != 0 && snapshot.data?.data?.modelDetails?.length != null
                              ? ListView.builder(
                                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: snapshot.data?.data?.modelDetails?.length,
                                  itemBuilder: (context, index) {


                                    return '${snapshot.data?.data!.modelDetails![index].brandName}' == selectedBrandName
                                        ?  InkWell(
                                            onTap: () async {
                                              Navigator.pop(context);
                                              setState(() {
                                                engineList=[];
                                                _engineTypeController.text='';
                                                yearTypeList=[];
                                                _yearController.text='';

                                                selectedmodel=snapshot.data?.data!.modelDetails![index].id;
                                                selectedModelName = snapshot.data?.data!.modelDetails![index].modelName;
                                                _modelController.text = "${snapshot.data?.data!.modelDetails![index].modelName}";
                                                _engineTypeController.text = "${snapshot.data?.data!.modelDetails![index].engineName}";
                                                _yearController.text = "${snapshot.data?.data!.modelDetails![index].years}";

                                                final engineName= "${snapshot.data?.data!.modelDetails![index].engineName}";
                                                final splitNames= engineName.split(',');
                                                for (int i = 0; i < splitNames.length; i++){
                                                  engineList.add(splitNames[i]);
                                                }

                                                final yearsNames= "${snapshot.data?.data!.modelDetails![index].years}";
                                                final splityearsNames= yearsNames.split(',');
                                                for (int i = 0; i < splityearsNames.length; i++){
                                                  yearTypeList.add(splityearsNames[i]);
                                                }
                                                if (_formKey.currentState!.validate()) {
                                                } else {
                                                }
                                              });

                                            },
                                          child: Container(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(13),
                                                  child: Text("${snapshot.data?.data!.modelDetails![index].modelName}",
                                                      style: const TextStyle(
                                                          fontFamily: 'Corbel_Regular',
                                                          fontWeight: FontWeight.normal,
                                                          fontSize: 15,
                                                          color: Colors.black)),
                                                ),
                                              ),
                                        )
                                        :  Container();
                                  },
                                )
                              : Container();
                    }
                  })
          );
        });
  }

  Widget setupAlertDialogMonthAndYear() {
    return Container(
      height: 300.0, // Change as per your requirement
      child: Column(
        children: [
          Container(
              width: double.infinity,
              height: 50,
              color: CustColors.blue,
              alignment: Alignment.center,
              child: const Text('Select Date',
                style: Styles.textButtonLabelSubTitle,)
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Text('Month',
                          style: Styles.textLabelTitle14,),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListWheelScrollView.useDelegate(
                            itemExtent: 40,
                            useMagnifier: true,
                            onSelectedItemChanged: (index) {
                              print(index);
                              monthYear1!(() {
                                selectedmonthIndex = index;
                                selectedMonthText = monthList[index];
                              });
                            },
                            childDelegate: ListWheelChildBuilderDelegate(
                                builder: (context, index) {
                                  return
                                    selectedmonthIndex==index
                                        ? Container(
                                            color: CustColors.pale_grey,
                                            margin: const EdgeInsets.only(left: 20, right: 20),
                                            alignment: Alignment.center,
                                            child: Text(
                                                '${monthList[index]}',
                                                style: Styles.TitleTextBlack
                                            ),
                                          )
                                        : Container(
                                            margin: const EdgeInsets.only(left: 20, right: 20),
                                            alignment: Alignment.center,
                                            child: Text('${monthList[index]}'),
                                          );
                                },
                                childCount: monthList.length),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Text('Year',
                          style: Styles.textLabelTitle14,),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListWheelScrollView.useDelegate(
                            itemExtent: 40,
                            useMagnifier: true,
                            onSelectedItemChanged: (index) {
                              print(index);
                              print(">>>selectedYearText + $selectedYearText" );
                              monthYear1!(() {
                                selectedyearIndex = index;
                                selectedYearText = yearList[index];
                                //if(selectedYearText == now.year){
                                  if(index == 12){
                                  print(">>>selectedYearText true + $selectedYearText" );
                                  monthList.clear();
                                  for(int i = 0; i <= now.month-1; i++ ){
                                    monthList.add(allMonthList[i]);
                                  }
                                }else{
                                  print(">>>selectedYearText false + $selectedYearText" );
                                  monthList.clear();
                                  for(int i = 0; i <= 11; i++ ){
                                    monthList.add(allMonthList[i]);
                                  }
                                }
                              });
                            },
                            childDelegate: ListWheelChildBuilderDelegate(
                                builder: (context, index) {
                                  return
                                    selectedyearIndex==index
                                        ? Container(
                                            color: CustColors.pale_grey,
                                            margin: const EdgeInsets.only(left: 20, right: 20),
                                            alignment: Alignment.center,
                                            child: Text(
                                                '${yearList[index]}',
                                                style: Styles.TitleTextBlack
                                            ),
                                          )
                                        : Container(
                                            margin: const EdgeInsets.only(left: 20, right: 20),
                                            alignment: Alignment.center,
                                            child: Text('${yearList[index]}'),
                                          );
                                },
                                childCount: yearList.length),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 15.8,bottom: 15),
            child: _isLoading
                ? Center(
              child: Container(
                height: _setValue(28),
                width: _setValue(28),
                child: const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      CustColors.light_navy),
                ),
              ),
            )
                : Container(
              child: MaterialButton(
                onPressed: () {

                  Navigator.pop(dialogContext!);
                  setState(() {

                    _lastMaintenanceController.text = '$selectedMonthText  $selectedYearText';
                    if (_formKey.currentState!.validate()) {
                    } else {
                    }
                  });

                },
                child: SizedBox(
                  height: 45,
                  width: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const[
                       Text(
                        'Done',
                        textAlign: TextAlign.center,
                        style: Styles.textButtonLabelSubTitle,
                      ),
                    ],
                  ),
                ),
                color: CustColors.materialBlue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        _setValue(10))),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget progressBarDarkBlue() {
    return SizedBox(
      height: 60.0,
      child: new Center(
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(CustColors.blue),
          )),
    );
  }

  Widget progressBarLightRose() {
    return const SizedBox(
      height: 60.0,
      child:  Center(
          child: CircularProgressIndicator(
            valueColor:  AlwaysStoppedAnimation<Color>(CustColors.blue),
          )),
    );
  }

  Widget progressBarTransparent() {
    return const SizedBox(
      height: 60.0,
      child:  Center(
          child: CircularProgressIndicator(
            valueColor:  AlwaysStoppedAnimation<Color>(Colors.transparent),
          )),
    );
  }

}

class Data {
  /// Initialize the instance of the [Data] class.
  Data({required this.x, required this.y});

  /// Spline series x points.
  final DateTime x;

  /// Spline series y points.
  final double y;
}


class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}