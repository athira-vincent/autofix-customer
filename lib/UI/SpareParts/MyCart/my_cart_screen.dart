import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/showcartpopbloc/show_cart_pop_bloc.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/showcartpopbloc/show_cart_pop_state.dart';
import 'package:auto_fix/UI/SpareParts/change_delivery_address_screen.dart';
import 'package:auto_fix/UI/SpareParts/purchase_response_screen.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/ForgotPassword/forgot_password_bloc.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/ForgotPassword/forgot_password_screen.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signin/login_screen.dart';
import 'package:auto_fix/Widgets/curved_bottomsheet_container.dart';
import 'package:auto_fix/Widgets/input_validator.dart';
import 'package:auto_fix/Widgets/screen_size.dart';
import 'package:auto_fix/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'showcartpopbloc/show_cart_pop_event.dart';

class MyCartScreen extends StatefulWidget {
  const MyCartScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MyCartScreenState();
  }
}

class _MyCartScreenState extends State<MyCartScreen> {
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
    return SafeArea(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
            ShowCartPopBloc()..add(FetchShowCartPopEvent()),
          ),
        ],
        child: Scaffold(
            body: ScrollConfiguration(
              behavior: MyBehavior(),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    appBarCustomUi(),
                    productsListUi(),
                    placeOrderUi(),
                    Divider(),
                    changeAddressUi(),
                    Divider(),
                    selectedBillDetailsUi(),
                    Divider(),
                    continueButtonUi(),
                  ],
                ),
              ),
            )),
      ),
    );
  }

  Widget appBarCustomUi() {
    return Row(
      children: const [

        Padding(
          padding: EdgeInsets.all(15),
          child: Text(
            'My Cart',
            textAlign: TextAlign.center,
            style: Styles.appBarTextBlue,
          ),
        ),
        Spacer(),
      ],
    );
  }

  Widget productsListUi() {
    return  BlocBuilder<ShowCartPopBloc,ShowCartPopState>(

      builder: (context, state) {
        if(state is ShowCartPopLoadedState){
          return ListView.builder(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount:state.cartlistmodel.data!.cartList.data.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10,0,10,0),
                    child: Container(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment:MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0,8,0,8),
                              child: Container(
                                height: 60,
                                width: 90,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Image.network(
                                    "",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0,8,0,0),
                                      child: Text(
                                        "Ford fiesta",
                                        style: Styles.sparePartNameSubTextBlack,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0,8,0,0),
                                      child: Text(
                                        state.cartlistmodel.data!.cartList.data[index].product.productName,
                                        style: Styles.sparePartNameTextBlack17,
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.fromLTRB(0,8,0,10),
                                      child: Text(
                                        "",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: Styles.sparePartNameSubTextBlack,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0,0,5,0),
                                      child: InkWell(
                                        onTap: (){

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
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                height: 20,
                                                width: 25,
                                                color: Colors.transparent,
                                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                                alignment: Alignment.topCenter,
                                                child: const Text(
                                                  "-",
                                                  textAlign: TextAlign.start,
                                                  style: Styles.homeNameTextStyle,
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    state.cartlistmodel.data!.cartList.data[index].quantity.toString(),
                                                    textAlign: TextAlign.center,
                                                    style: Styles.homeActiveTextStyle,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: 20,
                                                width: 25,
                                                color: Colors.transparent,
                                                alignment: Alignment.center,
                                                child: const Text(
                                                  "+",
                                                  style: Styles.homeNameTextStyle,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [

                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0,8,0,0),
                                    child: SvgPicture.asset('assets/image/home_customer/deleteMyCart.svg',height: 20,width: 20,),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0,8,0,0),
                                    child:Text(
                                      "\$ "+state.cartlistmodel.data!.cartList.data[index].product.price.toString(),
                                      style: Styles.sparePartNameTextBlack17,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0,8,0,0),
                                    child: Container(
                                      height: 20,
                                      width: 70,
                                      alignment: Alignment.center,
                                      color: CustColors.light_navy,
                                      child: Text(
                                        "Place order",
                                        style: Styles.badgeTextStyle1,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                    ),
                  ),
                  Divider(),

                ],
              );
            },
          );
        }
        else{
          return Container();
        }

      }
    );
  }

  Widget placeOrderUi() {
    return  Padding(
      padding: const EdgeInsets.fromLTRB(10,0,10,0),
      child: Container(
          width: double.infinity,
          child: Container(
            child: Row(
              mainAxisAlignment:MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/image/home_customer/mycartSucessflag.svg',height: 35,width: 35,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment:MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0,0,0,0),
                          child: Text(
                            "Buy all the  products in the cart",
                            style: Styles.sparePartNameTextBlack17,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0,8,0,0),
                        child: Text(
                          "\$ 3000",
                          style: Styles.sparePartNameTextBlack17,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0,8,0,0),
                        child: Container(
                          height: 20,
                          width: 70,
                          alignment: Alignment.center,
                          color: CustColors.light_navy,
                          child: Text(
                            "Place order",
                            style: Styles.badgeTextStyle1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }

  Widget changeAddressUi() {
    return  Padding(
      padding: const EdgeInsets.fromLTRB(10,10,10,10),
      child: Container(
          width: double.infinity,
          child: Row(
            mainAxisAlignment:MainAxisAlignment.start,
            children: [
              SvgPicture.asset(
                'assets/image/home_customer/myCartLocation.svg',height: 30,width: 30,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0,8,0,0),
                        child: Text(
                          "Delivering To: Savannah estate,plot 176",
                          maxLines: 1,
                          style: Styles.sparePartNameTextBlack17,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0,8,0,0),
                        child: Row(
                          children: [
                            Flexible(
                              child: Text(
                                "Beside oando filling station.",
                                style: Styles.sparePartNameTextBlack17,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2),
                              child: Container(
                                height: 20,
                                width: 45,
                                decoration: BoxDecoration(
                                    color: CustColors.roseText1,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: Text(
                                    "Work",
                                    style: Styles.sparePartNameTextBlack17,
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
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0,0,5,0),
                      child: InkWell(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChangeDeliveryAddressScreen()));
                        },
                        child: Container(
                          height: 25,
                          width: 60,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: CustColors.light_navy),
                              borderRadius: BorderRadius.circular(4)
                          ),
                          child: Text(
                            "Change",
                            style: Styles.homeActiveTextStyle,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
      ),
    );
  }

  Widget selectedBillDetailsUi() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10,10,10,10),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0.0)
        ),
        alignment: Alignment.center,
        child:Padding(
          padding: const EdgeInsets.fromLTRB(0,5,0,5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10,5,10,5),
                child: Container(
                  child: Text('Bill Details',
                    maxLines: 2,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.visible,
                    style: Styles.appBarTextBlack17,
                  ),
                ),
              ),
              Container(
                child: ListView.builder(
                  itemCount:2,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context,index,) {



                    return InkWell(
                      onTap:(){

                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10,5,10,5),
                        child: Container(
                          alignment: Alignment.center,
                          child:Row(
                            children: [
                              Row(
                                children: [
                                  Text('Timing belt replacement',
                                    maxLines: 2,
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.visible,
                                    style: Styles.textLabelTitle_12,
                                  ),
                                ],
                              ),
                              Spacer(),
                              Row(
                                children: [
                                  Text('200',
                                    maxLines: 2,
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.visible,
                                    style: Styles.textLabelTitle_10,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10,5,10,5),
                child: Row(
                  children: [
                    Row(
                      children: [
                        Text('Total price including tax',
                          maxLines: 2,
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.visible,
                          style: Styles.textLabelTitle_12,
                        ),
                      ],
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Text('200',
                          maxLines: 2,
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.visible,
                          style: Styles.textLabelTitle_12,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget continueButtonUi() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20,5,20,10),
          child: Container(
            margin: EdgeInsets.only(top: 5,bottom: 5),
            child: _isLoading
                ? Center(
              child: Container(
                height: _setValue(28),
                width: _setValue(28),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      CustColors.peaGreen),
                ),
              ),
            )
                : Container(

                  child: MaterialButton(
                    onPressed: () {

                      setState(() {

                      });
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PurchaseResponseScreen(isSuccess: false,)));

                    },
                    child: Container(
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Continue',
                            textAlign: TextAlign.center,
                            style: Styles.textButtonLabelSubTitle,
                          ),
                        ],
                      ),
                    ),
                    color: CustColors.materialBlue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            _setValue(10))),
                  ),
                ),
          ),
        ),
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

