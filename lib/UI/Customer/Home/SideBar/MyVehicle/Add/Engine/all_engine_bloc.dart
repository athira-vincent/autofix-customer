import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Customer/Home/SideBar/MyVehicle/Add/Engine/all_engine_mdl.dart';
import 'package:rxdart/rxdart.dart';

class AllEngineBloc {
  final Repository repository = Repository();
  final postAllEngine = PublishSubject<AllEngineMdl>();
  Stream<AllEngineMdl> get allEngineResponse => postAllEngine.stream;
  dispose() {
    postAllEngine.close();
  }

  postAllEngineRequest(int id,String token) async {
    AllEngineMdl _allEngineMdl = await repository.getAllEngine(id, token);
    postAllEngine.sink.add(_allEngineMdl);
  }
}
