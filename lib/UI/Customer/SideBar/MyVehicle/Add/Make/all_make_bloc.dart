import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Customer/SideBar/MyVehicle/Add/Make/all_make_mdl.dart';
import 'package:rxdart/rxdart.dart';

class AllMakeBloc {
  final Repository repository = Repository();
  final postAllMake = PublishSubject<AllMakeMdl>();
  Stream<AllMakeMdl> get allMakeResponse => postAllMake.stream;
  dispose() {
    postAllMake.close();
  }

  postAllMakeRequest(String token) async {
    AllMakeMdl _allMakeMdl = await repository.getAllMake(token);
    postAllMake.sink.add(_allMakeMdl);
  }
}
