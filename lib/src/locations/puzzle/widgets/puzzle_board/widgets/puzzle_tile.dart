part of '../puzzle_board.dart';

class _PuzzleTile extends StatelessWidget {
  const _PuzzleTile({
    Key? key,
    required this.tile,
  }) : super(key: key);

  /// The tile to be displayed.
  final Tile tile;

  @override
  Widget build(BuildContext context) {
    final state = context.select((PuzzleBloc bloc) => bloc.state);

    if (tile.isWhitespace) {
      return const SizedBox();
    }
    return LayoutBuilder(
      builder: (context, constraints) {
        final textStyle = Theme.of(context).textTheme.headline2?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: constraints.maxHeight / 2,
            );

        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Theme.of(context).primaryColor,
            textStyle: textStyle,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
          ),
          onPressed: state.puzzleStatus == PuzzleStatus.incomplete
              ? () => context.read<PuzzleBloc>().add(TileTapped(tile))
              : null,
          child: Text(tile.value.toString()),
        );
      },
    );
  }
}
