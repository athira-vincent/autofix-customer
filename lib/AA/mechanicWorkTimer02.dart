import 'package:auto_fix/Constants/styles.dart';
import 'package:flutter/material.dart';

class CountdownMechanicTimerTwo extends AnimatedWidget {
  Animation<int> animation;
  final VoidCallback? onTap;
  final ValueSetter<String> onChanged;

  CountdownMechanicTimerTwo({
        required this.animation,
        this.onTap,
        required this.onChanged,
      }) : super( listenable: animation);


  @override
  build(BuildContext context) {

    Duration clockTimer = Duration(seconds: animation.value);
    String timerText =
        '${clockTimer.inMinutes.remainder(60).toString()}:${clockTimer.inSeconds.remainder(60).toString().padLeft(2, '0')}';

    // print('animation.value  ${animation.value} ');
    // print('inMinutes ${clockTimer.inMinutes.toString()}');
    // print('inSeconds ${clockTimer.inSeconds.toString()}');
    // print('inSeconds.remainder ${clockTimer.inSeconds.remainder(60).toString()}');

    /*animation.addListener(() {
      onChanged;
    });*/

    return TextField(
      controller: TextEditingController(text: "$timerText"),
      textAlign: TextAlign.center,
      //softWrap: true,
      onChanged: (value){
        onChanged(value);
      },
      style: Styles.textCountdownMechanicTimer,
    );
  }
}