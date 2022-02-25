import 'dart:io';

import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/Constants/text_strings.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/wait_admin_approval_screen.dart';
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


class WorkSelectionScreen extends StatefulWidget {

  final String userType;
  final String userCategory;


  WorkSelectionScreen({required this.userType,required this.userCategory});

  @override
  State<StatefulWidget> createState() {
    return _WorkSelectionScreenState();
  }
}

class _WorkSelectionScreenState extends State<WorkSelectionScreen> {

  TextEditingController _workSelectionController = TextEditingController();
  FocusNode _workSelectionFocusNode = FocusNode();

  TextEditingController _noOfMechanicsController = TextEditingController();
  FocusNode _noOfMechanicsFocusNode = FocusNode();

  TextEditingController _rcNumberController = TextEditingController();
  FocusNode _rcNumberFocusNode = FocusNode();

  TextEditingController _chooseVechicleSpecializedController = TextEditingController();
  FocusNode _chooseVechicleSpecializedFocusNode = FocusNode();

  TextEditingController _yearOfExistenceController = TextEditingController();
  FocusNode _yearOfExistenceFocusNode = FocusNode();

  TextEditingController _addressController = TextEditingController();
  FocusNode _addressFocusNode = FocusNode();

  TextEditingController _identificationProofController = TextEditingController();
  FocusNode _identificationProofFocusNode = FocusNode();

