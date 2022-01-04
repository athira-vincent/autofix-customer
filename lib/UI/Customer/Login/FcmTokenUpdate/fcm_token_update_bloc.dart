import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Customer/Login/ForgotPassword/forgot_password_mdl.dart';
import 'package:rxdart/rxdart.dart';

import 'fcm_token_update_mdl.dart';

class FcmTokenUpdateBloc {
  final Repository repository = Repository();
  final postFcmTokenUpdate = PublishSubject<FcmTokenUpdateMdl>();
  Stream<FcmTokenUpdateMdl> get FcmTokenUpdateResponse =>
      postFcmTokenUpdate.stream;
  dispose() {
    postFcmTokenUpdate.close();
  }

  postFcmTokenUpdateRequest(
      String fcm,
      String Authtoken
      ) async {
    FcmTokenUpdateMdl fcmTokenUpdateMdl = await repository.getcmTokenUpdateRequest(fcm,Authtoken);
    postFcmTokenUpdate.sink.add(fcmTokenUpdateMdl);
  }
}
