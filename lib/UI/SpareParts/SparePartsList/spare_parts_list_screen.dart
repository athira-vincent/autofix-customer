import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/UI/SpareParts/FilterScreen/filter_screen.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/my_cart_screen.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/ForgotPassword/forgot_password_bloc.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/ForgotPassword/forgot_password_screen.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signin/login_screen.dart';
import 'package:auto_fix/Widgets/curved_bottomsheet_container.dart';
import 'package:auto_fix/Widgets/input_validator.dart';
import 'package:auto_fix/Widgets/screen_size.dart';
import 'package:auto_fix/main.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SparePartsListScreen extends StatefulWidget {
  const SparePartsListScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SparePartsListScreenState();
  }
}

class _SparePartsListScreenState extends State<SparePartsListScreen> {


  double per = .10;
  double perfont = .10;
  double _setValue(double value) {
    return value * per + value;
  }
  double _setValueFont(double value) {
    return value * perfont + value;
  }
  bool addToCart=false;

  TextEditingController searchController = new TextEditingController();
  StateSetter? setStateSearch;


  @override
  void initState() {
    super.initState();
    _getForgotPwd();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _getForgotPwd() {

  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Column(
                  children: [
                    appBarCustomUi(),
                    SparePartsListUi(),
                  ],
                ),
                addToCart==false
                ? Container()
                : ViewCartUi(),
              ],
            )),
      ),
    );
  }

  Widget appBarCustomUi() {
    return Row(
      children: [
        /*IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),*/
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            'Ford Fiesta',
            textAlign: TextAlign.center,
            style: Styles.appBarTextBlue,
          ),
        ),
        Spacer(),
        IconButton(
          icon: SvgPicture.asset(
            'assets/image/home_customer/filterSearch.svg',height: 20,width: 20,
          ),
          onPressed: () {

            _showModal(context);
          },
        ),
        IconButton(
          icon: SvgPicture.asset(
            'assets/image/home_customer/filterIcon.svg',height: 20,width: 20,
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  FilterScreen()));

          },
        ),
      ],
    );
  }

  Widget SparePartsListUi() {
    return Container(
      child: Expanded(
        child: GridView.builder(
          itemCount:8,
          shrinkWrap: true,
          controller: new ScrollController(keepScrollOffset: false),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
              childAspectRatio:0.7
          ),
          itemBuilder: (context,index,) {
            return Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: CustColors.greyText1),
                  borderRadius: BorderRadius.circular(0)
              ),
              child: Column(
                mainAxisAlignment:MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 100,
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.network(
                          "https://firebasestorage.googleapis.com/v0/b/autofix-336509.appspot.com/o/SupportChatImages%2FsparepartImage1.png?alt=media&token=0130eb9b-662e-4c1c-b8a1-f4232cbba284",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0,2,0,0),
                          child: Text(
                            "Clutch assembly",
                            style: Styles.sparePartNameTextBlack17,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0,8,0,0),
                          child: Text(
                            "A2137635123. | Ford fiesta fort",
                            style: Styles.sparePartNameSubTextBlack,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0,8,0,0),
                          child: Container(
                            height: 20,
                            width: 50,
                            alignment: Alignment.center,
                            color: CustColors.light_navy,
                            child: Text(
                              "5% OFF",
                              style: Styles.badgeTextStyle1,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0,8,0,0),
                          child: Text(
                            "\$ 3000",
                            style: Styles.sparePartOrginalPriceSubTextBlack,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0,8,0,0),
                          child: Row(
                            children: [
                              Text(
                                "\$ 3000",
                                style: Styles.sparePartOfferPriceSubTextBlack,
                              ),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0,0,5,0),
                                child: InkWell(
                                  onTap: (){
                                    print('gdfh');
                                    setState(() {
                                      addToCart = true;
                                    });
                                  },
                                  child: Container(
                                    height: 20,
                                    width: 70,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(color: CustColors.greyText3),
                                        borderRadius: BorderRadius.circular(4)
                                    ),
                                    child: Text(
                                      "+ Add to cart",
                                      style: Styles.homeActiveTextStyle,
                                    ),
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
            );
          },
        ),
      ),
    );
  }


  Widget ViewCartUi() {
    return InkWell(
      onTap: (){
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>  MyCartScreen()));
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8,8,8,8),
        child: Container(
          height: 65,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: CustColors.light_navy,
              border: Border.all(color:  CustColors.light_navy,),
              borderRadius: BorderRadius.circular(10)
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(25,0,25,0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "1 items",
                      style: Styles.addToCartItemText02,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0,8,0,0),
                      child: Text(
                        "\$ 3000",
                        style: Styles.addToCartItemText02,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Text(
                  "View Cart >",
                  style: Styles.addToCartText02,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showModal(context) {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(0.0)),
        ),
        context: context,
        builder: (context) {
          //3
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                setStateSearch = setState;
                return Container(
                  height: MediaQuery.of(context).size.height * .85,
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 35,
                            child:  TextField(
                              controller: searchController,
                              autofocus: true,
                              decoration: InputDecoration(
                                hintText: 'Search spare parts for your vehicle',
                                contentPadding: EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 5.0),
                                prefixIcon:  Icon(Icons.search_rounded, color: CustColors.light_navy),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: CustColors.whiteBlueish),
                                    borderRadius: BorderRadius.circular(0.0)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: CustColors.whiteBlueish),
                                    borderRadius: BorderRadius.circular(0.0)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: CustColors.whiteBlueish),
                                    borderRadius: BorderRadius.circular(0.0)),
                                disabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: CustColors.whiteBlueish),
                                    borderRadius: BorderRadius.circular(0.0)),
                                errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: CustColors.whiteBlueish),
                                    borderRadius: BorderRadius.circular(0.0)),

                              ),
                              onChanged: (text) {

                                if (text != null && text.isNotEmpty && text != "" ) {


                                }

                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
        });
  }



}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

