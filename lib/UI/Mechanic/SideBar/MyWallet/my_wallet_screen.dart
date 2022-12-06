import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/UI/Mechanic/SideBar/MyWallet/my_wallet_bloc.dart';
import 'package:auto_fix/UI/Mechanic/SideBar/MyWallet/my_wallet_mdl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'wallet_history.dart';

class MechanicMyWalletScreen extends StatefulWidget {
  MechanicMyWalletScreen();

  @override
  State<StatefulWidget> createState() {
    return _MechanicMyWalletScreenState();
  }
}

class _MechanicMyWalletScreenState extends State<MechanicMyWalletScreen> {
  String authToken = "", mechanicId = "", profileUrl = "";

  MechanicMyWalletBloc _mechanicWalletBloc = MechanicMyWalletBloc();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late MechanicMyWalletMdl mechanicMyWalletMdl;
  List<TodaysPayment>? _BookingDatum = [];
  MyWallet? _myWalletDaily, _myWalletWeekly, _myWalletMonthly;
  bool _isLoadingPage = true;

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
      mechanicId = shdPre.getString(SharedPrefKeys.userID).toString();
      profileUrl = shdPre.getString(SharedPrefKeys.profileImageUrl).toString();
      print('userFamilyId ' + authToken.toString());
      print('userId ' + mechanicId.toString());
      _mechanicWalletBloc.postMechanicFetchMyWalletDailyRequest(
          authToken, mechanicId, "1", "");
      _mechanicWalletBloc.postMechanicFetchMyWalletWeeklyRequest(
          authToken, mechanicId, "2", "");
      _mechanicWalletBloc.postMechanicFetchMyWalletMonthlyRequest(
          authToken, mechanicId, "3", "");

    });
  }

  _listenApiResponse() {
    _mechanicWalletBloc.MechanicMyWalletDailyResponse.listen((value) {
      if (value.status == "error") {
        setState(() {
          _isLoadingPage = false;
        });
      } else {
        setState(() {
          _isLoadingPage = false;
          _BookingDatum = value.data!.myWallet!.todaysPayments;
          _myWalletDaily = value.data!.myWallet;
        });
      }
    });
    _mechanicWalletBloc.MechanicMyWalletWeeklyResponse.listen((value) {
      if (value.status == "error") {
        /*setState(() {
          _isLoadingPage = false;
        });*/
      } else {
        setState(() {
          //_isLoadingPage = false;
          //_BookingDatum = value.data!.myWallet!.todaysPayments;
          _myWalletWeekly = value.data!.myWallet;
        });
      }
    });
    _mechanicWalletBloc.MechanicMyWalletMonthlyResponse.listen((value) {
      if (value.status == "error") {
        /*setState(() {
          _isLoadingPage = false;
        });*/
      } else {
        setState(() {
          //_isLoadingPage = false;
          //_BookingDatum = value.data!.myWallet!.todaysPayments;
          _myWalletMonthly = value.data!.myWallet;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: _isLoadingPage == true
            ? const Center(
                child: CircularProgressIndicator(
                  color: CustColors.light_navy,
                ),
              )
            : SizedBox(
                height: size.height,
                width: size.width,
                //color: Colors.blue,
                child: SingleChildScrollView(
                  child: Stack(
                    children: [
                      BottomLightBackground(size),
                      Column(
                        children: [
                          appBarCustomUi(size),
                          profileImageAndWalletTotal(),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                            child: Container(
                              height: 120,
                              margin: EdgeInsets.only(
                                left: size.width * 9 / 100,
                                right: size.width * 9 / 100,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SubTitleTextRound(
                                      size,
                                      "Daily Collection",
                                      _myWalletDaily?.totalAmount.toString()??"0"),
                                  SubTitleTextRound(
                                      size,
                                      "Weekly Collection",
                                      _myWalletWeekly?.totalAmount.toString()??"0"),
                                  SubTitleTextRound(
                                      size,
                                      "Monthly collection",
                                      _myWalletMonthly?.totalAmount.toString()??"0"),
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
                                      child: const Text(
                                        "Today's payments",
                                        style: Styles.myWalletTitleText03,
                                      )),
                                ),
                                const Spacer(),
                                // Align(
                                //   alignment: Alignment.centerRight,
                                //   child: Container(
                                //       margin: EdgeInsets.only(
                                //         top: size.height * 1.5 / 100,
                                //         //left: size.width * 9 / 100,
                                //         right: size.width * 10.5 / 100,
                                //       ),
                                //       child: Text(
                                //         _myWalletDaily?.balance.toString()??"0",
                                //         //"- ₦ 15000",
                                //         style: Styles.myWalletTitleText04,
                                //       )),
                                // ),
                              ],
                            ),
                          ),
                          _BookingDatum!.length != 0
                              ? ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: _BookingDatum?.length??0,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                      child: listTileItem(
                                          size,
                                          _BookingDatum![index]
                                              .customer!
                                              .firstName,
                                          _BookingDatum![index].bookedTime,
                                          _BookingDatum![index]
                                              .serviceCharge
                                              .toString()),
                                    );
                                  })
                              : Padding(
                                  padding: const EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 16.0),
                                  child: Container(
                                    height: 80,
                                    width: double.infinity,
                                    //color: Colors.white,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15.0, top: 10),
                                      child: Column(
                                        children: [
                                          SvgPicture.asset(
                                              "assets/image/ic_walletnotify.svg",
                                              width: 40,
                                              height: 40),
                                          const Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 12.0, top: 10),
                                              child: Text(
                                                "You have no payments to show",
                                                style: TextStyle(
                                                  fontFamily:
                                                      'SamsungSharpSans-Regular',
                                                  color: CustColors.light_navy,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ],
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
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        const Text(
          'My Wallet',
          textAlign: TextAlign.center,
          style: Styles.appBarTextBlue,
        ),
        const Spacer(),
        InkWell(
          onTap: () async {
            var datePicked = await DatePicker.showSimpleDatePicker(context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(DateTime.now().year - 10),
                    lastDate: DateTime.now(),
                    dateFormat: "dd-MMMM-yyyy",
                    locale: DateTimePickerLocale.en_us,
                    looping: false,
                    textColor: CustColors.light_navy,
                    itemTextStyle: const TextStyle(
                        fontSize: 18,
                        color: CustColors.light_navy,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Samsung_SharpSans_Medium'))
                .then((datePicked) {
              if (datePicked != null) {
                var dateTime = DateTime.parse(datePicked.toString());

                var formate1 =
                    "${dateTime.year}-${dateTime.month}-${dateTime.day}";

                /*Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Wallet_History(wallatdate: formate1)));*/
                _mechanicWalletBloc.postMechanicFetchMyWalletDailyRequest(
                    authToken, mechanicId, "", formate1);
              }
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Container(
              height: 30,
              width: 130,
              decoration: BoxDecoration(
                  color: CustColors.whiteBlueish,
                  borderRadius: BorderRadius.circular(5)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Text(
                        "Select date",
                        style: Styles.sparePartNameSubTextBlack,
                      ),
                    ),
                  ),
                  Container(
                    color: CustColors.light_navy,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 6.5, left: 6.5, bottom: 6.5, right: 4.3),
                      child: SvgPicture.asset(
                        'assets/image/ic_calender.svg',
                        height: 18,
                        width: 18,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget profileImageAndWalletTotal() {
    return Wrap(
      children: [
        SizedBox(
          height: 292,
          width: 500,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 26, 8, 0),
                child: ClipRRect(
                  //borderRadius: BorderRadius.circular(20.0),
                  child: Image.asset('assets/image/bg_wallet.png'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Wrap(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: SizedBox(
                          width: 110.0,
                          height: 110.0,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: CircleAvatar(
                                  radius: 75,
                                  // child:Image.network(
                                  //         _BookingDatum![0].mechanic!.mechanic![0].profilePic,
                                  //     fit: BoxFit.fill,
                                  //     ),
                                  backgroundColor: Colors.white,
                                  child: SizedBox(
                                    height: 106.0,
                                    width: 106.0,
                                    child: ClipOval(
                                      child: profileUrl != null &&
                                              profileUrl != ""
                                          ? Image.network(
                                              profileUrl,
                                              fit: BoxFit.fill,
                                            )
                                          : SvgPicture.asset(
                                              'assets/image/MechanicType/work_selection_avathar.svg'),
                                    ),
                                  ))),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 29, right: 33),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: const Text(
                              "Your balance ",
                              style: Styles.myWalletCardText02,
                            )),
                      ),
                    ),
                    Center(
                      child: Container(
                        margin: const EdgeInsets.only(top: 16, right: 33),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 100.0),
                            child: Row(children: [
                              const Text(
                                "₦ ",
                                style: Styles.myWalletCardText01,
                              ),
                              Text(
                                _myWalletDaily?.balance.toString()??'',
                                style: Styles.myWalletCardText01,
                              )
                            ]),
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
      height: MediaQuery.of(context).size.height * .70,
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * .28,
        left: size.width * 4 / 100,
        right: size.width * 4 / 100,
      ),
      child: Padding(
          padding: EdgeInsets.only(bottom: size.height * 3 / 100),
          child: Container(
            height: size.height * 70 / 100,
            //height: MediaQuery.of(context).size.height * double.parse(widget.percentage.toString()),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              //color: CustColors.blackishgrey,
              color: CustColors.whiteBlueish,
            ),
          )),
    );
  }

  Widget SubTitleTextRound(Size size, String titleText, String circleText) {
    return SizedBox(
      height: size.height * 20 / 100,
      width: size.width * 20 / 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              margin:
                  const EdgeInsets.only(top: 2, left: 2, right: 2, bottom: 0),
              child: Text(
                titleText,
                textAlign: TextAlign.center,
                style: Styles.myWalletSubTitleTextRoundText01,
              )),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
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

  Widget listTileItem(
      Size size, String customerName, String time, String amount) {
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
            left: size.width * 2.5 / 100),
        margin: EdgeInsets.only(
          left: size.width * 1.2 / 100,
          right: size.width * 1.2 / 100,
        ),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(6),
            ),
            color: Colors.white),
        //color: CustColors.white_02,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const Text(
                  "Customer",
                  style: Styles.myWalletListTileTitle01,
                ),
                SizedBox(
                  height: size.height * .7 / 100,
                ),
                Text(
                  customerName,
                  style: Styles.myWalletListTileTitle02,
                ),
              ],
            ),
            Column(
              children: [
                const Text(
                  "Time",
                  style: Styles.myWalletListTileTitle01,
                ),
                SizedBox(
                  height: size.height * .7 / 100,
                ),
                Text(
                  time,
                  style: Styles.myWalletListTileTitle02,
                ),
              ],
            ),
            Text(
              amount,
              style: Styles.myWalletListTileTitle03,
            )
          ],
        ),
      ),
    );
  }
}
