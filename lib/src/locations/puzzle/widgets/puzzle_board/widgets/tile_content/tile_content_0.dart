part of '../../puzzle_board.dart';

class _TileContent0 extends StatelessWidget {
  const _TileContent0({
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
    );
  }
}
