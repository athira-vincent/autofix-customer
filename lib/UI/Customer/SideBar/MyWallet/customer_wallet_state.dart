import 'package:auto_fix/Models/customer_wallet_detail_model/customer_wallet_detail_model.dart';
import 'package:auto_fix/Models/wallet_history_model/wallet_history_model.dart';

import 'package:equatable/equatable.dart';

class CustomerWalletState extends Equatable {
  @override
  List<Object> get props => [];
}

class CustomerWalletInitialState extends CustomerWalletState {
  @override
  List<Object> get props => [];
}

class CustomerWalletLoadingState extends CustomerWalletState {
  @override
  List<Object> get props => [];
}

class CustomerWalletLoadedState extends CustomerWalletState {
  final CustomerWalletDetailModel walletistoryModel;

  CustomerWalletLoadedState({required this.walletistoryModel});

  @override
  List<Object> get props => [];
}

class CustomerWalletErrorState extends CustomerWalletState {
  String message;

  CustomerWalletErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
