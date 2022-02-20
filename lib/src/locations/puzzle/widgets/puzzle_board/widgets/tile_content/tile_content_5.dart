part of '../../puzzle_board.dart';

class _TileContent5 extends StatelessWidget {
  const _TileContent5({
    required this.tile,
    Key? key,
  }) : super(key: key);

  final Tile tile;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: Stream.periodic(const Duration(seconds: 2), (i) => i % 3),
      builder: (context, snapshot) {
        late Color color;
        switch (snapshot.data) {
          case 0:
            color = Colors.green;
            break;
          case 1:
            color = Colors.yellow;
            break;
          case 2:
            color = Colors.red;
            break;
          default:
            color = Colors.green;
        }

        return Material(
          type: MaterialType.transparency,
          key: ValueKey(tile.value),
          color: color,
          child: Text(
            tile.value.toString(),
            overflow: TextOverflow.visible,
            textAlign: TextAlign.center,
            maxLines: 1,
            textScaleFactor: 1,
          ),
        );
      },
    );
  }
}
