import 'package:equatable/equatable.dart';

class WalletHistoryEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchWalletHistoryEvent extends WalletHistoryEvent {

  final String date;
  FetchWalletHistoryEvent(this.date);

  @override
  List<Object> get props => [];
}