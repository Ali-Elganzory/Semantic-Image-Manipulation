import 'dart:collection';

import 'package:flutter/material.dart';

import '/third_party/third_party.dart';

part 'toasted.g.dart';

@riverpod
class Toasts extends _$Toasts {
  final duration = const Duration(seconds: 3);

  @override
  _ToastedState build() {
    return _ToastedState.initial();
  }

  void show(String message, ToastType type) {
    // Add toast
    state = state.copyWith(
      toasts: state.toasts
        ..add(
          _Toast(
            message: message,
            type: type,
          ),
        ),
    );

    // Remove toast after duration
    Future.delayed(duration, () {
      if (state.toasts.isEmpty) return;
      state = state.copyWith(
        toasts: state.toasts..removeFirst(),
      );
    });
  }
}

enum ToastType {
  success,
  error,
}

class Toasted extends ConsumerWidget {
  const Toasted({
    Key? key,
    required this.child,
    this.alignment = Alignment.topRight,
    this.padding = 10,
    this.width = 260,
  }) : super(key: key);

  final Widget child;
  final Alignment alignment;
  final double padding;
  final double width;

  _Position positionFromAlignment(
    Alignment alignment,
  ) {
    final x = alignment.x;
    final y = alignment.y;

    return _Position(
      top: y < 0 ? padding : null,
      bottom: y > 0 ? padding : null,
      left: x < 0 ? padding : null,
      right: x > 0 ? padding : null,
    );
  }

  static const colorFromToastType = {
    ToastType.success: Colors.green,
    ToastType.error: Colors.red,
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final position = positionFromAlignment(alignment);
    final toasts = ref.watch(toastsProvider).toasts;

    return Stack(
      children: [
        child,
        Positioned(
          top: position.top,
          bottom: position.bottom,
          left: position.left,
          right: position.right,
          width: width,
          child: Material(
            color: Colors.transparent,
            child: ListView.separated(
              itemCount: toasts.length,
              shrinkWrap: true,
              separatorBuilder: (context, index) => SizedBox(height: padding),
              itemBuilder: (context, index) {
                final toast = toasts.elementAt(index);
                final color = colorFromToastType[toast.type];

                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  clipBehavior: Clip.antiAlias,
                  width: width,
                  height: 50,
                  child: Row(
                    children: [
                      Container(
                        color: color,
                        height: double.maxFinite,
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            toast.message,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _ToastedState {
  final Queue<_Toast> toasts;

  _ToastedState({
    required this.toasts,
  });

  _ToastedState.initial() : toasts = Queue<_Toast>();

  _ToastedState copyWith({
    Queue<_Toast>? toasts,
  }) {
    return _ToastedState(
      toasts: toasts ?? this.toasts,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _ToastedState &&
          runtimeType == other.runtimeType &&
          toasts.equals(other.toasts);

  @override
  int get hashCode => toasts.hashCode;
}

class _Toast {
  const _Toast({
    required this.message,
    required this.type,
  });

  final String message;
  final ToastType type;
}

class _Position {
  const _Position({
    this.top,
    this.left,
    this.right,
    this.bottom,
  });

  final double? top;
  final double? left;
  final double? right;
  final double? bottom;
}

extension Comparison<T> on Queue<T> {
  bool equals(Queue<T> other) {
    if (length != other.length) return false;

    for (var i = 0; i < length; i++) {
      if (elementAt(i) != other.elementAt(i)) return false;
    }

    return true;
  }
}
