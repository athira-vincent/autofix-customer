import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/UI/Customer/Home/SideBar/MyVehicle/Details/vehicle_details_bloc.dart';
import 'package:auto_fix/UI/Customer/Home/SideBar/MyVehicle/Details/vehicle_details_mdl.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectVehicleScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SelectVehicleScreenState();
  }
}

class _SelectVehicleScreenState extends State<SelectVehicleScreen> {
  final VehilceDetailsBloc _vehilceDetailsBloc = VehilceDetailsBloc();
  List<VehicleDetails>? vehicleDetailsList = [];
  double per = .10;
  double _setValue(double value) {
    return value * per + value;
  }

  _getVehicleList() async {
    SharedPreferences _shdPre = await SharedPreferences.getInstance();
    String token = _shdPre.getString(SharedPrefKeys.token)!;
    _vehilceDetailsBloc.postVehicleDetailsRequest(token);
  }

  _getVehicleDetails() async {
    _vehilceDetailsBloc.postVehicleDetails.listen((value) {
      if (value.status == "error") {
        setState(() {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(value.message.toString(),
                style: const TextStyle(
                    fontFamily: 'Roboto_Regular', fontSize: 14)),
            duration: const Duration(seconds: 2),
            backgroundColor: CustColors.peaGreen,
          ));
        });
      } else {
        setState(() {
          vehicleDetailsList = value.data!.vehicleDetailsList;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _vehilceDetailsBloc.dispose();
  }

  @override
  void initState() {
    super.initState();
    _getVehicleList();
    _getVehicleDetails();
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
                itemCount: vehicleDetailsList!.length,
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: () {},
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
                                  vehicleDetailsList![index].make!.makeName! +
                                      " " +
                                      vehicleDetailsList![index]
                                          .vehiclemodel!
                                          .modelName
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
