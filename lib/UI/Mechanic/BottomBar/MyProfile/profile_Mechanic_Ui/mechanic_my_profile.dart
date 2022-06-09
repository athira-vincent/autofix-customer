import 'dart:io';

import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/Constants/text_strings.dart';
import 'package:auto_fix/UI/Mechanic/BottomBar/MyProfile/profile_Mechanic_Bloc/mechanic_profile_bloc.dart';
import 'package:auto_fix/UI/Mechanic/BottomBar/MyProfile/profile_Mechanic_Models/mechanic_profile_mdl.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signin/login_screen.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signin/signin_bloc.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signup/StateList/state_list.dart';
import 'package:auto_fix/Widgets/CurvePainter.dart';
import 'package:auto_fix/Widgets/input_validator.dart';
import 'package:auto_fix/Widgets/screen_size.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:path/path.dart' as path;

class MechanicMyProfileScreen extends StatefulWidget {

  MechanicMyProfileScreen();

  @override
  State<StatefulWidget> createState() {
    return _MechanicMyProfileScreenState();
  }
}

class _MechanicMyProfileScreenState extends State<MechanicMyProfileScreen> {

  MechanicProfileBloc _mechanicProfileBloc = MechanicProfileBloc();

  double per = .10;
  double perfont = .10;
  bool _isLoadingPage = true;
  bool _isLoading = false;
  String _userName = "", _imageUrl = "", _userType = "",_orgName ="",profilepic="";
  final picker = ImagePicker();
  File? _images;

  double _setValue(double value) {
    return value * per + value;
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;

  TextEditingController _nameController = TextEditingController();
  FocusNode _nameFocusNode = FocusNode();

  TextEditingController _emailController = TextEditingController();
  FocusNode _emailFocusNode = FocusNode();


  TextEditingController _stateController = TextEditingController();
  FocusNode _stateFocusNode = FocusNode();
  String selectedState = "";

  TextEditingController _workSelectionController = TextEditingController();
  FocusNode _workSelectionFocusNode = FocusNode();
  List<String> workSelectionList = ['Regular Services','Emergency Services','Both'];
  String? selectedworkSelection = '' ;

  TextEditingController _addressController = TextEditingController();
  FocusNode _addressFocusNode = FocusNode();

  TextEditingController _yearOfExistenceController = TextEditingController();
  FocusNode _yearOfExistenceFocusNode = FocusNode();


  TextEditingController _photoController = TextEditingController();
  FocusNode _photoFocusNode = FocusNode();

  TextEditingController _phoneController = TextEditingController();
  FocusNode _phoneFocusNode = FocusNode();

  TextEditingController _orgTypeController = TextEditingController();
  FocusNode _orgTypeFocusNode = FocusNode();
  bool isloading = false;
  List<String> orgTypeList = [
    "Business name",
    "Private Limited Company",
    "Public Limited Company",
    "Incorporated Trustees",
    "Non-Governmental Organization"
  ];

  TextEditingController _orgNameController = TextEditingController();
  FocusNode _orgNameFocusNode = FocusNode();
  final SigninBloc _signinBloc = SigninBloc();

  bool editProfileEnabled = false;

  String authToken="";
  String id="", isOnline = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPrefData();
    _listenServiceListResponse();


  }

  Future<void> getSharedPrefData() async {
    print('getSharedPrefData');
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    setState(() {
      authToken = shdPre.getString(SharedPrefKeys.token).toString();
      id = shdPre.getString(SharedPrefKeys.userID).toString();
      isOnline = shdPre.getString(SharedPrefKeys.mechanicIsOnline).toString();
      print('userFamilyId'+authToken.toString());
      _isLoadingPage=true;
      _mechanicProfileBloc.postMechanicFetchProfileRequest(authToken,id);

    });
  }

