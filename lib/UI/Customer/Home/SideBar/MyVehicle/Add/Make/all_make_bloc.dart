import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Customer/Home/SideBar/MyVehicle/Add/Make/all_make_mdl.dart';
import 'package:rxdart/rxdart.dart';

class AllMakeBloc {
  final Repository repository = Repository();
  final postAllMake = PublishSubject<AllMakeMdl>();
  Stream<AllMakeMdl> get allMakeResponse => postAllMake.stream;

  final postMakeData = PublishSubject<List<MakeDetails>>();
  Stream<List<MakeDetails>> get allMakeDetails => postMakeData.stream;
  List<MakeDetails> _makeDataList = [];


  dispose() {
    postAllMake.close();
    postMakeData.close();
  }

  /*postAllMakeRequest(String token) async {
    AllMakeMdl _allMakeMdl = await repository.getAllMake(token);
    postAllMake.sink.add(_allMakeMdl);
  }*/

  postAllMakeDataRequest(String token) async{
    AllMakeMdl _allMakeMdl = await repository.getAllMake(token);
    _makeDataList.clear();
    _makeDataList.addAll(_allMakeMdl!.data!.makeDetails!);
    postAllMake.sink.add(_allMakeMdl);
    postMakeData.sink.add(_allMakeMdl!.data!.makeDetails!);
  }

  void searchMake(String searchText) {
    List<MakeDetails> _searchList = [];
    _searchList.clear();
    if (searchText != '' || searchText != ' ') {
      _makeDataList.forEach((element) {
        if(element.makeName!.toLowerCase().startsWith(searchText.toLowerCase())){
          _searchList.add(element);
        }
      });
      postMakeData.sink.add(_searchList);
    } else {
      postMakeData.sink.add(_makeDataList);
    }
  }
}
