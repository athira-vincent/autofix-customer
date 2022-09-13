import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/place_order_bloc/place_oder_state.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/place_order_bloc/place_order_event.dart';
import 'package:bloc/bloc.dart';

class PlaceOrderBloc extends Bloc<PlaceOrderEvent, PlaceOrderState> {
  PlaceOrderBloc() : super(PlaceOrderInitialState()) {
    on<PlaceOrderEvent>((event, emit) async {
      emit(PlaceOrderLoadingState());
      try {
        if (event is FetchPlaceOrderEvent) {
          var placeorderscreen = await Repository().placeorder(event.qty,event.totalprice,event.productid,event.addressid,);
          emit(PlaceOrderLoadedState(placeorderModel: placeorderscreen));
        }
      } catch (e) {
        emit(PlaceOrderErrorState(message: e.toString()));
      }
    });
  }
}
