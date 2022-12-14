

import 'package:auto_fix/Repository/repository.dart';

class GetCurrentWorldTime {

  String getCurrentWorldTime(){
    String currentDateTime = "";
    Repository().getCurrentWorldTime("Nairobi").then((value01) => {

      currentDateTime = value01.datetime!.millisecondsSinceEpoch.toString(),

      print("dateConverter(timeNow!) >>> ${currentDateTime}"),

    });

    return currentDateTime;
  }

  int getDurationDifference(int startTime, int totalTime){

    Duration timeBalance;
    String currentDateTime;
    int remainingTime = totalTime;
    Repository().getCurrentWorldTime("Nairobi").then((value01) => {

      currentDateTime = value01.datetime!.millisecondsSinceEpoch.toString(),
      print(">>>> customerCurrentTime currentDateTime : $currentDateTime"),

      timeBalance = DateTime.fromMillisecondsSinceEpoch(startTime).
      difference(DateTime.fromMillisecondsSinceEpoch(int.parse(currentDateTime))),
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