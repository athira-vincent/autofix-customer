import 'package:equatable/equatable.dart';


import '../../../../Models/new_checkout_model/new_checkout_model.dart';

class NewCheckoutState extends Equatable {
  @override
  List<Object> get props => [];
}

class NewCheckoutInitialState extends NewCheckoutState {
  @override
  List<Object> get props => [];
}

class NewCheckoutLoadingState extends NewCheckoutState {
  @override
  List<Object> get props => [];
}

class NewCheckoutLoadedState extends NewCheckoutState {
  final NewCheckoutModel newCheckoutModel;

  NewCheckoutLoadedState({required this.newCheckoutModel});

  @override
  List<Object> get props => [];
}

class NewCheckoutErrorState extends NewCheckoutState {
  String message;

  NewCheckoutErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
