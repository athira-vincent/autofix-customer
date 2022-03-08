import 'dart:io';

import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/vechicleSpecialization/vehicleSpecialization_bloc.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Mechanic/vechicleSpecialization/vehicleSpecialization_mdl.dart';
import 'package:auto_fix/Widgets/screen_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class VehicleSpecializationScreen extends StatefulWidget {

  VehicleSpecializationScreen();

  @override
  State<StatefulWidget> createState() {
    return _VehicleSpecializationScreenState();
  }
}

class _VehicleSpecializationScreenState extends State<VehicleSpecializationScreen> {

  final vehicleSpecializationBloc _specializationBloc = vehicleSpecializationBloc();


  List<VehicleSpecialization> _countryData = [];
  String? countryCode;
  String selectedState = "";
  bool isloading = false;
  List<String> vehicleSpecialisationList =[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _specializationBloc.dialvehicleSpecializationListRequest();
    _populateCountryList();
  }

  _populateCountryList() {
    _specializationBloc.vehicleSpecializationCode.listen((value) {
      setState(() {
        _countryData = value.cast<VehicleSpecialization>();
      });
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
          onPressed: () => Navigator.pop(context,vehicleSpecialisationList.toString()),
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
                Expanded(
                  child: Container(
                    //padding: EdgeInsets.only(top: ScreenSize().setValue(22.4)),
                    margin: EdgeInsets.only(/*left: ScreenSize().setValue(5),*/
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
                                          if (vehicleSpecialisationList.contains(_countryData[index].id)) {
                                            vehicleSpecialisationList.remove(_countryData[index].id);
                                          }
                                        }
                                      else
                                        {
                                          _countryData[index].value="1";
                                          vehicleSpecialisationList.insert(0, _countryData[index].id);
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
                                        /*Padding(
                                          padding: const EdgeInsets.all(0),
                                          child: Text(_countryData[index].name,
                                            style: Styles.textLabelTitle12,
                                            maxLines: 2,
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.visible,),
                                        ),*/
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
                ),

                InkWell(
                  onTap: (){
                    Navigator.pop(context,vehicleSpecialisationList.toString());
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