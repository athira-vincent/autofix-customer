import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Customer/Home/Vehicle/Add/Make/all_make_mdl.dart';
import 'package:rxdart/rxdart.dart';

class AllMakeBloc {
  final Repository repository = Repository();
  final postAllMake = PublishSubject<AllMakeMdl>();
  Stream<AllMakeMdl> get allMakeResponse => postAllMake.stream;
  dispose() {
    postAllMake.close();
  }

  postAllMakeRequest() async {
    AllMakeMdl _allMakeMdl = await repository.getAllMake();
    postAllMake.sink.add(_allMakeMdl);
  }
}
