import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/Constants/styles.dart';
import 'package:auto_fix/Models/notification_model/notification_model.dart';
import 'package:auto_fix/UI/Customer/SideBar/CustomerNotifications/cust_notification_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cust_notification_bloc.dart';
import 'cust_notification_event.dart';

class CustNotificationList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CustNotificationList();
  }
}

class _CustNotificationList extends State<CustNotificationList> {

  static const routeName = '/custNotificationList';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              CustomernotificationBloc()..add(FetchCustomernotificationEvent()),
        ),
      ],
      child: Scaffold(
          appBar: AppBar(
            leading: InkWell(
              onTap: (){
                Navigator.pop(context);
              },
                child: Icon(Icons.arrow_back)),
            backgroundColor: CustColors.light_navy,
            toolbarHeight: 80,
            elevation: 0,
            title: const Text(
              'Notifications',
              style: TextStyle(
                fontFamily: 'SamsungSharpSans-Medium',
                fontSize: 16.7,
              ),
            ),
            centerTitle: true,
          ),
          body: SafeArea(
            child: SizedBox(
              height: size.height,
              width: size.width,
              child: Stack(
                children: [
                  /*const Padding(
                    padding: EdgeInsets.only(left: 10.0, top: 10.0),
                    child: Text(
                      'New',
                      style: TextStyle(
                        fontFamily: 'SharpSans-Bold',
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),*/
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: BlocBuilder<CustomernotificationBloc,
                        CustomernotificationState>(builder: (context, state) {
                      if (state is CustomernotificationLoadingState) {
                        return progressBarDarkBlue();
                      } else if (state is CustomernotificationLoadedState) {
                        return state.notificationModel.data?.notificationList!.previousData!.length != 0
                          ? ListView.builder(
                            itemCount: state.notificationModel.data?.notificationList!.previousData!.length ?? 0,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return listItemEmergencyService(
                                  size,
                                  state.notificationModel.data!.notificationList!.previousData![index]);
                            })
                          : notificationListEmptyWidget(size);
                      } else if (state is CustomernotificationErrorState){
                        return notificationListEmptyWidget(size);
                      }else{
                        return Container();
                      }
                    }),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  Widget listItemEmergencyService(
      Size size, PreviousDatum previousDatum, ) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Container(
        decoration: BoxDecoration(
            color: const Color(0xfff5f4f7),
            border: Border.all(
              color: const Color(0xffbcbcbc),
              width: 0,
            )),
        height: 100,
        width: double.infinity,
        alignment: Alignment.center,
        child: Row(
          children: [
            /// --------------------- profile image to be updated from api ---------------
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: CircleAvatar(
                radius: 25,
                child: ClipOval(
                  child: Image.network(
                    'https://i.picsum.photos/id/799/200/200.jpg?hmac=zFQHfBiAYFHDNrr3oX_pQDYz-YWPWTDB3lIszvP8rRY',
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                padding: const EdgeInsets.only(left: 10.0, right: 10, top: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          previousDatum.message!,
                          //notificationList.message,
                          style: const TextStyle(
                            fontFamily: 'Samsung_SharpSans_Medium',
                            fontSize: 10.0,
                          ),
                        ),
                        // Text('Sade.  ',
                        //   style: TextStyle(
                        //     fontFamily: 'Samsung_SharpSans_Medium',
                        //     fontSize: 10.0,
                        //     fontWeight: FontWeight.bold,
                        //   ),),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      previousDatum.caption,
                      style: TextStyle(
                        fontFamily: 'Samsung_SharpSans_Medium',
                        fontSize: 10.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            /*Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: SizedBox(
                    height: 20,
                    width: 70,

                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        'View Services',
                        style: TextStyle(
                          fontFamily: 'SamsungSharpSans-Medium',
                          fontSize: 07,
                          color: Colors.black,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        primary: const Color(0xffd3dcf2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    //color: const Color(0xffd3dcf2),
                  ),
                ),
              ],
            ),*/
            /*Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    '1h',
                    style: TextStyle(
                      color: Color(0xffbcbcbc),
                      fontFamily: 'SamsungSharpSans-Medium',
                      fontSize: 07,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Icon(
                    Icons.more_vert,
                    color: Color(0xff5b5b5b),
                  ),
                )
              ],
            ),*/
          ],
        ),
      ),
    );
  }

  Widget notificationListEmptyWidget(Size size){
    return Center(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
            ),
            Image.asset(
              "assets/images/notification_empty.png",
              width: MediaQuery.of(context).size.width * 0.6,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            const Text(
              "No Notifications!",
              style: TextStyle(
                  fontSize: 25,
                  color: CustColors.materialBlue,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Samsung_SharpSans_Medium'),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            const Text(
              "You have no notifications to show",
              style: Styles.sparePartNameTextBlack17,
            ),
          ],
        ));
  }


  Widget progressBarDarkBlue() {
    return const SizedBox(
      height: 60.0,
      child: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(CustColors.light_navy),
          )),
    );
  }

  BoxDecoration boxDecorationStyle01 = BoxDecoration(
      borderRadius: BorderRadius.all(
        Radius.circular(8),
      ),
      border: Border.all(
        color: CustColors.greyish,
        width: 0.3,
      ),
      color: CustColors.white_03
  );

  TextStyle userNameTextStyle01 = const TextStyle(
      fontSize: 14,
      //fontFamily: "Samsung_SharpSans_Regular",
      //fontWeight: FontWeight.w600,
      color: CustColors.materialBlue);
  TextStyle warningTextStyle01 = const TextStyle(
      fontSize: 12,
      fontFamily: "Samsung_SharpSans_Regular",
      fontWeight: FontWeight.w600,
      color: Colors.black);

}
