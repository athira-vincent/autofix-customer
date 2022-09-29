import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/place_order_bloc/place_oder_state.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/place_order_bloc/place_order_event.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/placeallorderbloc/place_oder_all_state.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/placeallorderbloc/place_order_all_event.dart';
import 'package:bloc/bloc.dart';

class PlaceOrderAllBloc extends Bloc<PlaceOrderAllEvent, PlaceOrderAllState> {
  PlaceOrderAllBloc() : super(PlaceOrderAllInitialState()) {
    on<PlaceOrderAllEvent>((event, emit) async {
      emit(PlaceOrderAllLoadingState());
      try {
        if (event is FetchPlaceOrderAllEvent) {
          var placeorderAllscreen = await Repository().placeorderallitem(
            event.addressid,
          );
          emit(PlaceOrderAllLoadedState(placeorderModel: placeorderAllscreen));
        }
      } catch (e) {
        emit(PlaceOrderAllErrorState(message: e.toString()));
      }
    });
  }
}
