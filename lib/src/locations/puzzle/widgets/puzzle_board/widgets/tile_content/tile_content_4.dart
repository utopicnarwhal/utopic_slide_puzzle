part of '../../puzzle_board.dart';

Map<int, String> _tileValueTileAssetImageFileMap = {
  1: 'B3.svg',
  2: 'C4.svg',
  3: 'D4.svg',
  4: 'E4.svg',
  5: 'F4.svg',
  6: 'G4.svg',
  7: 'A4.svg',
  8: 'B4.svg',
  9: 'C5.svg',
  10: 'D5.svg',
  11: 'E5.svg',
  12: 'F5.svg',
  13: 'G5.svg',
  14: 'A5.svg',
  15: 'B5.svg',
  16: 'C6.svg',
};

class _TileContent4 extends StatefulWidget {
  const _TileContent4({
    required this.tile,
    required this.isTileMoved,
    Key? key,
  }) : super(key: key);

  final Tile tile;
  final bool isTileMoved;

  @override
  State<_TileContent4> createState() => _TileContent4State();
}

class _TileContent4State extends State<_TileContent4> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late _BounceHitFadeCurve _bounceHitFadeCurve;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      reverseDuration: _kSlideTileDuration * 4,
    );
    _bounceHitFadeCurve = _BounceHitFadeCurve(
      originalBounceDuration: _kSlideTileDuration,
      realDuration: _animationController.reverseDuration!,
      delayBeforeFirstBounce: _kSlideTileDuration * _kFirstBounceHitRatio,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (_tileValueTileAssetImageFileMap[widget.tile.value] == null) {
          return const SizedBox();
        }

        final child = SvgPicture.asset(
          'assets/images/music_notes_and_staffs/${_tileValueTileAssetImageFileMap[widget.tile.value]}',
          color: Theme.of(context).primaryTextTheme.bodyText1?.color,
          fit: BoxFit.cover,
          height: constraints.maxHeight,
          width: constraints.maxWidth,
        );

        if (widget.tile.value == 16) {
          return child;
        }

        if (widget.isTileMoved) {
          _animationController.reverse(from: 0.999).onError((error, _) {
            debugPrint(error.toString());
          });
        }

        return FadeTransition(
          opacity: CurveTween(curve: _bounceHitFadeCurve).animate(_animationController),
          child: child,
        );
      },
    );
  }
}

class _BounceHitFadeCurve extends Curve {
  const _BounceHitFadeCurve({
    required this.originalBounceDuration,
    required this.realDuration,
    required this.delayBeforeFirstBounce,
  });

  final Duration originalBounceDuration;
  final Duration realDuration;
  final Duration delayBeforeFirstBounce;

  @override
  double transformInternal(double t) {
    final flippedT = 1 - t;
    if (flippedT < delayBeforeFirstBounce.inMilliseconds / realDuration.inMilliseconds || flippedT > 1) {
      return 0;
    } else if (flippedT < originalBounceDuration.inMilliseconds / realDuration.inMilliseconds) {
      return 1;
    }
    final offset = originalBounceDuration.inMilliseconds / realDuration.inMilliseconds;

    return 1 - Curves.easeOutCubic.transform((flippedT - offset) / (1 - offset));
  }
}
