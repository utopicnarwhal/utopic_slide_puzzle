part of '../../puzzle_board.dart';

/// Tile content of the [PuzzleLevels.remember]
class _RememberTileContent extends StatelessWidget {
  const _RememberTileContent({
    required this.tile,
    required this.tappedTilesHistory,
    required this.buttonStyle,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final Tile tile;
  final List<Tile> tappedTilesHistory;
  final ButtonStyle buttonStyle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    var opacity = tile.value == 16 ? 1.0 : 0.0;

    const traceLength = 4;
    for (var i = tappedTilesHistory.length - 1; i >= 0 && i >= tappedTilesHistory.length - traceLength; --i) {
      if (tappedTilesHistory[i].value == tile.value) {
        opacity = (1 / traceLength) * (i - tappedTilesHistory.length + 1 + traceLength);
        break;
      }
    }

    return ElevatedButton(
      clipBehavior: Clip.hardEdge,
      style: buttonStyle,
      onPressed: onPressed,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: opacity,
        curve: Curves.easeInOutCubic,
        child: Text(
          tile.value.toString(),
          overflow: TextOverflow.visible,
          textAlign: TextAlign.center,
          maxLines: 1,
          textScaleFactor: 1,
        ),
      ),
    );
  }
}
