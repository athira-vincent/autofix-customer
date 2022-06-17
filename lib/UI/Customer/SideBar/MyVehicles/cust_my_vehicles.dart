import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/Constants/text_strings.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/home_Bloc/home_customer_bloc.dart';
import 'package:auto_fix/UI/Customer/SideBar/MyVehicles/CustVehicleListMdl.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Customer/add_car_bloc.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/CompleteProfile/Customer/add_car_screen.dart';
import 'package:auto_fix/Widgets/input_validator.dart';
import 'package:auto_fix/Widgets/snackbar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerMyVehicleScreen extends StatefulWidget {

  CustomerMyVehicleScreen();

  @override
  State<StatefulWidget> createState() {
    return _CustomerMyVehicleScreenState();
  }
}

class _CustomerMyVehicleScreenState extends State<CustomerMyVehicleScreen> {

  final HomeCustomerBloc _homeCustomerBloc = HomeCustomerBloc();
  final AddCarBloc _addCarBloc = AddCarBloc();



  String authToken = "",userID="";
  bool _isLoadingPage = false;
  bool _isDefaultLoading = false;

  bool _isLoadingButton = false;

  CustVehicleList? custVehicleListDefaultValue;
  CustVehicleList? custVehicleList;

  final List<String> imageList = [
    "https://firebasestorage.googleapis.com/v0/b/autofix-336509.appspot.com/o/SupportChatImages%2FsparepartImage1.png?alt=media&token=0130eb9b-662e-4c1c-b8a1-f4232cbba284",
    'https://firebasestorage.googleapis.com/v0/b/autofix-336509.appspot.com/o/SupportChatImages%2FsparepartImage2.png?alt=media&token=419e2555-5c26-4295-8201-6c78f1ed563e',
    "https://firebasestorage.googleapis.com/v0/b/autofix-336509.appspot.com/o/SupportChatImages%2FsparepartImage1.png?alt=media&token=0130eb9b-662e-4c1c-b8a1-f4232cbba284",
    'https://firebasestorage.googleapis.com/v0/b/autofix-336509.appspot.com/o/SupportChatImages%2FsparepartImage2.png?alt=media&token=419e2555-5c26-4295-8201-6c78f1ed563e',
  ];
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;

  TextEditingController _brandController = TextEditingController();
  FocusNode _brandFocusNode = FocusNode();

  TextEditingController _modelController = TextEditingController();
  FocusNode _modelFocusNode = FocusNode();

  TextEditingController _engineTypeController = TextEditingController();
  FocusNode _engineTypeFocusNode = FocusNode();

  TextEditingController _yearController = TextEditingController();
  FocusNode _yearControllerFocusNode = FocusNode();

