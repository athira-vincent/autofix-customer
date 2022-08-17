import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/home_spare_parts_list_bloc/home_spare_part_list_event.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/home_spare_parts_list_bloc/home_spare_part_list_state.dart';
import 'package:bloc/bloc.dart';

class SparePartListBloc extends Bloc<SparePartListEvent, SparePartListState> {
  SparePartListBloc() : super(SparePartListInitialState()) {
    on<SparePartListEvent>((event, emit) async {
      emit(SparePartListLoadingState());
      try {
        if (event is FetchSparePartListEvent) {
          var sparepartscreen = await Repository().getsparepartslist(event.modelname,event.search,event.fromcost,event.tocost);
          emit(SparePartListLoadedState(sparePartslistModel: sparepartscreen));
        }
      } catch (e) {
        emit(SparePartListErrorState(message: e.toString()));
      }
    });
  }
}
