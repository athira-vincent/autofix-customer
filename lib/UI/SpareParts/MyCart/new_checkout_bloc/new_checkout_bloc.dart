import 'package:auto_fix/Repository/repository.dart';
import 'package:bloc/bloc.dart';

import 'new_checkout_event.dart';
import 'new_checkout_state.dart';

class NewCheckoutBloc extends Bloc<NewCheckoutEvent, NewCheckoutState> {
  NewCheckoutBloc() : super(NewCheckoutInitialState()) {
    on<NewCheckoutEvent>((event, emit) async {
      emit(NewCheckoutLoadingState());
      try {
        if (event is FetchNewCheckoutEvent) {
          var newcheckoutscreen =
              await Repository().newcheckoutapi(event.cartid, event.addressid);
          emit(NewCheckoutLoadedState(newCheckoutModel: newcheckoutscreen));
        }
      } catch (e) {
        emit(NewCheckoutErrorState(message: e.toString()));
      }
    });
  }
}
