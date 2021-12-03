import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/UI/Customer/Home/SideBar/MyVehicle/Details/vehicle_details_bloc.dart';
import 'package:auto_fix/UI/Customer/Home/SideBar/MyVehicle/Details/vehicle_details_mdl.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectVehicleScreen extends StatefulWidget {
  final List<VehicleDetails>? vehicleDetailsList;
  SelectVehicleScreen(this.vehicleDetailsList);
  @override
  State<StatefulWidget> createState() {
    return _SelectVehicleScreenState();
  }
}

class _SelectVehicleScreenState extends State<SelectVehicleScreen> {
  double per = .10;
  double _setValue(double value) {
    return value * per + value;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: EdgeInsets.only(left: 36, top: 26, bottom: 10),
            child: Image.asset(
              'assets/images/back.png',
              width: 11,
              height: 19.2,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: Container(
          margin: EdgeInsets.only(top: 22),
          child: Text(
            'Select  Vehicle',
            style: TextStyle(
                fontSize: 17,
                color: CustColors.blue,
                fontWeight: FontWeight.w600,
                fontFamily: 'Corbel_Regular'),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(
                top: _setValue(9.8), left: _setValue(70), bottom: 6),
            child: Text(
              'Select a car as your default vehicle!',
              style: TextStyle(
                  fontSize: 12,
                  color: Color(0xff363131),
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Corbel_Light'),
            ),
          ),
          Flexible(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.vehicleDetailsList!.length,
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                          margin: EdgeInsets.only(
                              left: _setValue(34.5),
                              right: _setValue(34.5),
                              top: 16),
                          padding: EdgeInsets.symmetric(
                              horizontal: 7, vertical: 4.8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black38,
                                spreadRadius: 0,
                                blurRadius: 0.8,
                                offset: Offset(0, .3),
                              ),
                            ],
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                _setValue(5.8),
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(_setValue(7.5)),
                                  child: Image.network(
                                    "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/2022-chevrolet-corvette-z06-1607016574.jpg?crop=0.737xw:0.738xh;0.181xw,0.218xh&resize=640:*",
                                    width: _setValue(52.5),
                                    height: _setValue(52.5),
                                    fit: BoxFit.cover,
                                  )),
                              Container(
                                margin: EdgeInsets.only(left: _setValue(30.9)),
                                child: Text(
                                  widget.vehicleDetailsList![index].make!
                                          .makeName! +
                                      " " +
                                      widget.vehicleDetailsList![index]
                                          .vehiclemodel!.modelName
                                          .toString(),
                                  style: TextStyle(
                                      fontSize: 14.5,
                                      color: CustColors.black01,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Corbel_Regular'),
                                ),
                              )
                            ],
                          )));
                }),
          )
        ],
      ),
    );
  }
}
