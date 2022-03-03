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
        body: Container(
          margin: EdgeInsets.only(left: 40, right: 40),
          child: Column(
            children: [

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
                              crossAxisCount: 3,
                              childAspectRatio: .94,
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
                                      }
                                    else
                                      {
                                        _countryData[index].value="1";
                                      }
                                  });
                                },
                                child:Container(

                                  child: Column(
                                    mainAxisAlignment:MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            color:  _countryData[index].value=="0"?Colors.white:CustColors.greyish,
                                            borderRadius: BorderRadius.circular(11.0)
                                        ),
                                        height: 50,
                                        width: 50,
                                        child: Padding(
                                          padding: const EdgeInsets.all(0),
                                          child: Container(
                                              child: Image.network(_countryData[index].image,
                                              fit: BoxFit.contain,
                                                height: 50,
                                                width: 50,)
                                          )
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2),
                                        child: Text(_countryData[index].name,
                                          style: Styles.textLabelTitle12,
                                          maxLines: 2,
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.visible,),
                                      ),
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
            ],
          ),
        ),
      );
  }

}