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
};

class _TileContent4 extends StatelessWidget {
  const _TileContent4({
    required this.tile,
    required this.isTileMoved,
    Key? key,
  }) : super(key: key);

  final Tile tile;
  final bool isTileMoved;

  @override
  Widget build(BuildContext context) {
    if (_tileValueTileAssetImageFileMap[tile.value] == null || !isTileMoved) {
      return const SizedBox();
    }
    return FutureBuilder<dynamic>(
      future: Future<dynamic>.delayed(_kSlideTileDuration * 0.38),
      builder: (context, snapshot) {
        return AnimatedOpacity(
          opacity: snapshot.connectionState != ConnectionState.done ? 1 : 0,
          duration: snapshot.connectionState == ConnectionState.done ? const Duration(seconds: 3) : Duration.zero,
          curve: Curves.easeOutCubic,
          child: SvgPicture.asset(
            'assets/images/music_notes_and_staffs/${_tileValueTileAssetImageFileMap[tile.value]}',
            color: Theme.of(context).primaryTextTheme.bodyText1?.color,
          ),
        );
      },
    );
  }
}
