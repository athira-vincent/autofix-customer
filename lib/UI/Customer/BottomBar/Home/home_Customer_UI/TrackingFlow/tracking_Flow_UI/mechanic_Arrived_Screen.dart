import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/Widgets/screen_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MechanicArrivedScreen extends StatefulWidget {


  MechanicArrivedScreen();

  @override
  State<StatefulWidget> createState() {
    return _MechanicArrivedScreenState();
  }
}

class _MechanicArrivedScreenState extends State<MechanicArrivedScreen> {


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
                Container(
                    height: MediaQuery.of(context).size.height * 0.38,
                    child: bagroundBgText(size)
                ),
                diagonosisCurvedUi( size),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget appBarCustomUi(Size size) {
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back, color:  CustColors.light_navy,),
          onPressed: () => Navigator.pop(context),
        ),
        Text(
          'Mechanic arrived',
          textAlign: TextAlign.center,
          style: Styles.appBarTextBlue2,
        ),
        Spacer(),

      ],
    );
  }

  Widget bagroundBgText(Size size) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10,15,10,10),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                height: 180,
                width: double.infinity,
                child: SvgPicture.asset(
                  'assets/image/CustomerType/mechanicArrivedBg.svg',
                  fit: BoxFit.contain,
                )
            ),
          ],
        ),
      ),
    );
  }

  Widget diagonosisCurvedUi(Size size) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.50,
          decoration: BoxDecoration(
              color: CustColors.light_navy,
              borderRadius: BorderRadius.circular(20)
          ),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  height: 140,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15,15,15,15),
                    child: Text(
                      "Your mechanic added some additional services after his diagnostic test , it may cause additional cost than you expected.",
                      style: Styles.infoTextLabelTitleWhite,
                      textAlign: TextAlign.justify,
                    ),
                  ),
              ),
            ],
          ),
        ),

        Container(
          decoration: BoxDecoration(
              color: CustColors.rusty_red,
              borderRadius: BorderRadius.circular(20)
          ),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 150,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15,15,15,15),
                  child: Text(
                    "may cause additional cost than you expected.",
                    style: Styles.infoTextLabelTitle,
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
              Container(
                color: Colors.red,
                width: double.infinity,
                child: infoText(),
              ),
            ],
          ),
        ),
      ],
    );
  }


  Widget infoText() {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: CustColors.pale_grey,
          border: Border.all(
              color: CustColors.grey_03
          ),
          borderRadius: BorderRadius.all(
              Radius.circular(5.0) //         <--- border radius here
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      color: CustColors.light_navy,
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          50,
                        ),
                      ),
                    ),
                    child: SvgPicture.asset(
                      'assets/image/CustomerType/extraServiceInfo.svg',
                      fit: BoxFit.contain,
                    )
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Wait for some time.  Mechanic started diagnostic test. He will finalise the service you needed  ",
                    style: Styles.infoTextLabelTitle,
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }



  Widget RequestButton(Size size, BuildContext context) {
    return InkWell(
      onTap: (){

      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          children: [
            Spacer(),
            Container(
              height: 45,
              width:200,
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 8, bottom: 6,left: 20,right: 20),
              //padding: EdgeInsets.only(left: 20, right: 20),
              decoration: BoxDecoration(
                color: CustColors.light_navy,
                border: Border.all(
                  color: CustColors.blue,
                  style: BorderStyle.solid,
                  width: 0.70,
                ),
                borderRadius: BorderRadius.circular(7),
              ),
              child:  Text(
                "Request Payment",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Corbel_Bold',
                    fontSize:
                    ScreenSize().setValueFont(14.5),
                    fontWeight: FontWeight.w800),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _showMechanicAcceptanceDialog(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
                backgroundColor: Colors.white,
                insetPadding: EdgeInsets.only(left: 20, right: 20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                contentPadding: const EdgeInsets.all(20),
                content: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            "Wait few minutes !",
                            style: Styles.waitingTextBlack17,
                          ),
                          Text(
                            "Wait for the response from George Dola!",
                            style: Styles.awayTextBlack,
                          ),
                          Container(
                              height: 150,
                              child: SvgPicture.asset(
                                'assets/image/mechanicProfileView/waitForMechanic.svg',
                                height: 200,
                                fit: BoxFit.cover,
                              )
                          ),
                        ],
                      ),
                    ],
                  ),
                ));
          });
        });


  }
}
