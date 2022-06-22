import 'package:auto_fix/Repository/repository.dart';
import 'package:rxdart/rxdart.dart';

import 'mech_service_mdl.dart';

class MechServiceDetailsReviewBloc{
  final repository = Repository();

  final postMechServiceDetailsReview = PublishSubject<MechServiceDetailsMdl>();
  Stream <MechServiceDetailsMdl> get MechServiceDetailsMdlResponse => postMechServiceDetailsReview.stream;

  postGetMechServiceDetailsReviewRequest(
      String token, bookingId
      )async{
    MechServiceDetailsMdl _MechServiceDetailsMdl = await repository.postGetMechServiceDetailsReviewRequest( token, bookingId);
    postMechServiceDetailsReview.sink.add(_MechServiceDetailsMdl);
  }
}