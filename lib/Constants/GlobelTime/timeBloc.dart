import 'package:auto_fix/Constants/GlobelTime/timeMdl.dart';
import 'package:auto_fix/Repository/repository.dart';

import 'package:rxdart/rxdart.dart';

class TimeBloc{

  final repository = Repository();

  final postTime = PublishSubject<TimeModel>();

    Stream<TimeModel> get timeResponse => postTime.stream;

  dispose() {
    postTime.close();
  }

  postTimeRequest(String timeZone) async{
    TimeModel timeMdl = await repository.getCurrentWorldTime(timeZone);
    if(timeMdl != null) {
      postTime.sink.add(timeMdl);
    } else {

    }
  }
}