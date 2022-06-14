
import 'dart:io';

import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/Constants/text_strings.dart';
import 'package:auto_fix/UI/Customer/BottomBar/MyProfile/customer_profile_bloc.dart';
import 'package:auto_fix/UI/Customer/BottomBar/MyProfile/customer_profile_mdl.dart';
import 'package:auto_fix/UI/Customer/SideBar/EditProfile/customer_edit_profile_bloc.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signin/login_screen.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signin/signin_bloc.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signup/StateList/state_list.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signup/signup_bloc.dart';
import 'package:auto_fix/Widgets/input_validator.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as path;

class CustomerMyProfileScreen extends StatefulWidget {

  bool isEnableEditing;
  CustomerMyProfileScreen({required this.isEnableEditing});

  @override
  State<StatefulWidget> createState() {
    return _CustomerMyProfileScreenState();
  }
}

class _CustomerMyProfileScreenState extends State<CustomerMyProfileScreen> {


  final CustomerProfileBloc _fetchProfileBloc = CustomerProfileBloc();
  final CustomerEditProfileBloc _changeProfileBloc = CustomerEditProfileBloc();
  final SignupBloc _signupBloc = SignupBloc();
  final SigninBloc _signinBloc = SigninBloc();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _orgNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _orgTypeController = TextEditingController();
  TextEditingController _ministryGovtController = TextEditingController();


  FocusNode _nameFocusNode = FocusNode();
  FocusNode _orgNameNode = FocusNode();
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _phoneFocusNode = FocusNode();
  FocusNode _stateFocusNode = FocusNode();
  FocusNode _orgTypeFocusNode = FocusNode();
  FocusNode _ministryGovtFocusNode = FocusNode();

  List<String> orgTypeList = [
    "Business name",
    "Private Limited Company",
    "Public Limited Company",
    "Incorporated Trustees",
    "Non-Governmental Organization"
  ];

  List<String> ministryGovtList = [
    "Federal Ministry of Aviation",
    "Federal Ministry of Agriculture and natural  resources",
    "Federal Ministry of Finance, budget and planning",
    "Federal Ministry of Works and Housing",
    "Federal Ministry of Defence",
    "Federal Ministry of Niger Delta",
    "Federal Ministry of Petroleum Resources",
    "Federal Ministry of Education",
    "Federal Ministry of Power",
    "Federal Ministry of Envionment",
    "Ministry of Education",
    "Federal Ministry of Transport",
    "Ministry of Agriculture",
    "Ministry of Transport",
    "Ministry of Home Affairs",
    "Ministry of Finance",
    "Ministry of Housing",
    "Ministry of Works and Infrastructure",
    "Lagos state sport commission",
    "Federal Airports Authority of Nigeria",
    "Nigeria Civil Aviation Authority",
    "Nigerian Broadcasting Commission",
    "Nigerian Television Authority",
    "Nigerian Information Technology Development Agency",
    "Central Bank of Nigeria",
    "Corporate Affairs Commission",
    "Nigeria Police Force",
    "Federal Inland Revenue Service",
    "Federal Mortgage Bank of Nigeria",
    "Nigeria Delta Development Commission",
    "Joint Admission and Matriculation Board",
    "Department of Petroleum Resources",
    "Nigerian Electricity Regulatory Commission",
    "Nigerian Health Insurance Scheme",
    "Nigerian Football Association",
    "Nigerian Basketball Federation"
  ];


  bool isloading = false;
  bool saveloading = false;

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
  String _userName = "", _imageUrl = "", _userType = "", _orgName = "";
  final picker = ImagePicker();
  File? _images;

  @override
  void initState() {
    super.initState();
    editProfileEnabled = widget.isEnableEditing;
    getSharedPrefData();
    _listenFetchProfileResponse();
    _listenUpdateProfileResponse();
  }

  Future<void> getSharedPrefData() async {
    print('getSharedPrefData CustomerMyProfileScreen');
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    setState(() {
      authToken = shdPre.getString(SharedPrefKeys.token).toString();
      print('userFamilyId CustomerMyProfileScreen'+authToken.toString());
    });
    String id = shdPre.getString(SharedPrefKeys.userID,).toString();
    _fetchProfileBloc.postCustomerProfileRequest(authToken,id);
  }


