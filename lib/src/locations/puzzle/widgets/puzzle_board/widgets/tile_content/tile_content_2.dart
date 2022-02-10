part of '../../puzzle_board.dart';

class _TileContent2 extends StatelessWidget {
  const _TileContent2({
    required this.tile,
    required this.numberOfMoves,
    Key? key,
  }) : super(key: key);

  final Tile tile;
  final int numberOfMoves;

  @override
  Widget build(BuildContext context) {
    return Text(
      tile.value.toString(),
      overflow: TextOverflow.visible,
      textAlign: TextAlign.center,
      maxLines: 1,
    );
  }
}
