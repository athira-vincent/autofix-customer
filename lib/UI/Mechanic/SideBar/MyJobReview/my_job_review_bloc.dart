import 'package:auto_fix/Repository/repository.dart';
import 'package:auto_fix/UI/Mechanic/SideBar/MyJobReview/my_job_review_mdl.dart';
import 'package:rxdart/rxdart.dart';

class MechanicMyJobReviewBloc {
  final Repository repository = Repository();

  final postMechanicMyJobReview = PublishSubject<MechanicMyJobReviewMdl>();
  Stream<MechanicMyJobReviewMdl> get MechanicMyJobReviewResponse => postMechanicMyJobReview.stream;

  postMechanicFetchMyJobReviewRequest(
      String token, mechanicId
      ) async {
    MechanicMyJobReviewMdl _mechanicMyJobReviewMdl = await repository.postMechanicFetchMyJobReviewRequest(token, mechanicId);
    postMechanicMyJobReview.sink.add(_mechanicMyJobReviewMdl);
  }


  dispose() {
    postMechanicMyJobReview.close();
  }


}
