import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/UI/Mechanic/SideBar/MyWallet/wallet_history_bloc/wallet_history_bloc.dart';
import 'package:auto_fix/UI/Mechanic/SideBar/MyWallet/wallet_history_bloc/wallet_history_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'wallet_history_bloc/wallet_history_event.dart';

class Wallet_History extends StatefulWidget {
  final String wallatdate;

  const Wallet_History({Key? key, required this.wallatdate}) : super(key: key);

  @override
  State<Wallet_History> createState() => _Wallet_HistoryState();
}

class _Wallet_HistoryState extends State<Wallet_History> {
  var formate1;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => WalletHistoryBloc()
            ..add(FetchWalletHistoryEvent(
              widget.wallatdate.toString(),
            )),
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              appBarCustomUi(size),
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
                            "Wallet History",
                            style: Styles.myWalletTitleText03,
                          )),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
              BlocBuilder<WalletHistoryBloc, WalletHistoryState>(
                  builder: (context, state) {
                if (state is WalletHistoryLoadedState) {
                  return state.walletistoryModel.data!.walletHistory.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: state
                              .walletistoryModel.data!.walletHistory.length,
                          itemBuilder: (BuildContext context, int index) {
                            var dateTime = DateTime.parse(state
                                .walletistoryModel
                                .data!
                                .walletHistory[index]
                                .recordDate
                                .toString());

                            var formate1 =
                                "${dateTime.year}-${dateTime.month}-${dateTime.day}";
                            return Container(
                              child: listTileItem(
                                  size,
                                  "Pravin",
                                  formate1,
                                  state.walletistoryModel.data!
                                      .walletHistory[index].amount
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
                              padding:
                                  const EdgeInsets.only(left: 15.0, top: 10),
                              child: Column(
                                children: [
                                  SvgPicture.asset(
                                      "assets/image/ic_walletnotify.svg",
                                      width: 40,
                                      height: 40),
                                  const Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(left: 12.0, top: 10),
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
                        );
                } else {
                  return Container();
                }
              })
            ],
          ),
        ),
      ),
    ));
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
                  "Date",
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
            Column(
              children: [
                const Text(
                  "Amount",
                  style: Styles.myWalletListTileTitle01,
                ),
                SizedBox(
                  height: size.height * .7 / 100,
                ),
                Text(
                  amount,
                  style: Styles.myWalletListTileTitle03,
                ),
              ],
            )
          ],
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
      ],
    );
  }
}
