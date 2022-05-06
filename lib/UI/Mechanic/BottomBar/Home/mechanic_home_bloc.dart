
import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Mechanic/BottomBar/Home/mechanic_location_update_mdl.dart';
import 'package:auto_fix/UI/Mechanic/BottomBar/Home/mechanic_online_offline_mdl.dart';

import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';


class HomeMechanicBloc {

  final Repository repository = Repository();


  /// =============== Mechanic Online/Offline ================== ///

  final postMechanicOnlineOffline = PublishSubject<MechanicOnlineOfflineMdl>();
  Stream<MechanicOnlineOfflineMdl> get postMechanicOnlineOfflineResponse => postMechanicOnlineOffline.stream;

  postMechanicOnlineOfflineRequest(
      token, String status, String mechanicId) async {

    MechanicOnlineOfflineMdl _mechanicOnlineOfflineMdlMdl = await repository.postMechanicOnlineOfflineRequest(
      token, status, mechanicId);
    postMechanicOnlineOffline.sink.add(_mechanicOnlineOfflineMdlMdl);
  }

  /// =============== Mechanic Location Update ================== ///

  final postMechanicLocationUpdate = PublishSubject<MechanicLocationUpdateMdl>();
  Stream<MechanicLocationUpdateMdl> get postMechanicLocationUpdateResponse => postMechanicLocationUpdate.stream;

  postMechanicLocationUpdateRequest(
      token,
      lat,lng,) async {

    MechanicLocationUpdateMdl _mechanicLocationUpdateMdl = await repository.postMechanicLocationUpdateRequest(
     token, lat,lng);
    postMechanicLocationUpdate.sink.add(_mechanicLocationUpdateMdl);
  }


  /// =============== Date Conversion ================== ///

  dateConvert(DateTime Format) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(Format);
    print(formatted);

    return formatted;
  }

  /// =============== Time Conversion ================== ///

  timeConvert(DateTime Format) {
    final DateFormat formatter = DateFormat('hh:mm a');
    final String formatted = formatter.format(Format);
    print(formatted);

    return formatted;
  }



  dispose() {

  }
}
