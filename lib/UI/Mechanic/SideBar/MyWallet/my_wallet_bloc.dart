import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Mechanic/SideBar/MyWallet/my_wallet_mdl.dart';
import 'package:rxdart/rxdart.dart';

class MechanicMyWalletBloc {
  final Repository repository = Repository();

  final postMechanicMyWallet = PublishSubject<MechanicMyWalletMdl>();
  Stream<MechanicMyWalletMdl> get MechanicMyWalletResponse => postMechanicMyWallet.stream;

  postMechanicFetchMyWalletRequest(
      String token, type
      ) async {
    MechanicMyWalletMdl _mechanicMyWalletMdl = await repository.postMechanicFetchMyWalletRequest(token, type);
    postMechanicMyWallet.sink.add(_mechanicMyWalletMdl);
  }


  dispose() {
    postMechanicMyWallet.close();
  }


}
