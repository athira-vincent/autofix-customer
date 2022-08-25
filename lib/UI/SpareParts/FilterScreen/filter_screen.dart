import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/Models/sort_by_model/sort_by_filter_model.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/ForgotPassword/forgot_password_bloc.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/ForgotPassword/forgot_password_screen.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signin/login_screen.dart';
import 'package:auto_fix/Widgets/curved_bottomsheet_container.dart';
import 'package:auto_fix/Widgets/input_validator.dart';
import 'package:auto_fix/Widgets/screen_size.dart';
import 'package:auto_fix/main.dart';
import 'package:auto_fix/spare_parts_filter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FilterScreen extends StatefulWidget {
  final String modelname;
  const FilterScreen({Key? key, required this.modelname}) : super(key: key);

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
  bool filterstatus=false;

  double per = .10;
  double perfont = .10;

  double _setValue(double value) {
    return value * per + value;
  }

  double _setValueFont(double value) {
    return value * perfont + value;
  }

  bool language_en_ar = true;
  int selectedIndex = -1;
  int selectedpriceIndex = -1;

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

  int sortby=0;
  String startprice="";
  String endprice="";

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _emailFocusNode.removeListener(onFocusChange);
    _forgotPasswordBloc.dispose();
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
    return SafeArea(
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
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Divider(),
                  ),
                  PriceUi(),
                  // const Padding(
                  //   padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  //   child: Divider(),
                  // ),
                  // DiscountUi(),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Divider(),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  ApplyFilterButtonUi(),
                ],
              ),
            ),
          )),
    );
  }

  Widget appBarCustomUi() {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        const Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            'Filter',
            textAlign: TextAlign.center,
            style: Styles.appBarTextBlue,
          ),
        ),
        const Spacer(),
      ],
    );
  }

  Widget SortByUi() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(6, 0, 15, 5),
            child: Text(
              'Sort by',
              style: Styles.textFilterTitle03,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: SizedBox(
              height: 50,
              child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: SortByVariables.items.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 5,
                      childAspectRatio: 1 / 6,
                      crossAxisCount: 2),
                  itemBuilder: (BuildContext context1, index) {
                    return InkWell(
                      onTap: ()async {
                        SharedPreferences shdPre = await SharedPreferences.getInstance();
                        shdPre.remove("filterstatus");
                        setState(() {
                          selectedIndex = index++;
                          print("selectedindex");
                          print(selectedIndex);

                          if(selectedIndex==0){
                            sortby=2;
                          }
                          else if(selectedIndex==1){
                            print("type");
                            print("High to low");
                            sortby=1;
                          }
                          else{
                            sortby=3;
                          }
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 5, bottom: 5),
                        decoration: BoxDecoration(
                            color: selectedIndex == index
                                ? CustColors.light_navy
                                : Colors.white,
                            border: Border.all(
                              color: selectedIndex == index
                                  ? CustColors.light_navy
                                  : CustColors.greyish,
                            ),
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: Text(
                            SortByVariables.items[index].name,
                            style: selectedIndex == index
                                ? Styles.textFilterIncludeTitle_12
                                : Styles.textFilterNotIncludeTitle_12,
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }

  Widget PriceUi() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 5),
            child: Text(
              'Price',
              style: Styles.textFilterTitle03,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: SizedBox(
              height: 60,
              child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: SortByPriceVariables.priceitemsitems.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 6,
                      childAspectRatio: 1 / 5,
                      crossAxisCount: 2),
                  itemBuilder: (BuildContext context1, index2) {
                    return InkWell(
                      onTap: () async{
                        SharedPreferences shdPre = await SharedPreferences.getInstance();
                        shdPre.remove("filterstatus");
                        setState(() {
                          selectedpriceIndex = index2++;
                          print("selectedpriceindex");
                          print(selectedpriceIndex);

                            if(selectedpriceIndex==0){
                              startprice="300";
                              endprice="500";
                            }
                            else if(selectedpriceIndex==1){
                              startprice="300";
                              endprice="2000";
                            }
                            else if(selectedpriceIndex==2){
                              startprice="5000";
                              endprice="7000";
                            }
                            else if(selectedpriceIndex==3){
                              startprice="300";
                              endprice="5000";
                            }
                            else if(selectedpriceIndex==4){
                              startprice="3000";
                              endprice="2000";
                            }
                            else if(selectedpriceIndex==5){
                              startprice="5000";
                              endprice="7000";
                            }
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 5, bottom: 5),
                        decoration: BoxDecoration(
                            color: selectedpriceIndex == index2
                                ? CustColors.light_navy
                                : Colors.white,
                            border: Border.all(
                              color: selectedpriceIndex == index2
                                  ? CustColors.light_navy
                                  : CustColors.greyish,
                            ),
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: Text(
                            SortByPriceVariables.priceitemsitems[index2].price1+"-"+SortByPriceVariables.priceitemsitems[index2].price2,
                            style: selectedpriceIndex == index2
                                ? Styles.textFilterIncludeTitle_12
                                : Styles.textFilterNotIncludeTitle_12,
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }

  Widget DiscountUi() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 5),
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
                    children: [
                      for (int i = 0; i < discountVariables.length; i++)
                        InkWell(
                          onTap: () {
                            setState(() {
                              if (selectedDiscountVariables
                                  .contains(discountVariables[i])) {
                                selectedDiscountVariables
                                    .remove(discountVariables[i]);
                              } else {
                                selectedDiscountVariables
                                    .add(discountVariables[i]);
                              }
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            margin: const EdgeInsets.only(right: 10, bottom: 5),
                            decoration: BoxDecoration(
                                color: selectedDiscountVariables
                                        .contains(discountVariables[i])
                                    ? CustColors.light_navy
                                    : Colors.white,
                                border: Border.all(
                                  color: selectedDiscountVariables
                                          .contains(discountVariables[i])
                                      ? CustColors.light_navy
                                      : CustColors.greyish,
                                ),
                                borderRadius: BorderRadius.circular(20)),
                            child: Text(
                              discountVariables[i],
                              style: selectedDiscountVariables
                                      .contains(discountVariables[i])
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
    );
  }

  Widget ApplyFilterButtonUi() {
    return InkWell(
      onTap: () async{


        if(selectedpriceIndex==-1&&selectedIndex==-1){
          Fluttertoast.showToast(msg: "Select any filter option");
        }
        else{
          filterstatus==true;
          SharedPreferences shpref=await SharedPreferences.getInstance();
          shpref.setString("filterstatus", filterstatus.toString());
            Navigator.push(context,
                MaterialPageRoute(builder: (context) =>  Search_Spare_Parts_Filter(modelname: widget.modelname,fromcost:startprice.toString(),tocost:endprice.toString(),sorting:sortby.toString())));
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          children: [
            const Spacer(),
            Container(
              height: 35,
              width: 130,
              alignment: Alignment.center,
              margin:
                  const EdgeInsets.only(top: 8, bottom: 6, left: 20, right: 20),
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
              child: Text(
                "Apply filter",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Corbel_Bold',
                    fontSize: ScreenSize().setValueFont(14.5),
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
