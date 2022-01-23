import 'package:flutter/material.dart';
import 'package:utopic_slide_puzzle/src/layout/layout.dart';

/// {@template puzzle_name}
/// Displays the name of the current puzzle theme.
/// Visible only on a large layout.
/// {@endtemplate}
class PuzzleName extends StatelessWidget {
  /// {@macro puzzle_name}
  const PuzzleName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutBuilder(
      small: (context, child) => const SizedBox(),
      medium: (context, child) => const SizedBox(),
      large: (context, child) => Text(
        'Simple',
        style: Theme.of(context).textTheme.headline5?.copyWith(
              color: Theme.of(context).hintColor,
            ),
      ),
    );
  }
}
