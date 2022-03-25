import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/ForgotPassword/CreatePasswordScreen/create_password_screen.dart';
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

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FilterScreenState();
  }
}

class _FilterScreenState extends State<FilterScreen> {
  FocusNode _emailFocusNode = FocusNode();
  TextStyle _labelStyleEmail = const TextStyle();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  final ForgotPasswordBloc _forgotPasswordBloc = ForgotPasswordBloc();
  bool _isLoading = false;

  double per = .10;
  double perfont = .10;
  double _setValue(double value) {
    return value * per + value;
  }

  double _setValueFont(double value) {
    return value * perfont + value;
  }
  bool language_en_ar=true;


  List<String> sortByVariables = [
    "Price: Low to high",
    "Price: High to Low",
    "New arrivals",
  ];

  List<String> selectedSortByVariables = [];

  List<String> priceVariables = [
    "\$300 - \$500",
    "\$300 - \$2000",
    "\$5000- \$7000",
    "\$300 - \$5000",
    "\$3000 - \$2000",
    "\$5000- \$7000",
  ];

  List<String> selectedPriceVariables = [];

  List<String> discountVariables = [
    "10% Off",
    "20% Off",
    "25% Off",
    "30% Off",
    "40% Off",
    "50% Off",
    "60% Off",
    "70% Off",
  ];

  List<String> selectedDiscountVariables = [];


  @override
  void initState() {
    super.initState();
    _getForgotPwd();
  }

  @override
  void dispose() {
    super.dispose();
    _emailFocusNode.removeListener(onFocusChange);
    _forgotPasswordBloc.dispose();
  }

