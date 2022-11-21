import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/WelcomeScreens/Login/Signup/StatesList/states_list_mdl.dart';

import 'package:rxdart/rxdart.dart';

class StatesListBloc {
  final Repository repository = Repository();
  final postStatesList = PublishSubject<StatesListMdl>();
  Stream<StatesListMdl> get statesListResponse =>
      postStatesList.stream;
  dispose() {
    postStatesList.close();
  }

  postStatesListRequest(
      String token,id,
      ) async {
    StatesListMdl _customerProfileMdl =
    await repository.getStatesList(token,id);
    postStatesList.sink.add(_customerProfileMdl);
  }

}
