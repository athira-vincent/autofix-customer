import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Home/Vehicle/Add/Engine/all_engine_mdl.dart';
import 'package:rxdart/rxdart.dart';

class AllEngineBloc {
  final Repository repository = Repository();
  final postAllEngine = PublishSubject<AllEngineMdl>();
  Stream<AllEngineMdl> get allEngineResponse => postAllEngine.stream;
  dispose() {
    postAllEngine.close();
  }

  postAllEngineRequest() async {
    AllEngineMdl _allEngineMdl = await repository.getAllEngine();
    postAllEngine.sink.add(_allEngineMdl);
  }
}
