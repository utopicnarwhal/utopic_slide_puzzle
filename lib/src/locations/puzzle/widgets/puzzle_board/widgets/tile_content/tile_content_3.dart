part of '../../puzzle_board.dart';

class _TileContent3 extends StatelessWidget {
  const _TileContent3({
    required this.tile,
    required this.tappedTilesHistory,
    Key? key,
  }) : super(key: key);

  final Tile tile;
  final List<Tile> tappedTilesHistory;

  @override
  Widget build(BuildContext context) {
    var opacity = 0.0;

    const traceLength = 4;
    for (var i = tappedTilesHistory.length - 1; i >= 0 && i >= tappedTilesHistory.length - traceLength; --i) {
      if (tappedTilesHistory[i].value == tile.value) {
        opacity = (1 / traceLength) * (i - tappedTilesHistory.length + 1 + traceLength);
      }
    }

    return AnimatedOpacity(
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
    );
  }
}
