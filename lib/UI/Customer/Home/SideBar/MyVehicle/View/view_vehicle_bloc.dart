import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Customer/Home/SideBar/MyVehicle/View/view_vehilce_mdl.dart';
import 'package:rxdart/rxdart.dart';

class ViewVehicleBloc {
  final Repository repository = Repository();
  final postViewVehicle = PublishSubject<ViewVehicleMdl>();
  Stream<ViewVehicleMdl> get viewVehicleResponse => postViewVehicle.stream;
  dispose() {
    postViewVehicle.close();
  }

  postViewVehicleRequest() async {
    ViewVehicleMdl _viewVehicleMdl = await repository.getViewVehicle();
    postViewVehicle.sink.add(_viewVehicleMdl);
  }
}
