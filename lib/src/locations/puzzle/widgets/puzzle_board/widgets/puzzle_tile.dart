part of '../puzzle_board.dart';

class _PuzzleTile extends StatelessWidget {
  const _PuzzleTile({
    Key? key,
    required this.tile,
    this.padding = 0,
  }) : super(key: key);

  final Tile tile;
  final double padding;

  @override
  Widget build(BuildContext context) {
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

          return BlocBuilder<PuzzleBloc, PuzzleState>(
            bloc: puzzleBloc,
            builder: (context, puzzleState) {
              return ElevatedButton(
                clipBehavior: Clip.antiAlias,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  primary: Theme.of(context).primaryColor,
                  textStyle: textStyle,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(constraints.maxHeight / 6),
                    ),
                  ),
                ),
                onPressed:
                    puzzleState.puzzleStatus == PuzzleStatus.incomplete ? () => puzzleBloc.tileTapped(tile) : () {},
                child: Builder(
                  builder: (context) {
                    late Widget tileContentWidget;
                    switch (puzzleBloc.level) {
                      case 0:
                        tileContentWidget = _TileContent0(tile: tile);
                        break;
                      case 1:
                        tileContentWidget = _TileContent1(
                          tile: tile,
                          constraints: constraints,
                          tilePadding: padding,
                        );
                        break;
                      default:
                        tileContentWidget = _TileContent0(tile: tile);
                    }
                    return tileContentWidget;
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
