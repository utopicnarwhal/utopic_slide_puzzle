part of '../../puzzle_board.dart';

const _kanjiNumbersMap = {
  1: '一',
  2: '二',
  3: '三',
  4: '四',
  5: '五',
  6: '六',
  7: '七',
  8: '八',
  9: '九',
  10: '十',
  11: '十一',
  12: '十二',
  13: '十三',
  14: '十四',
  15: '十五',
  16: '十六',
};

const _romanNumbersMap = {
  1: 'I',
  2: 'II',
  3: 'III',
  4: 'IV',
  5: 'V',
  6: 'VI',
  7: 'VII',
  8: 'VIII',
  9: 'IX',
  10: 'X',
  11: 'XI',
  12: 'XII',
  13: 'XIII',
  14: 'XIV',
  15: 'XV',
  16: 'XVI',
};

const _englishAlphabetMap = {
  1: 'A',
  2: 'B',
  3: 'C',
  4: 'D',
  5: 'E',
  6: 'F',
  7: 'G',
  8: 'H',
  9: 'I',
  10: 'J',
  11: 'K',
  12: 'L',
  13: 'M',
  14: 'N',
  15: 'O',
  16: 'P',
};

/// Tile content of the [PuzzleLevels.swaps]
class _SwapsTileContent extends StatelessWidget {
  const _SwapsTileContent({
    required this.tile,
    required this.numberOfMoves,
    required this.buttonStyle,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final Tile tile;
  final int numberOfMoves;
  final ButtonStyle buttonStyle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    late Widget? child;
    if (numberOfMoves == 0) {
      child = Text(
        tile.value.toString(),
        overflow: TextOverflow.visible,
        textAlign: TextAlign.center,
        maxLines: 1,
      );
    } else {
      switch (numberOfMoves % 3) {
        case 0:
          child = Text(
            _englishAlphabetMap[tile.value] ?? '',
            key: Key(_englishAlphabetMap[tile.value] ?? ''),
            overflow: TextOverflow.visible,
            textAlign: TextAlign.center,
            maxLines: 1,
            textScaleFactor: 1,
          );
          break;
        case 1:
          child = Text(
            _kanjiNumbersMap[tile.value] ?? '',
            key: Key(_kanjiNumbersMap[tile.value] ?? ''),
            overflow: TextOverflow.visible,
            textAlign: TextAlign.center,
            maxLines: 1,
            style: const TextStyle(fontFamily: 'YujiSyuku'),
            textScaleFactor: 1,
          );
          break;
        case 2:
          child = Text(
            _romanNumbersMap[tile.value] ?? '',
            key: Key(_romanNumbersMap[tile.value] ?? ''),
            overflow: TextOverflow.visible,
            textAlign: TextAlign.center,
            maxLines: 1,
            textScaleFactor: 1,
          );
          break;
        default:
      }
    }

    return ElevatedButton(
      clipBehavior: Clip.hardEdge,
      style: buttonStyle,
      onPressed: onPressed,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        switchInCurve: Curves.easeInCubic,
        switchOutCurve: Curves.easeOutCubic,
        child: child,
      ),
    );
  }
}
