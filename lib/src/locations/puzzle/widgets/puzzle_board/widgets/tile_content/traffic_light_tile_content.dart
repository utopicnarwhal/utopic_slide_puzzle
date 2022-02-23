part of '../../puzzle_board.dart';

/// Tile content of the [PuzzleLevels.trafficLight]
class _TrafficLightTileContent extends StatefulWidget {
  const _TrafficLightTileContent({
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
  State<_TrafficLightTileContent> createState() => _TrafficLightTileContentState();
}

class _TrafficLightTileContentState extends State<_TrafficLightTileContent> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  ColorTween? _colorTween;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void didUpdateWidget(covariant _TrafficLightTileContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.trafficLight != widget.trafficLight) {
      final color = _colorFromTrafficLight(widget.trafficLight);
      final oldColor = _colorFromTrafficLight(oldWidget.trafficLight);
      _colorTween = ColorTween(begin: oldColor, end: color);
      _animationController.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Color _colorFromTrafficLight(TrafficLight trafficLight) {
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
    return color;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        final buttonColor = _colorTween?.evaluate(_animationController);

        return ElevatedButton(
          key: ValueKey(widget.tile.value),
          style: ElevatedButton.styleFrom(
            elevation: 0,
            textStyle: widget.buttonStyle.textStyle?.resolve({}),
            shape: widget.buttonStyle.shape?.resolve({}),
            padding: EdgeInsets.zero,
            primary: buttonColor ?? _colorFromTrafficLight(widget.trafficLight),
          ).copyWith(
            elevation: MaterialStateProperty.resolveWith(
              (states) => [MaterialState.focused, MaterialState.hovered, MaterialState.selected]
                      .any((element) => states.contains(element))
                  ? 8
                  : 0,
            ),
          ),
          onPressed: widget.onPressed,
          child: child,
        );
      },
      child: Center(
        child: Text(
          widget.tile.value.toString(),
          overflow: TextOverflow.visible,
          textAlign: TextAlign.center,
          maxLines: 1,
          textScaleFactor: 1,
        ),
      ),
    );
  }
}
