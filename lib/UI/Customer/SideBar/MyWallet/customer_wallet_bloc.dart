import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Customer/SideBar/MyWallet/customer_wallet_state.dart';
import 'package:bloc/bloc.dart';

import 'customer_wallet_event.dart';

class CustomerWalletBloc extends Bloc<CustomerWalletEvent, CustomerWalletState> {
  CustomerWalletBloc() : super(CustomerWalletInitialState()) {
    on<CustomerWalletEvent>((event, emit) async {
      emit(CustomerWalletLoadingState());
      try {
        if (event is FetchCustomerWalletEvent) {
          var customerwalletscreen = await Repository().customerwallet(/*event.date*/);
          emit(CustomerWalletLoadedState(walletistoryModel: customerwalletscreen));
        }
      } catch (e) {
        emit(CustomerWalletErrorState(message: e.toString()));
      }
    });
  }
}
