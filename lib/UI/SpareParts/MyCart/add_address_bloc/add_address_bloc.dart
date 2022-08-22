import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/add_address_bloc/add_address_event.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/add_address_bloc/add_address_state.dart';
import 'package:bloc/bloc.dart';

class AddAddressBloc extends Bloc<AddAddressEvent, AddAddressState> {
  AddAddressBloc() : super(AddAddressInitialState()) {
    on<AddAddressEvent>((event, emit) async {
      emit(AddAddressLoadingState());
      try {
        if (event is FetchAddAddressEvent) {
          var addaddresslistscreen = await Repository().addaddresslist(
              event.fullname,
              event.phone,
              event.pincode,
              event.city,
              event.state,
              event.address,
              event.addressline2,
              event.type);
          emit(AddAddressLoadedState(addaddressModel: addaddresslistscreen));
        }
      } catch (e) {
        emit(AddAddressErrorState(message: e.toString()));
      }
    });
  }
}
