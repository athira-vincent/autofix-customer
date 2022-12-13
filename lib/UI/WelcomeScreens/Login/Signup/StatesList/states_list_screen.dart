import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signup/StatesList/states_list_bloc.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signup/StatesList/states_list_mdl.dart';
import 'package:auto_fix/Widgets/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class SelectStatesScreen extends StatefulWidget {

  const SelectStatesScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SelectStatesScreenState();
  }
}

class _SelectStatesScreenState extends State<SelectStatesScreen> {

  //final SignupBloc _signupBloc = SignupBloc();
  final StatesListBloc _cityListBloc = StatesListBloc();
  List<StatesList> _countryData = [];
  List<StatesList> _countryDataAll = [];
  String authToken = "";
  String? countryCode;
  String selectedState = "";
  bool isloading = false;
  bool _isLoadingPage = true;
  int itemCount = 0;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPrefData();
    _listenApiResponse();
    //_signupBloc.dialStatesListRequest();
    //_populateCountryList();
    //_signupBloc.searchStates("");
  }

  Future<void> getSharedPrefData() async {
    print('getSharedPrefData CustomerMyProfileScreen');
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    setState(() {
      authToken = shdPre.getString(SharedPrefKeys.token).toString();
      print('userFamilyId CustomerMyProfileScreen'+authToken.toString());
    });
    _cityListBloc.postStatesListRequest("", "123");
  }

  _listenApiResponse() {
    _cityListBloc.postStatesList.listen((value) {
      if(value.status == "error"){
        setState(() {
          _isLoadingPage = false;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(value.message.toString(),
                style: const TextStyle(
                    fontFamily: 'Roboto_Regular', fontSize: 14)),
            duration: const Duration(seconds: 2),
            backgroundColor: CustColors.light_navy,
          ));
        });
      }else{
        setState(() {
          _isLoadingPage = false;
          _countryDataAll = value.data!.statesList!;
          _countryData = value.data!.statesList!;
          itemCount = _countryData.length;
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _cityListBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
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
              AppLocalizations.of(context)!.text_hint_state,
              style: Styles.titleTextSelectStateStyle,
            ),
          ),
        ),
        body: _isLoadingPage == true
            ?
        Center(child: CircularProgressIndicator(color: CustColors.light_navy,),)
            :
        Container(
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
                              if(text.isNotEmpty){
                                setState((){
                                  _countryData = _countryData
                                      .where((element) => element.name
                                      .toLowerCase()
                                      .contains(text.toLowerCase()))
                                      .toList();
                                  itemCount = _countryData.length;
                                });

                              }else{
                                setState((){
                                  _countryData = _countryDataAll;
                                  itemCount = _countryData.length;
                                });

                              }
                         },
                            textAlign: TextAlign.left,
                            style: Styles.textLabelSubTitle10,
                            decoration: InputDecoration(
                              hintText: AppLocalizations.of(context)!.text_Search_Your_State,
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
                      itemCount: itemCount,
                      itemBuilder: (context, index) {
                        return InkWell(
                            onTap: () {

                            selectedState = _countryData[index].name;

                            final stateName = _countryData[index].name;
                            final countryDataId = _countryData[index].name;
                            print(">>>>>selectedState : " + selectedState);
                            print(countryDataId + ">>>>>>>>>" + stateName);

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
                    child: Text(AppLocalizations.of(context)!.error_not_found),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }


  /*_populateCountryList() {
    _signupBloc.statesCode.listen((value) {
      setState(() {
        isloading = false;
        _countryData = value.cast<StateDetails>();
      });
    });
  }*/

}