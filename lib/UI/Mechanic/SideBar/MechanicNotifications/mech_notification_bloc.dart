
import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Mechanic/SideBar/MechanicNotifications/mech_notification_event.dart';
import 'package:auto_fix/UI/Mechanic/SideBar/MechanicNotifications/mech_notification_state.dart';
import 'package:bloc/bloc.dart';



class VendornotificationBloc extends Bloc<VendornotificationEvent, VendornotificationState> {
  VendornotificationBloc() : super(VendornotificationInitialState()) {
    on<VendornotificationEvent>((event, emit) async {
      emit(VendornotificationLoadingState());
      try {
        if (event is FetchVendornotificationEvent) {
          var vendornotificationscreen = await Repository().vendornotification();
          emit(VendornotificationLoadedState(notificationModel: vendornotificationscreen));
        }
      } catch (e) {
        emit(VendornotificationErrorState(message: e.toString()));
      }
    });
  }
}
