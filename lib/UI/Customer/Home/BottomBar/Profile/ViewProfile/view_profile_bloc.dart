import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Customer/Home/BottomBar/Profile/ViewProfile/view_profile_mdl.dart';
import 'package:rxdart/rxdart.dart';

class ViewProfileBloc {
  final Repository repository = Repository();
  final postViewProfile = PublishSubject<ViewProfileMdl>();
  Stream<ViewProfileMdl> get viewProfileResponse => postViewProfile.stream;
  dispose() {
    postViewProfile.close();
  }

  postViewProfileRequest(String id,String token, ) async {
    ViewProfileMdl _viewProfileMdl = await repository.getViewProfile(id, token, );
    postViewProfile.sink.add(_viewProfileMdl);
  }
}
