import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Customer/Home/Bookings/BookingsDetails/bookings_details_mdl.dart';
import 'package:rxdart/rxdart.dart';

class BookingsDetailsBloc {
  final Repository repository = Repository();
  final postBookingsDetails = PublishSubject<BookingsDetailsMdl>();
  Stream<BookingsDetailsMdl> get bookingsDetailsResponse =>
      postBookingsDetails.stream;
  dispose() {
    postBookingsDetails.close();
  }

  postBookingsDetailsRequest() async {
    BookingsDetailsMdl _bookingsDetailsMdl =
        await repository.getBookingsDetails();
    postBookingsDetails.sink.add(_bookingsDetailsMdl);
  }
}
