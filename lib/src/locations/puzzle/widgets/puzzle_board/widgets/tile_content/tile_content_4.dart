part of '../../puzzle_board.dart';

class _TileContent4 extends StatelessWidget {
  const _TileContent4({
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
