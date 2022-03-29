import 'dart:io';
import 'dart:math';

import 'package:another_xlider/another_xlider.dart';
import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Customer/add_car_bloc.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signin/login_screen.dart';
import 'package:auto_fix/Utility/check_network.dart';
import 'package:auto_fix/Widgets/input_validator.dart';
import 'package:auto_fix/Widgets/snackbar_widget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../Customer/customer_home_screen.dart';
import 'brand_model_engine/makeBrandDetails_Mdl.dart';
import 'brand_model_engine/modelDetails_Mdl.dart';
import 'package:path/path.dart' as path;



class AddCarScreen extends StatefulWidget {

  final String userType;
  final String userCategory;


  AddCarScreen({required this.userType,required this.userCategory});

  @override
  State<StatefulWidget> createState() {
    return _AddCarScreenState();
  }
}

class _AddCarScreenState extends State<AddCarScreen> {

  String authToken="";
  final AddCarBloc _addCarBloc = AddCarBloc();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isLoading = false;
  bool _isAddMore = false;
  String imageFirebaseUrl="";
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
  double _setValueFont(double value) {
    return value * perfont + value;
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

  StateSetter? monthYear1;
  int? selectedyearIndex = 0 ;
  int? selectedmonthIndex = 0 ;
  String? selectedMonthText= 'Jan' ;
  String? selectedYearText= '1900';
  List<String> monthList = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
  List<String> yearList = [for(int i=1900; i<2050; i+=1) i.toString()];

  String? selectedBrand = '' ;
  String? selectedmodel = '' ;

  List<String> engineList = [];
  String? selectedengine = '' ;

  List<String> yearTypeList = [];
  String? selectedYearType = '' ;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPrefData();
    _listenAddCarResponse();
  }

  Future<void> getSharedPrefData() async {
    print('getSharedPrefData');
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    setState(() {
      authToken = shdPre.getString(SharedPrefKeys.token).toString();
      print('userFamilyId'+authToken.toString());
      _addCarBloc.postMakeBrandRequest(authToken);
    });
  }

  _listenAddCarResponse() {
    _addCarBloc.postModelDetail.listen((value) {
      if (value.status == "error") {
        setState(() {
          SnackBarWidget().setMaterialSnackBar( "${value.message}", _scaffoldKey);
          print("message postSignUpCustomerIndividual >>>>>>>  ${value.message}");
          print("errrrorr postSignUpCustomerIndividual >>>>>>>  ${value.status}");
          _isLoading = false;
        });

      } else {

        setState(() {
          _showDialogForModel();


        });
      }
    });
    _addCarBloc.postMakeBrand.listen((value) {
      if (value.status == "error") {
        setState(() {
          SnackBarWidget().setMaterialSnackBar( "${value.message}", _scaffoldKey);
          print("message postSignUpCustomerIndividual >>>>>>>  ${value.message}");
          print("errrrorr postSignUpCustomerIndividual >>>>>>>  ${value.status}");
          _isLoading = false;
        });

      } else {

        setState(() {
          print("success postSignUpCustomerIndividual >>>>>>>  ${value.data!.brandDetails![0].brandName.toString()}");
          print("success postSignUpCustomerIndividual >>>>>>>  ${value.status}");
          _isLoading = false;

        });
      }
    });
    _addCarBloc.postAddCar.listen((value) {
      if (value.status == "error") {
        setState(() {
          SnackBarWidget().setMaterialSnackBar( "${value.message}", _scaffoldKey);
          print("message postSignUpCustomerIndividual >>>>>>>  ${value.message}");
          print("errrrorr postSignUpCustomerIndividual >>>>>>>  ${value.status}");
          _isLoading = false;
        });

      } else {

        setState(() {
          print("success postSignUpCustomerIndividual >>>>>>>  ${value.status}");
          _isLoading = false;
           if(_isAddMore==true)
             {
                 _formKey.currentState?.reset();
                 _brandController.text='';
                 _modelController.text='';
                 _engineTypeController.text='';
                 _yearController.text='';
                 _lastMaintenanceController.text='';
                 _plateNumberController.text='';
                 _isAddMore = false;
             }
           else
             {

               Navigator.pushReplacement(
                   context,
                   MaterialPageRoute(
                       builder: (context) =>
                           CustomerHomeScreen()));
               FocusScope.of(context).unfocus();
               _isAddMore = false;
             }




        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print('${_images?.path}' + ">>>>>>> image from Widget");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
      ),
    );
  }




  Widget completeYourProfileText() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        child: Text(
          AppLocalizations.of(context)!.text_complete_your_profile,
          style: Styles.textCompleteYourProfile,
        ),
      ),
    );
  }

