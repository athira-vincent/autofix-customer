import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Customer/Home/SelectCar/select_car_mdl.dart';
import 'package:rxdart/rxdart.dart';

class SelectCarBloc {
  final Repository repository = Repository();
  final postSelectCar = PublishSubject<SelectCarMdl>();
  Stream<SelectCarMdl> get selectCarResponse => postSelectCar.stream;
  dispose() {
    postSelectCar.close();
  }

  postSelectCarRequest() async {
    SelectCarMdl _selectCarMdl = await repository.getSelectCar();
    postSelectCar.sink.add(_selectCarMdl);
  }
}
