part of '../../puzzle_board.dart';

class _TileContent1 extends StatelessWidget {
  const _TileContent1({
    required this.tile,
    required this.constraints,
    required this.tilePadding,
    Key? key,
  }) : super(key: key);

  final Tile tile;
  final BoxConstraints constraints;
  final double tilePadding;

  @override
  Widget build(BuildContext context) {
    final maxHeight = constraints.maxHeight + tilePadding;
    final maxWidth = constraints.maxWidth + tilePadding;

    return OverflowBox(
      maxHeight: maxHeight,
      maxWidth: maxWidth,
      child: BlocBuilder<PuzzleBloc, PuzzleState>(
        builder: (context, puzzleState) {
          if (puzzleState.resizedImage == null) {
            return const SizedBox();
          }
          return CustomPaint(
            size: Size(maxWidth, maxHeight),
            painter: _ImageDrawer(
              image: puzzleState.resizedImage!,
              position: tile.correctPosition,
            ),
          );
        },
      ),
    );
  }
}

class _ImageDrawer extends CustomPainter {
  _ImageDrawer({
    required this.image,
    required this.position,
  });

  ui.Image image;
  Position position;

  @override
  void paint(Canvas canvas, Size size) {
    final xLength = image.width / 4;
    final yLength = image.height / 4;

    canvas.drawImageRect(
      image,
      Rect.fromLTWH(
        (position.x - 1) * xLength,
        (position.y - 1) * yLength,
        xLength,
        yLength,
      ),
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint(),
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
