import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/grapgh_ql_client.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/UI/Customer/SideBar/MyVehicle/Add/Engine/all_engine_bloc.dart';
import 'package:auto_fix/UI/Customer/SideBar/MyVehicle/Add/Engine/all_engine_mdl.dart';
import 'package:auto_fix/UI/Customer/SideBar/MyVehicle/Add/Make/all_make_bloc.dart';
import 'package:auto_fix/UI/Customer/SideBar/MyVehicle/Add/Model/all_model_bloc.dart';
import 'package:auto_fix/UI/Customer/SideBar/MyVehicle/Add/Model/all_model_mdl.dart';
import 'package:auto_fix/UI/Customer/SideBar/MyVehicle/Add/add_vehicle_bloc.dart';
import 'package:auto_fix/Widgets/input_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graphql/client.dart';
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

  TextEditingController _yearController =TextEditingController();
  TextEditingController _maintenanceController = TextEditingController();
  TextEditingController _mileageController = TextEditingController();

  String token = "";

  //final items = ['item1','item2','item3','item4','item5'];
  List<MakeDetails>? makeDetails;
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
    setState(() {
      /*_labelStyleUserName = _userNameFocusNode.hasFocus
          ? TextStyle(
        fontFamily: 'Montserrat_Light',
        color: Colors.white,
        fontSize: 12,
      )
          : TextStyle(
        fontFamily: 'Montserrat_Light',
        color: Colors.white,
        fontSize: 12,
      );
      _labelStylePassword = _passwordFocusNode.hasFocus
          ? TextStyle(
        fontFamily: 'Montserrat_Light',
        color: Colors.white,
        fontSize: 12,
      )
          : TextStyle(
        fontFamily: 'Montserrat_Light',
        color: Colors.white,
        fontSize: 12,
      );*/
    });
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
              value.data!.vehicleCreate!.customerId.toString()+
              "Last Maintenance : "+
              value.data!.vehicleCreate!.lastMaintenance.toString()+
              ">>>>>>>>>");
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Successfully Registered",
                style: TextStyle(fontFamily: 'Roboto_Regular', fontSize: 14)),
            duration: Duration(seconds: 2),
            backgroundColor: CustColors.darkBlue,
          ));
          /*Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const LoginScreen()));*/
          FocusScope.of(context).unfocus();

        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Form(
            autovalidateMode: _autoValidate,
            key: _formKey,
            child: Column(
              children: [
                Center(
                  child: Text(
                    "Add Vehicle",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Text(
                        "Car Brand : ",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton<MakeDetails>(
                            value: value,
                            iconSize: 30,
                            icon: (null),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                            hint: Text("Select Brand"),
                            onChanged: (val) {
                              setState(() {
                                this.value = val;
                                _allModelBloc.postAllModelRequest(
                                    int.parse(val!.id!), token);
                                print(val);
                              });
                            },
                            items: makeDetails!.map(buildMenuItem).toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Text(
                        "Car Model : ",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton<ModelDetails>(
                            value: modelValue,
                            iconSize: 30,
                            icon: (null),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                            hint: Text("Select Model"),
                            onChanged: (modelVal) {
                              setState(() {
                                this.modelValue = modelVal;
                                _allEngineBloc.postAllEngineRequest(
                                    int.parse(modelVal!.id!), token);
                                print(modelVal);
                              });
                            },
                            items: modelDetails!
                                .map((e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(
                                        e.modelName.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ))
                                .toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Text(
                        "Car Engine : ",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton<EngineDetails>(
                            value: engineValue,
                            iconSize: 30,
                            icon: (null),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                            hint: Text("Select Engine"),
                            onChanged: (engineVal) {
                              setState(() {
                                this.engineValue = engineVal;
                                print(engineVal);
                              });
                            },
                              items: engineDetails!
                                  .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(
                                  e.engineName.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ))
                                  .toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Text("Car Year : ",style: TextStyle(fontSize: 18),),),
                    Expanded(
                      flex: 5,
                      child: Container(
                        //margin: const EdgeInsets.only(top: 17, left: 34, right: 34),
                        child: TextFormField(
                          textAlignVertical: TextAlignVertical.center,
                          maxLines: 1,
                          style: TextStyle(
                            fontFamily: 'Montserrat_Semibond',
                            color: Colors.black,
                            fontSize: 15,
                          ),
                          //focusNode: _firstNameFocusNode,
                          keyboardType: TextInputType.number,
                          //validator: InputValidator(ch: "Name").nameChecking,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          controller: _yearController,
                          decoration: InputDecoration(
                              labelText: 'Year',
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: .3,
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 7.8,
                              ),
                              labelStyle: TextStyle(
                                fontFamily: 'Montserrat_Light',
                                color: Colors.black,
                                fontSize: 12,
                              )),
                        ),
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Text("Last Maintenance : ",style: TextStyle(fontSize: 18),),),
                    Expanded(
                      flex: 5,
                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.center,
                        maxLines: 1,
                        style: TextStyle(
                          fontFamily: 'Montserrat_Semibond',
                          color: Colors.black,
                          fontSize: 15,
                        ),
                        //focusNode: _firstNameFocusNode,
                        keyboardType: TextInputType.datetime,
                        //validator: InputValidator(ch: "Name").nameChecking,
                        inputFormatters: [
                          FilteringTextInputFormatter.singleLineFormatter,
                        ],
                        controller: _maintenanceController,
                        decoration: InputDecoration(
                            labelText: 'Maintenance',
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: .3,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 7.8,
                            ),
                            labelStyle: TextStyle(
                              fontFamily: 'Montserrat_Light',
                              color: Colors.black,
                              fontSize: 12,
                            )),
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Text("Car Mileage : ",style: TextStyle(fontSize: 18),),),
                    Expanded(
                      flex: 5,
                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.center,
                        maxLines: 1,
                        style: TextStyle(
                          fontFamily: 'Montserrat_Semibond',
                          color: Colors.black,
                          fontSize: 15,
                        ),
                        //focusNode: _firstNameFocusNode,
                        keyboardType: TextInputType.number,
                        //validator: InputValidator(ch: "Name").nameChecking,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        controller: _mileageController,
                        decoration: InputDecoration(
                            labelText: 'Mileage',
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: .3,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 7.8,
                            ),
                            labelStyle: TextStyle(
                              fontFamily: 'Montserrat_Light',
                              color: Colors.black,
                              fontSize: 12,
                            )),
                      ),
                    ),
                  ],
                ),

                Container(
                  child: _isLoading
                   ? Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          CustColors.darkBlue),
                    ),
                  )
                  : Container(
                      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                      color: Colors.blue,
                      child: MaterialButton(
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
                                /*_userNameController.text,
                                _passwordController.text*/);
                            setState(() {
                              _isLoading = true;
                            });
                          } else {
                            setState(() => _autoValidate =
                                AutovalidateMode.always);
                          }
                        },
                        child: Center(
                          child: Text(
                            "Save",
                            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Colors.white),
                          ),
                        ),
                      ),
                    ),

                ),

                /* Expanded(child: child
                    if (_formKey.currentState!.validate()) {
                        _signinBloc.postSignInRequest(
                        _userNameController.text,
                        _passwordController.text);
                        setState(() {
                        _isLoading = true;
                        });
                        } else {
                        setState(() => _autoValidate =
                        AutovalidateMode.always);
                        }

                )*/
              ],
            ),
          ),
        ),
      ),
    );
  }

  void setIsSignedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(SharedPrefKeys.isDefaultVehicleAvailable, true);
  }

  DropdownMenuItem<MakeDetails> buildMenuItem(MakeDetails item) =>
      DropdownMenuItem(
        value: item,
        child: Text(
          item.makeName.toString(),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      );
}