  TextEditingController _apprenticeCertificateController = TextEditingController();
  FocusNode _apprenticeCertificateFocusNode = FocusNode();

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
  bool _isLoading = false;



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print('${_images?.path}' + ">>>>>>> image from Widget");
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: ScrollConfiguration(
          behavior: MyBehavior(),
          child: SingleChildScrollView(
            child: SafeArea(
              child:
              widget.userCategory==TextStrings.user_category_individual
                ? Column(
                    children: [
                      completeYourProfileText(),
                      uploadMechanicProfileImage(size),
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
                                            workSelectionTextSelection() ,
                                            vehicleSpecializedTextSelection(),
                                            uploadApprenticeCertificateSelection()  ,
                                            addressTextSelection(),
                                            meansOfIdentificationSelection(),
                                            NextButtonMechanicIndividual(),


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
                  )
                : Column(
                    children: [
                      completeYourProfileText(),
                      uploadMechanicProfileImage(size),

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
                                            workSelectionTextSelection() ,
                                            numberOfMechanicsSelection(),
                                            rcNumberSelection(),
                                            vehicleSpecializedTextSelection(),
                                            yearOfExistenceSelection(),
                                            addressTextSelection(),
                                            NextButtonMechanicCorporate(),

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

  Widget uploadMechanicProfileImage(Size size) {
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
                child: SvgPicture.asset('assets/image/MechanicType/mechanicCompleteProfile_bg.svg',height: size.height * 0.25,width: 30,),
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

  Widget workSelectionTextSelection() {
    return  Container(
      margin: EdgeInsets.only(top: _setValue(15.5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(

            "Work Selection",
            style: Styles.textLabelTitle,
          ),
          TextFormField(
            textAlignVertical: TextAlignVertical.center,
            maxLines: 1,
            style: Styles.textLabelSubTitle,
            focusNode: _workSelectionFocusNode,
            keyboardType: TextInputType.name,
            enabled: false,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                  RegExp('[a-zA-Z ]')),
            ],
            validator: InputValidator(
                ch :
                AppLocalizations.of(context)!.text_name ).nameChecking,
            controller: _workSelectionController,
            cursorColor: CustColors.whiteBlueish,
            decoration: InputDecoration(
              isDense: true,
              hintText:
              "Select your service type(Emergency/regular…)",
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

  Widget vehicleSpecializedTextSelection() {
    return Container(
      margin: EdgeInsets.only(top: _setValue(15.5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(

            "Choose vehicle specialised",
            style: Styles.textLabelTitle,
          ),
          TextFormField(
            textAlignVertical: TextAlignVertical.center,
            maxLines: 1,
            style: Styles.textLabelSubTitle,
            focusNode: _chooseVechicleSpecializedFocusNode,
            keyboardType: TextInputType.name,
            enabled: false,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                  RegExp('[a-zA-Z ]')),
            ],
            validator: InputValidator(
                ch :
                AppLocalizations.of(context)!.text_name ).nameChecking,
            controller: _chooseVechicleSpecializedController,
            cursorColor: CustColors.whiteBlueish,
            decoration: InputDecoration(
              isDense: true,
              hintText:
              "Select your company specialised vehicles",
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

  Widget uploadApprenticeCertificateSelection() {
    return  Container(
      margin: EdgeInsets.only(top: _setValue(15.5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(

            "Upload certificate of apprentice ",
            style: Styles.textLabelTitle,
          ),
          TextFormField(
            textAlignVertical: TextAlignVertical.center,
            maxLines: 1,
            style: Styles.textLabelSubTitle,
            focusNode: _apprenticeCertificateFocusNode,
            keyboardType: TextInputType.name,
            enabled: false,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                  RegExp('[a-zA-Z ]')),
            ],
            validator: InputValidator(
                ch :
                AppLocalizations.of(context)!.text_name ).nameChecking,
            controller: _apprenticeCertificateController,
            cursorColor: CustColors.whiteBlueish,
            decoration: InputDecoration(
              isDense: true,
              hintText:
              "Attach your certificates ",
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

  Widget addressTextSelection() {
    return   Container(
      margin: EdgeInsets.only(top: _setValue(15.5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(

            "Address",
            style: Styles.textLabelTitle,
          ),
          TextFormField(
            textAlignVertical: TextAlignVertical.center,
            maxLines: 1,
            style: Styles.textLabelSubTitle,
            focusNode: _addressFocusNode,
            keyboardType: TextInputType.name,
            enabled: false,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                  RegExp('[a-zA-Z ]')),
            ],
            validator: InputValidator(
                ch :
                AppLocalizations.of(context)!.text_name ).nameChecking,
            controller: _addressController,
            cursorColor: CustColors.whiteBlueish,
            decoration: InputDecoration(
              isDense: true,
              hintText:
              "Enter your address",
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

  Widget meansOfIdentificationSelection() {
    return  Container(
      margin: EdgeInsets.only(top: _setValue(15.5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(

            "Means of identification ",
            style: Styles.textLabelTitle,
          ),
          TextFormField(
            textAlignVertical: TextAlignVertical.center,
            maxLines: 1,
            style: Styles.textLabelSubTitle,
            focusNode: _identificationProofFocusNode,
            keyboardType: TextInputType.name,
            enabled: false,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                  RegExp('[a-zA-Z ]')),
            ],
            validator: InputValidator(
                ch :
                AppLocalizations.of(context)!.text_name ).nameChecking,
            controller: _identificationProofController,
            cursorColor: CustColors.whiteBlueish,
            decoration: InputDecoration(
              isDense: true,
              hintText:
              "Attach any identification proof",
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
    ) ;
  }


  Widget numberOfMechanicsSelection() {
    return  Container(
      margin: EdgeInsets.only(top: _setValue(15.5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(

            "Number of mechanics",
            style: Styles.textLabelTitle,
          ),
          TextFormField(
            textAlignVertical: TextAlignVertical.center,
            maxLines: 1,
            style: Styles.textLabelSubTitle,
            focusNode: _noOfMechanicsFocusNode,
            keyboardType: TextInputType.name,
            enabled: false,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                  RegExp('[a-zA-Z ]')),
            ],
            validator: InputValidator(
                ch :
                AppLocalizations.of(context)!.text_name ).nameChecking,
            controller: _noOfMechanicsController,
            cursorColor: CustColors.whiteBlueish,
            decoration: InputDecoration(
              isDense: true,
              hintText:
              "Select your mechanic strength",
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

  Widget rcNumberSelection() {
    return  Container(
      margin: EdgeInsets.only(top: _setValue(15.5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(

            "RC number",
            style: Styles.textLabelTitle,
          ),
          TextFormField(
            textAlignVertical: TextAlignVertical.center,
            maxLines: 1,
            style: Styles.textLabelSubTitle,
            focusNode: _rcNumberFocusNode,
            keyboardType: TextInputType.name,
            enabled: false,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                  RegExp('[a-zA-Z ]')),
            ],
            validator: InputValidator(
                ch :
                AppLocalizations.of(context)!.text_name ).nameChecking,
            controller: _rcNumberController,
            cursorColor: CustColors.whiteBlueish,
            decoration: InputDecoration(
              isDense: true,
              hintText:
              "Enter your  RC number",
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

  Widget yearOfExistenceSelection() {
    return  Container(
      margin: EdgeInsets.only(top: _setValue(15.5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(

            "Year of existence",
            style: Styles.textLabelTitle,
          ),
          TextFormField(
            textAlignVertical: TextAlignVertical.center,
            maxLines: 1,
            style: Styles.textLabelSubTitle,
            focusNode: _yearOfExistenceFocusNode,
            keyboardType: TextInputType.name,
            enabled: false,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                  RegExp('[a-zA-Z ]')),
            ],
            validator: InputValidator(
                ch :
                AppLocalizations.of(context)!.text_name ).nameChecking,
            controller: _yearOfExistenceController,
            cursorColor: CustColors.whiteBlueish,
            decoration: InputDecoration(
              isDense: true,
              hintText:
              "Enter you year of existence ",
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
    ) ;
  }

  Widget NextButtonMechanicIndividual() {
    return  Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: _setValue(0.5),bottom: _setValue(25.5)),
      child: Row(
        children: [
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
                        Navigator.pushReplacement(
                          context,
                          new MaterialPageRoute(
                              builder: (context) =>
                                  WaitAdminApprovalScreen(refNumber:'12345678')),
                        );

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
    );
  }

  Widget NextButtonMechanicCorporate() {
    return  Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: _setValue(0.5),bottom: _setValue(25.5)),
      child: Row(
        children: [
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
                        Navigator.pushReplacement(
                          context,
                          new MaterialPageRoute(
                              builder: (context) =>
                                  WaitAdminApprovalScreen(refNumber:'12345678')),
                        );

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


class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}