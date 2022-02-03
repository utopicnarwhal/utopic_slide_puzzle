part of '../../puzzle_page.dart';

/// {@template centerSection}
/// Displays the board of the puzzle.
/// {@endtemplate}
class CenterSection extends StatelessWidget {
  /// {@macro centerSection}
  const CenterSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        print(constraints.minHeight);
        return const PuzzleBoard(
          key: Key('puzzle_board'),
        );
      }
    );
  }
}
