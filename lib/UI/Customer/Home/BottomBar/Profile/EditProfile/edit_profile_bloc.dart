import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Customer/Home/BottomBar/Profile/EditProfile/edit_profile_mdl.dart';
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
