import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/UI/Mechanic/BottomBar/MyProfile/profile_Mechanic_Bloc/mechanic_profile_bloc.dart';
import 'package:auto_fix/UI/Mechanic/BottomBar/MyProfile/profile_Mechanic_Models/mechanic_profile_mdl.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signup/StateList/state_list.dart';
import 'package:auto_fix/Widgets/CurvePainter.dart';
import 'package:auto_fix/Widgets/input_validator.dart';
import 'package:auto_fix/Widgets/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
  bool _isLoading = false;
  String _userName = "", _imageUrl = "", _userType = "";


  double _setValue(double value) {
    return value * per + value;
  }

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



  bool editProfileEnabled = false;

  String authToken="";

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
      print('userFamilyId'+authToken.toString());
      _mechanicProfileBloc.postMechanicFetchProfileRequest(authToken);

    });
  }

  _listenServiceListResponse() {

    _mechanicProfileBloc.MechanicProfileResponse.listen((value) {
      if (value.status == "error") {
        setState(() {
          _isLoading = false;
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
          _isLoading = false;
          setProfileData(value);
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
    _userName = value.data!.mechanicDetails!.firstName.toString();
    _imageUrl = value.data!.mechanicDetails!.mechanic![0].profilePic.toString();
    _userType = value.data!.mechanicDetails!.mechanic![0].mechType.toString();
    print(">>>>>>>>>>>>> _userType : " + _userType);
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                appBarCustomUi(),
                profileImageAndKmAndReviewCount(),
                NameTextUi(),
                EmailTextUi(),
                StateTextUi(),
                WorkTextUi(),
                AddressTextUi(),
                YearOfExperienceTextUi(),
                NextButtonMechanicIndividual()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget appBarCustomUi() {
    return Stack(
      children: [
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
            Text(
              'Mahesh',
              textAlign: TextAlign.center,
              style: Styles.appBarTextBlack,
            ),
            Spacer(),

          ],
        ),
      ],
    );
  }

  Widget profileImageAndKmAndReviewCount() {
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
                        padding: const EdgeInsets.fromLTRB(0,75,155,0),
                        child: Image.asset(
                          'assets/image/mechanicProfileView/curvedGray.png',
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(50,75,155,0),
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
                          child: Container(
                            height: 50,
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
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(97,10,0,0),
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
                                    child:  SvgPicture.asset('assets/image/MechanicType/work_selection_avathar.svg'),
                                  )))

                      ),
                    ),
                  ),

                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(155,75,0,0),
                        child: Image.asset(
                          'assets/image/mechanicProfileView/curvedWhite.png',
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(200,75,40,0),
                        child:Container(
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
                          cursorColor: CustColors.whiteBlueish,
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
                      editProfileEnabled == false
                      ? Text(
                          'Your name',
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
                          enabled: editProfileEnabled,
                          keyboardType: TextInputType.emailAddress,
                          validator: InputValidator(ch: AppLocalizations.of(context)!.text_email).emailValidator,
                          controller: _emailController,
                          cursorColor: CustColors.whiteBlueish,
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
                      editProfileEnabled == false
                          ? Text(
                            'Your email',
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

  Widget WorkTextUi() {
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
                              _showDialogForWorkSelection(workSelectionList);
                            }


                          },
                          child: Container(
                            height: 25,
                            width: 300,
                            child: TextFormField(
                              textAlignVertical: TextAlignVertical.center,
                              maxLines: 1,
                              style: Styles.appBarTextBlack15,
                              focusNode: _workSelectionFocusNode,
                              keyboardType: TextInputType.name,
                              enabled: false,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp('[a-zA-Z ]')),
                              ],
                              validator: InputValidator(
                                  ch :
                                  'Work Selection').nameChecking,
                              controller: _workSelectionController,
                              cursorColor: CustColors.whiteBlueish,
                              decoration: InputDecoration(
                                isDense: true,
                                hintText:  'Work',
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
                        'Your work selection',
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

  Widget NextButtonMechanicIndividual() {
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
                          CustColors.peaGreen),
                    ),
                  ),
                )
              : Container(
                  child: MaterialButton(
                    onPressed: () {

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



}