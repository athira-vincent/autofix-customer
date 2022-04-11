import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/home_Bloc/home_customer_bloc.dart';
import 'package:auto_fix/UI/Customer/SideBar/MyVehicles/CustVehicleListMdl.dart';
import 'package:auto_fix/Widgets/input_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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


  String authToken = "";
  bool _isLoadingPage = false;
  bool _isLoadingButton = false;

  CustVehicleList? custVehicleList;

  final List<String> imageList = [
    "https://firebasestorage.googleapis.com/v0/b/autofix-336509.appspot.com/o/SupportChatImages%2FsparepartImage1.png?alt=media&token=0130eb9b-662e-4c1c-b8a1-f4232cbba284",
    'https://firebasestorage.googleapis.com/v0/b/autofix-336509.appspot.com/o/SupportChatImages%2FsparepartImage2.png?alt=media&token=419e2555-5c26-4295-8201-6c78f1ed563e',
    "https://firebasestorage.googleapis.com/v0/b/autofix-336509.appspot.com/o/SupportChatImages%2FsparepartImage1.png?alt=media&token=0130eb9b-662e-4c1c-b8a1-f4232cbba284",
    'https://firebasestorage.googleapis.com/v0/b/autofix-336509.appspot.com/o/SupportChatImages%2FsparepartImage2.png?alt=media&token=419e2555-5c26-4295-8201-6c78f1ed563e',
  ];

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
    print('getSharedPrefData');
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    setState(() {
      authToken = shdPre.getString(SharedPrefKeys.token).toString();
      print('userFamilyId'+authToken.toString());

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

          custVehicleList = value.data?.custVehicleList?[0];
          _brandController.text = '${custVehicleList?.brand.toString()}';
          _modelController.text = '${custVehicleList?.model.toString()}';
          _engineTypeController.text = '${custVehicleList?.engine.toString()}';
          _yearController.text = '${custVehicleList?.year.toString()}';
          _lastMaintenanceController.text = '${custVehicleList?.lastMaintenance.toString()}';

          print("message postServiceList >>>>>>>  ${value.message}");
          print("sucess postServiceList >>>>>>>  ${value.status}");

        });
      }
    });
  }




  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
                                      CustColors.peaGreen),
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
                                                color: CustColors.blue,
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft: Radius.circular(15),
                                                  bottomRight: Radius.circular(15),
                                                ),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.fromLTRB(0,0,0,20),
                                                child: Column(
                                                  children: [
                                                    appBarCustomUi(snapshot),
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
                  /*Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0,0,0,0),
                        child: Container(
                            decoration: BoxDecoration(
                                color: CustColors.blue,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0,0,0,20),
                              child: Column(
                                children: [
                                  appBarCustomUi(),
                                  mainBodyUi(),
                                ],
                              ),
                            )
                        ),
                      ),
                      SubMainBodyUi(),
                    ],
                  ),*/
                  Visibility(
                    visible: _isLoadingPage,
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              CustColors.peaGreen),
                        ),
                      ),
                    ),
                  ),
                ],
              )
          ),
        ),
      ),
    );
  }


  Widget appBarCustomUi(AsyncSnapshot<CustVehicleListMdl> snapshot) {
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
                'Your Cars',
                textAlign: TextAlign.center,
                style: Styles.badgeTextStyle1,
              ),
            ),
          ],
        ),
        Container(
          height: 150,
          margin: EdgeInsets.all(0),
          child: ListView.builder(
            itemCount: snapshot.data?.data?.custVehicleList?.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, i, ){
              //for onTap to redirect to another screen
              return Padding(
                padding: const EdgeInsets.all(5),
                child: InkWell(
                  child: Column(
                    children: [
                      Container(
                        height: 130,
                        width: 130,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: snapshot.data?.data?.custVehicleList?[i].id == custVehicleList?.id ? Colors.white : Colors.transparent,)
                        ),
                        //ClipRRect for image border radius
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child:  snapshot.data?.data?.custVehicleList?[i].vehiclePic != null && snapshot.data?.data?.custVehicleList?[i].vehiclePic.trim() !=""
                              ? FadeInImage.assetNetwork(
                                  placeholder: 'assets/images/DummyChildRoundG1.png',
                                  image:'${snapshot.data?.data?.custVehicleList?[i].vehiclePic}',
                                  fit: BoxFit.cover,
                                )
                              :Image.asset(
                                'assets/images/DummyChildRoundG1.png',
                                fit: BoxFit.fill,
                              ),
                        ),
                      ),
                    ],
                  ),
                  onTap: (){
                    setState(() {
                      custVehicleList = snapshot.data?.data?.custVehicleList?[i];
                      _brandController.text = '${custVehicleList?.brand.toString()}';
                      _modelController.text = '${custVehicleList?.model.toString()}';
                      _engineTypeController.text = '${custVehicleList?.engine.toString()}';
                      _yearController.text = '${custVehicleList?.year.toString()}';
                      _lastMaintenanceController.text = '${custVehicleList?.lastMaintenance.toString()}';
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
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Your Default Vehicle',
                textAlign: TextAlign.center,
                style: Styles.badgeTextStyle1,
              ),
            ),
          ],
        ),

        Padding(
          padding: const EdgeInsets.fromLTRB(15,20,15,20),
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
                    deafultVechicleDetailsUi(custVehicleList!),
                  ],
                ),
              )
          ),
        ),
      ],
    );
  }

  Widget deafultVechicleDetailsUi(CustVehicleList custVehicleList) {
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
              child: Image.network(
                custVehicleList.vehiclePic,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  custVehicleList.model,
                  maxLines: 1,
                  textAlign: TextAlign.start,
                  style: Styles.appBarTextWhite,
                ),
                Text(
                  custVehicleList.brand,
                  maxLines: 1,
                  textAlign: TextAlign.start,
                  style: Styles.appBarTextWhite,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 50,
              width: 1,
              color: Colors.white,
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  custVehicleList.lastMaintenance,
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  style: Styles.appBarTextWhite,
                ),
                Text(
                  custVehicleList.year,
                  maxLines: 1,
                  textAlign: TextAlign.start,
                  style: Styles.appBarTextWhite,
                ),
              ],
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
                left: 20, right: 20,top:20, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: CustColors.pale_grey,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0),
                      ),
                    ),
                    child: Padding(
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
                  ),
                ],
              ),
            )
        ),
      ],
    );
  }

  Widget brandTextSelection(AsyncSnapshot<CustVehicleListMdl> snapshot) {
    return  Container(
      margin: EdgeInsets.only(top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Brand",
                  style: Styles.textLabelTitle,
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
      margin: EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Model",
                  style: Styles.textLabelTitle,
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
      margin: EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(

            "Select Engine Type",
            style: Styles.textLabelTitle,
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
      margin: EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(

            "Select Year",
            style: Styles.textLabelTitle,
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
      margin: EdgeInsets.only(top: 20,bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Last maintenance",
            style: Styles.textLabelTitle,
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


}
