import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/cod_bloc/cod_event.dart';
import 'package:auto_fix/UI/SpareParts/MyCart/cod_bloc/cod_state.dart';
import 'package:bloc/bloc.dart';

class CodBloc extends Bloc<CodEvent, CodState> {
  CodBloc() : super(CodInitialState()) {
    on<CodEvent>((event, emit) async {
      emit(CodLoadingState());
      try {
        if (event is FetchCodEvent) {
          var Codscreen = await Repository().Cod(event.amount,event.orderid);

          emit(CodLoadedState(codmodel: Codscreen));
        }
      } catch (e) {
        emit(CodErrorState(message: e.toString()));
      }
    });
  }
}
