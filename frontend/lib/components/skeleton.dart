import 'package:flutter/material.dart';

import '/third_party/third_party.dart';

class Skeleton extends StatelessWidget {
  const Skeleton({
    super.key,
    required this.isLoading,
    this.placeholder,
    required this.child,
  });

  final bool isLoading;
  final Widget? placeholder;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Shimmer.fromColors(
            baseColor: Colors.grey[400] ?? Colors.blueGrey,
            highlightColor: Colors.grey[500] ?? Colors.grey,
            enabled: true,
            child: placeholder ?? child,
          )
        : child;
  }
}
