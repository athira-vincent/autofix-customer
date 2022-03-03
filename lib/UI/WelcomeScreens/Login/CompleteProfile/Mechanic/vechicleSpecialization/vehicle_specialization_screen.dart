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
      );
  }

}