part of '../puzzle_page.dart';

/// {@template puzzle_title}
/// Displays the title of the puzzle in the given color.
/// {@endtemplate}
class _PuzzleTitle extends StatelessWidget {
  /// {@macro puzzle_title}
  const _PuzzleTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  /// The title to be displayed.
  final String title;

  @override
  Widget build(BuildContext context) {
    const primaryColor = UtopicPalette.utopicPrimary;

    return ResponsiveLayoutBuilder(
      small: (context, child) => Center(
        child: SizedBox(
          width: 300,
          child: Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline3?.copyWith(color: primaryColor),
            ),
          ),
        ),
      ),
      medium: (context, child) => Center(
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline3?.copyWith(color: primaryColor),
        ),
      ),
      extraLarge: (context, child) => SizedBox(
        width: 300,
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline2?.copyWith(color: primaryColor),
        ),
      ),
    );
  }
}
