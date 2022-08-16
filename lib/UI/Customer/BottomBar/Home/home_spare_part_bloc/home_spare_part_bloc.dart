
import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/home_spare_part_bloc/home_spare_part_event.dart';
import 'package:auto_fix/UI/Customer/BottomBar/Home/home_spare_part_bloc/home_spare_part_state.dart';
import 'package:bloc/bloc.dart';

class SparePartBloc extends Bloc<SparePartEvent, SparePartState> {
  SparePartBloc() : super(SparePartInitialState()) {
    on<SparePartEvent>((event, emit) async {
      emit(SparePartLoadingState());
      try {
        if (event is FetchSparePartEvent) {






          var sparepartscreen = await Repository().getspareparts(event.modelid);
          emit(SparePartLoadedState(sparePartsModel: sparepartscreen));
        }
      } catch (e) {
        emit(SparePartErrorState(message: e.toString()));
      }
    });
  }
}