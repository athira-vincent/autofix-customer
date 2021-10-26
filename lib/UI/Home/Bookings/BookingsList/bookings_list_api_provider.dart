import 'package:auto_fix/QueryProvider/query_provider.dart';
import 'package:auto_fix/UI/Home/Bookings/BookingsList/bookings_list_mdl.dart';

class BookingsListApiProvider {
  final QueryProvider _queryProvider = QueryProvider();
  Future<BookingsListMdl> getBookingsListRequest() async {
    Map<String, dynamic> _resp = await _queryProvider.bookingsList();
    // ignore: unnecessary_null_comparison
    if (_resp != null) {
      if (_resp['status'] == "error") {
        final errorMsg =
            BookingsListMdl(status: "error", message: _resp['message']);
        return errorMsg;
      } else {
        var data = {"data": _resp};
        return BookingsListMdl.fromJson(data);
      }
    } else {
      final errorMsg =
          BookingsListMdl(status: "error", message: "No Internet connection");
      return errorMsg;
    }
  }
}
