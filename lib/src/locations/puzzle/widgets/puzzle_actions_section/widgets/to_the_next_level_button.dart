part of '../../../puzzle_page.dart';

class _ToTheNextLevelButton extends StatelessWidget {
  const _ToTheNextLevelButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final puzzlePageBlocState = context.select<PuzzlePageBloc, PuzzlePageBlocState>((value) => value.state);
    if (puzzlePageBlocState is! PuzzlePageBlocLevelState) {
      return const SizedBox();
    }

    return BlocBuilder<PuzzleBloc, PuzzleState>(
      bloc: puzzlePageBlocState.puzzleBloc,
      builder: (context, puzzleBlocState) {
        if (puzzleBlocState.puzzleStatus != PuzzleStatus.complete) {
          return const SizedBox();
        }
        return FloatingActionButton.extended(
          label: Text(Dictums.of(context).nextLevelButtonLabel),
          backgroundColor: Theme.of(context).primaryColor,
          icon: const Icon(Icons.arrow_forward_rounded),
          onPressed: () {
            BlocProvider.of<PuzzlePageBloc>(context).changeLevelTo(puzzlePageBlocState.level + 1);
          },
        );
      },
    );
  }
}
