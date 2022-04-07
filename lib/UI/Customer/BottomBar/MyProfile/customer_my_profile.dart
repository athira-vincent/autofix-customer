
import 'dart:io';

import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/UI/Customer/BottomBar/MyProfile/customer_profile_bloc.dart';
import 'package:auto_fix/UI/Customer/BottomBar/MyProfile/customer_profile_mdl.dart';
import 'package:auto_fix/UI/Customer/SideBar/EditProfile/customer_edit_profile_bloc.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signup/StateList/state_list.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signup/signup_bloc.dart';
import 'package:auto_fix/Widgets/input_validator.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:path/path.dart' as path;

class CustomerMyProfileScreen extends StatefulWidget {

  CustomerMyProfileScreen();

  @override
  State<StatefulWidget> createState() {
    return _CustomerMyProfileScreenState();
  }
}

class _CustomerMyProfileScreenState extends State<CustomerMyProfileScreen> {


  final CustomerProfileBloc _fetchProfileBloc = CustomerProfileBloc();
  final CustomerEditProfileBloc _changeProfileBloc = CustomerEditProfileBloc();
  final SignupBloc _signupBloc = SignupBloc();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _orgTypeController = TextEditingController();


  FocusNode _nameFocusNode = FocusNode();
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _phoneFocusNode = FocusNode();
  FocusNode _stateFocusNode = FocusNode();
  FocusNode _orgTypeFocusNode = FocusNode();

  List<String> orgTypeList = [
    "Business name",
    "Private Limited Company",
    "Public Limited Company",
    "Incorporated Trustees",
    "Non-Governmental Organization"
  ];

  bool isloading = false;

  double per = .10;
  double perfont = .10;

  double _setValue(double value) {
    return value * per + value;
  }

  double _setValueFont(double value) {
    return value * perfont + value;
  }

