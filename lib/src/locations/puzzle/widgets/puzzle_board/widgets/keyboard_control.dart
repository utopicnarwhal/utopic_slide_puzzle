part of '../puzzle_board.dart';

class _KeyboardControl extends StatefulWidget {
  const _KeyboardControl({
    required this.puzzleBloc,
    required this.child,
    Key? key,
  }) : super(key: key);

  final Widget child;

  final PuzzleBloc puzzleBloc;

  @override
  State<_KeyboardControl> createState() => _KeyboardControlState();
}

class _KeyboardControlState extends State<_KeyboardControl> {
  StreamSubscription<KeyEvent>? _keyboardEventStreamListener;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _keyboardEventStreamListener?.cancel();
    _keyboardEventStreamListener = GlobalKeyboardListener.of(context)?.keyboardEventStream.listen(_handleKeyEvent);
  }

  @override
  void dispose() {
    _keyboardEventStreamListener?.cancel();
    super.dispose();
  }

  void _handleKeyEvent(KeyEvent event) {
    if (event is! KeyDownEvent) {
      return;
    }

    if (event.logicalKey == LogicalKeyboardKey.arrowLeft || event.physicalKey == PhysicalKeyboardKey.arrowLeft) {
      widget.puzzleBloc.moveLeft();
    } else if (event.logicalKey == LogicalKeyboardKey.arrowUp || event.physicalKey == PhysicalKeyboardKey.arrowUp) {
      widget.puzzleBloc.moveUp();
    } else if (event.logicalKey == LogicalKeyboardKey.arrowRight ||
        event.physicalKey == PhysicalKeyboardKey.arrowRight) {
      widget.puzzleBloc.moveRight();
    } else if (event.logicalKey == LogicalKeyboardKey.arrowDown || event.physicalKey == PhysicalKeyboardKey.arrowDown) {
      widget.puzzleBloc.moveDown();
    } else if (event.physicalKey == PhysicalKeyboardKey.keyA) {
      widget.puzzleBloc.moveLeft();
    } else if (event.physicalKey == PhysicalKeyboardKey.keyW) {
      widget.puzzleBloc.moveUp();
    } else if (event.physicalKey == PhysicalKeyboardKey.keyD) {
      widget.puzzleBloc.moveRight();
    } else if (event.physicalKey == PhysicalKeyboardKey.keyS) {
      widget.puzzleBloc.moveDown();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
