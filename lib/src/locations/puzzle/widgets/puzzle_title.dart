import 'package:flutter/material.dart';
import 'package:utopic_slide_puzzle/src/layout/layout.dart';
import 'package:utopic_slide_puzzle/src/theme/flutter_app_theme/flutter_app_theme.dart';

/// {@template puzzle_title}
/// Displays the title of the puzzle in the given color.
/// {@endtemplate}
class PuzzleTitle extends StatelessWidget {
  /// {@macro puzzle_title}
  const PuzzleTitle({
    Key? key,
    required this.title,
    this.color = UtopicPalette.utopicPrimary,
  }) : super(key: key);

  /// The title to be displayed.
  final String title;

  /// The color of the [title], defaults to [UtopicPalette.utopicPrimary].
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutBuilder(
      small: (context, child) => Center(
        child: SizedBox(
          width: 300,
          child: Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline3?.copyWith(color: color),
            ),
          ),
        ),
      ),
      medium: (context, child) => Center(
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline3?.copyWith(
                color: color,
              ),
        ),
      ),
      large: (context, child) => SizedBox(
        width: 300,
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline2?.copyWith(
                color: color,
              ),
        ),
      ),
    );
  }
}
