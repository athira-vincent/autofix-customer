import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/home_spare_parts_list_bloc/home_spare_part_list_event.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/home_spare_parts_list_bloc/home_spare_part_list_state.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/bloc/add_cart_event.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/bloc/add_cart_state.dart';
import 'package:bloc/bloc.dart';

class AddCartBloc extends Bloc<AddCartEvent, AddCartState> {
  AddCartBloc() : super(AddCartInitialState()) {
    on<AddCartEvent>((event, emit) async {
      emit(AddCartLoadingState());
      try {
        if (event is FetchAddCartEvent) {
          var addcartscreen = await Repository().addcart(event.productid);
          emit(AddCartLoadedState(addCartModel: addcartscreen));
        }
      } catch (e) {
        emit(AddCartErrorState(message: e.toString()));
      }
    });
  }
}
