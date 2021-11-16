import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Customer/Login/Signup/signup_mdl.dart';
import 'package:auto_fix/UI/Customer/Login/Signup/states_mdl.dart';
import 'package:rxdart/rxdart.dart';

class SignupBloc {
  final Repository repository = Repository();
  final postSignUp = PublishSubject<SignupMdl>();
  Stream<SignupMdl> get signUpResponse => postSignUp.stream;
  final statesCode = PublishSubject<List<StateDetails>>();
  Stream<List<StateDetails>> get countryDialcodeResponse => statesCode.stream;

  List<StateDetails> _statesDataList = [];
  dispose() {
    postSignUp.close();
    statesCode.close();
  }

  postSignUpRequest(String firstName, String userName, String email,
      String state, String password, String phone) async {
    SignupMdl _signUpMdl = await repository.getSignUp(
        firstName, userName, email, state, password, phone);
    postSignUp.sink.add(_signUpMdl);
  }

  dialStatesListRequest() async {
    dynamic _state = await repository.getStateList();
    _statesDataList.clear();
    _statesDataList.addAll(_state.stateData);
    statesCode.sink.add(_state.stateData);
  }

  void searchStates(String searchText) {
    List<StateDetails> _searchList = [];
    _searchList.clear();
    if (searchText != '' || searchText != ' ') {
      _statesDataList.forEach((element) {
        if (element.name!.toLowerCase().startsWith(searchText.toLowerCase())) {
          _searchList.add(element);
        }
      });

      statesCode.sink.add(_searchList);
    } else {
      statesCode.sink.add(_statesDataList);
    }
  }
}
