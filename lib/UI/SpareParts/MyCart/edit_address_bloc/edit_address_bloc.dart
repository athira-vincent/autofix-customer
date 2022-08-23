import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/add_address_bloc/add_address_event.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/add_address_bloc/add_address_state.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/edit_address_bloc/edit_address_event.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/edit_address_bloc/edit_address_state.dart';
import 'package:bloc/bloc.dart';

class EditAddressBloc extends Bloc<EditAddressEvent, EditAddressState> {
  EditAddressBloc() : super(EditAddressInitialState()) {
    on<EditAddressEvent>((event, emit) async {
      emit(EditAddressLoadingState());
      try {
        if (event is FetchEditAddressEvent) {
          var editaddresslistscreen = await Repository().editaddresslist(
              event.fullname,
              event.phone,
              event.pincode,
              event.city,
              event.state,
              event.address,
              event.addressline2,
              event.type);
          emit(EditAddressLoadedState(addaddressModel: editaddresslistscreen));
        }
      } catch (e) {
        emit(EditAddressErrorState(message: e.toString()));
      }
    });
  }
}
