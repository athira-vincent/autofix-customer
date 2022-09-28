import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/address_bloc/address_event.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/address_bloc/address_state.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/bloc/add_cart_event.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/showcartpopbloc/show_cart_pop_event.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/showcartpopbloc/show_cart_pop_state.dart';
import 'package:bloc/bloc.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  AddressBloc() : super(AddressInitialState()) {
    on<AddressEvent>((event, emit) async {
      emit(AddressLoadingState());
      try {
        if (event is FetchAddressEvent) {
          var addresslistscreen = await Repository().addresslist();
          emit(AddressLoadedState(addressModel: addresslistscreen));
        }
      } catch (e) {
        emit(AddressErrorState(message: e.toString()));
      }
    });
  }
}
