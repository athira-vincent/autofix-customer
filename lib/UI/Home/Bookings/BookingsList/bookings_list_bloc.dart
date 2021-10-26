import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Home/Bookings/BookingsList/bookings_list_mdl.dart';
import 'package:rxdart/rxdart.dart';

class BookingsListBloc {
  final Repository repository = Repository();
  final postBookingsList = PublishSubject<BookingsListMdl>();
  Stream<BookingsListMdl> get bookingsListResponse => postBookingsList.stream;
  dispose() {
    postBookingsList.close();
  }

  postBookingsListRequest() async {
    BookingsListMdl _bookingsListMdl = await repository.getBookingsList();
    postBookingsList.sink.add(_bookingsListMdl);
  }
}