  _listenFetchProfileResponse() {
    _fetchProfileBloc.postCustomerProfile.listen((value) {
        if (value.status == "error") {
          setState(() {
           // _isLoading = false;
            /*ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(value.message.toString(),
                  style: const TextStyle(
                      fontFamily: 'Roboto_Regular', fontSize: 14)),
              duration: const Duration(seconds: 2),
              backgroundColor: CustColors.light_navy,
            ));*/
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
  _listenUpdateProfileResponse(){
    _changeProfileBloc.postCustomerIndividualEditProfile.listen((value) {
      print("dbjbjbdjdbkj 001");
      if(value.status== "error"){
        setState(() {
          // _isLoading = false;
          saveloading=false;
          editProfileEnabled = true;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(value.message.toString(),
                style: const TextStyle(
                    fontFamily: 'Roboto_Regular', fontSize: 14)),
            duration: const Duration(seconds: 2),
            backgroundColor: CustColors.light_navy,
          ));
        });
      }
      else{
        setState(() {
          editProfileEnabled = false;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Successfully Updated",
                style: const TextStyle(
                    fontFamily: 'Roboto_Regular', fontSize: 14)),
            duration: const Duration(seconds: 2),
            backgroundColor: CustColors.light_navy,
          ));
          saveloading = false;
          getSharedPrefData();
        });
      }
    });
    _changeProfileBloc.postCustomerCorporateEditProfile.listen((value) {
      print("dbjbjbdjdbkj 002");
      if(value.status== "error"){
        setState(() {
          // _isLoading = false;
          saveloading=false;
          editProfileEnabled = true;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(value.message.toString(),
                style: const TextStyle(
                    fontFamily: 'Roboto_Regular', fontSize: 14)),
            duration: const Duration(seconds: 2),
            backgroundColor: CustColors.light_navy,
          ));
        });
      }
      else{
        setState(() {
          editProfileEnabled = false;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Successfully Updated",
                style: const TextStyle(
                    fontFamily: 'Roboto_Regular', fontSize: 14)),
            duration: const Duration(seconds: 2),
            backgroundColor: CustColors.light_navy,
          ));
          saveloading = false;
          getSharedPrefData();
        });
      }
    });
    _changeProfileBloc.postCustomerGovernmentEditProfile.listen((value) {
      print("dbjbjbdjdbkj 003");
      if(value.status== "error"){
        setState(() {
          // _isLoading = false;
          saveloading = false;
          editProfileEnabled = true;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(value.message.toString(),
                style: const TextStyle(
                    fontFamily: 'Roboto_Regular', fontSize: 14)),
            duration: const Duration(seconds: 2),
            backgroundColor: CustColors.light_navy,
          ));
        });
      }
      else{
        setState(() {
          editProfileEnabled = false;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Successfully Updated",
                style: const TextStyle(
                    fontFamily: 'Roboto_Regular', fontSize: 14)),
            duration: const Duration(seconds: 2),
            backgroundColor: CustColors.light_navy,
          ));
          saveloading = false;
          getSharedPrefData();
        });
      }
    });
  }

  void setProfileData(CustomerProfileMdl value){
    _nameController.text = value.data!.customerDetails!.firstName.toString() ;
    _emailController.text = value.data!.customerDetails!.emailId.toString();
    _phoneController.text = value.data!.customerDetails!.phoneNo.toString();
    _stateController.text = value.data!.customerDetails!.customer![0].state.toString();
    _orgTypeController.text = value.data!.customerDetails!.customer![0].orgType.toString();
    _ministryGovtController.text = value.data!.customerDetails!.customer![0].ministryName.toString();

    _userName = value.data!.customerDetails!.firstName.toString();
    _imageUrl = value.data!.customerDetails!.customer![0].profilePic.toString();
    _userType = value.data!.customerDetails!.customer![0].custType.toString();
    _orgNameController.text = value.data!.customerDetails!.customer![0].orgName.toString();

    _signinBloc.userDefaultData(
        authToken,
        TextStrings.user_customer,
       _imageUrl,       //----- profile image url should b updated
        value.data!.customerDetails!.firstName.toString(),
        value.data!.customerDetails!.id.toString(),

    );

    print(">>>>>>>>>>>>> _userType : CustomerMyProfileScreen" + _userType);
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
    return  Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //appBarCustomUi(size),
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
                                OrgNameTextUi(size),
                                OrganisationTypeTextUi(size),     // --------------------- Industry
                                NameTextUi(size),
                                EmailTextUi(size),
                                PhoneTextUi(size),
                                StateTextUi(size),
                                editProfileEnabled == true ? corporateSaveChangeButton(size) : Container(),
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
                              editProfileEnabled == true ? governmentSaveChangeButton(size) : Container(),
                            ],
                          ),
                  ),
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
        top: size.height * 3.3 / 100
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
                _userType == "1" ? '$_userName' : _orgName,
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
                        padding: const EdgeInsets.fromLTRB(0,80,155,0),
                        child:
                        Image.asset(
                          'assets/image/mechanicProfileView/curvedGray.png',
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          height: size.height * 5 / 100,
                          width: size.width * 28 / 100,
                          margin: EdgeInsets.only(
                            left: size.width * 18 / 100,
                            top: size.height * 11 / 100
                          ),
                          child: InkWell(
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
                            child: Row(
                              children: [
                                Icon(
                                  Icons.edit,
                                  size: 15,
                                  color: CustColors.light_navy,
                                ),
                                Text(' Edit Profile',
                                  style: Styles.appBarTextBlack17,),
                              ],
                            ),
                          ),
                        ),
                      ),
                      //),
                    ],
                  ),

                  Align(
                    alignment: Alignment.center,
                    child: Stack(
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15.0),
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
                                            child: _imageUrl != null&&_imageUrl!=""
                                                ?
                                            Image.network(_imageUrl,
                                              width: 150,
                                              height: 150,
                                              fit: BoxFit.cover,)
                                                :
                                            SvgPicture.asset('assets/image/MechanicType/work_selection_avathar.svg',
                                              width: 150,
                                              height: 150,
                                              fit: BoxFit.cover,)
                                          )))

                              ),
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
                        padding: const EdgeInsets.fromLTRB(155,80,0,0),
                        child: Image.asset(
                          'assets/image/mechanicProfileView/curvedWhite.png',
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          height: size.height * 5 / 100,
                          width: size.width * 20 / 100,
                          margin: EdgeInsets.only(
                              right: size.width * 15 / 100,
                              top: size.height * 11 / 100
                          ),
                          child: InkWell(
                            onTap: (){
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context)
                                  {
                                    return deactivateDialog();
                                  });
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.logout,
                                  size: 15,
                                  color: CustColors.light_navy,
                                ),
                                Text(' Logout',
                                  style: Styles.appBarTextBlack17,),
                              ],
                            ),
                          ),
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
                  padding: const EdgeInsets.all(13),
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
                              ch : _userType == "1" ? "Name" : "Contact Person").nameChecking,
                          controller: _nameController,
                          cursorColor: CustColors.light_navy,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText:  _userType == "1" ? "Name" : "Contact Person",
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
                       _userType == "1" ? 'Your name' : 'Contact person',
                        textAlign: TextAlign.center,
                        style: Styles.textLabelSubTitle,
                      )
                          :
                      Container(),
                    ],
                  ),
                ),
              ),
              //Spacer(),
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
                  padding: const EdgeInsets.fromLTRB(10,0,00,0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: TextFormField(

                          //enabled: editProfileEnabled,
                          enabled: false,
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
                          validator: InputValidator(ch: "Email").emailValidator,
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
              //Spacer(),
              // editProfileEnabled == true
              //     ? Container(
              //       // child: Padding(
              //       //   padding: const EdgeInsets.all(15),
              //       //   child: Icon(Icons.edit,size: 15, color: CustColors.blue),
              //       // )
              // )
              //     : Container(),
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
                         // enabled: editProfileEnabled,
                          enabled: false,
                          readOnly: !editProfileEnabled,
                          textAlignVertical: TextAlignVertical.center,
                          maxLines: 1,
                          style: Styles.appBarTextBlack15,
                          focusNode: _phoneFocusNode,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(15),
                          ],
                          validator: InputValidator(ch: 'Phone Number',).phoneNumChecking,
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
                  // child: Padding(
                  //   padding: const EdgeInsets.all(15),
                  //   child: Icon(Icons.edit,size: 15, color: CustColors.blue),
                  // )
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
                            validator: InputValidator(ch: 'State/FCT').emptyChecking,
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
                print("on tap Ministry/Govt. agency ");
                showMinistryGovtSelector();
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
                    child: SvgPicture.asset('assets/image/ic_ministry.svg',
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
                            maxLines: null,
                            style: Styles.appBarTextBlack15,
                            focusNode: _ministryGovtFocusNode,
                            validator: InputValidator(ch: 'Ministry/Govt. Agency').emptyChecking,
                            controller: _ministryGovtController,
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

  Widget OrgNameTextUi(Size size) {
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
                  padding: const EdgeInsets.all(13),
                  child: SvgPicture.asset('assets/image/ic_org_name.svg',
                    height: size.height * 2.5 / 100,
                    width: size.width * 2.5 / 100,
                  ),
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
                          focusNode: _orgNameNode,
                          keyboardType: TextInputType.name,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp('[a-zA-Z ]')),
                          ],
                          validator: InputValidator(
                              ch :'Name of Organization').nameChecking,
                          controller: _orgNameController,
                          cursorColor: CustColors.light_navy,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: 'Organisation Name',
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
                        'Organisation name',
                        textAlign: TextAlign.center,
                        style: Styles.textLabelSubTitle,
                      )
                          :
                      Container(),
                    ],
                  ),
                ),
              ),
              //Spacer(),
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
                    child: SvgPicture.asset('assets/image/ic_org_type.svg',
                      height: size.height * 2.5 / 100,
                      width: size.width * 2.5 / 100,
                    ),
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
                                ch :'Select your organization from list').emptyChecking,
                            controller: _orgTypeController,
                            cursorColor: CustColors.light_navy,
                            decoration: InputDecoration(
                              isDense: true,
                              hintText:  'Organization Type',
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
                //Spacer(),
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
    return saveloading ? CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(
          CustColors.light_navy),
    ):
    InkWell(
      onTap: (){

        if (_formKey.currentState!.validate()) {
          //_isLoading = true;
          saveloading = true;
          //editProfileEnabled = false;
          _changeProfileBloc.postCustomerIndividualEditProfileRequest(
              authToken,
              _nameController.text.toString(),"",
              _stateController.text.toString(),1,
              //selectedState, 1,
              _imageUrl);
          setState(() {

          });
        } else {
          print("individual _formKey.currentState!.validate() - else");
          setState(() => _autoValidate = AutovalidateMode.always);
        }

      },
      child:
      Container(
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
    return saveloading ? CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(
          CustColors.light_navy),
    ):
    InkWell(
      onTap: (){

        if (_formKey.currentState!.validate()) {
          //_isLoading = true;
          saveloading = true;
         // editProfileEnabled = false;
          _changeProfileBloc.postCustomerCorporateEditProfileRequest(
              authToken,
              _nameController.text.toString(), "",
              _stateController.text.toString(), 1,
              _imageUrl,
              _orgNameController.text.toString(),       // org name
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
    return saveloading ? CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(
        CustColors.light_navy),):
    InkWell(
      onTap: (){

        if (_formKey.currentState!.validate()) {
          //_isLoading = true;
          saveloading = true;
          //editProfileEnabled = false;
          _changeProfileBloc.postCustomerGovernmentEditProfileRequest(
              authToken,
              _nameController.text.toString(), "",
              _stateController.text.toString(), 1,
              _imageUrl, _ministryGovtController.text.toString()    //ministryName
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

  void showMinistryGovtSelector() {
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
                                /*Container(
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
                                                  _countryData.clear();
                                                  isloading = true;
                                                });
                                                _signupBloc.searchStates(text);
                                              },
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: 'Corbel_Regular',
                                                  fontWeight: FontWeight.w600,
                                                  color: CustColors.blue),
                                              decoration: InputDecoration(
                                                hintText: "Search Your  State",
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
                                ),*/
                                Container(
                                  height: 421 ,
                                  padding: EdgeInsets.only(top: _setValue(22.4)),
                                  child: ministryGovtList.length != 0
                                      ? ListView.separated(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount: ministryGovtList.length,
                                      itemBuilder: (context, index) {
                                      return InkWell(
                                          onTap: () {
                                            final dial_Code =
                                            ministryGovtList[index];

                                            setState(() {
                                              _ministryGovtController.text =
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
                                              '${ministryGovtList[index]}',
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

  Widget deactivateDialog() {
    return CupertinoAlertDialog(
      title: Text("Logout account?",
          style: TextStyle(
            fontFamily: 'Formular',
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: CustColors.materialBlue,
          )),
      content: Text("Are you sure you want to logout?"),
      actions: <Widget>[
        CupertinoDialogAction(
            textStyle: TextStyle(
              color: CustColors.rusty_red,
              fontWeight: FontWeight.normal,
            ),
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);


            },
            child: Text("Cancel")),
        CupertinoDialogAction(
            textStyle: TextStyle(
              color: CustColors.rusty_red,
              fontWeight: FontWeight.normal,
            ),
            isDefaultAction: true,
            onPressed: () async {

              setState(() {
                setDeactivate();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LoginScreen()),
                    ModalRoute.withName("/LoginScreen"));

              });
            },
            child: Text("Logout")),
      ],
    );
  }

  void setDeactivate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(SharedPrefKeys.token, "");
    prefs.setString(SharedPrefKeys.userID, "");
    prefs.setString(SharedPrefKeys.userName, "");
    prefs.setBool(SharedPrefKeys.isUserLoggedIn, false);
    prefs.setString(SharedPrefKeys.userType, "");


  }

}
