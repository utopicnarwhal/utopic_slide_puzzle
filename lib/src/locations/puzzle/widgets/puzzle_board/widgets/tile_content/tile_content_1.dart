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
    final maxHeight = constraints.maxHeight + (tilePadding * 2);
    final maxWidth = constraints.maxWidth + (tilePadding * 2);

    final resizedImage = context.select<PuzzleBloc, ui.Image?>((bloc) => bloc.state.resizedImage);

    if (resizedImage == null) {
      return Shimmer.fromColors(
        baseColor: UtopicPalette.shimmerBaseColor,
        highlightColor: UtopicPalette.shimmerHighlightColor,
        child: Container(color: Colors.white),
      );
    }

    return OverflowBox(
      maxHeight: maxHeight,
      maxWidth: maxWidth,
      child: CustomPaint(
        size: Size(maxWidth, maxHeight),
        painter: _ImageDrawer(
          image: resizedImage,
          position: tile.correctPosition,
        ),
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
    var xStart = 0;
    var yStart = 0;
    late double stepLength;
    if (image.width > image.height) {
      xStart = ((image.width - image.height) / 2).floor();
      stepLength = (image.height / 4).floor().toDouble();
    } else {
      yStart = ((image.height - image.width) / 2).floor();
      stepLength = (image.width / 4).floor().toDouble();
    }

    canvas.drawImageRect(
      image,
      Rect.fromLTWH(
        xStart + ((position.x - 1) * stepLength),
        yStart + ((position.y - 1) * stepLength),
        stepLength,
        stepLength,
      ),
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..filterQuality = ui.FilterQuality.high,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
