part of '../../puzzle_board.dart';

class _TileContent0 extends StatelessWidget {
  const _TileContent0({
    required this.tile,
    required this.buttonStyle,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final Tile tile;
  final ButtonStyle buttonStyle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      clipBehavior: Clip.hardEdge,
      style: buttonStyle,
      onPressed: onPressed,
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
