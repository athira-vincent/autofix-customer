import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Mechanic/SideBar/MyWallet/my_wallet_mdl.dart';
import 'package:rxdart/rxdart.dart';

class MechanicMyWalletBloc {
  final Repository repository = Repository();

  /// =============== Mechanic Wallet Type 1 - Daily ================== ///

  final postMechanicMyWalletDaily = PublishSubject<MechanicMyWalletMdl>();
  Stream<MechanicMyWalletMdl> get MechanicMyWalletDailyResponse => postMechanicMyWalletDaily.stream;

  postMechanicFetchMyWalletDailyRequest(
      String token, mechanicId, type,String customeDate
      ) async {
    MechanicMyWalletMdl _mechanicMyWalletMdl = await repository.postMechanicFetchMyWalletRequest(token, mechanicId,type,customeDate);
    postMechanicMyWalletDaily.sink.add(_mechanicMyWalletMdl);
  }

  /// =============== Mechanic Wallet Type 2 - Weekly ================== ///
  final postMechanicMyWalletWeekly = PublishSubject<MechanicMyWalletMdl>();
  Stream<MechanicMyWalletMdl> get MechanicMyWalletWeeklyResponse => postMechanicMyWalletWeekly.stream;

  postMechanicFetchMyWalletWeeklyRequest(
      String token, mechanicId, type, String customeDate
      ) async {
    MechanicMyWalletMdl _mechanicMyWalletMdl = await repository.postMechanicFetchMyWalletRequest(token, mechanicId, type, customeDate);
    postMechanicMyWalletWeekly.sink.add(_mechanicMyWalletMdl);
  }

  /// =============== Mechanic Wallet Type 3 - Monthly ================== ///
  final postMechanicMyWalletMonthly = PublishSubject<MechanicMyWalletMdl>();
  Stream<MechanicMyWalletMdl> get MechanicMyWalletMonthlyResponse => postMechanicMyWalletMonthly.stream;

  postMechanicFetchMyWalletMonthlyRequest(
      String token, mechanicId, type, String customeDate
      ) async {
    MechanicMyWalletMdl _mechanicMyWalletMdl = await repository.postMechanicFetchMyWalletRequest(token, mechanicId, type, customeDate);
    postMechanicMyWalletMonthly.sink.add(_mechanicMyWalletMdl);
  }

  dispose() {
    postMechanicMyWalletDaily.close();
    postMechanicMyWalletWeekly.close();
    postMechanicMyWalletMonthly.close();
  }


}
