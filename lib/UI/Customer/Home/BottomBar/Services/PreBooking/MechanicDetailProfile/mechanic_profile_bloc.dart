import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Customer/Home/BottomBar/Services/PreBooking/MechanicDetailProfile/mechanic_profile_mdl.dart';
import 'package:rxdart/rxdart.dart';

class MechanicProfileBloc {
  final Repository repository = Repository();
  final postViewMechanicDetails = PublishSubject<MechanicProfileMdl>();
  Stream<MechanicProfileMdl> get viewMechanicDetailsResponse =>
      postViewMechanicDetails.stream;
  dispose() {
    postViewMechanicDetails.close();
  }

  postMechanicDetailsRequest(
    String id,
  ) async {
    MechanicProfileMdl _mechanicProfileMdl =
        await repository.getMechanicProfile(id);
    postViewMechanicDetails.sink.add(_mechanicProfileMdl);
  }
}
