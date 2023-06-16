import 'package:flutter/material.dart';

import '/models/models.dart';
import '/third_party/third_party.dart';

class TaskChip extends HookConsumerWidget {
  const TaskChip({
    super.key,
    required this.task,
  });

  final TaskModel task;

  static const Map<TaskStatus, Color> _statusColors = {
    TaskStatus.error: Colors.red,
    TaskStatus.pending: Colors.grey,
    TaskStatus.running: Colors.blue,
    TaskStatus.success: Colors.green,
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isHovering = useState(false);
    final statusColor = _statusColors[task.status] ?? Colors.grey;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => isHovering.value = true,
      onExit: (_) => isHovering.value = false,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: isHovering.value ? Colors.grey[300] : Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: DefaultTextStyle(
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          child: AnimatedSize(
            duration: const Duration(milliseconds: 200),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.only(right: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: statusColor,
                  ),
                ),
                Text(
                  task.type.string,
                ),
                if (isHovering.value)
                  Text(
                    ' (${task.status.string})',
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
