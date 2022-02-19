part of '../../puzzle_board.dart';

class _TileContent5 extends StatelessWidget {
  const _TileContent5({
    required this.tile,
    Key? key,
  }) : super(key: key);

  final Tile tile;

  @override
  Widget build(BuildContext context) {
    return Text(
      tile.value.toString(),
      overflow: TextOverflow.visible,
      textAlign: TextAlign.center,
      maxLines: 1,
      textScaleFactor: 1,
    );
  }
}
