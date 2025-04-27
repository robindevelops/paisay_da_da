import 'package:flutter/material.dart';
import 'package:circular_reveal_animation/circular_reveal_animation.dart';

class AnimationUtil {
  static PageRouteBuilder circularRevealTransition({
    required Widget page,
    required Alignment centerAlignment,
    required Duration duration,
  }) {
    return PageRouteBuilder(
      barrierColor: Colors.black,
      transitionDuration: duration,
      pageBuilder: (context, animation, secondaryAnimation) {
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.fastOutSlowIn,
        );

        return CircularRevealAnimation(
          animation: curvedAnimation,
          centerAlignment: centerAlignment,
          child: page,
        );
      },
    );
  }
}
