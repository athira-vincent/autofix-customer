import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signup/CityList/city_list_mdl.dart';


import 'package:rxdart/rxdart.dart';

class CityListBloc {
  final Repository repository = Repository();
  final postCityList = PublishSubject<CityListMdl>();
  Stream<CityListMdl> get cityListResponse =>
      postCityList.stream;
  dispose() {
    postCityList.close();
  }

  postCityListRequest(
      String token,id,
      ) async {
    CityListMdl _customerProfileMdl =
    await repository.getCityList(token,id);
    postCityList.sink.add(_customerProfileMdl);
  }

}
