import 'dart:async';
import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/Utility/check_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NetworkErrorScreen extends StatefulWidget {

  NetworkErrorScreen();

  @override
  State<StatefulWidget> createState() {
    return _NetworkErrorScreenState();
  }
}

class _NetworkErrorScreenState extends State<NetworkErrorScreen> {

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  CheckInternet _checkInternet = CheckInternet();
  double per = .10;
  bool _isLoading = false;
  double _setValue(double value) {
    return value * per + value;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              height: size.height,
              width: size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  networkErrorBgUi(),
                  networkErrorTextUi(),
                  networkErrorTryButtonUi(size)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget networkErrorBgUi() {
    return  Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: _setValue(0.5),bottom: _setValue(25.5)),
      child: Container(
        child: Image.asset(
          'assets/image/img_network_error.png',
          fit: BoxFit.contain,
        ),
      ),
    ) ;
  }

  Widget networkErrorTextUi() {
    return  Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: _setValue(0.5),bottom: _setValue(25.5)),
      child: Container(
        child: Column(
          children: [
            Text(AppLocalizations.of(context)!.text_Connection_Failed),
            Text(AppLocalizations.of(context)!.text_no_internet_connection),
            Text(AppLocalizations.of(context)!.text_check_onnection_try_again)
          ],
        ),
      ),
    ) ;
  }

  Widget networkErrorTryButtonUi(Size size) {
    return  Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: _setValue(0.3),bottom: _setValue(30.5),),
      child: Container(
        margin: EdgeInsets.only(
          left: size.width * 35 / 100,
          right: size.width * 35 / 100,
          bottom: size.height * 10 /100
        ),
        child: Container(
          margin: const EdgeInsets.only(top: 8.8),
          child: _isLoading
              ? Container(
                height: 38,
                width: 85,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10),
                  ),
                  color: CustColors.materialBlue,
                ),
                child: Center(
                  child: SizedBox(
                    height: _setValue(25),
                    width: _setValue(25),
                    child: const CircularProgressIndicator(
                      valueColor:  AlwaysStoppedAnimation<Color>(
                          Colors.white),
                    ),
                  ),
            ),
          )
              : SizedBox(
                height: 38,
                width: 85,
                child: MaterialButton(
                  onPressed: () {
                    onCheckNetworkButton();
                  },
                  child: Container(
                    height: 38,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                         Text(
                          AppLocalizations.of(context)!.text_Try_Again,
                          textAlign: TextAlign.center,
                          style: Styles.textButtonLabelSubTitle12,
                        ),
                      ],
                    ),
                  ),
                  color: CustColors.light_navy,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          _setValue(10))),
                ),
          ),
        ),
      ),
    ) ;
  }

  _verifyOtpCode() {
    Timer(Duration(milliseconds: 4000), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  Widget progressBarDarkBlue() {
    return SizedBox(
      height: 60.0,
      child: new Center(
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(CustColors.blue),
          )),
    );
  }

  Widget progressBarLightRose() {
    return const SizedBox(
      height: 60.0,
      child:  Center(
          child: CircularProgressIndicator(
            valueColor:  AlwaysStoppedAnimation<Color>(CustColors.blue),
          )),
    );
  }

  Widget progressBarTransparent() {
    return const SizedBox(
      height: 60.0,
      child:  Center(
          child: CircularProgressIndicator(
            valueColor:  AlwaysStoppedAnimation<Color>(Colors.transparent),
          )),
    );
  }

  void onCheckNetworkButton() {
    _checkInternet.check().then((intenet) {
      if (intenet != null && intenet) {
        _isLoading = false;
        Navigator.pop(context);

      } else {
        setState(() {
          _isLoading = true;
          _verifyOtpCode();
          print('true');
        });
      }
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