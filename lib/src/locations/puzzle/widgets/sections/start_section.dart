part of '../../puzzle_page.dart';

/// {@template simple_start_section}
/// Displays the start section of the puzzle based on [state].
/// {@endtemplate}
class _StartSection extends StatelessWidget {
  /// {@macro simple_start_section}
  const _StartSection({
    Key? key,
    required this.state,
  }) : super(key: key);

  /// The state of the puzzle.
  final PuzzleState state;

  @override
  Widget build(BuildContext context) {
    final result = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(40),
        const _PuzzleName(),
        const Gap(20),
        _PuzzleTitle(
          title: state.puzzleStatus == PuzzleStatus.complete
              ? Dictums.of(context).puzzleSolved
              : 'Level 1', // TODO(sergei): add level name here
        ),
        const Gap(20),
        _NumberOfMovesAndTilesLeft(
          numberOfMoves: state.numberOfMoves,
          numberOfTilesLeft: state.numberOfTilesLeft,
        ),
        const Gap(20),
        ResponsiveLayoutBuilder(
          medium: (_, __) => const SizedBox(),
          extraLarge: (_, __) => const _ToTheNextLevelButton(),
        ),
      ],
    );

    return ResponsiveLayoutBuilder(
      small: (_, child) => child!,
      medium: (_, child) => child!,
      extraLarge: (_, child) => Padding(
        padding: const EdgeInsets.only(left: 50, right: 32),
        child: child,
      ),
      child: (_) => result,
    );
  }
}
