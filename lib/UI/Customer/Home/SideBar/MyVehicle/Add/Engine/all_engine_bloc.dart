import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Customer/Home/SideBar/MyVehicle/Add/Engine/all_engine_mdl.dart';
import 'package:rxdart/rxdart.dart';

class AllEngineBloc {
  final Repository repository = Repository();
  final postAllEngine = PublishSubject<AllEngineMdl>();
  Stream<AllEngineMdl> get allEngineResponse => postAllEngine.stream;

  final postEngineData = PublishSubject<List<EngineDetails>>();
  Stream<List<EngineDetails>> get allEngineDetails => postEngineData.stream;
  List<EngineDetails> _engineDataList = [];

  dispose() {
    postAllEngine.close();
    postEngineData.close();
  }

  postAllEngineRequest(int id,String token) async {
    AllEngineMdl _allEngineMdl = await repository.getAllEngine(id, token);
    postAllEngine.sink.add(_allEngineMdl);
  }

  postAllEngineDataRequest(int id,String token) async{
    AllEngineMdl _allEngineMdl = await repository.getAllEngine(id, token);
    _engineDataList.clear();
    _engineDataList.addAll(_allEngineMdl.data!.engineDetails!);
    postAllEngine.sink.add(_allEngineMdl);
    postEngineData.sink.add(_allEngineMdl.data!.engineDetails!);
  }
  void searchMake(String searchText) {
    List<EngineDetails> _searchList = [];
    _searchList.clear();
    if (searchText != '' || searchText != ' ') {
      _engineDataList.forEach((element) {
        if(element.engineName!.toLowerCase().startsWith(searchText.toLowerCase())){
          _searchList.add(element);
        }
      });
      postEngineData.sink.add(_searchList);
    } else {
      postEngineData.sink.add(_engineDataList);
    }
  }
}
