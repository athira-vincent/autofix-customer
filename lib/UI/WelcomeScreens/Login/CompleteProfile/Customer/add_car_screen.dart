import 'dart:io';

import 'package:another_xlider/another_xlider.dart';
import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/Constants/text_strings.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signin/login_screen.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signup/StateList/state_list.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signup/signup_bloc.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signup/states_mdl.dart';
import 'package:auto_fix/Utility/check_network.dart';
import 'package:auto_fix/Widgets/input_validator.dart';
import 'package:auto_fix/Widgets/snackbar_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AddCarScreen extends StatefulWidget {
  const AddCarScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AddCarScreenState();
  }
}

class _AddCarScreenState extends State<AddCarScreen> {

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

  TextEditingController _addressController = TextEditingController();
  FocusNode _addressFocusNode = FocusNode();
  File? _images;
  bool isloading = false;
  String? countryCode;
  double per = .10;
  double perfont = .10;
  double height = 0;
  String selectedState = "";
  final picker = ImagePicker();

  var _value = 2.0;
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
  bool _isLoading = false;
  double _lowerValue = 100;
  double _upperValue = 500;






  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: ScrollConfiguration(
          behavior: MyBehavior(),
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [

                  Container(
                    child: Text(
                      AppLocalizations.of(context)!.text_complete_your_profile,
                      style: Styles.textHeadLogin28,
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                    child: Container(
                      color: Colors.white,
                      child: Row(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              color: Colors.white,
                              child: SvgPicture.asset('assets/image/CustomerType/customerAddCar_bg.svg',height: size.height * 0.20,width: 30,),
                            ),
                          ),
                          Container(
                            width: 180,
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
                                      style: Styles.textLabelTitle14,
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
                  ),

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


                                        Container(
                                          margin: EdgeInsets.only(top: _setValue(15.5)),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(

                                                "Brand",
                                                style: Styles.textLabelTitle,
                                              ),
                                              TextFormField(
                                                textAlignVertical: TextAlignVertical.center,
                                                maxLines: 1,
                                                style: Styles.textLabelSubTitle,
                                                focusNode: _brandFocusNode,
                                                keyboardType: TextInputType.name,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter.allow(
                                                      RegExp('[a-zA-Z ]')),
                                                ],
                                                validator: InputValidator(
                                                    ch :
                                                    AppLocalizations.of(context)!.text_name ).nameChecking,
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
                                                  hintStyle: Styles.textLabelSubTitle,),
                                              ),
                                            ],
                                          ),
                                        ) ,


                                        Container(
                                          margin: EdgeInsets.only(top: _setValue(15.5)),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(

                                                "Model",
                                                style: Styles.textLabelTitle,
                                              ),
                                              TextFormField(
                                                textAlignVertical: TextAlignVertical.center,
                                                maxLines: 1,
                                                style: Styles.textLabelSubTitle,
                                                focusNode: _modelFocusNode,
                                                keyboardType: TextInputType.name,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter.allow(
                                                      RegExp('[a-zA-Z ]')),
                                                ],
                                                validator: InputValidator(
                                                    ch :
                                                    AppLocalizations.of(context)!.text_name ).nameChecking,
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
                                                  hintStyle: Styles.textLabelSubTitle,),
                                              ),
                                            ],
                                          ),
                                        ) ,

                                        Container(
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
                                                keyboardType: TextInputType.name,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter.allow(
                                                      RegExp('[a-zA-Z ]')),
                                                ],
                                                validator: InputValidator(
                                                    ch :
                                                    AppLocalizations.of(context)!.text_name ).nameChecking,
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
                                                  hintStyle: Styles.textLabelSubTitle,),
                                              ),
                                            ],
                                          ),
                                        ) ,



                                        Container(
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
                                                inputFormatters: [
                                                  FilteringTextInputFormatter.allow(
                                                      RegExp('[a-zA-Z ]')),
                                                ],
                                                validator: InputValidator(
                                                    ch :
                                                    AppLocalizations.of(context)!.text_name ).nameChecking,
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
                                                  hintStyle: Styles.textLabelSubTitle,),
                                              ),
                                            ],
                                          ),
                                        ) ,

                                        Container(
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
                                                inputFormatters: [
                                                  FilteringTextInputFormatter.allow(
                                                      RegExp('[a-zA-Z ]')),
                                                ],
                                                validator: InputValidator(
                                                    ch :
                                                    AppLocalizations.of(context)!.text_name ).nameChecking,
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
                                                  hintStyle: Styles.textLabelSubTitle,),
                                              ),
                                            ],
                                          ),
                                        ) ,

                                        Container(
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
                                                        _upperValue = upperValue;
                                                        print('$_lowerValue');
                                                      });
                                                    },
                                                  )
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ) ,


                                        Container(
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
                                        ) ,



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