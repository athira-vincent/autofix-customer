import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Customer/Home/SideBar/MyVehicle/Add/Model/all_model_mdl.dart';
import 'package:rxdart/rxdart.dart';

class AllModelBloc {
  final Repository repository = Repository();
  final postAllModel = PublishSubject<AllModelMdl>();
  Stream<AllModelMdl> get allModelResponse => postAllModel.stream;
  dispose() {
    postAllModel.close();
  }

  postAllModelRequest(int id) async {
    AllModelMdl _allModelMdl = await repository.getAllModel(id);
    postAllModel.sink.add(_allModelMdl);
  }
}