  TextEditingController _lastMaintenanceController = TextEditingController();
  FocusNode _lastMaintenanceFocusNode = FocusNode();




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPrefData();
    _listenServiceListResponse();


  }

  Future<void> getSharedPrefData() async {
    print('getSharedPrefData CustomerMyVehicleScreen');
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    setState(() {
      authToken = shdPre.getString(SharedPrefKeys.token).toString();
      userID = shdPre.getString(SharedPrefKeys.userID).toString();
      print('userFamilyId CustomerMyVehicleScreen'+authToken.toString());
      print('userID CustomerMyVehicleScreen'+userID.toString());
      _homeCustomerBloc.postCustVehicleListRequest(authToken);

    });
  }

  _listenServiceListResponse() {
    _homeCustomerBloc.postCustVehicleListResponse.listen((value) {
      if (value.status == "error") {
        setState(() {
          print("message postServiceList >>>>>>>  ${value.message}");
          print("errrrorr postServiceList >>>>>>>  ${value.status}");
        });

      } else {

        setState(() {

          for(int i = 0; i<int.parse('${value.data?.custVehicleList?.length}'); i++)
            {
              if(value.data?.custVehicleList?[i].defaultVehicle.toString() == "1")
                {
                  custVehicleListDefaultValue = value.data?.custVehicleList?[i];
                  print("sucess postServiceList >>>>>>>  ${custVehicleListDefaultValue}");

                }
            }

          _brandController.text = '${custVehicleListDefaultValue?.brand.toString()}';
          _modelController.text = '${custVehicleListDefaultValue?.model.toString()}';
          _engineTypeController.text = '${custVehicleListDefaultValue?.engine.toString()}';
          _yearController.text = '${custVehicleListDefaultValue?.year.toString()}';
          _lastMaintenanceController.text = '${custVehicleListDefaultValue?.lastMaintenance.toString()}';

          print("message postServiceList >>>>>>>  ${value.message}");
          print("sucess postServiceList >>>>>>>  ${value.status}");

        });
      }
    });
    _addCarBloc.updateDefaultVehicleResponse.listen((value) {
      if (value.status == "error") {
        setState(() {
          _isDefaultLoading = false;

          print("message postServiceList >>>>>>>  ${value.message}");
          print("errrrorr postServiceList >>>>>>>  ${value.status}");
        });

      } else {

        setState(() {
          _isDefaultLoading = false;
          SnackBarWidget().setMaterialSnackBar( "Vehicle set as default", _scaffoldKey);
          print("message postServiceList >>>>>>>  ${value.message}");
          print("sucess postServiceList >>>>>>>  ${value.status}");

        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: AppBar(
                automaticallyImplyLeading: false,
                flexibleSpace: appBarCustomUi(),
                elevation: 0,
                backgroundColor: CustColors.light_navy,
            ),
          ),
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
                child: Stack(
                  children: [
                    StreamBuilder(
                        stream:  _homeCustomerBloc.postCustVehicleListResponse,
                        builder: (context, AsyncSnapshot<CustVehicleListMdl> snapshot) {
                          print("${snapshot.hasData}");
                          print("${snapshot.connectionState}");
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return Align(
                                alignment: Alignment.center,
                                child: Container(
                                  height: MediaQuery.of(context).size.height,
                                  alignment: Alignment.center,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        CustColors.light_navy),
                                  ),
                                ),
                              );
                            default:
                              return
                                snapshot.data?.data?.custVehicleList?.length != 0 && snapshot.data?.data?.custVehicleList?.length != null
                                    ? Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(0,0,0,0),
                                            child: Container(
                                                decoration: BoxDecoration(
                                                  color: CustColors.light_navy,
                                                  borderRadius: BorderRadius.only(
                                                    bottomLeft: Radius.circular(15),
                                                    bottomRight: Radius.circular(15),
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.fromLTRB(5,0,0,20),
                                                  child: Column(
                                                    children: [
                                                      mainBodyUi(snapshot),
                                                    ],
                                                  ),
                                                )
                                            ),
                                          ),
                                          SubMainBodyUi(snapshot),
                                        ],
                                      )
                                    : Container();
                          }
                        }
                    ),
                    Visibility(
                      visible: _isLoadingPage,
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                CustColors.light_navy),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(5),
            child: FloatingActionButton(
              // isExtended: true,
              child: Icon(Icons.add),
              backgroundColor: CustColors.materialBlue,
              onPressed: () {
                setState(() {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => AddCarScreen(userCategory:"1" ,userType: TextStrings.user_customer,fromPage: "2",))
                  ).then((value) {
                    getSharedPrefData();
                  });
                });
              },
            ),
          ),
        ),

      );
  }



  Widget appBarCustomUi() {
    return Stack(
      children: [
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            Text(
              'My Vechicles',
              textAlign: TextAlign.center,
              style: Styles.appBarTextWhite,
            ),
            Spacer(),

          ],
        ),
      ],
    );
  }

  Widget mainBodyUi(AsyncSnapshot<CustVehicleListMdl> snapshot) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Your cars',
                textAlign: TextAlign.center,
                style: Styles.myVechicleYourCarTextStyle,
              ),
            ),
          ],
        ),
        Container(
          height: 150,
          child: ListView.builder(
            itemCount: snapshot.data?.data?.custVehicleList?.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, i, ){
              //for onTap to redirect to another screen
              return Padding(
                padding: const EdgeInsets.all(5),
                child: InkWell(
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      Container(
                        height: 120,
                        width: 130,
                        alignment: Alignment.centerLeft,
                        child: Column(
                          children: [
                            Container(
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(23),
                                  border: Border.all(
                                    color: snapshot.data?.data?.custVehicleList?[i].id == custVehicleListDefaultValue?.id
                                        ? Colors.white
                                        : Colors.transparent,
                                    width: 2,)
                              ),
                              //ClipRRect for image border radius
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: snapshot.data?.data?.custVehicleList?[i].vehiclePic != ""
                                    ? FadeInImage.assetNetwork(
                                        placeholder: 'assets/image/CustomerType/dummyCar.png',
                                        image:'${snapshot.data?.data?.custVehicleList?[i].vehiclePic}',
                                        fit: BoxFit.fill,
                                      )
                                    :  Container(
                                        color: Colors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.all(25),
                                          child: SvgPicture.asset(
                                              'assets/image/CustomerType/dummyCar00.svg',
                                              fit: BoxFit.contain,
                                            ),
                                        ),
                                    )
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 65,
                        child: InkWell(
                          onTap: (){
                            setState(() {
                              print('delete vechicle');

                              if(int.parse('${snapshot.data?.data?.custVehicleList?.length.toString()}') > 1)
                                {
                                  if(snapshot.data?.data?.custVehicleList?[i].defaultVehicle == 1)
                                    {
                                      SnackBarWidget().setMaterialSnackBar( "Default vehicle can't be deleted", _scaffoldKey);

                                    }
                                  else
                                    {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context)
                                          {
                                            return deleteVehicleDialog(i,snapshot.data?.data?.custVehicleList);
                                          });
                                    }

                                }
                              else
                                {


                                }
                            });
                          },
                          child: Container(
                            width: 25,
                            height: 25,
                            child: SvgPicture.asset(
                              'assets/image/CustomerType/myvehicleDelete.svg',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  onTap: (){
                    setState(() {
                      print('>>>>>>>>>>${snapshot.data?.data?.custVehicleList?[i].vehiclePic.toString()}>>>>>>>');
                      custVehicleList = snapshot.data?.data?.custVehicleList?[i];
                      _brandController.text = '${snapshot.data?.data?.custVehicleList?[i].brand.toString()}';
                      _modelController.text = '${snapshot.data?.data?.custVehicleList?[i].model.toString()}';
                      _engineTypeController.text = '${snapshot.data?.data?.custVehicleList?[i].engine.toString()}';
                      _yearController.text = '${snapshot.data?.data?.custVehicleList?[i].year.toString()}';
                      _lastMaintenanceController.text = '${snapshot.data?.data?.custVehicleList?[i].lastMaintenance.toString()}';
                    });
                  },
                ),
              );
            },
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15,0,15,0),
              child: Text(
                'Your Default Vehicle',
                textAlign: TextAlign.center,
                style: Styles.myVechicleYourCarTextStyle,
              ),
            ),
          ],
        ),

        Padding(
          padding: const EdgeInsets.fromLTRB(15,15,15,15),
          child: Container(
              decoration: BoxDecoration(
                color: CustColors.blueLight,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15),
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0,0,0,0),
                child: Column(
                  children: [
                    deafultVechicleDetailsUi(custVehicleListDefaultValue!),
                  ],
                ),
              )
          ),
        ),
      ],
    );
  }

  Widget deafultVechicleDetailsUi(CustVehicleList custVehicleListDefaultValue) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color:Colors.transparent )
            ),
            //ClipRRect for image border radius
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child:  '${custVehicleListDefaultValue.vehiclePic}' != null && '${custVehicleListDefaultValue.vehiclePic}' != ""
                  ? FadeInImage.assetNetwork(
                      placeholder: 'assets/image/CustomerType/dummyCar.png',
                      image:'${custVehicleListDefaultValue.vehiclePic}',
                      fit: BoxFit.fill,
                    )
                  : Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: SvgPicture.asset(
                          'assets/image/CustomerType/dummyCar00.svg',
                          fit: BoxFit.contain,
                        ),
                      ),
                    )
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(25,0,0,0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    custVehicleListDefaultValue.model,
                    maxLines: 1,
                    textAlign: TextAlign.start,
                    style: Styles.myVechicleDetailsTextStyle,
                  ),
                  Text(
                    custVehicleListDefaultValue.brand,
                    maxLines: 1,
                    textAlign: TextAlign.start,
                    style: Styles.myVechicleDetailsTextStyle,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8,8,30,8),
            child: Container(
              height: 50,
              width: 1,
              color: Colors.white,
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0,0,0,0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    custVehicleListDefaultValue.lastMaintenance,
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    style: Styles.myVechicleDetailsTextStyle,
                  ),
                  Text(
                    custVehicleListDefaultValue.year,
                    maxLines: 1,
                    textAlign: TextAlign.start,
                    style: Styles.myVechicleDetailsTextStyle,
                  ),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }

  Widget SubMainBodyUi(AsyncSnapshot<CustVehicleListMdl> snapshot) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Form(
            autovalidateMode: _autoValidate,
            key: _formKey,
            child: Container(
              margin: EdgeInsets.only(
                left: 25, right: 25,top:20, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:EdgeInsets.only(
                        left: 0, right: 0,top:20, bottom: 20),
                    child: Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Selected vehicle details",
                            style: Styles.MyVechiclesSubTitleBlue,
                          ),

                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: CustColors.pale_grey,
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            children: [

                              brandTextSelection(snapshot),
                              modelTextSelection(snapshot),
                              engineTypeTextSelection(snapshot),
                              yearTypeTextSelection(snapshot),
                              lastMaintenanceTextSelection(snapshot),

                            ],
                          ),
                        ),
                        setAsDefaultLife(snapshot),
                      ],
                    ),
                  ),
                ],
              ),
            )
        ),
        SizedBox(height: 50,)
      ],
    );
  }

  Widget brandTextSelection(AsyncSnapshot<CustVehicleListMdl> snapshot) {
    return  Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Brand",
                  style: Styles.MyVechiclesSubTitle,
                ),
                Spacer(),

              ],
            ),
          ),
          TextFormField(
            textAlignVertical: TextAlignVertical.center,
            maxLines: 1,
            style: Styles.textLabelSubTitle,
            focusNode: _brandFocusNode,
            enabled: false,
            keyboardType: TextInputType.name,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                  RegExp('[a-zA-Z ]')),
            ],
            validator: InputValidator(
                ch : 'Brand name' ).nameCheckingWithNumeric,
            controller: _brandController,
            cursorColor: CustColors.whiteBlueish,
            decoration: InputDecoration(
              isDense: true,
              hintText:
              "",
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
              errorStyle: Styles.textLabelSubTitleRed,
              hintStyle: Styles.textLabelSubTitle,),
          ),
        ],
      ),
    );
  }

  Widget modelTextSelection(AsyncSnapshot<CustVehicleListMdl> snapshot) {
    return  Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Model",
                  style: Styles.MyVechiclesSubTitle,
                ),
                Spacer(),

              ],
            ),
          ),
          TextFormField(
            textAlignVertical: TextAlignVertical.center,
            maxLines: 1,
            style: Styles.textLabelSubTitle,
            focusNode: _modelFocusNode,
            keyboardType: TextInputType.name,
            enabled: false,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                  RegExp('[a-zA-Z ]')),
            ],
            validator: InputValidator(
                ch :
                'Model name'  ).nameCheckingWithNumeric,
            controller: _modelController,
            cursorColor: CustColors.whiteBlueish,
            decoration: InputDecoration(
              isDense: true,
              hintText:
              "",
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
              errorStyle: Styles.textLabelSubTitleRed,
              hintStyle: Styles.textLabelSubTitle,),
          ),
        ],
      ),
    );
  }

  Widget engineTypeTextSelection(AsyncSnapshot<CustVehicleListMdl> snapshot) {
    return  Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(

            "Select Engine Type",
            style: Styles.MyVechiclesSubTitle,
          ),
          TextFormField(
            textAlignVertical: TextAlignVertical.center,
            maxLines: 1,
            style: Styles.textLabelSubTitle,
            focusNode: _engineTypeFocusNode,
            enabled: false,
            keyboardType: TextInputType.name,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                  RegExp('[a-zA-Z ]')),
            ],
            validator: InputValidator(
                ch :
                'Engine Type' ).nameCheckingWithNumericAndBracket,
            controller: _engineTypeController,
            cursorColor: CustColors.whiteBlueish,
            decoration: InputDecoration(
              isDense: true,
              hintText:
              "",
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
              errorStyle: Styles.textLabelSubTitleRed,
              hintStyle: Styles.textLabelSubTitle,),
          ),
        ],
      ),
    );
  }

  Widget yearTypeTextSelection(AsyncSnapshot<CustVehicleListMdl> snapshot) {
    return  Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(

            "Select Year",
            style: Styles.MyVechiclesSubTitle,
          ),
          TextFormField(
            textAlignVertical: TextAlignVertical.center,
            maxLines: 1,
            style: Styles.textLabelSubTitle,
            focusNode: _yearControllerFocusNode,
            keyboardType: TextInputType.name,
            enabled: false,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                  RegExp('[a-zA-Z ]')),
            ],
            validator: InputValidator(
                ch :
                'Year' ).nameCheckingWithNumeric,
            controller: _yearController,
            cursorColor: CustColors.whiteBlueish,
            decoration: InputDecoration(
              isDense: true,
              hintText:
              "",
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
              errorStyle: Styles.textLabelSubTitleRed,
              hintStyle: Styles.textLabelSubTitle,),
          ),
        ],
      ),
    );
  }

  Widget lastMaintenanceTextSelection(AsyncSnapshot<CustVehicleListMdl> snapshot) {
    return  Container(
      margin: EdgeInsets.only(top: 10,bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Last maintenance",
            style: Styles.MyVechiclesSubTitle,
          ),
          TextFormField(
            textAlignVertical: TextAlignVertical.center,
            maxLines: 1,
            style: Styles.textLabelSubTitle,
            focusNode: _lastMaintenanceFocusNode,
            keyboardType: TextInputType.name,
            enabled: false,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                  RegExp('[a-zA-Z ]')),
            ],
            validator: InputValidator(
                ch :
                'Last maintenance date' ).nameCheckingWithNumeric,
            controller: _lastMaintenanceController,
            cursorColor: CustColors.whiteBlueish,
            decoration: InputDecoration(
              isDense: true,
              hintText:
              "",
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
              errorStyle: Styles.textLabelSubTitleRed,
              hintStyle: Styles.textLabelSubTitle,),
          ),
        ],
      ),
    );
  }

  Widget setAsDefaultLife(AsyncSnapshot<CustVehicleListMdl> snapshot) {
    return  InkWell(
      onTap: (){
        setState(() {
          if(int.parse('${snapshot.data?.data?.custVehicleList?.length.toString()}') > 1)
          {
            _isDefaultLoading = true;


            _addCarBloc.postUpdateDefaultVehicleApi(
                authToken,custVehicleListDefaultValue?.id, userID);
            if(custVehicleList?.id != null)
              {
                custVehicleListDefaultValue = custVehicleList;

                for(int i=0 ; i<int.parse('${snapshot.data?.data?.custVehicleList!.length.toString()}');i++)
                  {
                    if(custVehicleListDefaultValue?.id.toString() == snapshot.data?.data?.custVehicleList?[i].id)
                    {
                      snapshot.data?.data?.custVehicleList?[i].defaultVehicle = 1;
                    }
                    else
                      {
                        snapshot.data?.data?.custVehicleList?[i].defaultVehicle = 0;

                      }
                  }
              }
          }
                    else
          {
            _isDefaultLoading = false;

          }

        });
      },
      child:
      _isDefaultLoading == true
      ? Center(
        child: Container(
          height: 30,
          width: 30,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
                CustColors.light_navy),
          ),
        ),
      )
      : Container(
        width: double.infinity,
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: CustColors.light_navy,
          borderRadius: BorderRadius.only(
            bottomRight:Radius.circular(15),
            bottomLeft:Radius.circular(15),

          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15,0,15,0),
          child: Text(
            'Set as default vehicle',
            textAlign: TextAlign.center,
            style: Styles.myVechicleYourCarTextStyle,
          ),
        ),
      ),
    );
  }

  Widget deleteVehicleDialog(int i, List<CustVehicleList>? custVehicleList) {
    return CupertinoAlertDialog(
      title: Text("Delete vehicle?",
          style: TextStyle(
            fontFamily: 'Formular',
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: CustColors.materialBlue,
          )),
      content: Text("Are you sure you want to delete?"),
      actions: <Widget>[
        CupertinoDialogAction(
            textStyle: TextStyle(
              color: CustColors.rusty_red,
              fontWeight: FontWeight.normal,
            ),
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancel")),
        CupertinoDialogAction(
            textStyle: TextStyle(
              color: CustColors.rusty_red,
              fontWeight: FontWeight.normal,
            ),
            isDefaultAction: true,
            onPressed: () async {
              setState(() {
                _addCarBloc.postVechicleUpdateRequest(
                    authToken, custVehicleList?[i].id,
                    "0");
                custVehicleList?.removeAt(i);
                Navigator.pop(context);

              });
            },
            child: Text("Delete")),
      ],
    );
  }


}

class MyBehavior extends ScrollBehavior {


  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
