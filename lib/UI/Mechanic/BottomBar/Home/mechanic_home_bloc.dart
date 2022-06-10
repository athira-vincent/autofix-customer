
import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Mechanic/BottomBar/Home/brand_specialization_mdl.dart';
import 'package:auto_fix/UI/Mechanic/BottomBar/Home/mechanic_active_service_mdl.dart';
import 'package:auto_fix/UI/Mechanic/BottomBar/Home/mechanic_location_update_mdl.dart';
import 'package:auto_fix/UI/Mechanic/BottomBar/Home/mechanic_online_offline_mdl.dart';
import 'package:auto_fix/UI/Mechanic/BottomBar/Home/upcoming_services_mdl.dart';

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
      token, String mechanicId,
      lat,lng,) async {

    MechanicLocationUpdateMdl _mechanicLocationUpdateMdl = await repository.postMechanicLocationUpdateRequest(
     token, mechanicId, lat,lng);
    postMechanicLocationUpdate.sink.add(_mechanicLocationUpdateMdl);
  }

  /// =============== Mechanic brand Specialization ================== ///

  final postMechanicBrandSpecialization = PublishSubject<MechanicBrandSpecializationMdl>();
  Stream<MechanicBrandSpecializationMdl> get postMechanicBrandSpecializationResponse => postMechanicBrandSpecialization.stream;

  postMechanicBrandSpecializationRequest(
      token, brandName) async {

    MechanicBrandSpecializationMdl _mechanicLocationUpdateMdl = await repository.postMechanicBrandSpecializationRequest(
        token, brandName);
    postMechanicBrandSpecialization.sink.add(_mechanicLocationUpdateMdl);
  }

  /// =============== Mechanic Upcoming Service ================== ///

  final postMechanicUpComingService = PublishSubject<MechanicUpcomingServiceMdl>();
  Stream<MechanicUpcomingServiceMdl> get postMechanicUpComingServiceResponse => postMechanicUpComingService.stream;

  postMechanicUpComingServiceRequest(
      token, type, mechanicId) async {

    MechanicUpcomingServiceMdl _mechanicUpComingServiceMdl = await repository.postMechanicUpComingServiceRequest(
        token, type, mechanicId);
    postMechanicUpComingService.sink.add(_mechanicUpComingServiceMdl);
  }

  /// =============== Mechanic Completed Service ================== ///

  final postMechanicCompletedService = PublishSubject<MechanicUpcomingServiceMdl>();
  Stream<MechanicUpcomingServiceMdl> get postMechanicCompletedServiceResponse => postMechanicCompletedService.stream;

  postMechanicCompletedServiceRequest(
      token, type, mechanicId) async {

    MechanicUpcomingServiceMdl _mechanicUpComingServiceMdl = await repository.postMechanicUpComingServiceRequest(
        token, type, mechanicId);
    postMechanicCompletedService.sink.add(_mechanicUpComingServiceMdl);
  }

  /// =============== Mechanic All Service ================== ///

  final postMechanicAllService = PublishSubject<MechanicUpcomingServiceMdl>();
  Stream<MechanicUpcomingServiceMdl> get postMechanicAllServiceResponse => postMechanicAllService.stream;

  postMechanicAllServiceRequest(
      token, type, mechanicId) async {

    MechanicUpcomingServiceMdl _mechanicUpComingServiceMdl = await repository.postMechanicUpComingServiceRequest(
        token, type, mechanicId);
    postMechanicAllService.sink.add(_mechanicUpComingServiceMdl);
  }

  /// =============== Mechanic Active Service ================== ///

  final postMechanicActiveService = PublishSubject<MechanicActiveServiceUpdateMdl>();
  Stream<MechanicActiveServiceUpdateMdl> get postMechanicActiveServiceResponse => postMechanicActiveService.stream;

  postMechanicActiveServiceRequest(
      token, mechanicId) async {

    MechanicActiveServiceUpdateMdl _mechanicActiveServiceMdl = await repository.postMechanicActiveServiceRequest(
        token, mechanicId);
    postMechanicActiveService.sink.add(_mechanicActiveServiceMdl);
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
