part of '../../../puzzle_page.dart';

/// {@template stopwatch_number_of_moves_and_tiles_left}
/// Displays how many moves have been made on the current puzzle
/// and how many puzzle tiles are not in their correct position.
/// {@endtemplate}
class _StopwatchAndNumberOfMovesAndTilesLeft extends StatelessWidget {
  /// {@macro stopwatch_number_of_moves_and_tiles_left}
  const _StopwatchAndNumberOfMovesAndTilesLeft({
    Key? key,
    required this.numberOfMoves,
    required this.numberOfTilesLeft,
    this.color,
  }) : super(key: key);

  /// The number of moves to be displayed.
  final int numberOfMoves;

  /// The number of tiles left to be displayed.
  final int numberOfTilesLeft;

  /// The color of texts that display [numberOfMoves] and [numberOfTilesLeft].
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutBuilder(
      small: (context, child) => Center(child: child),
      medium: (context, child) => Center(child: child),
      extraLarge: (context, child) => child!,
      child: (currentSize) {
        final bodyTextStyle = currentSize.index <= Breakpoint.sm.index
            ? Theme.of(context).textTheme.bodyText2
            : Theme.of(context).textTheme.bodyText1;

        final crossAxisAlignment =
            currentSize.index <= Breakpoint.md.index ? CrossAxisAlignment.center : CrossAxisAlignment.stretch;

        return Column(
          key: const Key('stopwatchAndNumberOfMovesAndTilesLeft'),
          crossAxisAlignment: crossAxisAlignment,
          children: [
            StreamBuilder<dynamic>(
              key: const Key('puzzleStapwatch'),
              stream: Stream<dynamic>.periodic(
                const Duration(milliseconds: 100),
              ),
              builder: (context, _) {
                final elapsed = context.read<PuzzlePageBloc>().stopwatch.elapsed;
                return Text(
                  '${elapsed.inMinutes.toString().padLeft(2, '0')}:${elapsed.inSeconds.remainder(60).toString().padLeft(2, '0')}',
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ),
            const Gap(8),
            RichText(
              key: const Key('numberOfMovesAndTilesLeft'),
              text: TextSpan(
                text: numberOfMoves.toString(),
                style: Theme.of(context).textTheme.headline4,
                children: [
                  TextSpan(
                    text: ' ${Dictums.of(context).puzzleNumberOfMoves} | ',
                    style: bodyTextStyle,
                  ),
                  TextSpan(
                    text: numberOfTilesLeft.toString(),
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  TextSpan(
                    text: ' ${Dictums.of(context).puzzleNumberOfTilesLeft}',
                    style: bodyTextStyle,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
