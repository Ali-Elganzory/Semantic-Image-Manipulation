import 'package:flutter/material.dart';

import '/util/util.dart';
import '/third_party/third_party.dart';

class EditableText extends HookWidget {
  const EditableText({
    super.key,
    required this.text,
    this.realtimeText = false,
    this.tooltip = '',
    this.minChars = 3,
    required this.onChanged,
    this.style = const TextStyle(
      fontWeight: FontWeight.w500,
    ),
  });

  final String text;
  final bool realtimeText;
  final String tooltip;
  final int minChars;
  final FutureOr<bool> Function(String) onChanged;
  final TextStyle style;
  final double size = 16;

  @override
  Widget build(BuildContext context) {
    final prevText = useState(text);
    final currentText = useState(text);
    final isHovering = useState(false);
    final isEditMode = useState(false);

    useEffect(() {
      if (realtimeText) {
        prevText.value = currentText.value = text;
      }
      return null;
    }, [text]);

    void onSave() async {
      isEditMode.value = false;
      if (currentText.value == prevText.value) {
        return;
      }
      if (currentText.value.length < minChars) {
        context.showSnackBar('Text must be at least $minChars characters long');
        currentText.value = prevText.value;
        return;
      }
      final res = await onChanged(currentText.value);
      if (!res) {
        currentText.value = prevText.value;
      } else {
        prevText.value = currentText.value;
      }
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => isHovering.value = true,
      onExit: (_) => isHovering.value = false,
      child: GestureDetector(
        onTap: () => isEditMode.value = true,
        child: isEditMode.value
            ? TextFormField(
                autofocus: true,
                initialValue: currentText.value,
                style: style.copyWith(
                  fontSize: size,
                  color: Theme.of(context).primaryColorDark,
                ),
                decoration: const InputDecoration(
                  constraints: BoxConstraints.tightFor(width: 200),
                ),
                onChanged: (value) => currentText.value = value,
                onTapOutside: (event) => onSave(),
                onEditingComplete: onSave,
              )
            : Row(
                children: [
                  Tooltip(
                    message: isEditMode.value ? '' : tooltip,
                    child: Text(
                      currentText.value,
                      style: style.copyWith(
                        fontSize: size,
                        color: Theme.of(context).primaryColorDark,
                      ),
                    ),
                  ),
                  AnimatedOpacity(
                    opacity: isHovering.value ? 1 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.edit_rounded,
                            color: Theme.of(context).primaryColorDark,
                            size: size,
                          ),
                          onPressed: () => isEditMode.value = true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
