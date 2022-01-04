import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/UI/Customer/Home/SideBar/MyVehicle/Details/vehicle_details_bloc.dart';
import 'package:auto_fix/UI/Customer/Home/SideBar/MyVehicle/Details/vehicle_details_mdl.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VehicleDetailsScreen extends StatefulWidget {
  const VehicleDetailsScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _VehicleDetailsScreenState();
  }
}

class _VehicleDetailsScreenState extends State<VehicleDetailsScreen> {

  final VehilceDetailsBloc _vehilceDetailsBloc = VehilceDetailsBloc();


  @override
  void initState() {
    super.initState();
    _getVehicleList();
    _getVehicleDetails();
  }

  _getVehicleList() async {
    SharedPreferences _shdPre = await SharedPreferences.getInstance();
    String token = _shdPre.getString(SharedPrefKeys.token)!;
    _vehilceDetailsBloc.postVehicleDetailsRequest(token);
  }

  @override
  void dispose() {
    super.dispose();
    _vehilceDetailsBloc.dispose();
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
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: EdgeInsets.only(left: 5, top: 26, bottom: 10),
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
            'My Vehicles',
            style: TextStyle(
                fontSize: 17,
                color: CustColors.blue,
                fontWeight: FontWeight.w600,
                fontFamily: 'Corbel_Regular'),
          ),
        ),
      ),
      body: Container(
        child: Padding(
        padding: const EdgeInsets.only(left: 15,right: 15, top: 26, bottom: 10),
        child: Container(
          child: StreamBuilder(
              stream: _vehilceDetailsBloc.vehicleDetailsResponse,
              builder: (context, AsyncSnapshot<VehicleDetailsMdl> snapshot) {
                print("${snapshot.hasData}");
                print("${snapshot.connectionState}");
                if (snapshot.connectionState != ConnectionState.active) {
                  print('connectionState');
                  return Container();
                }
                else if (snapshot.hasData ||  snapshot.data!.data!.vehicleDetailsList!=null)
                {
                  if (snapshot.data!.status == 'error') {
                    print('errorrrrrrr');
                    return Container(child:Center(child: Text("Something Went Wrong")));

                  }
                  else
                  if (snapshot.data!.data!.vehicleDetailsList!.length == 0) {
                    print('error');
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Container(
                            width: double.infinity,
                            child:Column(
                              children: [

                                Padding(
                                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                                  child: Container(
                                      width: 170,
                                      height: 170,
                                      child: Image.asset(
                                        'assets/images/NoActivitiesV.png',
                                        fit: BoxFit.cover,)
                                  ),
                                ),

                                Text("No activities were found",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color:Colors.black12,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'CircularStd'
                                  ),
                                ),
                              ],
                            )
                        ),
                      ),
                    );
                  }
                }
                else {
                  return null!;
                }
                return  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data!.data!.vehicleDetailsList!.length,
                      itemBuilder: (context, index) {

                        print(snapshot.data!.data!.vehicleDetailsList![index].year.toString() +  '+++++++');

                        return Card(
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  '${snapshot.data!.data!.vehicleDetailsList![index].vehiclemodel!.modelName.toString()}',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  '${snapshot.data!.data!.vehicleDetailsList![index].engine!.engineName.toString()}',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );

                      },
                    );
              }),
        ),
      ),
      ),
    );
  }
}
