
import 'package:auto_fix/Models/notification_model/notification_model.dart';
import 'package:equatable/equatable.dart';

class VendornotificationState extends Equatable {
  @override
  List<Object> get props => [];
}

class VendornotificationInitialState extends VendornotificationState {
  @override
  List<Object> get props => [];
}

class VendornotificationLoadingState extends VendornotificationState {
  @override
  List<Object> get props => [];
}

class VendornotificationLoadedState extends VendornotificationState {
  final NotificationModel notificationModel;

  VendornotificationLoadedState({required this.notificationModel});

  @override
  List<Object> get props => [];
}

class VendornotificationErrorState extends VendornotificationState {
  String message;

  VendornotificationErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
