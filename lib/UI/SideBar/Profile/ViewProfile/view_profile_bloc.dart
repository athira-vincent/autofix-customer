import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/SideBar/Profile/ViewProfile/view_profile_mdl.dart';
import 'package:rxdart/rxdart.dart';

class ViewProfileBloc {
  final Repository repository = Repository();
  final postViewProfile = PublishSubject<ViewProfileMdl>();
  Stream<ViewProfileMdl> get viewProfileResponse => postViewProfile.stream;
  dispose() {
    postViewProfile.close();
  }

  postViewProfileRequest(String id) async {
    ViewProfileMdl _viewProfileMdl = await repository.getViewProfile(id);
    postViewProfile.sink.add(_viewProfileMdl);
  }
}
