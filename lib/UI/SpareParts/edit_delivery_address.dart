import 'package:auto_fix/UI/SpareParts/MyCart/edit_address_bloc/edit_address_bloc.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/edit_address_bloc/edit_address_event.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/edit_address_bloc/edit_address_state.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signup/CityList/city_list_screen.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signup/StatesList/states_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/Models/customer_models/type_address_model/type_address_model.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/add_address_bloc/add_address_bloc.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/add_address_bloc/add_address_event.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/add_address_bloc/add_address_state.dart';
import 'package:auto_fix/Widgets/input_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Edit_Delivery_Address extends StatefulWidget {
  final String fullname,
      phone,
      pincode,
      city,
      state,
      addressline1,
      addressline2,
      type,
      addressid;
  final int isDefault;

  const Edit_Delivery_Address(
      {Key? key,
      required this.fullname,
      required this.phone,
      required this.pincode,
      required this.city,
      required this.state,
      required this.addressline1,
      required this.addressline2,
      required this.type,
      required this.addressid,
        required this.isDefault})
      : super(key: key);

  @override
  State<Edit_Delivery_Address> createState() => _Edit_Delivery_AddressState();
}

class _Edit_Delivery_AddressState extends State<Edit_Delivery_Address> {
  int selectedIndex = -1;
  final Geolocator geolocator = Geolocator();
  String location = '';
  String Address = '';
  String displayAddress = '';
  String states = '';
  String addressline1 = '';
  String addressline2 = '';
  String type = "";
  TextEditingController namecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController pincontroller = TextEditingController();
  TextEditingController localitycontroller = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  FocusNode _localityFocusNode = FocusNode();

  bool value = false;
  String selectedState = "", selectedCity = "" ;
  int isDefault = 0;

