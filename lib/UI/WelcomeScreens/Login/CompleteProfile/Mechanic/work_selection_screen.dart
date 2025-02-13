import 'dart:io';
import 'dart:typed_data';

import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/Constants/text_strings.dart';
import 'package:auto_fix/Models/customer_models/brand_list_model/brandListMdl.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/CompleteProfile/mechanic_complete_profile_bloc.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/both_service_list.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/ServiceList/emergancy_service_list_screen.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/regular_service_list.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/vechicleSpecialization/vehicleSpecialization_mdl.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/vechicleSpecialization/vehicle_specialization_screen.dart';
import 'package:auto_fix/Utility/check_network.dart';
import 'package:auto_fix/Widgets/input_validator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


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

  MechanicCompleteProfileBloc _completeProfileBloc = MechanicCompleteProfileBloc();

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

  List<String> workSelectionList = ['Regular Services','Emergency Services','Both'];
  String? selectedworkSelection = '' ;

  List<String> noOfMechanicsSelectionList = ['1-25','25-50','50-75','75-100'];
  String? noOfMechanicsSelection = '' ;

  String? _fileName_meansOfIdentification;
  String? _fileName_apprenticeCertificate;
  String imageFirebaseUrl="";
  String meansOfIdentificationFirebaseUrl="";
  String certificateOfApprenticeFirebaseUrl="";

  String selectedVehicleId = "";
  String selectedVehicles = "";

  String authToken="";

  @override
  void initState() {
    super.initState();
    getSharedPrefData();
    _listenCompleteProfileResponse();

  }

  Future<void> getSharedPrefData() async {
    print('getSharedPrefData');
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    setState(() {
      authToken = shdPre.getString(SharedPrefKeys.token).toString();
      print('authToken >>>>>>> '+authToken.toString());

    });
  }

  _listenCompleteProfileResponse() {
    _completeProfileBloc.postCompleteProfileIndividual.listen((value) {
      if (value.status == "error") {
        setState(() {
          //SnackBarWidget().setMaterialSnackBar( "${value.message}", _scaffoldKey);
          print("message postCompleteProfileIndividual >>>>>>>  ${value.message}");
          print("errrrorr postCompleteProfileIndividual >>>>>>>  ${value.status}");
          _isLoading = false;
        });

      } else {

        setState(() {
          print("success postCompleteProfileIndividual >>>>>>>  ${value.status}");
          _isLoading = false;
          //_completeProfileBloc.userDefault(value.data!.customersSignUpIndividual!.token.toString());
          //SnackBarWidget().setMaterialSnackBar( "Successfully Registered", _scaffoldKey);
          /*Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      OtpVerificationScreen(userType: widget.userType,userCategory: widget.userCategory,)));
          FocusScope.of(context).unfocus();
          */
          changeScreen();
        });
      }
    });
    _completeProfileBloc.postCompleteProfileCorporate.listen((value) {
      if (value.status == "error") {
        setState(() {
          //SnackBarWidget().setMaterialSnackBar( "${value.message}", _scaffoldKey);
          print("message postCompleteProfileCorporate >>>>>>>  ${value.message}");
          print("errrrorr postCompleteProfileCorporate >>>>>>>  ${value.status}");
          _isLoading = false;
        });

      } else {

        setState(() {
          print("success postCompleteProfileCorporate >>>>>>>  ${value.status}");
          _isLoading = false;
          //_completeProfileBloc.userDefault(value.data!.mechanicSignUpIndividual!.token.toString());
         // SnackBarWidget().setMaterialSnackBar( "Successfully Registered", _scaffoldKey);
          /*Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      OtpVerificationScreen(userType: widget.userType,userCategory: widget.userCategory,)));
          FocusScope.of(context).unfocus();*/
          changeScreen();
        });
      }
    });
  }

  void changeScreen(){
    if(_workSelectionController.text.toString() == "Regular Services"){
      print("Regular Services");
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => RegularServiceListScreen() ));
      FocusScope.of(context).unfocus();
    }else if(_workSelectionController.text.toString() == "Emergency Services"){
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => EmergencyServiceListScreen() ));
      FocusScope.of(context).unfocus();
    }
    else{
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => BothServiceListScreen() ));
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print('${_images?.path}' + ">>>>>>> image from Widget");
    return Scaffold(
      backgroundColor: Colors.white,
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: SafeArea(
            child:
            widget.userCategory == TextStrings.user_category_individual
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
                                      uploadApprenticeCertificateSelection() ,
                                      meansOfIdentificationSelection(),
                                      addressTextSelection(),
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
                        AppLocalizations.of(context)!.text_upload_your_profile_photo,
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
                                            child:  SvgPicture.asset('assets/image/CustomerType/profileAvathar.svg'),
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
    return  InkWell(
      onTap: (){
        _showDialogForWorkSelection(workSelectionList);
      },
      child: Container(
        margin: EdgeInsets.only(top: _setValue(15.5)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.text_work_selection,
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
                  AppLocalizations.of(context)!.text_work_selection).nameChecking,
              controller: _workSelectionController,
              cursorColor: CustColors.light_navy,
              decoration: InputDecoration(
                isDense: true,
                suffixIcon: Align(
                  widthFactor: 3.0,
                  heightFactor: 3.0,
                  child: SvgPicture.asset('assets/image/arrow_down.svg',height: 7,width: 7,)
                ),
                hintText:
                AppLocalizations.of(context)!.text_select_your_service_type,
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

  Widget vehicleSpecializedTextSelection() {
    return InkWell(
      onTap: (){
        _awaitReturnValueFromSecondScreen1(context);
      },
      child: Container(
        margin: EdgeInsets.only(top: _setValue(15.5)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.text_choose_vehicle_specialised,
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
                    RegExp('[a-zA-Z0-9 ]')),
              ],
              validator: InputValidator(
                  ch :AppLocalizations.of(context)!.text_vehicle_specialised).nameCheckingWithNumericAndBracket,
              controller: _chooseVechicleSpecializedController,
              cursorColor: CustColors.light_navy,
              decoration: InputDecoration(
                suffixIcon: Align(
                    widthFactor: 3.0,
                    heightFactor: 3.0,
                    child: SvgPicture.asset('assets/image/arrow_down.svg',height: 7,width: 7,)
                ),
                isDense: true,
                hintText: "Select your specialised vehicles",
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

  void _awaitReturnValueFromSecondScreen1(BuildContext context) async {

    // start the SecondScreen and wait for it to finish with a result
    List<Datum> vehicleSpecialisationList = [];
    vehicleSpecialisationList.clear();
    selectedVehicleId="";
    selectedVehicles = "";
    _chooseVechicleSpecializedController.text="";
    vehicleSpecialisationList = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VehicleSpecializationScreen(),
        ));

    setState(() {
      for(int i = 0; i<vehicleSpecialisationList.length ; i++){
        if(vehicleSpecialisationList.length-1 == i){
          selectedVehicleId = selectedVehicleId
              + vehicleSpecialisationList[i].id.toString() ;
          selectedVehicles = selectedVehicles
              + vehicleSpecialisationList[i].brandName.toString() ;
        }
        else{
          selectedVehicleId = selectedVehicleId
              + vehicleSpecialisationList[i].id.toString() + ",";
          selectedVehicles = selectedVehicles
              + vehicleSpecialisationList[i].brandName.toString() + ",";

        }
      }
      if(selectedState!='[]')
      {
        _chooseVechicleSpecializedController.text = selectedVehicles;
        print ("Selected state @ sign up: " + selectedState );
        print ("Selected selectedVehicleId @ sign up: " + selectedVehicleId );
        print ("Selected selectedVehicles @ sign up: " + selectedVehicles.trim() );
      }

    });
  }

  void _awaitReturnValueFromSecondScreen(BuildContext context) async {

    // start the SecondScreen and wait for it to finish with a result
    List<VehicleSpecialization> vehicleSpecialisationList = [];
    vehicleSpecialisationList.clear();
    selectedVehicleId="";
    selectedVehicles = "";
    _chooseVechicleSpecializedController.text="";
    vehicleSpecialisationList = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VehicleSpecializationScreen(),
        ));

    setState(() {
      for(int i = 0; i<vehicleSpecialisationList.length ; i++){
        if(vehicleSpecialisationList.length-1 == i){
          selectedVehicleId = selectedVehicleId
              + vehicleSpecialisationList[i].id.toString() ;
          selectedVehicles = selectedVehicles
              + vehicleSpecialisationList[i].name.toString() ;
        }
        else{
          selectedVehicleId = selectedVehicleId
              + vehicleSpecialisationList[i].id.toString() + ", ";
          //+ ( vehicleSpecialisationList.length == i ? "" : ", ") ;
          selectedVehicles = selectedVehicles
              + vehicleSpecialisationList[i].name.toString() + ", ";
          //+ ( vehicleSpecialisationList.length == i ? "" : ", ") ;

        }
      }
      if(selectedState!='[]')
        {
          _chooseVechicleSpecializedController.text = selectedVehicles;
          print ("Selected state @ sign up: " + selectedState );
          print ("Selected selectedVehicleId @ sign up: " + selectedVehicleId );
          print ("Selected selectedVehicles @ sign up: " + selectedVehicles );
         /* if (_formKey.currentState!.validate()) {
          } else {
          }*/
        }

    });
  }

  Widget uploadApprenticeCertificateSelection() {
    return  InkWell(
      onTap: (){
        _openFileExplorerApprenticeCertificate();
      },
      child: Container(
        margin: EdgeInsets.only(top: _setValue(15.5)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.text_upload_certificate_apprentice,
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
                  ch :AppLocalizations.of(context)!.text_upload_certificate_apprentice).emptyChecking,
              controller: _apprenticeCertificateController,
              cursorColor: CustColors.light_navy,
              decoration: InputDecoration(
                isDense: true,
                suffixIcon: Align(
                    widthFactor: 3.0,
                    heightFactor: 3.0,
                    child: SvgPicture.asset('assets/image/attach_icon.svg',height: 9,width: 9,)
                ),
                hintText:
                AppLocalizations.of(context)!.text_attach_your_certificates,
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
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                  RegExp('[a-zA-Z0-9 .,:()-]')),
            ],
            validator: InputValidator(
                ch :AppLocalizations.of(context)!.text_address).emptyChecking,
            controller: _addressController,
            cursorColor: CustColors.light_navy,
            decoration: InputDecoration(
              isDense: true,
              hintText:
              AppLocalizations.of(context)!.text_enter_address,
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
    return  InkWell(
      onTap: (){
        _openFileExplorerMeansOfIdentification();
      },
      child: Container(
        margin: EdgeInsets.only(top: _setValue(15.5)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.text_means_identification,
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
                  ch :AppLocalizations.of(context)!.text_means_identification ).emptyChecking,
              controller: _identificationProofController,
              cursorColor: CustColors.light_navy,
              decoration: InputDecoration(
                isDense: true,
                suffixIcon: Align(
                    widthFactor: 3.0,
                    heightFactor: 3.0,
                    child: SvgPicture.asset('assets/image/attach_icon.svg',height: 9,width: 9,)
                ),
                hintText:
                AppLocalizations.of(context)!.text_attach_any_identification_proof,
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
    ) ;
  }


  Widget numberOfMechanicsSelection() {
    return  InkWell(
      onTap: (){
        _showDialogNumberOfMecanicsSelection(noOfMechanicsSelectionList);
      },
      child: Container(
        margin: EdgeInsets.only(top: _setValue(15.5)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.text_number_mechanics,
              style: Styles.textLabelTitle,
            ),
            TextFormField(
              textAlignVertical: TextAlignVertical.center,
              maxLines: 1,
              style: Styles.textLabelSubTitle,
              focusNode: _noOfMechanicsFocusNode,
              keyboardType: TextInputType.number,
              enabled: false,
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                    RegExp('[0-9]')),
              ],
              validator: InputValidator(
                  ch :
                  AppLocalizations.of(context)!.text_mechanic_strength).nameCheckingWithNumeric,
              controller: _noOfMechanicsController,
              cursorColor: CustColors.light_navy,
              decoration: InputDecoration(
                isDense: true,
                suffixIcon: Align(
                    widthFactor: 3.0,
                    heightFactor: 3.0,
                    child: SvgPicture.asset('assets/image/arrow_down.svg',height: 7,width: 7,)
                ),
                hintText: AppLocalizations.of(context)!.text_select_your_mechanic_strength,
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

  Widget rcNumberSelection() {
    return  Container(
      margin: EdgeInsets.only(top: _setValue(15.5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.text_RC_number,
            style: Styles.textLabelTitle,
          ),
          TextFormField(
            textAlignVertical: TextAlignVertical.center,
            maxLines: 1,
            style: Styles.textLabelSubTitle,
            focusNode: _rcNumberFocusNode,
            keyboardType: TextInputType.name,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                  RegExp('[a-zA-Z0-9 ]')),
            ],
            validator: InputValidator(
                ch : AppLocalizations.of(context)!.text_RC_number).nameCheckingWithNumeric,
            controller: _rcNumberController,
            cursorColor: CustColors.light_navy,
            decoration: InputDecoration(
              isDense: true,
              hintText:
              AppLocalizations.of(context)!.text_enter_your_RC_number,
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

            AppLocalizations.of(context)!.text_year_of_existence,
            style: Styles.textLabelTitle,
          ),
          TextFormField(
            textAlignVertical: TextAlignVertical.center,
            maxLines: 1,
            style: Styles.textLabelSubTitle,
            focusNode: _yearOfExistenceFocusNode,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                  RegExp('[0-9]')),
              LengthLimitingTextInputFormatter(3),
            ],
            validator: InputValidator(
                ch : AppLocalizations.of(context)!.text_year_of_existence ).nameCheckingWithNumeric,
            controller: _yearOfExistenceController,
            cursorColor: CustColors.light_navy,
            decoration: InputDecoration(
              isDense: true,
              hintText:
              AppLocalizations.of(context)!.text_enter_you_year_of_existence,
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
                        CustColors.light_navy),
                  ),
                ),
              )
                  : Container(
                    child: MaterialButton(
                      onPressed: () {

                        if (_formKey.currentState!.validate()) {
                          //_isLoading = true;
                          _completeProfileBloc.postCompleteProfileIndividualRequest(
                              authToken,
                              _workSelectionController.text,
                              // _chooseVechicleSpecializedController.text.toString(),
                              //selectedVehicleId,
                              selectedVehicles,
                              _addressController.text.toString(),
                              certificateOfApprenticeFirebaseUrl,
                              meansOfIdentificationFirebaseUrl,imageFirebaseUrl
                          );
                        } else {
                          print("individual _formKey.currentState!.validate() - else");
                          setState(() => _autoValidate = AutovalidateMode.always);
                        }



                       /* Navigator.pushReplacement(
                          context,
                          new MaterialPageRoute(
                              builder: (context) =>
                                  WaitAdminApprovalScreen(refNumber:'12345678')),
                        );*/

                      },
                      child: Container(
                        height: 45,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.next,
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
                        CustColors.light_navy),
                  ),
                ),
              )
                  : Container(

                    child: MaterialButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _completeProfileBloc.postCompleteProfileCorporateRequest(
                              authToken,
                              _workSelectionController.text,
                              //selectedVehicleId,
                              selectedVehicles,
                              _addressController.text.toString(),
                              _noOfMechanicsController.text.toString(),
                              _rcNumberController.text.toString(),
                              _yearOfExistenceController.text.toString(),
                               imageFirebaseUrl
                          );
                        } else {
                          print("_corporate - formKey.currentState!.validate() - else");
                          setState(() => _autoValidate = AutovalidateMode.always);
                        }

//                        --------------------------
                        /*_completeProfileBloc.postCompleteProfileIndividualRequest(
                          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ODUsImlhdCI6MTY0NzQyODMzNCwiZXhwIjoxNjQ3NTE0NzM0fQ.Yki8raBNQFKL9Karbd0U3tcfu53EtNMq_TQE6ELDdzw",
                          _workSelectionController.text,
                          // _chooseVechicleSpecializedController.text.toString(),
                          selectedVehicleId,
                          _addressController.text.toString(),
                        );*/

                        /*Navigator.pushReplacement(
                          context,
                          new MaterialPageRoute(
                              builder: (context) =>
                                  WaitAdminApprovalScreen(refNumber:'12345678')),);*/

                      },
                      child: Container(
                        height: 45,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.next,
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
                    title: Text(AppLocalizations.of(context)!.text_camera,
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
                          //_photoController.text = fileName;
                        }
                      });
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.image,
                      color: CustColors.blue,
                    ),
                    title: Text(AppLocalizations.of(context)!.text_gallery,
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
                          //_photoController.text = fileName;
                        }
                      });
                    },
                  ),
                ],
              ));
        });
  }

  _showDialogForWorkSelection(List<String> _workSelectionList) async {
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
                itemCount: _workSelectionList.length,
                itemBuilder: (context, index) {
                  return  ListTile(
                    title: Text("${_workSelectionList[index]}",
                        style: TextStyle(
                            fontFamily: 'Corbel_Regular',
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                            color: Colors.black)),
                    onTap: () async {
                      Navigator.pop(context);

                      setState(() {
                        selectedworkSelection=_workSelectionList[index];
                        _workSelectionController.text = workSelectionList[index];
                        /*if (_formKey.currentState!.validate()) {
                        } else {

                        }*/
                      });

                    },
                  );
                },
              ),
            ),);
        });
  }

  _showDialogNumberOfMecanicsSelection(List<String> noOfMechanicsSelectionList) async {
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
                itemCount: noOfMechanicsSelectionList.length,
                itemBuilder: (context, index) {
                  return  ListTile(
                    title: Text("${noOfMechanicsSelectionList[index]}",
                        style: TextStyle(
                            fontFamily: 'Corbel_Regular',
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                            color: Colors.black)),
                    onTap: () async {
                      Navigator.pop(context);

                      setState(() {

                        noOfMechanicsSelection=noOfMechanicsSelectionList[index];
                        _noOfMechanicsController.text = noOfMechanicsSelectionList[index];
                        /*if (_formKey.currentState!.validate()) {
                        } else {
                        }*/
                      });
                    },
                  );
                },
              ),
            ),);
        });
  }

  _openFileExplorerApprenticeCertificate() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf','docx'],
        withData: true
    );

    if (result != null) {
      Uint8List? fileBytes = result.files.first.bytes;
      String fileName = result.files.first.name;

      // Upload PDF file
      TaskSnapshot taskSnapshot = await storage.ref('MechanicApprenticeCertificate/$fileName').putData(fileBytes!);
      String pdfUrl = await taskSnapshot.ref.getDownloadURL();

      setState(() {
        print(fileName.toString());
        _apprenticeCertificateController.text = fileName.toString();
        certificateOfApprenticeFirebaseUrl = pdfUrl;
        /*if (_formKey.currentState!.validate()) {
        } else {
        }*/
      });

      print(">>>>>>>>>>>>>>>> MechanicApprenticeCertificate " + pdfUrl);
    }
    if (!mounted) return;
  }

  _openFileExplorerMeansOfIdentification() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf','docx'],
        withData: true
    );

    if (result != null) {
      Uint8List? fileBytes = result.files.first.bytes;
      String fileName = result.files.first.name;

      // Upload PDF file
      TaskSnapshot taskSnapshot = await storage.ref('MechanicIDProof/$fileName').putData(fileBytes!);
      String pdfUrl = await taskSnapshot.ref.getDownloadURL();

      setState(() {
        print(fileName.toString());
        _identificationProofController.text = fileName.toString();
        meansOfIdentificationFirebaseUrl = pdfUrl;
        /*if (_formKey.currentState!.validate()) {
        } else {
        }*/
      });

      print(">>>>>>>>>>>>>>>> MechanicIDProof " + pdfUrl);
    }
    if (!mounted) return;
  }

  Future uploadImageToFirebase(File images) async {
    String fileName = path.basename(images.path);
    Reference reference = FirebaseStorage.instance.ref().child("MechanicProfileImage").child(fileName);
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

}


class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}