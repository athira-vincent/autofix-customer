import 'package:auto_fix/Repository/repository.dart';
<<<<<<< HEAD:lib/UI/SideBar/Profile/ViewProfile/view_profile_bloc.dart
import 'package:auto_fix/UI/SideBar/Profile/ViewProfile/view_profile_mdl.dart';
=======
import 'package:auto_fix/UI/Customer/Home/Profile/ViewProfile/view_profile_mdl.dart';
>>>>>>> a24f82096464da68f60291951771eb4f46989a15:lib/UI/Customer/Home/Profile/ViewProfile/view_profile_bloc.dart
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