  bool editProfileEnabled = false;
  String selectedState = "";
  String authToken="";
  String _userName = "", _imageUrl = "", _userType = "2";
  final picker = ImagePicker();
  File? _images;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPrefData();
    _listenFetchProfileResponse();
  }

  Future<void> getSharedPrefData() async {
    print('getSharedPrefData');
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    setState(() {
      authToken = shdPre.getString(SharedPrefKeys.token).toString();
      print('userFamilyId'+authToken.toString());
    });

    _fetchProfileBloc.postCustomerProfileRequest(authToken);
  }


  _listenFetchProfileResponse() {
    _fetchProfileBloc.postCustomerProfile.listen((value) {
        if (value.status == "error") {
          setState(() {
           // _isLoading = false;
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
            //_isLoading = false;
            /*ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Password Reset Enabled.\nCheck Your mail",
                  style: TextStyle(fontFamily: 'Roboto_Regular', fontSize: 14)),
              duration: Duration(seconds: 2),
              backgroundColor: CustColors.peaGreen,
            ));*/
            setProfileData(value);
          });
        }
      });
  }

  void setProfileData(CustomerProfileMdl value){
    _nameController.text = value.data!.customerDetails!.firstName.toString() ;
    _emailController.text = value.data!.customerDetails!.emailId.toString();
    _phoneController.text = value.data!.customerDetails!.phoneNo.toString();
    _stateController.text = value.data!.customerDetails!.customer![0].state.toString();
    _userName = value.data!.customerDetails!.firstName.toString();
    _imageUrl = value.data!.customerDetails!.customer![0].profilePic.toString();
    _orgTypeController.text = value.data!.customerDetails!.customer![0].orgType.toString();
   // _userType = value.data!.customerDetails!.customer![0].custType.toString();
    print(">>>>>>>>>>>>> _userType : " + _userType);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _fetchProfileBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                appBarCustomUi(size),
                profileImageAndKmAndReviewCount(size),
                Form(
                    autovalidateMode: _autoValidate,
                    key: _formKey,
                    child:
                      _userType == "1"
                          ?
                          Column(
                            children: [
                              NameTextUi(size),
                              EmailTextUi(size),
                              PhoneTextUi(size),
                              StateTextUi(size),
                              editProfileEnabled == true ? individualSaveChangeButton(size) : Container(),
                            ],
                          )
                          :
                        _userType == "2"
                            ?
                          Column(
                            children: [
                              NameTextUi(size),
                              OrganisationTypeTextUi(size),     // --------------------- Industry
                              EmailTextUi(size),
                              PhoneTextUi(size),
                              StateTextUi(size),
                              corporateSaveChangeButton(size),
                            ],
                          )
                            :
                        Column(
                          children: [
                            StateTextUi(size),
                            ministryTextUi(size),
                            NameTextUi(size),
                            EmailTextUi(size),
                            PhoneTextUi(size),

                            governmentSaveChangeButton(size),
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

  Widget appBarCustomUi(Size size) {
    return Container(
      margin: EdgeInsets.only(
        left: size.width * 10 / 100,
        //top: size.height * 3.3 / 100
      ),
      child: Stack(
        children: [
          Row(
            children: [
              /*IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),*/
              Text(
                '$_userName',
                textAlign: TextAlign.center,
                style: Styles.appBarTextBlack,
              ),
              Spacer(),

            ],
          ),
        ],
      ),
    );
  }

  Widget profileImageAndKmAndReviewCount(Size size) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10,5,10,10),
      child: Container(
       // color: Colors.red,
        alignment: Alignment.center,
        child: Wrap(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10,5,10,10),
              child: Stack(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0,65,155,0),
                        child:
                        Image.asset(
                          'assets/image/mechanicProfileView/curvedGray.png',
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          setState(() {
                            print('editProfileEnabled $editProfileEnabled');
                            if(editProfileEnabled)
                            {
                              editProfileEnabled=false;
                            }
                            else
                            {
                              editProfileEnabled=true;
                            }
                            print('editProfileEnabled $editProfileEnabled');
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                            left: size.width * 18 / 100,
                            top: size.height * 10 / 100
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.edit,
                                size: 15,
                                color: CustColors.blue,
                              ),
                              Text('Edit Profile',
                                style: Styles.appBarTextBlack17,),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  Align(
                    alignment: Alignment.center,
                    child: Stack(
                      children: [
                        Center(
                          child: Container(
                            width: 125.0,
                            height: 125.0,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child:Container(
                                    child:CircleAvatar(
                                        radius: 50,
                                        backgroundColor: Colors.white,
                                        child: ClipOval(
                                          child: _imageUrl == null
                                              ?
                                          SvgPicture.asset('assets/image/MechanicType/work_selection_avathar.svg')
                                              :
                                          Image.network(_imageUrl,
                                            width: 150,
                                            height: 150,
                                            fit: BoxFit.cover,),
                                        )))

                            ),
                          ),
                        ),
                        editProfileEnabled == true
                            ?
                        InkWell(
                          onTap: (){
                            _showDialogSelectPhoto();
                            print("on tap photo ");
                          },
                          child: Center(
                            child: Container(
                              child: Image.asset(
                                "assets/image/ic_camera_black.png",
                                //height: size.height * 7 / 100,
                                width: size.width * 7 / 100,
                              ),
                            ),
                          ),
                        )
                            :
                        Container(),
                      ],
                    ),
                  ),

                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(155,65,0,0),
                        child: Image.asset(
                          'assets/image/mechanicProfileView/curvedWhite.png',
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: size.width * 55 / 100,
                            top: size.height * 10 / 100
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.logout,
                              size: 15,
                              color: CustColors.blue,
                            ),
                            Text('Logout',
                              style: Styles.appBarTextBlack17,),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget NameTextUi(Size size) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20,5,20,5),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: CustColors.whiteBlueish,
                    borderRadius: BorderRadius.circular(11.0)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Icon(Icons.person, color: CustColors.blue),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10,0,10,0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: TextFormField(
                          enabled: editProfileEnabled,
                          readOnly: !editProfileEnabled,
                          textAlignVertical: TextAlignVertical.center,
                          maxLines: 1,
                          style: Styles.appBarTextBlack15,
                          focusNode: _nameFocusNode,
                          keyboardType: TextInputType.name,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp('[a-zA-Z ]')),
                          ],
                          validator: InputValidator(
                              ch :AppLocalizations.of(context)!.text_organization_name).nameChecking,
                          controller: _nameController,
                          cursorColor: CustColors.light_navy,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText:  'Name',
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 2.8,
                              horizontal: 0.0,
                            ),
                            hintStyle: Styles.appBarTextBlack15,),
                        ),
                      ),
                      editProfileEnabled != true
                          ?
                      Text(
                        'Your name',
                        textAlign: TextAlign.center,
                        style: Styles.textLabelSubTitle,
                      )
                          :
                      Container(),
                    ],
                  ),
                ),
              ),
              Spacer(),
              editProfileEnabled == true
                  ? Container(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Icon(Icons.edit,size: 15, color: CustColors.blue),
                  )
              )
                  : Container(),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0,5,0,5),
            child: Divider(),
          )
        ],
      ),
    );
  }

  Widget EmailTextUi(Size size) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20,5,20,5),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: CustColors.whiteBlueish,
                    borderRadius: BorderRadius.circular(11.0)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: SvgPicture.asset('assets/image/ic_email.svg',
                    height: size.height * 2 / 100,
                    width: size.width * 2 / 100,
                  ),
                  //child: Icon(Icons.mail, color: CustColors.blue),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10,0,10,0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: TextFormField(
                          enabled: editProfileEnabled,
                          readOnly: !editProfileEnabled,
                          textAlignVertical: TextAlignVertical.center,
                          maxLines: 1,
                          style: Styles.appBarTextBlack15,
                          focusNode: _emailFocusNode,
                          keyboardType: TextInputType.emailAddress,
                          /*inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp('[a-zA-Z ]')),
                          ],*/
                          validator: InputValidator(ch: AppLocalizations.of(context)!.text_email).emailValidator,
                          controller: _emailController,
                          cursorColor: CustColors.light_navy,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText:  'Email',
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 2.8,
                              horizontal: 0.0,
                            ),
                            hintStyle: Styles.appBarTextBlack15,),
                        ),
                      ),
                      editProfileEnabled != true
                          ?
                      Text(
                        'Your email id',
                        textAlign: TextAlign.center,
                        style: Styles.textLabelSubTitle,
                      )
                          :
                      Container(),
                    ],
                  ),
                ),
              ),
              Spacer(),
              editProfileEnabled == true
                  ? Container(
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Icon(Icons.edit,size: 15, color: CustColors.blue),
                    )
              )
                  : Container(),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0,5,0,5),
            child: Divider(),
          )
        ],
      ),
    );
  }

  Widget PhoneTextUi(Size size) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20,5,20,5),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: CustColors.whiteBlueish,
                    borderRadius: BorderRadius.circular(11.0)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: SvgPicture.asset('assets/image/ic_phone.svg',
                    height: size.height * 2 / 100,
                    width: size.width * 2 / 100,
                  ),
                  //child: Icon(Icons.mail, color: CustColors.blue),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10,0,10,0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: TextFormField(
                          enabled: editProfileEnabled,
                          readOnly: !editProfileEnabled,
                          textAlignVertical: TextAlignVertical.center,
                          maxLines: 1,
                          style: Styles.appBarTextBlack15,
                          focusNode: _phoneFocusNode,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(15),
                          ],
                          validator: InputValidator(ch: AppLocalizations.of(context)!.text_phone,).phoneNumChecking,
                          controller: _phoneController,
                          cursorColor: CustColors.light_navy,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText:  'Phone',
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 2.8,
                              horizontal: 0.0,
                            ),
                            hintStyle: Styles.appBarTextBlack15,),
                        ),
                      ),
                      editProfileEnabled != true
                          ?
                      Text(
                        'Your phone number',
                        textAlign: TextAlign.center,
                        style: Styles.textLabelSubTitle,
                      )
                          :
                      Container(),
                    ],
                  ),
                ),
              ),
              Spacer(),
              editProfileEnabled == true
                  ? Container(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Icon(Icons.edit,size: 15, color: CustColors.blue),
                  )
              )
                  : Container(),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0,5,0,5),
            child: Divider(),
          )
        ],
      ),
    );
  }

  Widget StateTextUi(Size size) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20,5,20,5),
      child: Column(
        children: [
          InkWell(
            onTap: (){
              if(editProfileEnabled == true){
                _awaitReturnValueFromSecondScreen(context);
              }
            },
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: CustColors.whiteBlueish,
                      borderRadius: BorderRadius.circular(11.0)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: SvgPicture.asset('assets/image/ic_location.svg',
                      height: size.height * 2.5 / 100,
                      width: size.width * 2.5 / 100,
                    ),
                    //child: Icon(Icons.mail, color: CustColors.blue),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10,0,10,0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          child: TextFormField(
                            readOnly: true,
                            enabled: false,
                            textAlignVertical: TextAlignVertical.center,
                            maxLines: 1,
                            style: Styles.appBarTextBlack15,
                            focusNode: _stateFocusNode,
                            validator: InputValidator(ch: AppLocalizations.of(context)!.text_state).emptyChecking,
                            controller: _stateController,
                            cursorColor: CustColors.light_navy,
                            decoration: InputDecoration(
                              isDense: true,
                              hintText:  'State',
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 2.8,
                                horizontal: 0.0,
                              ),
                              hintStyle: Styles.appBarTextBlack15,),
                          ),
                        ),
                        editProfileEnabled != true
                        ?
                        Text(
                          'Your state',
                          textAlign: TextAlign.center,
                          style: Styles.textLabelSubTitle,
                        )
                        :
                        Container(),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                editProfileEnabled == true
                    ? Container(
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Icon(Icons.edit,size: 15, color: CustColors.blue),
                      )
                )
                    : Container(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0,5,0,5),
            child: Divider(),
          )
        ],
      ),
    );
  }

  Widget ministryTextUi(Size size) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20,5,20,5),
      child: Column(
        children: [
          InkWell(
            onTap: (){
              if(editProfileEnabled == true){
                _awaitReturnValueFromSecondScreen(context);
              }
            },
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: CustColors.whiteBlueish,
                      borderRadius: BorderRadius.circular(11.0)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: SvgPicture.asset('assets/image/ic_location.svg',
                      height: size.height * 2.5 / 100,
                      width: size.width * 2.5 / 100,
                    ),
                    //child: Icon(Icons.mail, color: CustColors.blue),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10,0,10,0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          child: TextFormField(
                            readOnly: true,
                            enabled: false,
                            textAlignVertical: TextAlignVertical.center,
                            maxLines: 1,
                            style: Styles.appBarTextBlack15,
                            focusNode: _stateFocusNode,
                            validator: InputValidator(ch: AppLocalizations.of(context)!.text_state).emptyChecking,
                            controller: _stateController,
                            cursorColor: CustColors.light_navy,
                            decoration: InputDecoration(
                              isDense: true,
                              hintText:  'Ministry',
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 2.8,
                                horizontal: 0.0,
                              ),
                              hintStyle: Styles.appBarTextBlack15,),
                          ),
                        ),
                        editProfileEnabled != true
                            ?
                        Text(
                          'Your ministry/govt agency ',
                          textAlign: TextAlign.center,
                          style: Styles.textLabelSubTitle,
                        )
                            :
                        Container(),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                editProfileEnabled == true
                    ? Container(
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Icon(Icons.edit,size: 15, color: CustColors.blue),
                    )
                )
                    : Container(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0,5,0,5),
            child: Divider(),
          )
        ],
      ),
    );
  }

  Widget OrganisationTypeTextUi(Size size) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20,5,20,5),
      child: Column(
        children: [
          InkWell(
            onTap: (){
              if(editProfileEnabled == true){
                showOrganisationTypeSelector();
                print("Type of Organisation");
              }
            },
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: CustColors.whiteBlueish,
                      borderRadius: BorderRadius.circular(11.0)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Icon(Icons.person, color: CustColors.blue),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10,0,10,0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          child: TextFormField(
                            readOnly: true,
                            enabled: false,
                            textAlignVertical: TextAlignVertical.center,
                            maxLines: 1,
                            style: Styles.appBarTextBlack15,
                            focusNode: _orgTypeFocusNode,
                            keyboardType: TextInputType.name,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp('[a-zA-Z ]')),
                            ],
                            validator: InputValidator(
                                ch :AppLocalizations.of(context)!.text_hint_organization_type).emptyChecking,
                            controller: _orgTypeController,
                            cursorColor: CustColors.light_navy,
                            decoration: InputDecoration(
                              isDense: true,
                              hintText:  'Industry',
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 2.8,
                                horizontal: 0.0,
                              ),
                              hintStyle: Styles.appBarTextBlack15,),
                          ),
                        ),
                        editProfileEnabled != true
                            ?
                        Text(
                          'Type of organisation ',
                          textAlign: TextAlign.center,
                          style: Styles.textLabelSubTitle,
                        )
                            :
                        Container(),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                editProfileEnabled == true
                    ? Container(
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Icon(Icons.edit,size: 15, color: CustColors.blue),
                    )
                )
                    : Container(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0,5,0,5),
            child: Divider(),
          )
        ],
      ),
    );
  }

  Widget individualSaveChangeButton (Size size){
    return InkWell(
      onTap: (){

        if (_formKey.currentState!.validate()) {
          //_isLoading = true;

          _changeProfileBloc.postCustomerIndividualEditProfileRequest(
              authToken,
              _nameController.text.toString(),"",
              selectedState, 1,
              _imageUrl);

        } else {
          print("individual _formKey.currentState!.validate() - else");
          setState(() => _autoValidate = AutovalidateMode.always);
        }

      },
      child: Container(
        width: size.width,
        height: size.height * 7 / 100,
        color: CustColors.light_navy,
        margin: EdgeInsets.only(
          bottom: size.height * 2 / 100
        ),
        //padding: ,
        child: Center(
          child: Text(
            "Save changes",
            style: Styles.addToCartText02,
          ),
        ),
      ),
    );
  }

  Widget corporateSaveChangeButton (Size size){
    return InkWell(
      onTap: (){

        if (_formKey.currentState!.validate()) {
          //_isLoading = true;

          _changeProfileBloc.postCustomerCorporateEditProfileRequest(
              authToken,
              _nameController.text.toString(), "",
              selectedState, 1,
              _imageUrl,
            "",       // org name
            _orgTypeController.text.toString()
          );

        } else {
          print("individual _formKey.currentState!.validate() - else");
          setState(() => _autoValidate = AutovalidateMode.always);
        }

      },
      child: Container(
        width: size.width,
        height: size.height * 7 / 100,
        color: CustColors.light_navy,
        margin: EdgeInsets.only(
            bottom: size.height * 2 / 100
        ),
        //padding: ,
        child: Center(
          child: Text(
            "Save changes",
            style: Styles.addToCartText02,
          ),
        ),
      ),
    );
  }

  Widget governmentSaveChangeButton (Size size){
    return InkWell(
      onTap: (){

        if (_formKey.currentState!.validate()) {
          //_isLoading = true;

          _changeProfileBloc.postCustomerGovernmentEditProfileRequest(
              authToken,
              _nameController.text.toString(), "",
              selectedState, 1,
              _imageUrl, " "    //ministryName
          );

        } else {
          print("individual _formKey.currentState!.validate() - else");
          setState(() => _autoValidate = AutovalidateMode.always);
        }

      },
      child: Container(
        width: size.width,
        height: size.height * 7 / 100,
        color: CustColors.light_navy,
        margin: EdgeInsets.only(
            bottom: size.height * 2 / 100
        ),
        //padding: ,
        child: Center(
          child: Text(
            "Save changes",
            style: Styles.addToCartText02,
          ),
        ),
      ),
    );
  }

  void _awaitReturnValueFromSecondScreen(BuildContext context) async {

    // start the SecondScreen and wait for it to finish with a result
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SelectStateScreen(),
        ));
    setState(() {
      selectedState = result;
      _stateController.text = selectedState;
      print ("Selected state @ sign up: " + selectedState );
    });
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
                          //_photoController.text = fileName;
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
          _imageUrl = fileImageurl;
        });

      }catch(onError){
        print("Error");
      }
      print(">>>>>>>>>>>>>>>> imageFirebaseUrl "+_imageUrl.toString());
    });
  }

  void showOrganisationTypeSelector() {
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
                                  height: 421 - 108,
                                  padding:
                                  EdgeInsets.only(top: _setValue(22.4)),
                                  child: orgTypeList.length != 0
                                      ? ListView.separated(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: orgTypeList.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                          onTap: () {
                                            final dial_Code =
                                            orgTypeList[index];

                                            setState(() {
                                              _orgTypeController.text =
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
                                              '${orgTypeList[index]}',
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
  }

}
