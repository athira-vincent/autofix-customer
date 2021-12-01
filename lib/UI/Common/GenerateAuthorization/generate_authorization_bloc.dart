import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Common/GenerateAuthorization/generate_authorization_mdl.dart';
import 'package:rxdart/rxdart.dart';

class GenerateAuthorizationBloc {
  final Repository repository = Repository();
  final postGenerateAutorization = PublishSubject<GenerateAutorizationMdl>();
  Stream<GenerateAutorizationMdl> get generateAutorizationResponse =>
      postGenerateAutorization.stream;
  dispose() {
    postGenerateAutorization.close();
  }

  postGenerateAutorizationRequest(String userId, int type) async {
    GenerateAutorizationMdl _generateAutorizationMdl =
        await repository.getToken(userId, type);
    postGenerateAutorization.sink.add(_generateAutorizationMdl);
  }
}
