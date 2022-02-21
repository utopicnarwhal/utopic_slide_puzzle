part of '../../puzzle_board.dart';

class _TileContent5 extends StatelessWidget {
  const _TileContent5({
    required this.tile,
    required this.buttonStyle,
    required this.onPressed,
    required this.trafficLight,
    Key? key,
  }) : super(key: key);

  final Tile tile;
  final ButtonStyle buttonStyle;
  final VoidCallback onPressed;
  final TrafficLight trafficLight;

  @override
  Widget build(BuildContext context) {
    late Color color;
    switch (trafficLight) {
      case TrafficLight.green:
        color = Theme.of(context).brightness == ui.Brightness.light ? Colors.lightGreen : Colors.lightGreen.shade800;
        break;
      case TrafficLight.yellow:
        color = Theme.of(context).brightness == ui.Brightness.light ? Colors.amber.shade300 : Colors.amber.shade900;
        break;
      case TrafficLight.red:
        color = Theme.of(context).brightness == ui.Brightness.light ? Colors.red : Colors.red.shade800;
        break;
    }

    return ElevatedButton(
      key: ValueKey(tile.value),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      style: ElevatedButton.styleFrom(
        primary: color,
        elevation: 0,
        textStyle: buttonStyle.textStyle?.resolve({}),
        shape: buttonStyle.shape?.resolve({}),
        padding: EdgeInsets.zero,
      ),
      onPressed: onPressed,
      child: Center(
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
