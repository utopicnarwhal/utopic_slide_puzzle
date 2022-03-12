part of '../../puzzle_page.dart';

class _PuzzleInfoArea extends StatelessWidget {
  const _PuzzleInfoArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PuzzlePageBloc, PuzzlePageBlocState>(
      builder: (context, puzzlePageBlocState) {
        if (puzzlePageBlocState is! PuzzlePageBlocLevelState) {
          return const SizedBox();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _PuzzleName(),
            const Gap(20),
            BlocBuilder<PuzzleBloc, PuzzleState>(
              bloc: puzzlePageBlocState.puzzleBloc,
              buildWhen: (previous, current) => previous.puzzleStatus != current.puzzleStatus,
              builder: (context, puzzleState) {
                final levelNumber = puzzlePageBlocState.level.index + 1;

                return _PuzzleTitle(
                  title: puzzleState.puzzleStatus == PuzzleStatus.complete
                      ? Dictums.of(context).puzzleSolved
                      : Dictums.of(context).levelNumberIndicator(levelNumber),
                );
              },
            ),
            const Gap(20),
            BlocBuilder<PuzzleBloc, PuzzleState>(
              bloc: puzzlePageBlocState.puzzleBloc,
              buildWhen: (previous, current) =>
                  previous.numberOfMoves != current.numberOfMoves ||
                  previous.numberOfCorrectTiles != current.numberOfCorrectTiles,
              builder: (context, puzzleState) {
                return _StopwatchAndNumberOfMovesAndTilesLeft(
                  numberOfMoves: puzzleState.numberOfMoves,
                  numberOfTilesLeft: puzzleState.numberOfTilesLeft,
                );
              },
            ),
            const Gap(12),
          ],
        );
      },
    );
  }
}