  _listenServiceListResponse() {

    _mechanicProfileBloc.MechanicProfileResponse.listen((value) {
      print("jgjhgghvj 01 $value");
      if (value.status == "error") {
        setState(() {
          _isLoadingPage = false;
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
          _isLoadingPage = false;
          setProfileData(value);
        });
      }
    });
    _mechanicProfileBloc.MechanicEditIndividualProfileResponse.listen((value) {
      if (value.status == "error") {
        setState(() {
          _isLoading = false;
          _isLoadingPage = false;
          editProfileEnabled = false;
        });
      } else {
        setState(() {
          _isLoading = false;
          _isLoadingPage = true;
          editProfileEnabled = false;
          _mechanicProfileBloc.postMechanicFetchProfileRequest(authToken,id);
        });
      }
    });
    _mechanicProfileBloc.postMechanicEditCorporateProfileResponse.listen((value) {
      if (value.status == "error") {
        setState(() {
          _isLoading = false;
          _isLoadingPage = false;
          editProfileEnabled = false;
        });
      } else {
        setState(() {
          _isLoading = false;
          _isLoadingPage = true;
          editProfileEnabled = false;
          _mechanicProfileBloc.postMechanicFetchProfileRequest(authToken,id);
        });
      }
    });
  }


  void setProfileData(MechanicProfileMdl value){
    _nameController.text = value.data!.mechanicDetails!.firstName.toString() ;
    _emailController.text = value.data!.mechanicDetails!.emailId.toString();
    _phoneController.text = value.data!.mechanicDetails!.phoneNo.toString();
    _stateController.text = value.data!.mechanicDetails!.mechanic![0].state.toString();
    _yearOfExistenceController.text = value.data!.mechanicDetails!.mechanic![0].yearExp.toString();
    _orgNameController.text = value.data!.mechanicDetails!.mechanic![0].orgName.toString();
    _orgTypeController.text = value.data!.mechanicDetails!.mechanic![0].orgType.toString();
    _userName = value.data!.mechanicDetails!.firstName.toString();
    _imageUrl = value.data!.mechanicDetails!.mechanic![0].profilePic.toString();
    print("fkjhkhkjhkhk $_imageUrl");
    _userType = value.data!.mechanicDetails!.mechanic![0].mechType.toString();
    print(">>>>>>>>>>>>> _userType : " + _userType);
    _signinBloc.userDefault(
        authToken,
        TextStrings.user_mechanic,
        _imageUrl,                    //----- profile image url should b updated
        //value.data!.signIn!.user!.firstName.toString() + value.data!.signIn!.user!.lastName.toString(),
        value.data!.mechanicDetails!.firstName.toString(),
        value.data!.mechanicDetails!.id.toString(), isOnline
    );
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                        children: [
                          appBarCustomUi(),
                          profileImageAndKmAndReviewCount(size),
                 Form(
                   autovalidateMode: _autoValidate,
                   key: _formKey,
                   child: _userType == "1"
                     ?
                       Column(
                         children: [
                           NameTextUi(),
                           EmailTextUi(),
                           PhoneTextUi(),
                           StateTextUi(),
                           // OrgNameTextUi(),
                           //OrgTypeTextUi(),
                           YearOfExperienceTextUi(),
                           editProfileEnabled  == true ? NextButton() : Container(),
                         ],
                       )
                       :
                   _userType == "2"
                     ?
                   Column(
                       children: [
                         NameTextUi(),
                         EmailTextUi(),
                         PhoneTextUi(),
                         StateTextUi(),
                         // OrgNameTextUi(),
                         OrgTypeTextUi(),
                         YearOfExperienceTextUi(),
                         editProfileEnabled == true ? NextButton() : Container(),
                     ],
                   ):Column()
                 )

                        ],
                      ),
                Visibility(
                  visible: _isLoadingPage,
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            CustColors.peaGreen),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ),
        ),
      );
  }

  Widget appBarCustomUi() {
    return Stack(
      children: [
        Row(
          children: [
            // IconButton(
            //   icon: Icon(Icons.arrow_back, color: Colors.black),
            //   onPressed: () => Navigator.pop(context),
            // ),
            // Text(
            //   _userType == "1" ? '$_userName' : _orgName,
            //   textAlign: TextAlign.center,
            //   style: Styles.appBarTextBlack,
            //   //'Mahesh',
            //   // textAlign: TextAlign.center,
            //   // style: Styles.appBarTextBlack,
            // ),
            Spacer(),

          ],
        ),
      ],
    );
  }

  Widget profileImageAndKmAndReviewCount(Size size) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10,10,10,10),
      child: Container(
        alignment: Alignment.center,
        child: Wrap(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10,10,10,10),
              child: Stack(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(00,80,155,0),
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
                          child: Image.asset(
                            'assets/image/mechanicProfileView/curvedGray.png',
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        // height: 50,
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
                                        child: _imageUrl !=null&&_imageUrl!=""
                                        ?
                                        Image.network(_imageUrl,
                                          width: 150,
                                          height: 150,
                                          fit: BoxFit.cover,
                                        )
                                            :
                                        SvgPicture.asset('assets/image/MechanicType/work_selection_avathar.svg',
                                        width:150,
                                        height:150,
                                        fit:BoxFit.cover),
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
                        },
                        child: Center(
                          child: Container(
                            child: Image.asset(
                                'assets/image/ic_camera_black.png',
                              width: size.width * 7/100,
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
                        child: InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context)
                                {
                                  return deactivateDialog();
                                });
                          },
                          child: Image.asset(
                            'assets/image/mechanicProfileView/curvedWhite.png',
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
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
                      //),
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
  _showDialogSelectPhoto() async{
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20), topLeft: Radius.circular(20))),
      builder: (builder){
        return Container(
          height: 115,
          child: ListView(
            children: [
              ListTile(
                leading: Icon(
                  Icons.camera_alt,
                  color: CustColors.blue,
                ),
                title: Text('Camera',
                style: TextStyle(
                  fontFamily: 'Corbel_Regular',
                  fontWeight: FontWeight.normal,
                  fontSize: 15,
                  color:Colors.black)),
                onTap: ()async{
                  Navigator.pop(context);
                  XFile? image= await picker.pickImage(
                    source: ImageSource.camera,imageQuality: 30);

                  setState(() {
                    if (image != null){
                      _images = File(image.path);
                      uploadImageToFirebase(_images!);
                      String filename = path.basename(image.path);
                    }
                  });
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.image,
                  color:CustColors.blue,
                ),
                title: Text('Gallery',
                style: TextStyle(
                  fontFamily: 'Corabel_Regular',
                  fontWeight: FontWeight.normal,
                  fontSize: 15,
                  color: Colors.black)),
                onTap: () async{
                  Navigator.pop(context);
                  XFile? image = (await picker.pickImage(
                    source: ImageSource.gallery, imageQuality: 30));
                  setState(() {
                    if(image != null){
                      _images = (File(image.path));
                      uploadImageToFirebase(_images!);
                      String fileName = path.basename(image.path);
                    }
                  });
                },
              )
            ],
          ),
        );
      }
    );
  }
  Future uploadImageToFirebase(File images) async{
    String fileName = path.basename(images.path);
    Reference reference = FirebaseStorage.instance.ref().child("SupportChatImages").child(fileName);
    UploadTask uploadTask = reference.putFile(images);
    uploadTask.whenComplete(() async{
      try{
        String fileImageurl = "";
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

  Widget NameTextUi() {
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
                          textAlignVertical: TextAlignVertical.center,
                          maxLines: 1,
                          enabled: editProfileEnabled,
                          readOnly: !editProfileEnabled,
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
                      editProfileEnabled == true
                      ? Text(
                          //'Your name',
                          _userType == "1" ? 'Your name' : 'Contact person',
                          textAlign: TextAlign.center,
                          style: Styles.textLabelSubTitle,
                        )
                      : Container(),
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

  Widget EmailTextUi() {
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
                  child: Icon(Icons.email, color: CustColors.blue),
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10,0,10,0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 250,
                        child: TextFormField(
                          textAlignVertical: TextAlignVertical.center,
                          maxLines: 1,
                          style: Styles.appBarTextBlack15,
                          focusNode: _emailFocusNode,
                          enabled: false,
                          keyboardType: TextInputType.emailAddress,
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
                      Text(
                            'Your email',
                            textAlign: TextAlign.center,
                            style: Styles.textLabelSubTitle,
                          )
                    ],
                  ),
                ),
              ),
              Spacer(),
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

  Widget StateTextUi() {
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
                  child: Icon(Icons.location_on_rounded, color: CustColors.blue),
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10,0,10,0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: InkWell(
                          onTap: () async {
                            print("on tap state ");

                            if(editProfileEnabled == true)
                              {
                                _awaitReturnValueFromSecondScreen(context);
                              }


                          },
                          child: Container(
                            height: 25,
                            child: TextFormField(
                              readOnly: true,
                              enabled: false,
                              textAlignVertical: TextAlignVertical.center,
                              maxLines: 1,
                              style: Styles.appBarTextBlack15,
                              focusNode: _stateFocusNode,
                              //keyboardType: TextInputType.phone,
                              validator: InputValidator(ch: AppLocalizations.of(context)!.text_state).emptyChecking,
                              controller: _stateController,
                              cursorColor: CustColors.whiteBlueish,
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
                        ),
                      ),
                      editProfileEnabled == false
                          ? Text(
                        'Your state',
                        textAlign: TextAlign.center,
                        style: Styles.textLabelSubTitle,
                      )
                          : Container(),
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

  Widget OrgNameTextUi() {
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
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10,0,10,0),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 25,
                          child: TextFormField(
                            textAlignVertical: TextAlignVertical.center,
                            maxLines: 1,
                            enabled: editProfileEnabled,
                            style: Styles.appBarTextBlack15,
                            focusNode: _orgNameFocusNode,
                            keyboardType: TextInputType.name,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp('[a-zA-Z ]')),
                            ],
                            validator: InputValidator(
                                ch :AppLocalizations.of(context)!.text_organization_name).nameChecking,
                            controller: _orgNameController,
                            cursorColor: CustColors.whiteBlueish,
                            decoration: InputDecoration(
                              isDense: true,
                              hintText:  'Organization Name',
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
                        editProfileEnabled == false
                            ? Container(
                              child: Text(
                                  'Your organization name',
                                  textAlign: TextAlign.start,
                                  style: Styles.textLabelSubTitle,
                                ),
                            )
                            : Container(),
                      ],
                    ),
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

  Widget OrgTypeTextUi() {
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
                  child: Icon(Icons.work, color: CustColors.blue),
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10,0,10,0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: InkWell(
                          onTap: () async {
                            print("on tap state ");

                            if(editProfileEnabled == true)
                            {
                              showOrganisationTypeSelector();
                            }
                          },
                          child: Container(
                            height: 25,
                            width: 400,
                            child: TextFormField(
                              enabled: false,
                              readOnly: true,
                              textAlignVertical: TextAlignVertical.center,
                              maxLines: 1,
                              style: Styles.appBarTextBlack15,
                              focusNode: _orgTypeFocusNode,
                              keyboardType: TextInputType.text,
                              //validator: InputValidator(ch: AppLocalizations.of(context)!.text_hint_organization_type).emptyChecking,
                              controller: _orgTypeController,
                              cursorColor: CustColors.whiteBlueish,
                              decoration: InputDecoration(
                                isDense: true,
                                hintText:  'Organization',
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
                        ),
                      ),
                      editProfileEnabled == false
                          ? Text(
                        'Your organization type',
                        textAlign: TextAlign.center,
                        style: Styles.textLabelSubTitle,
                      )
                          : Container(),
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
          Padding(
            padding: const EdgeInsets.fromLTRB(0,5,0,5),
            child: Divider(),
          )
        ],
      ),
    );
  }

  Widget PhoneTextUi() {
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
                  child: Icon(Icons.phone, color: CustColors.blue),
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10,0,10,0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: TextFormField(
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

                      Text(
                        'Your phone number',
                        textAlign: TextAlign.center,
                        style: Styles.textLabelSubTitle,
                      )
                    ],
                  ),
                ),
              ),
              Spacer(),
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

  Widget AddressTextUi() {
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
                  child: Icon(Icons.location_history_outlined, color: CustColors.blue),
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10,0,10,0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: Container(
                          height: 25,
                          width: 300,
                          child: TextFormField(
                            textAlignVertical: TextAlignVertical.center,
                            maxLines: 1,
                            enabled: editProfileEnabled,
                            style: Styles.appBarTextBlack15,
                            focusNode: _addressFocusNode,
                            keyboardType: TextInputType.name,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp('[a-zA-Z0-9 ]')),
                            ],
                            validator: InputValidator(
                                ch :'Address').nameCheckingWithNumeric,
                            controller: _addressController,
                            cursorColor: CustColors.whiteBlueish,
                            decoration: InputDecoration(
                              isDense: true,
                              hintText:  'Address',
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
                      ),
                      editProfileEnabled == false
                          ? Text(
                        'Your address',
                        textAlign: TextAlign.center,
                        style: Styles.textLabelSubTitle,
                      )
                          : Container(),
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
          Padding(
            padding: const EdgeInsets.fromLTRB(0,5,0,5),
            child: Divider(),
          )
        ],
      ),
    );
  }

  Widget YearOfExperienceTextUi() {
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
                  child: Icon(Icons.badge_outlined, color: CustColors.blue),
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10,0,10,0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: Container(
                          height: 25,
                          width: 300,
                          child: TextFormField(
                            textAlignVertical: TextAlignVertical.center,
                            maxLines: 1,
                            style: Styles.appBarTextBlack15,
                            focusNode: _yearOfExistenceFocusNode,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp('[0-9]')),
                            ],
                            validator: InputValidator(
                                ch : 'Year of existence' ).nameCheckingWithNumeric,
                            controller: _yearOfExistenceController,
                            cursorColor: CustColors.whiteBlueish,
                            decoration: InputDecoration(
                              isDense: true,
                              hintText:  'Experience',
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
                      ),
                      editProfileEnabled == false
                          ? Text(
                              'Your experience',
                              textAlign: TextAlign.center,
                              style: Styles.textLabelSubTitle,
                            )
                          : Container(),
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
          Padding(
            padding: const EdgeInsets.fromLTRB(0,5,0,5),
            child: Divider(),
          )
        ],
      ),
    );
  }

  Widget NextButton() {
    return editProfileEnabled==true
        ?  Container(
          width: double.infinity,
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

                      setState(() {
                        print("$_userType");
                        if(_userType == "1")
                          {
                            print("Individual");
                            _isLoading = true;
                            _mechanicProfileBloc.postMechanicEditProfileIndividualRequest(
                              authToken,
                              _nameController.text,
                              _nameController.text,
                              _stateController.text,
                              _imageUrl,
                              1,
                              _yearOfExistenceController.text,
                            );
                          }
                        else
                          {
                            _isLoading = true;
                            _mechanicProfileBloc.postMechanicEditProfileCorporateRequest(
                              authToken,
                              _nameController.text,
                              _nameController.text,
                              _stateController.text,
                              _imageUrl,
                              2,
                              _yearOfExistenceController.text,
                              _orgNameController.text,
                              _orgTypeController.text,
                            );
                            print("Cooperate");
                        }
                      });
                    },
                    child: Container(
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Save',
                            textAlign: TextAlign.center,
                            style: Styles.textButtonLabelSubTitle,
                          ),
                        ],
                      ),
                    ),
                    color: CustColors.materialBlue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            _setValue(0))),
                  ),
                ),
        )
        :  Container();
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

  void showOrganisationTypeSelector() {
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
                                                  final dial_Code = orgTypeList[index];
                                                  setState(() {
                                                    _orgTypeController.text = dial_Code.toString();
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
                                                        fontSize:12,
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