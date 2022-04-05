import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/Widgets/CurvePainter.dart';
import 'package:auto_fix/Widgets/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../Constants/text_strings.dart';
import '../../../../Widgets/input_validator.dart';
import '../../../Customer/BottomBar/Home/MechanicProfileView/mechanic_tracking_Screen.dart';

class MechanicMyProfileScreen extends StatefulWidget {

  MechanicMyProfileScreen();

  @override
  State<StatefulWidget> createState() {
    return _MechanicMyProfileScreenState();
  }
}

class _MechanicMyProfileScreenState extends State<MechanicMyProfileScreen> {

  TextEditingController _nameController = TextEditingController();
  FocusNode _nameFocusNode = FocusNode();


  double per = .10;
  double perfont = .10;
  double height = 0;
  String selectedState = "";

  double totalFees = 0.0;
  String authToken="";

  double _setValue(double value) {
    return value * per + value;
  }

  double _setValueFont(double value) {
    return value * perfont + value;
  }

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

    });
  }

  _listenServiceListResponse() {

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
                appBarCustomUi(size),
                profileImageAndKmAndReviewCount(size),
                NameTextUi(size),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget appBarCustomUi(Size size) {
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
                        child: Container(
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(90,10,0,0),
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

  Widget NameTextUi(Size size) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20,5,20,5),
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
                  Text(
                    'Your name',
                    textAlign: TextAlign.center,
                    style: Styles.textLabelSubTitle,
                  ),
                ],
              ),
            ),
          ),
          Spacer(),

        ],
      ),
    );
  }


}