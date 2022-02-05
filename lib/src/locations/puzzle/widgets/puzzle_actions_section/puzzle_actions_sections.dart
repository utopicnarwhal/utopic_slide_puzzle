part of '../../puzzle_page.dart';

class _PuzzleActionsSection extends StatelessWidget {
  const _PuzzleActionsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: const [
        _ToTheNextLevelButton(),
        _ShuffleButton(),
      ],
    );
  }
}
