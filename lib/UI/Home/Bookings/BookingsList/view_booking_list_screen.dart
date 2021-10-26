import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/UI/Home/Bookings/BookingsList/Active/active_booking_list.dart';
import 'package:auto_fix/UI/Home/Bookings/BookingsList/Completed/completed_booking_list.dart';
import 'package:auto_fix/UI/Home/Bookings/BookingsList/Pending/pending_booking_list.dart';
import 'package:auto_fix/UI/Home/Bookings/BookingsList/bookings_list_bloc.dart';
import 'package:flutter/material.dart';

class ViewBookingListScreen extends StatefulWidget {
  const ViewBookingListScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ViewBookingListScreenState();
  }
}

class _ViewBookingListScreenState extends State<ViewBookingListScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final BookingsListBloc _bookingsListBloc = BookingsListBloc();
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _bookingsListBloc.postBookingsListRequest();
    _getBookingsList();
  }

  @override
  void dispose() {
    super.dispose();
    _bookingsListBloc.dispose();
  }

  _getBookingsList() async {
    _bookingsListBloc.postBookingsList.listen((value) {
      if (value.status == "error") {
        setState(() {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(value.message,
                style: const TextStyle(
                    fontFamily: 'Roboto_Regular', fontSize: 14)),
            duration: const Duration(seconds: 2),
            backgroundColor: CustColors.peaGreen,
          ));
        });
      } else {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Bookings",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: NestedScrollView(
        body: TabBarView(controller: _tabController, children: const [
          ActiveBookingList(),
          CompletedBookingList(),
          PendingBookingsList()
        ]),
        headerSliverBuilder: (context, value) {
          return [
            SliverToBoxAdapter(
              child: TabBar(
                controller: _tabController,
                tabs: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: const Text(
                      'ACTIVE',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: const Text(
                      'COMPLETED',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: const Text(
                      'PENDING',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ];
        },
      ),
    );
  }
}
