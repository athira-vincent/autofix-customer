import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/bloc/add_cart_state.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/delete_cart_bloc/delete_cart_event.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/delete_cart_bloc/delete_cart_state.dart';
import 'package:bloc/bloc.dart';

class DeleteCartBloc extends Bloc<DeleteCartEvent, DeleteCartState> {
  DeleteCartBloc() : super(DeleteCartInitialState()) {
    on<DeleteCartEvent>((event, emit) async {
      emit(DeleteCartLoadingState());
      try {
        if (event is FetchDeleteCartEvent) {
          var deletecartscreen = await Repository().deletecart(event.productid);
          emit(DeleteCartLoadedState(deleteCartModel: deletecartscreen));
        }
      } catch (e) {
        emit(DeleteCartErrorState(message: e.toString()));
      }
    });
  }
}
