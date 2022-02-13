part of '../../puzzle_page.dart';

class _PuzzleActionsSection extends StatelessWidget {
  const _PuzzleActionsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final puzzleState = context.select<PuzzlePageBloc, PuzzlePageBlocState>((puzzlePageBloc) => puzzlePageBloc.state);

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        const _ShuffleButton(),
        const _ToTheNextLevelButton(),
        if (puzzleState is PuzzlePageBlocLevelState && puzzleState.level == PuzzleLevels.image)
          const _UploadCustomImageButton(),
      ],
    );
  }
}
