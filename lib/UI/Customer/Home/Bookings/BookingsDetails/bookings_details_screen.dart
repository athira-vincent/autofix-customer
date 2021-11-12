import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:auto_fix/UI/Customer/Home/Bookings/BookingsDetails/bookings_details_bloc.dart';
import 'package:flutter/material.dart';

class BookingsDetailsScreen extends StatefulWidget {
  const BookingsDetailsScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _BookingsDetailsScreenState();
  }
}

class _BookingsDetailsScreenState extends State<BookingsDetailsScreen> {
  final BookingsDetailsBloc _bookingsDetailsBloc = BookingsDetailsBloc();
  @override
  void initState() {
    super.initState();
    _bookingsDetailsBloc.postBookingsDetailsRequest();
    _getBookingsDetails();
  }

  @override
  void dispose() {
    super.dispose();
    _bookingsDetailsBloc.dispose();
  }

  _getBookingsDetails() async {
    _bookingsDetailsBloc.postBookingsDetails.listen((value) {
      if (value.status == "error") {
        setState(() {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(value.message.toString(),
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
    return const Scaffold();
  }
}
