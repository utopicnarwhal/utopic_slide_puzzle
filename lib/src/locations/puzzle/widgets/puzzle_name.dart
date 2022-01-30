part of '../puzzle_page.dart';

/// {@template puzzle_name}
/// Displays the name of the current puzzle theme.
/// Visible only on a large layout.
/// {@endtemplate}
class _PuzzleName extends StatelessWidget {
  /// {@macro puzzle_name}
  const _PuzzleName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutBuilder(
      small: (context, child) => const SizedBox(),
      medium: (context, child) => const SizedBox(),
      extraLarge: (context, child) => Text(
        Dictums.of(context).puzzleChallengeTitle,
        style: Theme.of(context).textTheme.headline5?.copyWith(
              color: Theme.of(context).hintColor,
            ),
      ),
    );
  }
}
