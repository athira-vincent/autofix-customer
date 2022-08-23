import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/bloc/add_cart_state.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/delete_address_bloc/delete_address_event.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/delete_address_bloc/delete_address_state.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/delete_cart_bloc/delete_cart_event.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/delete_cart_bloc/delete_cart_state.dart';
import 'package:bloc/bloc.dart';

class DeleteAddressBloc extends Bloc<DeleteAddressEvent, DeleteAddressState> {
  DeleteAddressBloc() : super(DeleteAddressInitialState()) {
    on<DeleteAddressEvent>((event, emit) async {
      emit(DeleteAddressLoadingState());
      try {
        if (event is FetchDeleteAddressEvent) {
          var deletecartscreen = await Repository().deleteaddress(event.addressid,event.status);
          emit(DeleteAddressLoadedState(deleteAddressModel: deletecartscreen));
        }
      } catch (e) {
        emit(DeleteAddressErrorState(message: e.toString()));
      }
    });
  }
}
