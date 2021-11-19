import 'package:auto_fix/QueryProvider/query_provider.dart';
import 'package:auto_fix/UI/Customer/Home/SideBar/Bookings/BookingsDetails/bookings_details_mdl.dart';

class BookingsDetailsApiProvider {
  final QueryProvider _queryProvider = QueryProvider();
  Future<BookingsDetailsMdl> getBookingsDetailRequest() async {
    Map<String, dynamic> _resp = await _queryProvider.bookingDetail();
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg =
            BookingsDetailsMdl(status: "error", message: _resp['message']);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return BookingsDetailsMdl.fromJson(data);
      }
    } else {
      final errorMsg = BookingsDetailsMdl(
          status: "error", message: "No Internet connection");
      return errorMsg;
    }
  }
}
