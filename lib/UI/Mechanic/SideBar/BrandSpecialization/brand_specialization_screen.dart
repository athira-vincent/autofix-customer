
import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/Models/customer_models/brand_list_model/brandListMdl.dart';
import 'package:auto_fix/UI/Mechanic/SideBar/BrandSpecialization/brand_specialization_bloc.dart';
import 'package:auto_fix/UI/Mechanic/SideBar/BrandSpecialization/brand_specialization_mdl.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/vechicleSpecialization/vehicleSpecialization_bloc.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/vechicleSpecialization/vehicleSpecialization_mdl.dart';
import 'package:auto_fix/Widgets/screen_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class BrandSpecializationScreen extends StatefulWidget {

  BrandSpecializationScreen();

  @override
  State<StatefulWidget> createState() {
    return _BrandSpecializationScreenState();
  }
}

class _BrandSpecializationScreenState extends State<BrandSpecializationScreen> {

  final brandSpecializationBloc _specializationBloc = brandSpecializationBloc();


  //List<VehicleSpecialization> _countryData = [];
  String? countryCode;
  String selectedState = "",authToken = "", mechanicId = "";
  bool isloading = false;
  //List<String> vehicleSpecialisationList =[];
  //List<VehicleSpecialization> vehicleSpecialisationList = [];

  List<MechanicBrandList>? _brandListData = [];
  List<MechanicBrandList> vehicleSpecialisationbrandList = [];



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getSharedPrefData();

