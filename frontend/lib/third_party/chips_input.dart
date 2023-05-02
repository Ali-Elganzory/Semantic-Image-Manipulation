// MIT License
//
// Copyright (c) 2019 Simon Lightfoot
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// See: https://twitter.com/shakil807/status/1042127387515858949
// https://github.com/pchmn/MaterialChipsInput/tree/master/library/src/main/java/com/pchmn/materialchips
// https://github.com/BelooS/ChipsLayoutManager

typedef ChipsInputSuggestions<T> = List<T>;
typedef ChipSelected<T> = void Function(T data, bool selected);
typedef ChipsBuilder<T> = Widget Function(
    BuildContext context, ChipsInputState<T> state, T data);

class ChipsInput<T> extends StatefulWidget {
  const ChipsInput({
    Key? key,
    this.decoration = const InputDecoration(),
    required this.chipBuilder,
    required this.suggestionBuilder,
    required this.suggestions,
    required this.onChanged,
    required this.onSearchChanged,
    this.onChipTapped,
  }) : super(key: key);

  final InputDecoration decoration;
  final ChipsInputSuggestions<T> suggestions;
  final ValueChanged<List<T>> onChanged;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<T>? onChipTapped;
  final ChipsBuilder<T> chipBuilder;
  final ChipsBuilder<T> suggestionBuilder;

  @override
  ChipsInputState<T> createState() => ChipsInputState<T>();
}

class ChipsInputState<T> extends State<ChipsInput<T>> with TextInputClient {
  static const kObjectReplacementChar = 0xFFFC;

  Set<T> _chips = {};
  int _searchId = 0;

  FocusNode? _focusNode;
  TextEditingValue _value = const TextEditingValue();
  TextInputConnection? _connection;

  String get text {
    return String.fromCharCodes(
      _value.text.codeUnits.where((ch) => ch != kObjectReplacementChar),
    );
  }

  @override
  TextEditingValue get currentTextEditingValue => _value;

  bool get _hasInputConnection => _connection != null && _connection!.attached;

  void requestKeyboard() {
    if (_focusNode?.hasFocus != null && _focusNode!.hasFocus) {
      _openInputConnection();
    } else {
      FocusScope.of(context).requestFocus(_focusNode);
    }
  }

  void selectSuggestion(T data) {
    setState(() {
      _chips.add(data);
      _updateTextInputState();
    });
    widget.onChanged(_chips.toList(growable: false));
  }

  void deleteChip(T data) {
    setState(() {
      _chips.remove(data);
      _updateTextInputState();
    });
    widget.onChanged(_chips.toList(growable: false));
  }

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode!.addListener(_onFocusChanged);
  }

  void _onFocusChanged() {
    if (_focusNode?.hasFocus != null && _focusNode!.hasFocus) {
      _openInputConnection();
    } else {
      _closeInputConnectionIfNeeded();
    }
    setState(() {
      // rebuild so that _TextCursor is hidden.
    });
  }

  @override
  void dispose() {
    _focusNode?.dispose();
    _closeInputConnectionIfNeeded();
    super.dispose();
  }

  void _openInputConnection() {
    if (!_hasInputConnection) {
      _connection = TextInput.attach(this, const TextInputConfiguration());
      _connection!.setEditingState(_value);
    }
    _connection!.show();
  }

  void _closeInputConnectionIfNeeded() {
    if (_hasInputConnection) {
      _connection!.close();
      _connection = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    var chipsChildren = _chips
        .map<Widget>(
          (data) => widget.chipBuilder(context, this, data),
        )
        .toList();

    chipsChildren.add(
      SizedBox(
        height: 20,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              text,
            ),
            _TextCaret(
              resumed: _focusNode!.hasFocus,
            ),
          ],
        ),
      ),
    );

    final showSuggestions =
        _focusNode!.hasFocus && widget.suggestions.isNotEmpty;

    return Column(
      children: <Widget>[
        AnimatedContainer(
          height: showSuggestions ? 100 : 0,
          duration: const Duration(milliseconds: 300),
          width: double.maxFinite,
          margin: showSuggestions ? const EdgeInsets.only(bottom: 8) : null,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Scrollbar(
              interactive: true,
              thumbVisibility: true,
              child: ListView.separated(
                primary: true,
                shrinkWrap: true,
                itemCount: widget.suggestions.length,
                itemBuilder: (BuildContext context, int index) {
                  return widget.suggestionBuilder(
                      context, this, widget.suggestions[index]);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    height: 1,
                  );
                },
              ),
            ),
          ),
        ),
        MouseRegion(
          cursor: SystemMouseCursors.text,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: requestKeyboard,
            child: InputDecorator(
              decoration: widget.decoration,
              isFocused: _focusNode!.hasFocus,
              isEmpty: _value.text.isEmpty,
              child: Wrap(
                spacing: 4.0,
                runSpacing: 4.0,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: chipsChildren,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void updateEditingValue(TextEditingValue value) {
    final oldCount = _countReplacements(_value);
    final newCount = _countReplacements(value);
    setState(() {
      if (newCount < oldCount) {
        _chips = Set.from(_chips.take(newCount));
      }
      _value = value;
    });
    _onSearchChanged(text);
  }

  int _countReplacements(TextEditingValue value) {
    return value.text.codeUnits
        .where((ch) => ch == kObjectReplacementChar)
        .length;
  }

  @override
  void updateFloatingCursor(RawFloatingCursorPoint point) {
    // Not required
  }

  @override
  void connectionClosed() {
    _focusNode?.unfocus();
  }

  @override
  void performAction(TextInputAction action) {
    _focusNode?.unfocus();
  }

  void _updateTextInputState() {
    final text =
        String.fromCharCodes(_chips.map((_) => kObjectReplacementChar));
    _value = TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
      composing: TextRange(start: 0, end: text.length),
    );
    _connection?.setEditingState(_value);
  }

  void _onSearchChanged(String value) async {
    final localId = ++_searchId;
    if (_searchId == localId && mounted) {
      widget.onSearchChanged(value);
    }
  }

  @override
  // implement currentAutofillScope
  AutofillScope? get currentAutofillScope => throw UnimplementedError();

  @override
  void performPrivateCommand(String action, Map<String, dynamic> data) {
    // implement performPrivateCommand
    // print('performPrivateCommand: $action, $data');
  }

  @override
  void showAutocorrectionPromptRect(int start, int end) {
    // implement showAutocorrectionPromptRect
  }
}

class _TextCaret extends StatefulWidget {
  const _TextCaret({
    Key? key,
    this.duration = const Duration(milliseconds: 500),
    this.resumed = false,
  }) : super(key: key);

  final Duration duration;
  final bool resumed;

  @override
  _TextCursorState createState() => _TextCursorState();
}

class _TextCursorState extends State<_TextCaret>
    with SingleTickerProviderStateMixin {
  bool _displayed = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(widget.duration, _onTimer);
  }

  void _onTimer(Timer timer) {
    setState(() => _displayed = !_displayed);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FractionallySizedBox(
      heightFactor: 0.7,
      child: Opacity(
        opacity: _displayed && widget.resumed ? 1.0 : 0.0,
        child: Container(
          width: 2.0,
          color: theme.textTheme.bodyMedium!.color,
        ),
      ),
    );
  }
}