  _getForgotPwd() {
    _forgotPasswordBloc.postForgotPassword.listen((value) {
      if (value.status == "error") {
        setState(() {
          _isLoading = false;
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
          _isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Password Reset Enabled.\nCheck Your mail",
                style: TextStyle(fontFamily: 'Roboto_Regular', fontSize: 14)),
            duration: Duration(seconds: 2),
            backgroundColor: CustColors.peaGreen,
          ));

          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const LoginScreen()));
          FocusScope.of(context).unfocus();
        });
      }
    });
  }

  void onFocusChange() {
    setState(() {
      _labelStyleEmail = _emailFocusNode.hasFocus
          ? const TextStyle(color: CustColors.peaGreen)
          : const TextStyle(color: Color.fromARGB(52, 3, 43, 80));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: ScrollConfiguration(
              behavior: MyBehavior(),
              child: SingleChildScrollView(
                // ignore: avoid_unnecessary_containers
                child: Column(
                  children: [
                    appBarCustomUi(),

                    SortByUi(),

                    PriceUi(),

                    DiscountUi(),

                    SizedBox(height: 30,),

                    ApplyFilterButtonUi(),


                  ],
                ),
              ),
            )),
      ),
    );
  }

  Widget appBarCustomUi() {
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            'Filter',
            textAlign: TextAlign.center,
            style: Styles.appBarTextBlue,
          ),
        ),
        Spacer(),
      ],
    );
  }

  Widget SortByUi() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10,5,10,5),
        child: Column(
          mainAxisAlignment:MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15,0,15,5),
              child: Text(
                'Sort by',
                style: Styles.textFilterTitle03,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                controller: ScrollController(),
                child: Padding(
                  padding: const EdgeInsets.all(1),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Wrap(
                      direction: Axis.horizontal,
                      spacing: 1.0,
                      runSpacing: 1.0,
                      runAlignment: WrapAlignment.spaceEvenly,
                      children:  [
                        for(int i=0;i<sortByVariables.length;i++)
                          InkWell(
                            onTap: (){
                              setState(() {
                                if(selectedSortByVariables.contains('${sortByVariables[i]}'))
                                  {
                                    selectedSortByVariables.remove('${sortByVariables[i]}');
                                  }
                                else
                                  {
                                    selectedSortByVariables.add('${sortByVariables[i]}');
                                  }

                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              margin: EdgeInsets.only(right: 10, bottom: 10),
                              decoration: BoxDecoration(
                                color: selectedSortByVariables.contains('${sortByVariables[i]}')
                                    ? CustColors.light_navy
                                    : Colors.white,
                                  border: Border.all(
                                    color: selectedSortByVariables.contains('${sortByVariables[i]}')
                                        ? CustColors.light_navy
                                        : CustColors.greyish,
                                  ),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Text(
                                '${sortByVariables[i]}',
                                style: selectedSortByVariables.contains('${sortByVariables[i]}')
                                ? Styles.textFilterIncludeTitle_12
                                : Styles.textFilterNotIncludeTitle_12,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget PriceUi() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10,5,10,5),
        child: Column(
          mainAxisAlignment:MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15,0,15,5),
              child: Text(
                'Price',
                style: Styles.textFilterTitle03,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                controller: ScrollController(),
                child: Padding(
                  padding: const EdgeInsets.all(1),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Wrap(
                      direction: Axis.horizontal,
                      spacing: 1.0,
                      runSpacing: 1.0,
                      runAlignment: WrapAlignment.spaceEvenly,
                      children:  [
                        for(int i=0;i<priceVariables.length;i++)
                          InkWell(
                            onTap: (){
                              setState(() {
                                if(selectedPriceVariables.contains('${priceVariables[i]}'))
                                {
                                  selectedPriceVariables.remove('${priceVariables[i]}');
                                }
                                else
                                {
                                  selectedPriceVariables.add('${priceVariables[i]}');
                                }

                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              margin: EdgeInsets.only(right: 10, bottom: 10),
                              decoration: BoxDecoration(
                                  color: selectedPriceVariables.contains('${priceVariables[i]}')
                                      ? CustColors.light_navy
                                      : Colors.white,
                                  border: Border.all(
                                    color: selectedPriceVariables.contains('${priceVariables[i]}')
                                        ? CustColors.light_navy
                                        : CustColors.greyish,
                                  ),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Text(
                                '${priceVariables[i]}',
                                style: selectedPriceVariables.contains('${priceVariables[i]}')
                                    ? Styles.textFilterIncludeTitle_12
                                    : Styles.textFilterNotIncludeTitle_12,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget DiscountUi() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10,5,10,5),
        child: Column(
          mainAxisAlignment:MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15,0,15,5),
              child: Text(
                'Discount',
                style: Styles.textFilterTitle03,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                controller: ScrollController(),
                child: Padding(
                  padding: const EdgeInsets.all(1),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Wrap(
                      direction: Axis.horizontal,
                      spacing: 1.0,
                      runSpacing: 1.0,
                      runAlignment: WrapAlignment.spaceEvenly,
                      children:  [
                        for(int i=0;i<discountVariables.length;i++)
                          InkWell(
                            onTap: (){
                              setState(() {
                                if(selectedDiscountVariables.contains('${discountVariables[i]}'))
                                {
                                  selectedDiscountVariables.remove('${discountVariables[i]}');
                                }
                                else
                                {
                                  selectedDiscountVariables.add('${discountVariables[i]}');
                                }

                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              margin: EdgeInsets.only(right: 10, bottom: 10),
                              decoration: BoxDecoration(
                                  color: selectedDiscountVariables.contains('${discountVariables[i]}')
                                      ? CustColors.light_navy
                                      : Colors.white,
                                  border: Border.all(
                                    color: selectedDiscountVariables.contains('${discountVariables[i]}')
                                        ? CustColors.light_navy
                                        : CustColors.greyish,
                                  ),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Text(
                                '${discountVariables[i]}',
                                style: selectedDiscountVariables.contains('${discountVariables[i]}')
                                    ? Styles.textFilterIncludeTitle_12
                                    : Styles.textFilterNotIncludeTitle_12,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget ApplyFilterButtonUi() {
    return InkWell(
      onTap: (){

        print("$selectedSortByVariables");
        print("$selectedPriceVariables");
        print("$selectedDiscountVariables");

      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          children: [
            Spacer(),
            Container(
              height: 35,
              width:130,
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 8, bottom: 6,left: 20,right: 20),
              //padding: EdgeInsets.only(left: 20, right: 20),
              decoration: BoxDecoration(
                color: CustColors.light_navy,
                border: Border.all(
                  color: CustColors.blue,
                  style: BorderStyle.solid,
                  width: 0.70,
                ),
                borderRadius: BorderRadius.circular(7),
              ),
              child:  Text(
                "Apply filter",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Corbel_Bold',
                    fontSize:
                    ScreenSize().setValueFont(14.5),
                    fontWeight: FontWeight.w800),
              ),
            ),
          ],
        ),
      ),
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