    //vehicleSpecialisationList.clear();
    vehicleSpecialisationbrandList.clear();
    //_specializationBloc.dialvehicleSpecializationListRequest();
    _populateCountryList();
  }

  Future<void> getSharedPrefData() async {
    print('getSharedPrefData');
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    setState(() {
      authToken = shdPre.getString(SharedPrefKeys.token).toString();
      mechanicId = shdPre.getString(SharedPrefKeys.userID).toString();
      print('CustomerApprovedScreen bookingId >>>> $mechanicId');
      isloading=true;
      _specializationBloc.postBrandDetailsRequest(
          authToken, "$mechanicId");
    });
  }


  _populateCountryList() {
    /*_specializationBloc.vehicleSpecializationCode.listen((value) {
      setState(() {
        _countryData = value.cast<VehicleSpecialization>();
      });
    });*/
    _specializationBloc.postBrandListResponse.listen((value) {
      if (value.status == "error") {

        setState(() {
          isloading=false;
        });
      } else {

        setState(() {
          _brandListData = value.data?.mechanicBrandList;
          print(">>>>>>>>>" + _brandListData.toString());
          print(">>>>>>>>>" + _brandListData!.length.toString());
          //print(">>>>>>>>>" + _brandListData![23].brandName);
          isloading=false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context,vehicleSpecialisationbrandList),
        ),
        backgroundColor: Colors.white,
        title: Text(
          'Select brands',
          textAlign: TextAlign.center,
          style: Styles.textLabelTitle,
        ),
      ),
        body: SafeArea(
          child: Container(
            margin: EdgeInsets.only(left: 20, right: 20,top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Choose multiple brands you specialised in',
                    maxLines: 2,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.visible,
                    style: Styles.textLabelTitle,
                  ),
                ),
                /*Expanded(
                  child: Container(
                    //padding: EdgeInsets.only(top: ScreenSize().setValue(22.4)),
                    margin: EdgeInsets.only(*//*left: ScreenSize().setValue(5),*/
                /*
                        top: ScreenSize().setValue(22.4)),
                    child: _countryData.length != 0
                        ? Container(
                            child: GridView.builder(
                              itemCount:_countryData.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                childAspectRatio: 1.5,
                                crossAxisSpacing: 1,
                                mainAxisSpacing: 1,
                              ),
                              itemBuilder: (context,index,) {
                                return GestureDetector(
                                  onTap:(){
                                    setState(() {
                                      if(_countryData[index].value=="1")
                                        {
                                          _countryData[index].value="0";
                                          if (vehicleSpecialisationList.contains(_countryData[index])) {
                                            vehicleSpecialisationList.remove(_countryData[index]);
                                          }
                                        }
                                      else
                                        {
                                          _countryData[index].value="1";
                                          vehicleSpecialisationList.insert(0, _countryData[index]);
                                        }
                                      print(vehicleSpecialisationList);
                                    });
                                  },
                                  child:Container(

                                    child: Column(
                                      mainAxisAlignment:MainAxisAlignment.start,
                                      children: [
                                        Stack(
                                          alignment: Alignment.topRight,
                                          children: [

                                            Container(
                                              decoration: BoxDecoration(
                                                  color:  _countryData[index].value=="0"?Colors.white:CustColors.whiteBlueish,
                                                  borderRadius: BorderRadius.circular(11.0)
                                              ),
                                              height: 50,
                                              width: 50,
                                              child: Container(
                                                  child: Image.network(_countryData[index].image,
                                                  fit: BoxFit.contain,
                                                    height: 50,
                                                    width: 50,)
                                              ),
                                            ),
                                            Container(
                                              height: 20,
                                              width: 20,
                                              child: Align(
                                                alignment: Alignment.topRight,
                                                child: Container(
                                                  child: _countryData[index].value=="1"
                                                      ? Icon( Icons.check_circle,size: 20,color: CustColors.light_navy,)
                                                      : Container(),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        *//*Padding(
                                          padding: const EdgeInsets.all(0),
                                          child: Text(_countryData[index].name,
                                            style: Styles.textLabelTitle12,
                                            maxLines: 2,
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.visible,),
                                        ),*//*
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        : Center(
                            child: Text('No Results found.'),
                          ),
                  ),
                ),*/
                Expanded(
                  child: Container(
                    //padding: EdgeInsets.only(top: ScreenSize().setValue(22.4)),
                    margin: EdgeInsets.only(/*left: ScreenSize().setValue(5),*/
                        top: ScreenSize().setValue(22.4)),
                    child:
                    isloading == false
                    ? _brandListData?.length != 0
                        ? Container(
                            child: GridView.builder(
                              itemCount:_brandListData?.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                childAspectRatio: 1.5,
                                crossAxisSpacing: 1,
                                mainAxisSpacing: 1,
                              ),
                              itemBuilder: (context,index,) {
                                return GestureDetector(
                                  onTap:(){
                                    setState(() {
                                      if(_brandListData![index].inBrand=="1")
                                      {
                                        _brandListData![index].inBrand="0";
                                        if (vehicleSpecialisationbrandList.contains(_brandListData![index])) {
                                          vehicleSpecialisationbrandList.remove(_brandListData![index]);
                                        }
                                      }
                                      else
                                      {
                                        _brandListData![index].inBrand="1";
                                        vehicleSpecialisationbrandList.insert(0, _brandListData![index]);
                                      }
                                      print(vehicleSpecialisationbrandList);
                                    });
                                  },
                                  child:Container(

                                    child: Column(
                                      mainAxisAlignment:MainAxisAlignment.start,
                                      children: [
                                        Stack(
                                          alignment: Alignment.topRight,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  color:  _brandListData![index].inBrand == "0" ? Colors.white : CustColors.whiteBlueish,
                                                  borderRadius: BorderRadius.circular(11.0)
                                              ),
                                              height: 50,
                                              width: 50,
                                              child: Container(
                                                  child: Image.network(_brandListData![index].icon,
                                                    fit: BoxFit.contain,
                                                    height: 50,
                                                    width: 50,)
                                              ),
                                            ),
                                            Container(
                                              height: 20,
                                              width: 20,
                                              child: Align(
                                                alignment: Alignment.topRight,
                                                child: Container(
                                                  child: _brandListData![index].inBrand == "1"
                                                      ? Icon( Icons.check_circle,size: 20,color: CustColors.light_navy,)
                                                      : Container(),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        : Center(
                            child: Text('No BrandList found.'),
                          )
                    :Center(
                      child: Container(
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              CustColors.light_navy),
                        ),
                      ),
                    ),
                  ),
                ),

                InkWell(
                  onTap: (){
                    Navigator.pop(context,vehicleSpecialisationbrandList);
                  },
                  child: Row(
                    children: [
                      Spacer(),
                      Container(
                        height: size.height * 0.045,
                        width: size.width * 0.246,
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
                          "Next",
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
              ],
            ),
          ),
        ),
      );
  }

}