import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/order_list_bloc/order_list_event.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/order_list_bloc/order_list_state.dart';
import 'package:bloc/bloc.dart';

class OrderListBloc extends Bloc<OrderListEvent, OrderListState> {
  OrderListBloc() : super(OrderListInitialState()) {
    on<OrderListEvent>((event, emit) async {
      emit(OrderListLoadingState());
      try {
        if (event is FetchOrderListEvent) {
          var orderlistscreen = await Repository().orderlist();
          emit(OrderListLoadedState(orderDetailsmodel: orderlistscreen));
        }
      } catch (e) {
        emit(OrderListErrorState(message: e.toString()));
      }
    });
  }
}
