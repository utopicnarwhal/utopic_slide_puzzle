part of '../puzzle_board.dart';

class _KeyboardControl extends StatelessWidget {
  const _KeyboardControl({
    required this.puzzleBloc,
    required this.child,
    Key? key,
  }) : super(key: key);

  final Widget child;

  final PuzzleBloc puzzleBloc;

  void _handleKeyEvent(KeyEvent event) {
    if (event is! KeyDownEvent) {}

    if (event.logicalKey == LogicalKeyboardKey.arrowLeft || event.physicalKey == PhysicalKeyboardKey.arrowLeft) {
      puzzleBloc.moveLeft();
    } else if (event.logicalKey == LogicalKeyboardKey.arrowUp || event.physicalKey == PhysicalKeyboardKey.arrowUp) {
      puzzleBloc.moveUp();
    } else if (event.logicalKey == LogicalKeyboardKey.arrowRight ||
        event.physicalKey == PhysicalKeyboardKey.arrowRight) {
      puzzleBloc.moveRight();
    } else if (event.logicalKey == LogicalKeyboardKey.arrowDown || event.physicalKey == PhysicalKeyboardKey.arrowDown) {
      puzzleBloc.moveDown();
    } else if (event.physicalKey == PhysicalKeyboardKey.keyA) {
      puzzleBloc.moveLeft();
    } else if (event.physicalKey == PhysicalKeyboardKey.keyW) {
      puzzleBloc.moveUp();
    } else if (event.physicalKey == PhysicalKeyboardKey.keyD) {
      puzzleBloc.moveRight();
    } else if (event.physicalKey == PhysicalKeyboardKey.keyS) {
      puzzleBloc.moveDown();
    }
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: FocusNode(
        descendantsAreFocusable: false,
      ),
      autofocus: true,
      onKeyEvent: _handleKeyEvent,
      child: child,
    );
  }
}
