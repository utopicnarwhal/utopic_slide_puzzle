import 'dart:async';

import 'package:flutter/material.dart';

/// {@template global_keyboard_listener}
/// Handle keyboard events.
///
/// Usually this widget should be in a [MaterialApp]'s builder method
/// or only where you need to listen keyboard events
/// {@endtemplate}
class GlobalKeyboardListener extends StatefulWidget {
  /// {@macro global_keyboard_listener}
  const GlobalKeyboardListener({
    required this.builder,
    this.onKeyEvent,
    Key? key,
  }) : super(key: key);

  /// The child builder widget.
  ///
  /// It is common to give the root [MaterialApp] to pass the themeMode into it
  final Widget Function(BuildContext context) builder;

  /// Main key event listener
  ///
  /// return false to prevent passing key event to the [GlobalKeyboardListenerState.keyboardEventStream]
  final bool? Function(KeyEvent)? onKeyEvent;

  @override
  State<GlobalKeyboardListener> createState() => GlobalKeyboardListenerState();

  /// The data from the closest [GlobalKeyboardListenerState] instance that encloses the given context.
  static GlobalKeyboardListenerState? of(BuildContext context) {
    return context.findAncestorStateOfType<GlobalKeyboardListenerState>();
  }
}

/// Widget state class of the [GlobalKeyboardListener] widget
class GlobalKeyboardListenerState extends State<GlobalKeyboardListener> {
  late StreamController<KeyEvent> _keyboardEventStreamController;

  /// Listen to this [Stream] to get a keyboard event
  late Stream<KeyEvent> keyboardEventStream;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _keyboardEventStreamController = StreamController();
    keyboardEventStream = _keyboardEventStreamController.stream.asBroadcastStream();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _keyboardEventStreamController.close();
    super.dispose();
  }

  void _handleKeyEvent(KeyEvent event) {
    final passToStream = widget.onKeyEvent?.call(event);
    if (passToStream != false) {
      _keyboardEventStreamController.add(event);
    }
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: _focusNode,
      autofocus: true,
      onKeyEvent: _handleKeyEvent,
      child: Builder(builder: widget.builder),
    );
  }
}
