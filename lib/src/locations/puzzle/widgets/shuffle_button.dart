part of '../puzzle_page.dart';

/// {@template puzzle_shuffle_button}
/// Displays the button to shuffle the puzzle.
/// {@endtemplate}
@visibleForTesting
class SimplePuzzleShuffleButton extends StatelessWidget {
  /// {@macro puzzle_shuffle_button}
  const SimplePuzzleShuffleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UtopicButton(
      onPressed: () => context.read<PuzzleBloc>().add(const PuzzleReset()),
      text: Dictums.of(context).shuffleButtonText,
      size: UtopicButtonSize.large,
      leading: const Icon(
        Icons.refresh_rounded,
        size: 20,
      ),
    );
  }
}
