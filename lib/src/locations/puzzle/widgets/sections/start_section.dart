part of '../../puzzle_page.dart';

/// {@template simple_start_section}
/// Displays the start section of the puzzle based on [BlocProvider]'s bloc state.
/// {@endtemplate}
class _StartSection extends StatelessWidget {
  /// {@macro simple_start_section}
  const _StartSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.select((PuzzleBloc bloc) => bloc.state);

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
          extraLarge: (_, __) => const _PuzzleActionsSection(),
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
