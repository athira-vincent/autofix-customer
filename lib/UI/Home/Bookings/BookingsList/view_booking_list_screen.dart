import 'package:auto_fix/UI/Home/Bookings/BookingsList/Active/active_booking_list.dart';
import 'package:auto_fix/UI/Home/Bookings/BookingsList/Completed/completed_booking_list.dart';
import 'package:auto_fix/UI/Home/Bookings/BookingsList/Pending/pending_booking_list.dart';
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
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
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
