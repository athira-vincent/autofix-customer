
import 'package:auto_fix/Models/notification_model/notification_model.dart';
import 'package:equatable/equatable.dart';


class CustomernotificationState extends Equatable {
  @override
  List<Object> get props => [];
}

class CustomernotificationInitialState extends CustomernotificationState {
  @override
  List<Object> get props => [];
}

class CustomernotificationLoadingState extends CustomernotificationState {
  @override
  List<Object> get props => [];
}

class CustomernotificationLoadedState extends CustomernotificationState {
  final NotificationModel notificationModel;

  CustomernotificationLoadedState({required this.notificationModel});

  @override
  List<Object> get props => [];
}

class CustomernotificationErrorState extends CustomernotificationState {
  String message;

  CustomernotificationErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
