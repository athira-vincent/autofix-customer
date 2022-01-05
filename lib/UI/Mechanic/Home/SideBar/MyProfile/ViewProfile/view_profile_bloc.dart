import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Mechanic/Home/SideBar/MyProfile/ViewProfile/view_profile_mdl.dart';
import 'package:rxdart/rxdart.dart';

class MechanicViewProfileBloc {
  final Repository repository = Repository();
  final postViewProfile = PublishSubject<MechanicViewProfileMdl>();
  Stream<MechanicViewProfileMdl> get viewProfileResponse => postViewProfile.stream;
  dispose() {
    postViewProfile.close();
  }

  postViewProfileRequest(String id,String token, ) async {
    MechanicViewProfileMdl _viewProfileMdl = await repository.getViewMechanicProfile(id, token, );
    postViewProfile.sink.add(_viewProfileMdl);
  }
}
