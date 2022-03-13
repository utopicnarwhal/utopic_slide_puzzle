part of '../../../puzzle_page.dart';

class _ShuffleButton extends StatelessWidget {
  const _ShuffleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UtopicButton(
      text: Dictums.of(context).shuffleButtonText,
      leading: const Icon(Icons.refresh),
      onPressed: () {
        final puzzlePageBlocState = BlocProvider.of<PuzzlePageBloc>(context).state;
        if (puzzlePageBlocState is PuzzlePageBlocLevelState) {
          puzzlePageBlocState.puzzleBloc.reset();
        }
      },
    );
  }
}
