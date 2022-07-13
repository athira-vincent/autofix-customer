import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/UI/Mechanic/SideBar/MyWallet/my_wallet_bloc.dart';
import 'package:auto_fix/UI/Mechanic/SideBar/MyWallet/my_wallet_mdl.dart';
import 'package:auto_fix/Widgets/snackbar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MechanicMyWalletScreen extends StatefulWidget {

  MechanicMyWalletScreen();

  @override
  State<StatefulWidget> createState() {
    return _MechanicMyWalletScreenState();
  }
}

class _MechanicMyWalletScreenState extends State<MechanicMyWalletScreen> {

  String authToken = "" ;
  MechanicMyWalletBloc _mechanicWalletBloc = MechanicMyWalletBloc();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late MechanicMyWalletMdl mechanicMyWalletMdl;
  //BookingDatum? _BookingDatum;
  List<BookingDatum>? _BookingDatum=[];
  MyWallet? _MyWallet;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPrefData();
    _listenApiResponse();
  }

  Future<void> getSharedPrefData() async {
    print('getSharedPrefData');
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    setState(() {
      authToken = shdPre.getString(SharedPrefKeys.token).toString();
      print('userFamilyId ' + authToken.toString());
     //print('userId ' + userId.toString());
      _mechanicWalletBloc.postMechanicFetchMyWalletRequest(authToken, "");
    });
  }

  _listenApiResponse() {
    _mechanicWalletBloc.postMechanicMyWallet.listen((value) {
      if(value.status == "error"){
        setState(() {
          //_isLoading = false;
         // SnackBarWidget().setMaterialSnackBar(value.message.toString(),_scaffoldKey);
        });
      }else{
        setState(() {
          _BookingDatum = value.data!.myWallet!.bookingData;
          //_MyWallet = value.data!.myWallet;
          _MyWallet = value.data!.myWallet;
          //mechanicMyWalletMdl = value;
          //SnackBarWidget().setMaterialSnackBar(value.data!.mechanicWorkStatusUpdate!.message.toString(),_scaffoldKey);
          /*_isLoading = false;
          _signinBloc.userDefault(value.data!.socialLogin!.token.toString());*/
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
          child: Container(
            height: size.height,
            width: size.width,
            //color: Colors.blue,
            child: SingleChildScrollView(
              child: Container(
                child: Stack(
                  children: [
                    BottomLightBackground(size),
                    
                    Column(
                      children: [
                        appBarCustomUi(size),
                        profileImageAndWalletTotal(),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0,12,0,0),
                          child: Container(
                            height: 120,
                            margin: EdgeInsets.only(
                              left: size.width * 9 / 100,
                              right: size.width * 9 / 100,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SubTitleTextRound(size,"Total job done",_MyWallet!.jobCount.toString()),
                                SubTitleTextRound(size,"All payments",_MyWallet!.totalPayment.toString()),
                                SubTitleTextRound(size,"Monthly collection",_MyWallet!.monthlySum.toString()),
                              ],
                            ),
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.only(
                           //top: size.height * .2 / 100,
                            bottom: size.width * .2 / 100,
                          ),
                          child: Row(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                    margin: EdgeInsets.only(
                                      top: size.height * 1.5 / 100,
                                      left: size.width * 9 / 100,
                                      right: size.width * 9 / 100,
                                    ),
                                    child: Text("Todays payments",
                                      style: Styles.myWalletTitleText03,)
                                ),
                              ),
                              Spacer(),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                    margin: EdgeInsets.only(
                                      top: size.height * 1.5 / 100,
                                     //left: size.width * 9 / 100,
                                      right: size.width * 10.5 / 100,
                                    ),
                                    child: Text(
                                      _MyWallet!.totalPayment.toString(),
                                      //"- ₦ 15000",
                                      style: Styles.myWalletTitleText04,)
                                ),
                              ),
                            ],
                          ),
                        ),

                        // listTileItem(size,
                        //     _BookingDatum![0].customer!.firstName,
                        //     _BookingDatum![0].bookedTime,
                        //     _BookingDatum![0].serviceCharge.toString()),
                        // //Spacer(),
                        // listTileItem(size,
                        //     _BookingDatum![0].customer!.firstName,
                        //     _BookingDatum![0].bookedTime,
                        //     _BookingDatum![0].serviceCharge.toString()),
                        //
                        // listTileItem(size,
                        //     _BookingDatum![0].customer!.firstName,
                        //     _BookingDatum![0].bookedTime,
                        //     _BookingDatum![0].serviceCharge.toString()),
                        // listTileItem(size,
                        //     "John Carlo","11:30","₦ 5000"),
                        ListView.builder(
                          shrinkWrap: true,
                        itemCount: _BookingDatum!.length,
                        itemBuilder: (BuildContext context, int index) {
                            return Container(
                              child: listTileItem(size,
                                  '${_BookingDatum![0].customer!.firstName}',
                                   '${_BookingDatum![0].bookedTime}',
                                  '${_BookingDatum![0].serviceCharge.toString()}'),
                            );
                        }
                        ),

                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget appBarCustomUi(Size size) {
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        Text(
          'My Wallet',
          textAlign: TextAlign.center,
          style: Styles.appBarTextBlue,
        ),
        Spacer(),
      ],
    );
  }

  Widget profileImageAndWalletTotal() {
    return Wrap(
      children: [
        Container(
          height: 292,
          width: 500,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8,26,8,0),
                child: Container(
                  child: ClipRRect(
                    //borderRadius: BorderRadius.circular(20.0),
                    child:Container(
                        child:
                        // Image.network(
                        //     _BookingDatum![0].mechanic!.mechanic![0].profilePic)
                        Image.asset('assets/image/bg_wallet.png')
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(0,0,0,0),
                child: Wrap(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0,0,0,0),
                        child: Container(
                          width: 120.0,
                          height: 120.0,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child:Container(
                                  child:CircleAvatar(
                                      radius: 75,
                                      backgroundColor: Colors.white,
                                      child: ClipOval(
                                        child:
                                        //SvgPicture.asset('assets/image/MechanicType/work_selection_avathar.svg'),
                                        Image.network(
                                            _BookingDatum![0].mechanic!.mechanic![0].profilePic,
                                        fit: BoxFit.fill,
                                        )
                                      )))
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 29,
                            right: 33
                        ),
                        child: Container(
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child:Container(
                                child:Container(
                                    child: Text("Your balance ",
                                      style: Styles.myWalletCardText02,)
                                ),
                              )

                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(
                            top: 16,
                            right: 33
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child:Container(
                            child:Padding(
                              padding: const EdgeInsets.only(left: 100.0),
                              child: Container(
                                  child: Row(
                                    children:[
                                      Text("₦ ",
                                        style: Styles.myWalletCardText01,),
                                      Text('${_MyWallet!.totalPayment}',
                                        style: Styles.myWalletCardText01,)
                           ]
                              ),
                              ),
                            ),
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
    );
  }

  Widget BottomLightBackground(Size size) {
    return Container(
      height: MediaQuery.of(context).size.height*.70,
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height*.28,
        left: size.width * 4 / 100,
        right: size.width * 4 / 100,
      ),
      child: Padding(
          padding: EdgeInsets.only(bottom: size.height * 3 / 100 ),
          child: Container(
            height: size.height * 70 /100,
            //height: MediaQuery.of(context).size.height * double.parse(widget.percentage.toString()),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
               Radius.circular(10),
              ),
              //color: CustColors.blackishgrey,
              color: CustColors.whiteBlueish,
            ),
          )
      ),
    );
  }

  Widget SubTitleTextRound(Size size,String titleText,String circleText) {
    return  Container(
      height: size.height * 20 / 100,
      width: size.width * 20 / 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              margin : EdgeInsets.only(
                  top: 2,
                  left: 2,
                  right: 2,
                  bottom: 0
              ),
              child: Text(titleText,
              textAlign: TextAlign.center,
              style: Styles.myWalletSubTitleTextRoundText01,)),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0,5,0,0),
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.white,
                child: Text(
                  circleText,
                  textAlign: TextAlign.center,
                  style: Styles.myWalletSubTitleTextRoundText02,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget listTileItem(Size size, String customerName, String time, String amount){
    return Container(
      padding: EdgeInsets.only(
          top: size.height * 1 / 100,
          bottom: size.height * 1 / 100,
      ),
      margin: EdgeInsets.only(
        left: size.width * 8 / 100,
        right: size.width * 8 / 100,
      ),
      child: Container(
        padding: EdgeInsets.only(
            top: size.height * 1.8 / 100,
            bottom: size.height * 1.8 / 100,
            right: size.width * 2.5 / 100,
            left: size.width * 2.5 / 100
        ),
        margin: EdgeInsets.only(
          left: size.width * 1.2 / 100,
          right: size.width * 1.2 / 100,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(6),
            ),
            color: Colors.white
        ),
        //color: CustColors.white_02,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text("Customer",style: Styles.myWalletListTileTitle01,),
                SizedBox(
                  height: size.height * .7 / 100,
                ),
                Text(customerName,style: Styles.myWalletListTileTitle02,),
              ],
            ),

            Column(
              children: [
                Text("Time",style: Styles.myWalletListTileTitle01,),
                SizedBox(
                  height: size.height * .7 / 100,
                ),
                Text(time,style: Styles.myWalletListTileTitle02,),
              ],
            ),

            Container(
              child: Text(
                amount,style: Styles.myWalletListTileTitle03,
              ),
            )

          ],
        ),
      ),

    );

  }

}
