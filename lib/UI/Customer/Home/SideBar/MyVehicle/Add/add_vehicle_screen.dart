import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/grapgh_ql_client.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';

import 'package:auto_fix/UI/Customer/Home/SideBar/MyVehicle/Add/Engine/all_engine_bloc.dart';
import 'package:auto_fix/UI/Customer/Home/SideBar/MyVehicle/Add/Engine/all_engine_mdl.dart';
import 'package:auto_fix/UI/Customer/Home/SideBar/MyVehicle/Add/Make/all_make_bloc.dart';
import 'package:auto_fix/UI/Customer/Home/SideBar/MyVehicle/Add/Model/all_model_bloc.dart';
import 'package:auto_fix/UI/Customer/Home/SideBar/MyVehicle/Add/Model/all_model_mdl.dart';
import 'package:auto_fix/UI/Customer/Home/SideBar/MyVehicle/Add/add_vehicle_bloc.dart';
import 'package:auto_fix/UI/Customer/Home/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Make/all_make_mdl.dart';

class AddVehicleScreen extends StatefulWidget {
  const AddVehicleScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AddVehicleScreenState();
  }
}

class _AddVehicleScreenState extends State<AddVehicleScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;

  TextEditingController _yearController = TextEditingController();
  TextEditingController _maintenanceController = TextEditingController();
  TextEditingController _mileageController = TextEditingController();

  String token = "";

  List<MakeDetails>? makeDetails = [];
  MakeDetails? value;

  List<ModelDetails>? modelDetails = [];
  ModelDetails? modelValue;

  List<EngineDetails>? engineDetails = [];
  EngineDetails? engineValue;

  final AddVehicleBloc _addVehicleBloc = AddVehicleBloc();
  final AllModelBloc _allModelBloc = AllModelBloc();
  final AllMakeBloc _allMakeBloc = AllMakeBloc();
  final AllEngineBloc _allEngineBloc = AllEngineBloc();
  int make_id = 0;
  int model_id = 0;
  int engine_id = 0;
  String make_name = "";
  String model_name = "";
  String engine_name = "";
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    _addToken();
    _yearController.addListener(onFocusChange);
    _maintenanceController.addListener(onFocusChange);
    _mileageController.addListener(onFocusChange);
    //_allModelBloc.postAllModelRequest(make_id);
    //_allEngineBloc.postAllEngineRequest(model_id);
    _getAllModel();
    _getAllMake();
    _getAllEngine();
    _addVehicle();
  }

  _addToken() async {
    SharedPreferences _shdPre = await SharedPreferences.getInstance();
    token = _shdPre.getString(SharedPrefKeys.token)!;
    print("Token : " + token);
    GqlClient.I.config(token: token);
    _allMakeBloc.postAllMakeRequest(token);
  }

  @override
  void dispose() {
    super.dispose();
    _yearController.dispose();
    _maintenanceController.dispose();
    _mileageController.dispose();
    _addVehicleBloc.dispose();
    _allModelBloc.dispose();
    _allMakeBloc.dispose();
    _allEngineBloc.dispose();
  }

  void onFocusChange() {
    setState(() {});
  }

  _getAllModel() async {
    _allModelBloc.postAllModel.listen((value) {
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
          modelDetails = value.data!.modelDetails;
        });
      }
    });
  }

  _getAllMake() async {
    _allMakeBloc.postAllMake.listen((value) {
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
          makeDetails = value.data!.makeDetails;
          // print("c"+value.data.acceptInvitations.message.toString()+"c");
          print(">>>>>Brand Data" +
              value.data!.makeDetails!.length.toString() +
              ">>>>>>>>>");
        });
      }
    });
  }

  _getAllEngine() async {
    _allEngineBloc.postAllEngine.listen((value) {
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
          print(">>>>>Brand Data" +
              value.data!.engineDetails!.length.toString() +
              ">>>>>>>>>");
          engineDetails = value.data!.engineDetails;
        });
      }
    });
  }

  _addVehicle() async {
    _addVehicleBloc.postAddVehicle.listen((value) {
      if (value.status == "error") {
        setState(() {
          bool _isLoading = false;
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
          print("errrrorr 01");
          _isLoading = false;
          print(">>>>>Vehicle Api Data" +
              "id : " +
              value.data!.vehicleCreate!.id.toString() +
              "Customer Id : " +
              value.data!.vehicleCreate!.customerId.toString() +
              "Last Maintenance : " +
              value.data!.vehicleCreate!.lastMaintenance.toString() +
              ">>>>>>>>>");
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Successfully Registered",
                style: TextStyle(fontFamily: 'Roboto_Regular', fontSize: 14)),
            duration: Duration(seconds: 2),
            backgroundColor: CustColors.darkBlue,
          ));
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const HomeScreen()));
          FocusScope.of(context).unfocus();
          setIsSignedIn();
        });
      }
    });
  }

 /* String? _selectedColor;
  List<String> _animals = ["Dog", "Cat", "Crocodile", "Dragon"];
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10.0),
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  padding: EdgeInsets.only(right: 5),
                  //color: Colors.red,
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 6,
                            child: Container(
                              margin: EdgeInsets.all(4),
                              padding: EdgeInsets.only(
                                  top: 15, bottom: 5, left: 8, right: 5),
                              // color: Colors.purple,
                              child: Column(
                                children: const [
                                  Text(
                                    "Add Your Car",
                                    style: TextStyle(
                                      color: CustColors.blue,
                                      fontSize: 22,
                                      fontFamily: 'Corbel_Bold',
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Stack(
                              children: [
                                Container(
                                  margin: EdgeInsets.all(4),
                                  padding: EdgeInsets.only(
                                      top: 15, bottom: 5, left: 10, right: 5),
                                  width: double.infinity,
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: CustColors.cloudy_blue,
                                      style: BorderStyle.solid,
                                      width: 1.0,
                                    ),
                                    color: CustColors.cloudy_blue,
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              left: 10, right: 28),
                                          padding: EdgeInsets.all(1),
                                          child: const Text(
                                            "Upload Your \nCar Photos",
                                            style: TextStyle(
                                                color: CustColors.blue,
                                                fontFamily: 'Corbel_Regular',
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 6,
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              left: 10, right: 26, bottom: 3),
                                          padding: EdgeInsets.all(2),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: CustColors.blue,
                                              style: BorderStyle.solid,
                                              width: 1.0,
                                            ),
                                            color: CustColors.blue,
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          alignment: Alignment.bottomRight,
                                          margin:
                                              EdgeInsets.only(top: 1, right: 4),
                                          padding: EdgeInsets.all(1),
                                          child: Image.asset(
                                            "assets/images/icon_add.png",
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.all(4),
                        padding: EdgeInsets.only(
                            top: 55, bottom: 10, left: 20, right: 90),
                        child: Image.asset(
                          "assets/images/car_image.png",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: Container(
                  margin: EdgeInsets.only(left: 6, right: 6),
                  padding: EdgeInsets.all(2),
                  //color: Colors.green,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.all(2),
                        padding: EdgeInsets.only(
                            top: 4, bottom: 4, left: 10, right: 10),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                            color: CustColors.cloudy_blue,
                            style: BorderStyle.solid,
                            width: 0.70,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: DropdownButton<MakeDetails>(
                          onChanged: (value) {
                            setState(() {
                              this.value = value;
                              _allModelBloc.postAllModelRequest(
                                  int.parse(value!.id!), token);
                              print(value);
                            });
                          },
                          value: value,
                          underline: Container(),
                          hint: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Select Your Brand",
                              style: TextStyle(
                                fontSize: 18,
                                color: CustColors.blue,
                                fontFamily: 'Corbel_Regular',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          icon: Image.asset(
                            "assets/images/icon_dropdown_arrow.png",
                            height: 30,
                            width: 30,
                          ),
                          isExpanded: true,
                          items: makeDetails!.map(buildMenuItem).toList(),
                          selectedItemBuilder: (BuildContext context) =>
                              makeDetails!
                                  .map((e) => Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          e.makeName.toString(),
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: CustColors.blue,
                                              fontFamily: 'Corbel_Regular',
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ))
                                  .toList(),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(2),
                        padding: EdgeInsets.only(
                            top: 4, bottom: 4, left: 10, right: 10),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                            color: CustColors.cloudy_blue,
                            style: BorderStyle.solid,
                            width: 0.70,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: DropdownButton<ModelDetails>(
                          onChanged: (value) {
                            setState(() {
                              this.modelValue = value;
                              _allEngineBloc.postAllEngineRequest(
                                  int.parse(value!.id!), token);
                              print(modelValue);
                            });
                          },
                          value: modelValue,
                          underline: Container(),
                          hint: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Car Model",
                              style: TextStyle(
                                fontSize: 18,
                                color: CustColors.blue,
                                fontFamily: 'Corbel_Regular',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          icon: Image.asset(
                            "assets/images/icon_dropdown_arrow.png",
                            height: 30,
                            width: 30,
                          ),
                          isExpanded: true,
                          items: modelDetails!
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(
                                    e.modelName.toString(),
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: CustColors.blue,
                                      fontFamily: 'Corbel_Regular',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                          selectedItemBuilder: (BuildContext context) =>
                              modelDetails!
                                  .map(
                                    (e) => Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        e.modelName.toString(),
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: CustColors.blue,
                                            fontFamily: 'Corbel_Regular',
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  )
                                  .toList(),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(2),
                        padding: EdgeInsets.only(
                            top: 4, bottom: 4, left: 10, right: 10),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                            color: CustColors.cloudy_blue,
                            style: BorderStyle.solid,
                            width: 0.70,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: DropdownButton<EngineDetails>(
                          onChanged: (value) {
                            setState(() {
                              this.engineValue = value;
                              print(value);
                            });
                          },
                          value: engineValue,
                          underline: Container(),
                          hint: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Select Engine Type",
                              style: TextStyle(
                                fontSize: 18,
                                color: CustColors.blue,
                                fontFamily: 'Corbel_Regular',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          icon: Image.asset(
                            "assets/images/icon_dropdown_arrow.png",
                            height: 30,
                            width: 30,
                          ),
                          isExpanded: true,
                          items: engineDetails!
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(
                                    e.engineName.toString(),
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: CustColors.blue,
                                      fontFamily: 'Corbel_Regular',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ).toList(),
                          selectedItemBuilder: (BuildContext context) =>
                              engineDetails!
                                  .map(
                                    (e) => Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        e.engineName.toString(),
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: CustColors.blue,
                                            fontFamily: 'Corbel_Regular',
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ).toList(),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(2),
                        padding: EdgeInsets.only(
                            top: 4, bottom: 4, left: 10, right: 10),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                            color: CustColors.cloudy_blue,
                            style: BorderStyle.solid,
                            width: 0.70,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: DropdownButton<String>(
                          onChanged: (val) {
                            setState(() {
                              //_selectedColor = val;
                            });
                          },
                          //value: _selectedColor,
                          underline: Container(),
                          hint: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Select Year",
                              style: TextStyle(
                                fontSize: 18,
                                color: CustColors.blue,
                                fontFamily: 'Corbel_Regular',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          icon: Image.asset(
                            "assets/images/icon_dropdown_arrow.png",
                            height: 30,
                            width: 30,
                          ),
                          isExpanded: true,
                          items: [],
                          /*items: _animals
                              .map((e) => DropdownMenuItem(
                                    child: Text(
                                      e,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: CustColors.blue,
                                        fontFamily: 'Corbel_Regular',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    value: e,
                                  ))
                              .toList(),
                          selectedItemBuilder: (BuildContext context) =>
                              _animals
                                  .map((e) => Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          e,
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: CustColors.blue,
                                              fontFamily: 'Corbel_Regular',
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ))
                                  .toList(),*/
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(2),
                        padding: EdgeInsets.only(
                            top: 4, bottom: 4, left: 10, right: 10),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                            color: CustColors.cloudy_blue,
                            style: BorderStyle.solid,
                            width: 0.70,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: DropdownButton<String>(
                          onChanged: (val) {
                            setState(() {
                              //_selectedColor = val;
                            });
                          },
                          //value: _selectedColor,
                          underline: Container(),
                          hint: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Last maintenance",
                              style: TextStyle(
                                fontSize: 18,
                                color: CustColors.blue,
                                fontFamily: 'Corbel_Regular',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          icon: Image.asset(
                            "assets/images/icon_dropdown_arrow.png",
                            height: 30,
                            width: 30,
                          ),
                          isExpanded: true,
                          items: [],
                          /*items: _animals
                              .map((e) => DropdownMenuItem(
                                    child: Text(
                                      e,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: CustColors.blue,
                                        fontFamily: 'Corbel_Regular',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    value: e,
                                  ))
                              .toList(),
                          selectedItemBuilder: (BuildContext context) =>
                              _animals
                                  .map((e) => Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          e,
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: CustColors.blue,
                                              fontFamily: 'Corbel_Regular',
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ))
                                  .toList(),*/
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(2),
                        padding: EdgeInsets.only(
                            top: 4, bottom: 4, left: 10, right: 10),
                        child: Text(
                          "Approximate Mileage",
                          style: TextStyle(
                            fontSize: 18,
                            color: CustColors.blue,
                            fontFamily: 'Corbel_Regular',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(2),
                        padding: EdgeInsets.only(
                            top: 4, bottom: 4, left: 10, right: 10),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                            color: CustColors.cloudy_blue,
                            style: BorderStyle.solid,
                            width: 0.70,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: _isLoading ?
                        Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                CustColors.darkBlue),
                          ),
                        )
                        :
                        Container(
                          margin: EdgeInsets.all(4),
                          padding: EdgeInsets.only(
                              top: 7.3, bottom: 7.2, left: 35, right: 35.3),
                          decoration: BoxDecoration(
                            color: CustColors.blue,
                            border: Border.all(
                              color: CustColors.blue,
                              style: BorderStyle.solid,
                              width: 0.70,
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: MaterialButton(
                            child: Text(
                              "Save",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Corbel_Regular',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800),
                            ),
                            onPressed: (){
                              if (_formKey.currentState!.validate()) {
                                _addVehicleBloc.postAddVehicleRequest(
                                    token,
                                    _yearController.text,
                                    "10.551123",
                                    "76.066753",
                                    _mileageController.text,
                                    _maintenanceController.text,
                                    "3",
                                    int.parse(value!.id!),
                                    int.parse(modelValue!.id!),
                                    int.parse(engineValue!.id!)
                                  /* _userNameController.text,
                                _passwordController.text*/
                                );
                                setState(() {
                                  _isLoading = true;
                                });
                              } else {
                                setState(() =>
                                _autoValidate = AutovalidateMode.always);
                              }
                            },
                          ),

                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void setIsSignedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(SharedPrefKeys.isDefaultVehicleAvailable, 2);
  }

  DropdownMenuItem<MakeDetails> buildMenuItem(MakeDetails item) =>
      DropdownMenuItem(
        value: item,
        child: Text(
          item.makeName.toString(),
          style: TextStyle(
            fontSize: 18,
            color: CustColors.blue,
            fontFamily: 'Corbel_Regular',
            fontWeight: FontWeight.w700,
          ),
        ),
      );
}
