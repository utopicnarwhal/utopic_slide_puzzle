part of '../puzzle_board.dart';

class _KeyboardAndSwipeControl extends StatelessWidget {
  _KeyboardAndSwipeControl({
    required this.puzzleBloc,
    required this.child,
    Key? key,
  }) : super(key: key);

  final Widget child;

  final _focusNode = FocusNode();

  final PuzzleBloc puzzleBloc;

  void _handleKeyEvent(KeyEvent event) {
    if (event is! KeyDownEvent) {
      return;
    }
    if (event.logicalKey == LogicalKeyboardKey.arrowLeft || event.physicalKey == PhysicalKeyboardKey.arrowLeft) {
      puzzleBloc.moveLeft();
      return;
    }
    if (event.logicalKey == LogicalKeyboardKey.arrowUp || event.physicalKey == PhysicalKeyboardKey.arrowUp) {
      puzzleBloc.moveUp();
      return;
    }
    if (event.logicalKey == LogicalKeyboardKey.arrowRight || event.physicalKey == PhysicalKeyboardKey.arrowRight) {
      puzzleBloc.moveRight();
      return;
    }
    if (event.logicalKey == LogicalKeyboardKey.arrowDown || event.physicalKey == PhysicalKeyboardKey.arrowDown) {
      puzzleBloc.moveDown();
      return;
    }
    if (event.physicalKey == PhysicalKeyboardKey.keyA) {
      puzzleBloc.moveLeft();
      return;
    }
    if (event.physicalKey == PhysicalKeyboardKey.keyW) {
      puzzleBloc.moveUp();
      return;
    }
    if (event.physicalKey == PhysicalKeyboardKey.keyD) {
      puzzleBloc.moveRight();
      return;
    }
    if (event.physicalKey == PhysicalKeyboardKey.keyS) {
      puzzleBloc.moveDown();
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKeyEvent: _handleKeyEvent,
      child: RawKeyboardListener(
        autofocus: true,
        focusNode: _focusNode,
        child: SwipeDetector(
          behavior: HitTestBehavior.opaque,
          onSwipeLeft: (offset) {
            puzzleBloc.moveLeft();
          },
          onSwipeUp: (offset) {
            puzzleBloc.moveUp();
          },
          onSwipeRight: (offset) {
            puzzleBloc.moveRight();
          },
          onSwipeDown: (offset) {
            puzzleBloc.moveDown();
          },
          child: child,
        ),
      ),
    );
  }
}
