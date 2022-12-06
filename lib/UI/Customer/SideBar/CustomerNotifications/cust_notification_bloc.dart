
import 'package:bloc/bloc.dart';
import 'package:auto_fix/Repository/repository.dart';

import 'cust_notification_event.dart';
import 'cust_notification_state.dart';

class CustomernotificationBloc extends Bloc<CustomernotificationEvent, CustomernotificationState> {
  CustomernotificationBloc() : super(CustomernotificationInitialState()) {
    on<CustomernotificationEvent>((event, emit) async {
      emit(CustomernotificationLoadingState());
      try {
        if (event is FetchCustomernotificationEvent) {
          var customernotificationscreen = await Repository().customernotification();
          emit(CustomernotificationLoadedState(notificationModel: customernotificationscreen));
        }
      } catch (e) {
        emit(CustomernotificationErrorState(message: e.toString()));
      }
    });
  }
}
