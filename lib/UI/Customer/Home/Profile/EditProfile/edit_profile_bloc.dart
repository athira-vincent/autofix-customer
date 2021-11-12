import 'package:auto_fix/Repository/repository.dart';
<<<<<<< HEAD:lib/UI/SideBar/Profile/EditProfile/edit_profile_bloc.dart
import 'package:auto_fix/UI/SideBar/Profile/EditProfile/edit_profile_mdl.dart';
=======
import 'package:auto_fix/UI/Customer/Home/Profile/EditProfile/edit_profile_mdl.dart';
>>>>>>> a24f82096464da68f60291951771eb4f46989a15:lib/UI/Customer/Home/Profile/EditProfile/edit_profile_bloc.dart
import 'package:rxdart/rxdart.dart';

class EditProfileBloc {
  final Repository repository = Repository();
  final postEditProfile = PublishSubject<EditProfileMdl>();
  Stream<EditProfileMdl> get editProfileResponse => postEditProfile.stream;
  dispose() {
    postEditProfile.close();
  }

  postEditProfileRequest() async {
    EditProfileMdl _editProfileMdl = await repository.getEditProfile();
    postEditProfile.sink.add(_editProfileMdl);
  }
}
