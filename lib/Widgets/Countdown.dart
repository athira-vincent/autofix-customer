import 'package:auto_fix/Constants/styles.dart';
import 'package:flutter/material.dart';

class Countdown extends AnimatedWidget {
  Countdown({required this.animation}) : super( listenable: animation);
  Animation<int> animation;

  @override
  build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation.value);

    String timerText =
        '${clockTimer.inMinutes.remainder(60).toString()}:${clockTimer.inSeconds.remainder(60).toString().padLeft(2, '0')}';

    print('animation.value  ${animation.value} ');
    print('inMinutes ${clockTimer.inMinutes.toString()}');
    print('inSeconds ${clockTimer.inSeconds.toString()}');
    print('inSeconds.remainder ${clockTimer.inSeconds.remainder(60).toString()}');

    return Text(
      "$timerText",
      textAlign: TextAlign.center,
      softWrap: true,
      style: Styles.textLabelTitle16,
    );
  }
}