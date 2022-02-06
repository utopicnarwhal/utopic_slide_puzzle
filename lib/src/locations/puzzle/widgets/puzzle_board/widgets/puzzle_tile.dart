part of '../puzzle_board.dart';

class _PuzzleTile extends StatelessWidget {
  const _PuzzleTile({
    Key? key,
    required this.tile,
    this.padding = 0,
  }) : super(key: key);

  /// The tile to be displayed.
  final Tile tile;
  final double padding;

  @override
  Widget build(BuildContext context) {
    final state = context.select((PuzzleBloc bloc) => bloc.state);

    if (tile.isWhitespace) {
      return const SizedBox();
    }
    return Padding(
      padding: EdgeInsets.all(padding),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final textStyle = Theme.of(context).textTheme.headline2?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: constraints.maxHeight / 2.2,
              );

          final puzzleBloc = context.read<PuzzleBloc>();

          return ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Theme.of(context).primaryColor,
              textStyle: textStyle,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(constraints.maxHeight / 6),
                ),
              ),
            ),
            onPressed: state.puzzleStatus == PuzzleStatus.incomplete ? () => puzzleBloc.tileTapped(tile) : null,
            child: Builder(
              // [Builder] needed to pass the correct context to the [puzzleBloc.tileContentBuilder]
              builder: (context) => puzzleBloc.tileContentBuilder(context, tile),
            ),
          );
        },
      ),
    );
  }
}
