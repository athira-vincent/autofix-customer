import 'package:auto_fix/Models/wallet_history_model/wallet_history_model.dart';

import 'package:equatable/equatable.dart';

class WalletHistoryState extends Equatable {
  @override
  List<Object> get props => [];
}

class WalletHistoryInitialState extends WalletHistoryState {
  @override
  List<Object> get props => [];
}

class WalletHistoryLoadingState extends WalletHistoryState {
  @override
  List<Object> get props => [];
}

class WalletHistoryLoadedState extends WalletHistoryState {
  final WalletistoryModel walletistoryModel;

  WalletHistoryLoadedState({required this.walletistoryModel});

  @override
  List<Object> get props => [];
}

class WalletHistoryErrorState extends WalletHistoryState {
  String message;

  WalletHistoryErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