  @override
  void initState() {
    namecontroller.text = widget.fullname;
    phonecontroller.text = widget.phone;
    pincontroller.text = widget.pincode;
    _stateController.text = widget.state;
    _cityController.text = widget.city;
    isDefault = widget.isDefault;
    print("isdefault");
    print(isDefault);
    if (widget.addressline1.isEmpty || widget.addressline2.isEmpty) {
      localitycontroller.text = widget.city;
    } else {
      localitycontroller.text = widget.addressline1 + widget.addressline2;
    }

    setState(() {
      if (widget.type == "Home") {
        selectedIndex = 0;
        type = "Home";
      } else if (widget.type == "Work") {
        type = "Work";
        selectedIndex = 1;
      } else {
        type = "Other";
        selectedIndex = 2;
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: MultiBlocListener(
        listeners: [
          BlocListener<EditAddressBloc, EditAddressState>(
            listener: (context, state) {
              if (state is EditAddressLoadedState) {
                if (state.addaddressModel.data!.addAddress.status ==
                    "Success") {
                  Fluttertoast.showToast(msg: "Updated Address successfully");
                  // final addresslistBloc = BlocProvider.of<AddressBloc>(context);
                  // addresslistBloc.add(FetchAddressEvent());
                }
              }
            },
          ),
        ],
        child: Scaffold(
          //resizeToAvoidBottomInset: false,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              appBarCustomUi(size),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                    left: size.width * 5 / 100,
                    right: size.width * 5 / 100,
                    top: size.height * 2 / 100,
                    bottom: size.height * 2 / 100,
                  ),
                  child: locationForm(size),
                ),
              ),
              InkWell(
                  onTap: () async {
                    print("on tap saveAddress");

                    final editaddressBloc =
                        BlocProvider.of<EditAddressBloc>(context);
                    editaddressBloc.add(FetchEditAddressEvent(
                        namecontroller.text,
                        phonecontroller.text,
                        pincontroller.text,
                        localitycontroller.text,
                        states,
                        addressline1,
                        addressline2,
                        type,
                        isDefault.toString(),
                        widget.addressid));
                  },
                  child: saveAddressButton(size))
            ],
          ),
        ),
      ),
    );
  }

  Widget appBarCustomUi(Size size) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              //Radius.circular(8),
              ),
          border: Border.all(color: CustColors.almost_black, width: 0.3)),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: CustColors.warm_grey03),
            onPressed: () => Navigator.pop(context),
          ),
          const Text(
            'Address ',
            textAlign: TextAlign.center,
            style: Styles.appBarTextBlue,
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Widget useMyLocationButton(Size size) {
    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: () async {
          Position position = await _getGeoLocationPosition();

          _getGeoLocationPosition();
          GetAddressFromLatLong(position);
          print("noelf");
        },
        child: Container(
          decoration: const BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(6),
              ),
              color: CustColors.light_navy),
          padding: EdgeInsets.only(
            left: size.width * 3 / 100,
            right: size.width * 3 / 100,
            //top: size.height * .5 / 100,
            //bottom: size.height * .5 / 100,
          ),
          child: Row(
            children: [
              Container(
                  margin: EdgeInsets.only(right: size.width * 1.5 / 100),
                  width: size.width * 4 / 100,
                  height: size.height * 4 / 100,
                  child: SvgPicture.asset(
                    "assets/image/ic_zoom_location.svg",
                  )),
              const Text(
                "Use my location",
                style: TextStyle(
                  fontSize: 14.3,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Samsung_SharpSans_Medium",
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget addressTypeOptions(Size size, String text, String imagePath) {
    return Container(
      decoration: boxDecorationStyle,
      padding: EdgeInsets.only(
        left: size.width * 3 / 100,
        right: size.width * 3 / 100,
        top: size.height * 1 / 100,
        bottom: size.height * 1 / 100,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            margin: EdgeInsets.only(right: size.width * 1 / 100),
            child: SvgPicture.asset(
              imagePath,
              height: size.height * 2.3 / 100,
              width: size.width * 2.3 / 100,
            ),
          ),
          Text(
            text,
            style: hintTextStyle,
          )
        ],
      ),
    );
  }

  Widget locationForm(Size size) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Name",
            style: hintTextStyle,
          ),
          Container(
            margin: EdgeInsets.only(
              top: size.height * 1.7 / 100,
              bottom: size.height * 1.7 / 100,
            ),
            decoration: boxDecorationStyle,
            child: TextFormField(
              controller: namecontroller,
              textAlignVertical: TextAlignVertical.center,
              maxLines: 1,
              style: Styles.textLabelSubTitle,
              // focusNode: _nameFocusNode,
              keyboardType: TextInputType.name,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
              ],
              validator: InputValidator(ch: "Name").nameChecking,
              //controller: _nameController,
              cursorColor: CustColors.whiteBlueish,
              decoration: const InputDecoration(
                isDense: true,
                //hintText:  "name",
                border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: CustColors.greyish,
                    width: .5,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: CustColors.greyish,
                    width: .5,
                  ),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: CustColors.greyish,
                    width: .5,
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 12.8,
                  horizontal: 0.0,
                ),
                hintStyle: Styles.textLabelSubTitle,
              ),
            ),
          ),

          Text(
            "Phone number",
            style: hintTextStyle,
          ),
          Container(
            margin: EdgeInsets.only(
              top: size.height * 1.7 / 100,
              bottom: size.height * 1.7 / 100,
            ),
            decoration: boxDecorationStyle,
            child: TextFormField(
              controller: phonecontroller,
              textAlignVertical: TextAlignVertical.center,
              maxLines: 1,
              style: Styles.textLabelSubTitle,
              // focusNode: _nameFocusNode,
              keyboardType: TextInputType.phone,

              validator: InputValidator(ch: "Phone").phoneNumChecking,
              //controller: _nameController,
              cursorColor: CustColors.whiteBlueish,
              decoration: const InputDecoration(
                isDense: true,
                // hintText:  "phone",
                border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: CustColors.greyish,
                    width: .5,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: CustColors.greyish,
                    width: .5,
                  ),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: CustColors.greyish,
                    width: .5,
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 12.8,
                  horizontal: 0.0,
                ),
                hintStyle: Styles.textLabelSubTitle,
              ),
            ),
          ),

          Text(
            "Locality", //Locality
            style: hintTextStyle,
          ),
          Container(
            margin: EdgeInsets.only(
              top: size.height * 1.7 / 100,
              bottom: size.height * 1.7 / 100,
            ),
            decoration: boxDecorationStyle,
            child: TextFormField(
              controller: localitycontroller,
              textAlignVertical: TextAlignVertical.center,
              maxLines: 1,
              style: Styles.textLabelSubTitle,
              focusNode: _localityFocusNode,
              keyboardType: TextInputType.name,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
              ],
              validator: InputValidator(ch: "Locality").phoneNumChecking, //Phone
              cursorColor: CustColors.materialBlue,
              decoration: const InputDecoration(
                isDense: true,
                // hintText:  "phone",
                border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: CustColors.greyish,
                    width: .5,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: CustColors.greyish,
                    width: .5,
                  ),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: CustColors.greyish,
                    width: .5,
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 12.8,
                  horizontal: 5.0,
                ),
                hintStyle: Styles.textLabelSubTitle,
              ),
            ),
          ),

          Text(
            "City", //"City"
            style: hintTextStyle,
          ),
          InkWell(
            onTap: (){
              _localityFocusNode.unfocus();
              _awaitCityReturnValueFromSecondScreen(context);
            },
            child: Container(
              margin: EdgeInsets.only(
                top: size.height * 1.7 / 100,
                bottom: size.height * 1.7 / 100,
              ),
              decoration: boxDecorationStyle,
              child: TextFormField(
                enabled: false,
                readOnly: true,
                controller: _cityController,
                textAlignVertical: TextAlignVertical.center,
                maxLines: 1,
                style: Styles.textLabelSubTitle,
                // focusNode: _nameFocusNode,
                keyboardType: TextInputType.name,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
                ],

                validator: InputValidator(ch: "State").emptyChecking, //"State"
                cursorColor: CustColors.whiteBlueish,
                decoration: const InputDecoration(
                  isDense: true,
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: CustColors.greyish,
                      width: .5,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: CustColors.greyish,
                      width: .5,
                    ),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: CustColors.greyish,
                      width: .5,
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 12.8,
                    horizontal: 0.0,
                  ),
                  hintStyle: Styles.textLabelSubTitle,
                ),
              ),
            ),
          ),

          Text(
            "State",
            style: hintTextStyle,
          ),
          InkWell(
            onTap: (){
              _awaitStateReturnValueFromSecondScreen(context);
            },
            child: Container(
              margin: EdgeInsets.only(
                top: size.height * 1.7 / 100,
                bottom: size.height * 1.7 / 100,
              ),
              decoration: boxDecorationStyle,
              child: TextFormField(
                enabled: false,
                readOnly: true,
                controller: _stateController,
                textAlignVertical: TextAlignVertical.center,
                maxLines: 1,
                style: Styles.textLabelSubTitle,
                // focusNode: _nameFocusNode,
                keyboardType: TextInputType.name,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
                ],

                validator: InputValidator(ch: "State").emptyChecking, //"State"
                cursorColor: CustColors.whiteBlueish,
                decoration: const InputDecoration(
                  isDense: true,
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: CustColors.greyish,
                      width: .5,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: CustColors.greyish,
                      width: .5,
                    ),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: CustColors.greyish,
                      width: .5,
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 12.8,
                    horizontal: 0.0,
                  ),
                  hintStyle: Styles.textLabelSubTitle,
                ),
              ),
            ),
          ),

          Text(
            "Pincode ",
            style: hintTextStyle,
          ),
          Container(
            margin: EdgeInsets.only(
              top: size.height * 1.7 / 100,
              bottom: size.height * 1.7 / 100,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Container(
                    decoration: boxDecorationStyle,
                    child: TextFormField(
                      controller: pincontroller,
                      textAlignVertical: TextAlignVertical.center,
                      maxLines: 1,
                      style: Styles.textLabelSubTitle,
                      // focusNode: _nameFocusNode,
                      keyboardType: TextInputType.phone,
                      validator: InputValidator(ch: "Pincode").phoneNumChecking,
                      //controller: _nameController,
                      cursorColor: CustColors.whiteBlueish,
                      decoration: const InputDecoration(
                        isDense: true,
                        // hintText:  "PinCode",
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: CustColors.greyish,
                            width: .5,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: CustColors.greyish,
                            width: .5,
                          ),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: CustColors.greyish,
                            width: .5,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 12.8,
                          horizontal: 0.0,
                        ),
                        hintStyle: Styles.textLabelSubTitle,
                      ),
                    ),
                  ),
                ),
                // SizedBox(
                //   width: size.width * 8 / 100,
                // ),
                // useMyLocationButton(size),
              ],
            ),
          ),

          Text(
            "Type of address",
            style: hintTextStyle,
          ),
          Container(
              margin: EdgeInsets.only(
                top: size.height * 1.7 / 100,
                bottom: size.height * 1.7 / 100,
              ),
              child:
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Flexible(
                  //         child: addressTypeOptions(
                  //             size, "Home", "assets/image/ic_home_outline.svg")),
                  //     SizedBox(
                  //       width: size.width * 1.5 / 100,
                  //     ),
                  //     Flexible(
                  //         child: addressTypeOptions(
                  //             size, "Work", "assets/image/ic_work_outline.svg")),
                  //     SizedBox(
                  //       width: size.width * 1.5 / 100,
                  //     ),
                  //     Flexible(
                  //         child: addressTypeOptions(
                  //             size, "Other", "assets/image/ic_location_outline.svg")),
                  //   ],
                  // ),

                  SizedBox(
                height: 30,
                child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: TypeAddressModel.items.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 8,
                        childAspectRatio: 1 / 3,
                        crossAxisCount: 1),
                    itemBuilder: (BuildContext context1, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            selectedIndex = index++;
                            if (selectedIndex == 0) {
                              type = "Home";
                            } else if (selectedIndex == 1) {
                              type = "Work";
                            } else {
                              type = "Other";
                            }
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                            left: size.width * 3 / 100,
                            right: size.width * 3 / 100,
                            top: size.height * 1 / 100,
                            bottom: size.height * 1 / 100,
                          ),
                          decoration: BoxDecoration(
                              color: selectedIndex == index
                                  ? CustColors.light_navy
                                  : Colors.white,
                              border: Border.all(color: CustColors.light_navy),
                              borderRadius: BorderRadius.circular(4)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                margin:
                                    EdgeInsets.only(right: size.width * 1 / 100),
                                child: SvgPicture.asset(
                                  TypeAddressModel.items[index].image,
                                  height: size.height * 2.3 / 100,
                                  width: size.width * 2.3 / 100,
                                  color: selectedIndex == index
                                      ? Colors.white
                                      : null,
                                ),
                              ),
                              Text(
                                TypeAddressModel.items[index].name,
                                style: TextStyle(
                                    fontSize: 10,
                                    fontFamily: "Samsung_SharpSans_Regular",
                                    fontWeight: FontWeight.w400,
                                    color: selectedIndex == index
                                        ? Colors.white
                                        : Colors.black),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              )),

          Row(
            children: [
              Text("Make this as default address : ", style: hintTextStyle),
              Checkbox(
                value: value == true || isDefault == 1 ? true : false,
                onChanged: (value) {
                  setState(() {
                    this.value = value!;

                    if (value == true) {
                      isDefault = 1;
                    } else {
                      isDefault = 2;
                    }
                  });
                },
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget saveAddressButton(Size size) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(6),
            ),
            color: CustColors.light_navy),
        padding: EdgeInsets.only(
          left: size.width * 3 / 100,
          right: size.width * 3 / 100,
          top: size.height * .9 / 100,
          bottom: size.height * .9 / 100,
        ),
        margin: EdgeInsets.only(
          right: size.width * 6 / 100,
          bottom: size.height * 3.6 / 100,
        ),
        child: const Text(
          "Save address",
          style: TextStyle(
            fontSize: 14.3,
            fontWeight: FontWeight.w600,
            fontFamily: "Samsung_SharpSans_Medium",
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  BoxDecoration boxDecorationStyle = BoxDecoration(
      borderRadius: const BorderRadius.all(
        Radius.circular(8),
      ),
      border: Border.all(color: CustColors.greyish, width: 0.3));

  TextStyle hintTextStyle = const TextStyle(
      fontSize: 10,
      fontFamily: "Samsung_SharpSans_Regular",
      fontWeight: FontWeight.w400,
      color: Colors.black);

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<void> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    Address =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    setState(() {
      localitycontroller.text = place.locality.toString();
      pincontroller.text = place.postalCode.toString();

      states = place.administrativeArea.toString();
      addressline1 = place.administrativeArea.toString() +
          place.subAdministrativeArea.toString() +
          place.locality.toString();
      addressline2 = place.street.toString();
    });
  }

  void _awaitCityReturnValueFromSecondScreen(BuildContext context) async {
    // start the SecondScreen and wait for it to finish with a result
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SelectCityScreen(),
        ));
    setState(() {
      selectedCity = result;
      _cityController.text = selectedCity;
      print("Selected state @ sign up: " + selectedCity);
    });
  }

  void _awaitStateReturnValueFromSecondScreen(BuildContext context) async {
    // start the SecondScreen and wait for it to finish with a result
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SelectStatesScreen(),
        ));
    setState(() {
      selectedState = result;
      _stateController.text = selectedState;
      print("Selected state @ sign up: " + selectedState);
    });
  }

}
