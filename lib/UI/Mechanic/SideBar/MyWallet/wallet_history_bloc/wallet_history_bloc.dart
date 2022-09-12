import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Mechanic/SideBar/MyWallet/wallet_history_bloc/wallet_history_state.dart';
import 'package:bloc/bloc.dart';

import 'wallet_history_event.dart';

class WalletHistoryBloc extends Bloc<WalletHistoryEvent, WalletHistoryState> {
  WalletHistoryBloc() : super(WalletHistoryInitialState()) {
    on<WalletHistoryEvent>((event, emit) async {
      emit(WalletHistoryLoadingState());
      try {
        if (event is FetchWalletHistoryEvent) {
          var wallethistoryscreen = await Repository().wallethistory(event.date);
          emit(WalletHistoryLoadedState(walletistoryModel: wallethistoryscreen));
        }
      } catch (e) {
        emit(WalletHistoryErrorState(message: e.toString()));
      }
    });
  }
}
