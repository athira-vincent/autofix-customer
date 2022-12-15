

import 'package:auto_fix/Repository/repository.dart';

class GetCurrentWorldTime {


  Future<String> getCurrentWorldTime() async {
    String currentDateTime = "";
    Repository().getCurrentWorldTime("Nairobi").then((value01) => {

      currentDateTime = value01.datetime!.millisecond.toString(),

      print("dateConverter(timeNow!) >>> ${currentDateTime}"),

    });

    return currentDateTime;
  }

  Future<int> getDurationDifference(int startTime, int totalTime) async{

    Duration timeBalance;
    String currentDateTime;
    int remainingTime = totalTime;
    print("totalTime $totalTime");
    print("startTime $startTime");

    Repository().getCurrentWorldTime("Nairobi").then((value01) => {

      currentDateTime = value01.datetime!.millisecond.toString(),
      print(">>>> customerCurrentTime currentDateTime : $currentDateTime"),

      timeBalance = DateTime.fromMillisecondsSinceEpoch(startTime).difference(DateTime.fromMillisecondsSinceEpoch(int.parse(currentDateTime))),
      print( "time difference >>> ${timeBalance.inSeconds}"),

        if(timeBalance.inSeconds > -totalTime){
            remainingTime = remainingTime + timeBalance.inSeconds
        }
        else{
            remainingTime = 0,
        }


    });
    print("remaining Time >>> $remainingTime");
   return remainingTime;
  }

}