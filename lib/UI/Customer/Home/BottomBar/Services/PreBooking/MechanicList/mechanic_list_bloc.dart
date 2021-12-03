import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Customer/Home/BottomBar/Services/PreBooking/MechanicList/mechanic_list_mdl.dart';
import 'package:rxdart/rxdart.dart';

class MechanicListBloc {
  final Repository repository = Repository();
  final postViewMechanicList = PublishSubject<MechanicListMdl>();
  Stream<MechanicListMdl> get viewMechanicListResponse => postViewMechanicList.stream;
  dispose() {
    postViewMechanicList.close();
  }

  postMechanicListRequest(String token, int page, int size,String serviceId) async {
    MechanicListMdl _mechanicListMdl = await repository.getAllMechanicList(token, page, size,serviceId);
    postViewMechanicList.sink.add(_mechanicListMdl);
  }
}