  Widget uploadVechicleImage(Size size) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 5),
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
                      child: Text(
                        'Upload your vechicle photo',
                        textAlign: TextAlign.center,
                        style: Styles.textUploadYourProfilePic,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Center(
                            child: Container(
                              width: 100.0,
                              height: 100.0,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: _images == null
                                    ? Container(
                                        child:CircleAvatar(
                                        radius: 50,
                                        backgroundColor: Colors.white,
                                        child: ClipOval(
                                          child:  SvgPicture.asset('assets/image/CustomerType/upload_car_avathar.svg'),
                                        )))
                                    : Container(
                                      height: 100,
                                      width: 100,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        backgroundImage: FileImage(_images!),
                                      ),
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
    return  InkWell(
      onTap: (){
        _showDialogForBrands();
      },
      child: Container(
        margin: EdgeInsets.only(top: _setValue(0.5)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Brand",
                    style: Styles.textLabelTitle,
                  ),
                  Spacer(),
                  Icon(
                    Icons.keyboard_arrow_down_sharp,
                    color: Colors.white,
                    size: 28.0,
                  ),

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
              cursorColor: CustColors.whiteBlueish,
              decoration: InputDecoration(
                isDense: true,
                hintText:
                "Select your vehicle brand",
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
                enabledBorder: UnderlineInputBorder(
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
      ),
    );
  }

  Widget modelTextSelection() {
    return  InkWell(
      onTap: () async {

        if(selectedBrand=='')
          {
            SnackBarWidget().setMaterialSnackBar( "Please select brand first", _scaffoldKey);
          }
        else
          {
            await  _addCarBloc.postModelDetailRequest(authToken,selectedBrand);

          }

      },
      child: Container(
        margin: EdgeInsets.only(top: _setValue(15.5)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Model",
                    style: Styles.textLabelTitle,
                  ),
                  Spacer(),
                  Icon(
                    Icons.keyboard_arrow_down_sharp,
                    color: Colors.white,
                    size: 28.0,
                  ),

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
              cursorColor: CustColors.whiteBlueish,
              decoration: InputDecoration(
                isDense: true,
                hintText:
                "Select your car variant",
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
                enabledBorder: UnderlineInputBorder(
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
      ) ,
    );
  }

  Widget engineTypeTextSelection() {
    return  InkWell(
      onTap: (){
        if(selectedmodel=='')
        {
          SnackBarWidget().setMaterialSnackBar( "Please select model first", _scaffoldKey);
        }
        else
        {
          _showDialogForEngineType(engineList);
        }
      },
      child: Container(
        margin: EdgeInsets.only(top: _setValue(15.5)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(

              "Select Engine Type",
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
              cursorColor: CustColors.whiteBlueish,
              decoration: InputDecoration(
                isDense: true,
                hintText:
                "Select your engine model",
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
                enabledBorder: UnderlineInputBorder(
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
      ) ,
    );
  }

  Widget yearTypeTextSelection() {
    return  InkWell(
      onTap: (){
        if(selectedmodel=='')
        {
          SnackBarWidget().setMaterialSnackBar( "Please select model first", _scaffoldKey);
        }
        else
        {
          _showDialogForYear(yearTypeList);
        }

      },
      child: Container(
        margin: EdgeInsets.only(top: _setValue(15.5)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(

              "Select Year",
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
              cursorColor: CustColors.whiteBlueish,
              decoration: InputDecoration(
                isDense: true,
                hintText:
                "Select your vehicle manufacture date",
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
                enabledBorder: UnderlineInputBorder(
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
      ) ,
    );
  }

  Widget plateNumberTextSelection() {
    return   Container(
      margin: EdgeInsets.only(top: _setValue(15.5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(

            "Plate number",
            style: Styles.textLabelTitle,
          ),
          TextFormField(
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
            cursorColor: CustColors.whiteBlueish,
            decoration: InputDecoration(
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
              enabledBorder: UnderlineInputBorder(
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
    return  InkWell(
      onTap: (){
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                contentPadding: EdgeInsets.all(0.0),
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
        margin: EdgeInsets.only(top: _setValue(15.5)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
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
              cursorColor: CustColors.whiteBlueish,
              decoration: InputDecoration(
                isDense: true,
                hintText:
                "Select your last service date",
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
                enabledBorder: UnderlineInputBorder(
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
      ),
    );
  }

  Widget approximateMilageSelection() {
    return  Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: _setValue(15.5),bottom: _setValue(15.5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            child: Text(
              "Approximate mileage",
              style: Styles.textLabelTitle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Container(
              child: Text(
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
                  max: 500,
                  min: 0,
                  tooltip: FlutterSliderTooltip(
                      custom: (value) {
                        return Text(value.toString());
                      }
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
                            padding: EdgeInsets.all(5),
                            child: Icon(
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
              margin: EdgeInsets.only(top: 20.8),
              child: _isLoading
                  ? Center(
                child: Container(
                  height: _setValue(28),
                  width: _setValue(28),
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        CustColors.peaGreen),
                  ),
                ),
              )
                  : Container(

                      child: MaterialButton(
                        onPressed: () {
                          setState(() {
                            _isAddMore = true;
                            _isLoading = true;
                            print('true');
                          });
                          if (_formKey.currentState!.validate()) {

                            setState(() {
                              _isLoading = false;
                              print('sucess');
                              _addCarBloc. postAddCarRequest(
                                  authToken,
                                  selectedYearType ,
                                  _plateNumberController.text,
                                  selectedengine,
                                  _lastMaintenanceController.text,
                                  _lowerValue.toString(),
                                  selectedBrand,
                                  selectedmodel,
                                  imageFirebaseUrl
                              );
                            });
                          } else {
                            setState(() {
                              _isLoading = false;
                              print('error');
                            });
                          }


                        },
                        child: Container(
                          height: 45,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Add More',
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
          ),
          Spacer(),
          Container(
            child: Container(
              margin: EdgeInsets.only(top: 20.8),
              child: _isLoading
                  ? Center(
                      child: Container(
                        height: _setValue(28),
                        width: _setValue(28),
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              CustColors.peaGreen),
                        ),
                      ),
                    )
                  : Container(
                    child: MaterialButton(
                      onPressed: () {
                        print( authToken + "  " +
                            selectedYearType! + "  " +
                            'kl-34 A213' + "  " +
                            selectedengine! +  "  " +
                            _lastMaintenanceController.text + "  " +
                                _plateNumberController.text + "  " +
                            _lowerValue.toString() + "  " +
                            selectedBrand! + "  " +
                            selectedmodel! + " >>>>>>>>>>>> " +
                            _brandController.text.toString() + "  " +
                            _modelController.text + "  " +
                            _engineTypeController.text + "  " +
                            _yearController.text + "  " +
                            _lastMaintenanceController.text + "  " +
                                _plateNumberController.text + "  " +
                            _lowerValue.toString() );
                        setState(() {
                          _isLoading = true;
                          _isAddMore = false;
                          print('true');
                        });
                        if (_formKey.currentState!.validate()) {

                          setState(() {
                            _isLoading = false;
                            print('sucess');
                            _addCarBloc. postAddCarRequest(
                              authToken,
                              selectedYearType ,
                               _plateNumberController.text,
                              selectedengine,
                              _lastMaintenanceController.text,
                              _lowerValue.toString(),
                              selectedBrand,
                              selectedmodel,
                              imageFirebaseUrl
                            );
                          });
                        } else {
                          setState(() {
                            _isLoading = false;
                            print('error');
                          });
                        }
                      },
                      child: Container(
                        height: 45,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Next',
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
          ),
        ],
      ),
    ) ;
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
                          uploadImageToFirebase(_images!);
                          String fileName = path.basename(image.path);
                          print(_images.toString() + ">>>>>>> image from camera");
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
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20))),
        builder: (builder) {
          return Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                Container(
                  child: StreamBuilder(
                      stream:  _addCarBloc.MakeBrandResponse,
                      builder: (context, AsyncSnapshot<MakeBrandDetailsMdl> snapshot) {
                        print("${snapshot.hasData}");
                        print("${snapshot.connectionState}");

                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return CircularProgressIndicator();
                          default:
                            return
                              snapshot.data?.data?.brandDetails?.length != 0 && snapshot.data?.data?.brandDetails?.length != null
                                  ? ListView.builder(
                                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        itemCount: snapshot.data?.data?.brandDetails?.length,
                                        itemBuilder: (context, index) {
                                          return  ListTile(
                                            title: Text("${snapshot.data?.data!.brandDetails![index].brandName}",
                                                style: TextStyle(
                                                    fontFamily: 'Corbel_Regular',
                                                    fontWeight: FontWeight.normal,
                                                    fontSize: 15,
                                                    color: Colors.black)),
                                            onTap: () async {
                                              Navigator.pop(context);

                                              setState(() {
                                                selectedmodel='';
                                                _modelController.text ='';
                                                engineList=[];
                                                _engineTypeController.text='';
                                                yearTypeList=[];
                                                _yearController.text='';

                                                selectedBrand=snapshot.data?.data!.brandDetails![index].id;
                                                _brandController.text = "${snapshot.data?.data!.brandDetails![index].brandName}";
                                                if (_formKey.currentState!.validate()) {
                                                } else {
                                                }
                                              });

                                            },
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

  _showDialogForModel() async {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20))),
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
                          return CircularProgressIndicator();
                        default:
                          return
                            snapshot.data?.data?.modelDetails?.length != 0 && snapshot.data?.data?.modelDetails?.length != null
                                ? ListView.builder(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: snapshot.data?.data?.modelDetails?.length,
                              itemBuilder: (context, index) {
                                if (snapshot.connectionState != ConnectionState.active) {
                                  print('connectionState');
                                  return Center(child: progressBarLightRose());
                                }
                                return  ListTile(
                                  title: Text("${snapshot.data?.data!.modelDetails![index].modelName}",
                                      style: TextStyle(
                                          fontFamily: 'Corbel_Regular',
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15,
                                          color: Colors.black)),
                                  onTap: () async {
                                    Navigator.pop(context);

                                    setState(() {
                                      engineList=[];
                                      _engineTypeController.text='';
                                      yearTypeList=[];
                                      _yearController.text='';

                                      selectedmodel=snapshot.data?.data!.modelDetails![index].id;
                                      _modelController.text = "${snapshot.data?.data!.modelDetails![index].modelName}";

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

  _showDialogForEngineType(List<String> engineList) async {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20))),
        builder: (builder) {
          return Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: engineList.length,
                itemBuilder: (context, index) {
                  return  ListTile(
                    title: Text("${engineList[index]}",
                        style: TextStyle(
                            fontFamily: 'Corbel_Regular',
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                            color: Colors.black)),
                    onTap: () async {
                      Navigator.pop(context);

                      setState(() {

                        selectedengine=engineList[index];
                        _engineTypeController.text = engineList[index];
                        if (_formKey.currentState!.validate()) {
                        } else {
                        }
                      });

                    },
                  );
                },
              ),
            ),);
        });
  }

  _showDialogForYear(List<String> yearTypeList) async {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20))),
        builder: (builder) {
          return Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: yearTypeList.length,
                itemBuilder: (context, index) {
                  return  ListTile(
                    title: Text("${yearTypeList[index]}",
                        style: TextStyle(
                            fontFamily: 'Corbel_Regular',
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                            color: Colors.black)),
                    onTap: () async {
                      Navigator.pop(context);

                      setState(() {

                        selectedYearType=yearTypeList[index];
                        _yearController.text = yearTypeList[index];
                        if (_formKey.currentState!.validate()) {
                        } else {
                        }
                      });

                    },
                  );
                },
              ),
            ),);
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
              child: Text('Select Date',
                style: Styles.textButtonLabelSubTitle,)
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
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
                                            margin: EdgeInsets.only(left: 20, right: 20),
                                            alignment: Alignment.center,
                                            child: Text(
                                                '${monthList[index]}',
                                                style: Styles.TitleTextBlack
                                            ),
                                          )
                                        : Container(
                                            margin: EdgeInsets.only(left: 20, right: 20),
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
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
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
                              monthYear1!(() {
                                selectedyearIndex = index;
                                selectedYearText = yearList[index];
                              });
                            },
                            childDelegate: ListWheelChildBuilderDelegate(
                                builder: (context, index) {
                                  return
                                    selectedyearIndex==index
                                        ? Container(
                                            color: CustColors.pale_grey,
                                            margin: EdgeInsets.only(left: 20, right: 20),
                                            alignment: Alignment.center,
                                            child: Text(
                                                '${yearList[index]}',
                                                style: Styles.TitleTextBlack
                                            ),
                                          )
                                        : Container(
                                            margin: EdgeInsets.only(left: 20, right: 20),
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
            margin: EdgeInsets.only(top: 15.8,bottom: 15),
            child: _isLoading
                ? Center(
              child: Container(
                height: _setValue(28),
                width: _setValue(28),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      CustColors.peaGreen),
                ),
              ),
            )
                : Container(
              child: MaterialButton(
                onPressed: () {

                  Navigator.pop(context);
                  setState(() {

                    _lastMaintenanceController.text = '$selectedMonthText  $selectedYearText';
                    if (_formKey.currentState!.validate()) {
                    } else {
                    }
                  });

                },
                child: Container(
                  height: 45,
                  width: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
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
    return Container(
      height: 60.0,
      child: new Center(
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(CustColors.blue),
          )),
    );
  }

  Widget progressBarLightRose() {
    return Container(
      height: 60.0,
      child: new Center(
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(CustColors.blue),
          )),
    );
  }

  Widget progressBarTransparent() {
    return Container(
      height: 60.0,
      child: new Center(
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.transparent),
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