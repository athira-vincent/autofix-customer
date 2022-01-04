import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Customer/Home/SideBar/MyVehicle/Add/Model/all_model_mdl.dart';
import 'package:rxdart/rxdart.dart';

class AllModelBloc {
  final Repository repository = Repository();
  final postAllModel = PublishSubject<AllModelMdl>();
  Stream<AllModelMdl> get allModelResponse => postAllModel.stream;

  final postModelData = PublishSubject<List<ModelDetails>>();
  Stream<List<ModelDetails>> get allModelDetails => postModelData.stream;
  List<ModelDetails> _modelDataList = [];

  dispose() {
    postAllModel.close();
    postModelData.close();
  }

  /*postAllModelRequest(int id,String token) async {
    AllModelMdl _allModelMdl = await repository.getAllModel(id,token);
    postAllModel.sink.add(_allModelMdl);
  }*/

  postAllModelDataRequest(String id, String token) async{
    AllModelMdl _allModelMdl = await repository.getAllModel(id,token);
    _modelDataList.clear();
    _modelDataList.addAll(_allModelMdl.data!.modelDetails!);
    postAllModel.sink.add(_allModelMdl);
    postModelData.sink.add(_allModelMdl.data!.modelDetails!);
  }

  void searchMake(String searchText) {
    List<ModelDetails> _searchList = [];
    _searchList.clear();
    if (searchText != '' || searchText != ' ') {
      _modelDataList.forEach((element) {
        if(element.modelName!.toLowerCase().startsWith(searchText.toLowerCase())){
          _searchList.add(element);
        }
      });
      postModelData.sink.add(_searchList);
    } else {
      postModelData.sink.add(_modelDataList);
    }
  }

}
