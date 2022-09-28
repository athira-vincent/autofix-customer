import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/bloc/add_cart_event.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/showcartpopbloc/show_cart_pop_event.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/showcartpopbloc/show_cart_pop_state.dart';
import 'package:bloc/bloc.dart';

class ShowCartPopBloc extends Bloc<ShowCartPopEvent, ShowCartPopState> {
  ShowCartPopBloc() : super(ShowCartPopInitialState()) {
    on<ShowCartPopEvent>((event, emit) async {
      emit(ShowCartPopLoadingState());
      try {
        if (event is FetchShowCartPopEvent) {
          var cartlistscreen = await Repository().cartlist();
          emit(ShowCartPopLoadedState(cartlistmodel: cartlistscreen));
        }
      } catch (e) {
        emit(ShowCartPopErrorState(message: e.toString()));
      }
    });
  }
}
