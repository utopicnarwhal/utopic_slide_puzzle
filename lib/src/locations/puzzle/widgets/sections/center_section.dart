part of '../../puzzle_page.dart';

/// {@template centerSection}
/// Displays the board of the puzzle.
/// {@endtemplate}
class CenterSection extends StatelessWidget {
  /// {@macro centerSection}
  const CenterSection({
    required this.levelScrollPageController,
    required this.levelScrollGlobalKey,
    Key? key,
  }) : super(key: key);

  /// [PageController] to manage current shown puzzle level
  final PageController levelScrollPageController;

  /// [GlobalKey] to say Flutter that it's the same widget when the layout changes
  final GlobalKey? levelScrollGlobalKey;

  @override
  Widget build(BuildContext context) {
    var scrollDirection = Axis.horizontal;

    var tilePadding = 6.0;
    var boardSize = 450.0;
    double? centerSectionHeight;

    return ResponsiveLayoutBuilder(
      tiny: (context, child) {
        tilePadding = 2;
        boardSize = 312;
        centerSectionHeight = boardSize;
        return child!;
      },
      extraSmall: (context, child) {
        tilePadding = 2;
        boardSize = 344;
        centerSectionHeight = boardSize;
        return child!;
      },
      small: (context, child) {
        tilePadding = 4;
        boardSize = 424;
        centerSectionHeight = boardSize;
        return child!;
      },
      medium: (context, child) {
        tilePadding = 4;
        centerSectionHeight = boardSize;
        return child!;
      },
      large: (context, child) {
        scrollDirection = Axis.vertical;
        boardSize = 640;
        centerSectionHeight = MediaQuery.of(context).size.height;
        return child!;
      },
      extraLarge: (context, child) {
        scrollDirection = Axis.vertical;
        tilePadding = 8;
        boardSize = 864;
        centerSectionHeight = MediaQuery.of(context).size.height;
        return child!;
      },
      child: (breakpoint) {
        return SizedBox(
          height: centerSectionHeight,
          child: PageView.builder(
            key: levelScrollGlobalKey,
            clipBehavior: Clip.none,
            controller: levelScrollPageController,
            scrollDirection: scrollDirection,
            itemCount: PuzzleLevels.values.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Center(
                child: BlocProvider.value(
                  value: BlocProvider.of<PuzzlePageBloc>(context).getPuzzleBlocForLevel(PuzzleLevels.values[index]),
                  child: PuzzleBoard(
                    key: Key('puzzle_board_level_$index'),
                    tilePadding: tilePadding,
                    boardSize: boardSize,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
