import 'package:flutter/material.dart';

import '/third_party/third_party.dart';

class AnimatedUpDown extends HookWidget {
  final Widget child;
  final Duration duration;

  /// [extraSpace] + child height: the space in which it animates up and down.
  final double extraSpace;
  final Curve curve;

  const AnimatedUpDown({
    super.key,
    required this.child,
    required this.duration,
    required this.extraSpace,
    this.curve = Curves.easeInOutCubic,
  });

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(
      duration: duration,
      lowerBound: 0,
      upperBound: extraSpace,
      initialValue: 0,
      animationBehavior: AnimationBehavior.preserve,
    )..repeat(reverse: true);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.5 * extraSpace),
      child: AnimatedBuilder(
        animation: CurvedAnimation(
          parent: controller,
          curve: curve,
        ),
        child: child,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, controller.value - 0.5 * extraSpace),
            child: child,
          );
        },
      ),
    );
  }
}
