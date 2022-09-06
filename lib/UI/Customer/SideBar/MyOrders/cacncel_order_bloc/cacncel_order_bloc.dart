import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Customer/SideBar/MyOrders/cacncel_order_bloc/cacncel_order_state.dart';
import 'package:auto_fix/UI/Customer/SideBar/MyOrders/cacncel_order_bloc/cancel_order_event.dart';
import 'package:bloc/bloc.dart';

class CancelOrderBloc extends Bloc<CancelOrderEvent, CancelOrderState> {
  CancelOrderBloc() : super(CancelOrderInitialState()) {
    on<CancelOrderEvent>((event, emit) async {
      emit(CancelOrderLoadingState());
      try {
        if (event is FetchCancelOrderEvent) {
          var cancelorderscreen = await Repository().cancelorder(event.orderid);
          emit(CancelOrderLoadedState(deleteAddressModel: cancelorderscreen));
        }
      } catch (e) {
        emit(CancelOrderErrorState(message: e.toString()));
      }
    });
  }
}
