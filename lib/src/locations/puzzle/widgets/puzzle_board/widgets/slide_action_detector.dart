part of '../puzzle_board.dart';

class _SlideActionDetector extends StatelessWidget {
  _SlideActionDetector({
    required this.puzzleBloc,
    required this.child,
    Key? key,
  }) : super(key: key);

  final Widget child;

  final _focusNode = FocusNode();

  final PuzzleBloc puzzleBloc;

  void _handleKeyEvent(RawKeyEvent event) {
    if (event.repeat != false || event is! RawKeyDownEvent) {
      return;
    }
    print(event);
    if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
      puzzleBloc.moveLeft();
    } else if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
      puzzleBloc.moveUp();
    } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
      puzzleBloc.moveRight();
    } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
      puzzleBloc.moveDown();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(_focusNode);
      },
      child: RawKeyboardListener(
        autofocus: true,
        focusNode: _focusNode,
        onKey: _handleKeyEvent,
        child: SwipeDetector(
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
