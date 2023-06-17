import 'package:flutter/material.dart';

import '/third_party/third_party.dart';

class RectangleSwitch extends HookWidget {
  const RectangleSwitch({
    super.key,
    required this.initialValue,
    required this.onChanged,
    this.height = 30,
  });

  final bool initialValue;
  final void Function(bool) onChanged;
  final double height;

  static const double _aspectRatio = 5 / 3;

  @override
  Widget build(BuildContext context) {
    final value = useState<bool>(initialValue);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          value.value = !value.value;
          onChanged(value.value);
        },
        child: Container(
          width: height * _aspectRatio,
          height: height,
          decoration: BoxDecoration(
            color: value.value
                ? Theme.of(context).primaryColor
                : Theme.of(context).primaryColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(4 / 30 * height),
          ),
          padding: const EdgeInsets.all(2),
          child: Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 200),
                left: value.value ? 2 / 3 * (height - 2) : 0,
                right: value.value ? 0 : 2 / 3 * (height - 2),
                child: Container(
                  height: height - 4,
                  width: height - 4,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4 / 30 * height),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
