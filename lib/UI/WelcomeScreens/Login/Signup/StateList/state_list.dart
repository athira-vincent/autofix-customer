import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signup/signup_bloc.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signup/states_mdl.dart';
import 'package:auto_fix/Widgets/screen_size.dart';
import 'package:flutter/material.dart';

class SelectStateScreen extends StatefulWidget {

  const SelectStateScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SelectStateScreenState();
  }
}

class _SelectStateScreenState extends State<SelectStateScreen> {

  final SignupBloc _signupBloc = SignupBloc();
  List<StateDetails> _countryData = [];
  String? countryCode;

  String selectedState = "";

  bool isloading = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _signupBloc.dialStatesListRequest();
    _populateCountryList();
    _signupBloc.searchStates("");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _signupBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: <Widget>[
              IconButton(
                icon: Image.asset(
                  "assets/image/icon_close.png",
                  height: 15,
                  width: 15,
                ),
                onPressed: () {
                  Navigator.pop(context,selectedState.toString());
                },
              )
            ],
            title: Text(
              ' Select your state/FCT',
              style: Styles.titleTextSelectStateStyle,
            ),
          ),
        ),
        body: Container(
          margin: EdgeInsets.only(left: 40, right: 40),
          child: Column(
            children: [
              Container(
                height: ScreenSize().setValue(36.3),
                margin: EdgeInsets.only(top: ScreenSize().setValue(14)),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      ScreenSize().setValue(10),
                    ),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: CustColors.pinkish_grey,
                      spreadRadius: 0,
                      blurRadius: 1.5,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: ScreenSize().setValue(18)),
                      child: Icon(
                        Icons.search,
                        size: 20,
                        color: CustColors.light_navy,
                      ),
                    ),
                    Flexible(
                      child: Container(
                        margin: EdgeInsets.only(left: ScreenSize().setValue(12)),
                        alignment: Alignment.center,
                        height: ScreenSize().setValue(36.3),
                        child: Center(
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            textAlignVertical: TextAlignVertical.center,
                            onChanged: (text) {
                           setState(() {
                             _countryData.clear();
                             isloading = true;
                           });
                           _signupBloc.searchStates(text);
                         },
                            textAlign: TextAlign.left,
                            style: Styles.textLabelSubTitle10,
                            decoration: InputDecoration(
                              hintText: "Search Your State",
                              border: InputBorder.none,
                              contentPadding: new EdgeInsets.only(bottom: 15),
                              hintStyle: Styles.textLabelSubTitle10,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: Container(
                  //padding: EdgeInsets.only(top: ScreenSize().setValue(22.4)),
                  margin: EdgeInsets.only(/*left: ScreenSize().setValue(5),*/
                      top: ScreenSize().setValue(22.4)),
                  child: _countryData.length != 0
                      ? ListView.separated(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: _countryData.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                          onTap: () {

                            selectedState = _countryData[index].name!;

                            final stateName = _countryData[index].name;
                            final countryDataId = _countryData[index].id;
                            print(">>>>>selectedState : " + selectedState);
                            print(countryDataId! + ">>>>>>>>>" + stateName!);

                           // Navigator.of(context).pop(stateName);
                            Navigator.pop(context,selectedState.toString());

                          },
                          child: Container(
                            margin: EdgeInsets.only(
                              left: 5,
                              right: 5,
                            ),
                            child: Text(
                              '${_countryData[index].name}',
                              style:Styles.textLabelSubTitle10,
                            ),
                          ));
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Container(
                          margin: EdgeInsets.only(
                              top: ScreenSize().setValue(10),
                              left: 5,
                              right: 5,
                              bottom: ScreenSize().setValue(10)),
                          child: Divider(
                            height: 0,
                          ));
                    },
                  )
                      : Center(
                    child: Text('No Results found.'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  _populateCountryList() {
    _signupBloc.statesCode.listen((value) {
      setState(() {
        isloading = false;
        _countryData = value.cast<StateDetails>();
      });
    });
  }

}