import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/cust_rating_bloc/cust_rating_event.dart';
import 'package:bloc/bloc.dart';

import 'cust_rating_state.dart';

class CustRatingBloc extends Bloc<CustRatingEvent, CustRatingState> {
  CustRatingBloc() : super(CustRatingInitialState()) {
    on<CustRatingEvent>((event, emit) async {
      emit(CustRatingLoadingState());
      try {
        if (event is FetchCustRatingEvent) {
          var custratscreen = await Repository().custrating(event.rating,event.orderid,event.productid);
          emit(CustRatingLoadedState(customerRatingModel: custratscreen));
        }
      } catch (e) {
        emit(CustRatingErrorState(message: e.toString()));
      }
    });
  }
}
