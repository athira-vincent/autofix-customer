import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Home/Vehicle/Add/Model/all_model_mdl.dart';
import 'package:rxdart/rxdart.dart';

class AllModelBloc {
  final Repository repository = Repository();
  final postAllModel = PublishSubject<AllModelMdl>();
  Stream<AllModelMdl> get allModelResponse => postAllModel.stream;
  dispose() {
    postAllModel.close();
  }

  postAllModelRequest() async {
    AllModelMdl _allModelMdl = await repository.getAllModel();
    postAllModel.sink.add(_allModelMdl);
  }
}
