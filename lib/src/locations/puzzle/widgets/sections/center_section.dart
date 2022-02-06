part of '../../puzzle_page.dart';

/// {@template centerSection}
/// Displays the board of the puzzle.
/// {@endtemplate}
class CenterSection extends StatelessWidget {
  /// {@macro centerSection}
  const CenterSection({required this.levelScrollPageController, Key? key}) : super(key: key);

  /// [PageController] to manage current shown puzzle level
  final PageController levelScrollPageController;

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutBuilder(
      medium: (context, child) => child!,
      extraLarge: (context, child) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 32),
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Center(
            child: child,
          ),
        );
      },
      child: (breakpoint) {
        var scrollDirection = Axis.vertical;
        if (breakpoint.index <= Breakpoint.md.index) {
          scrollDirection = Axis.horizontal;
        }

        return BlocBuilder<PuzzlePageBloc, PuzzlePageBlocState>(
          builder: (context, puzzlePageBlocState) {
            if (puzzlePageBlocState is! PuzzlePageBlocLevelState) {
              return const SizedBox();
            }
            return BlocProvider.value(
              value: puzzlePageBlocState.puzzleBloc,
              child: const PuzzleBoard(
                key: Key('puzzle_board_level_0'),
              ),
            );
          },
        );

        return PageView.builder(
          controller: levelScrollPageController,
          scrollDirection: scrollDirection,
          itemCount: 16,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return PuzzleBoard(
              key: Key('puzzle_board_level_$index'),
            );
          },
        );
      },
    );
  }
}
