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

          var clipBehavior = Clip.hardEdge;
          if (puzzleBloc.level == PuzzleLevels.image) {
            // Make image clipping by the tile border radius as smooth as poss
            clipBehavior = Clip.antiAliasWithSaveLayer;
          }

          return BlocBuilder<PuzzleBloc, PuzzleState>(
            bloc: puzzleBloc,
            builder: (context, puzzleState) {
              return ElevatedButton(
                clipBehavior: clipBehavior,
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  padding: EdgeInsets.zero,
                  primary: Theme.of(context).primaryColor,
                  textStyle: textStyle,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(constraints.maxHeight / 6),
                    ),
                  ),
                ),
                onPressed: () {
                  if (puzzleState.puzzleStatus == PuzzleStatus.incomplete) {
                    puzzleBloc.tileTapped(tile);
                  }
                },
                child: Builder(
                  builder: (context) {
                    late Widget tileContentWidget;
                    switch (puzzleBloc.level) {
                      case PuzzleLevels.number:
                        tileContentWidget = _TileContent0(tile: tile);
                        break;
                      case PuzzleLevels.image:
                        tileContentWidget = _TileContent1(
                          tile: tile,
                          constraints: constraints,
                          tilePadding: padding,
                        );
                        break;
                      case PuzzleLevels.swaps:
                        tileContentWidget = _TileContent2(
                          tile: tile,
                          numberOfMoves: puzzleState.numberOfMoves,
                        );
                        break;
                      case PuzzleLevels.remember:
                        tileContentWidget = _TileContent3(
                          tile: tile,
                        );
                        break;
                      case PuzzleLevels.pianoNotes:
                        break;
                      case PuzzleLevels.trafficLight:
                        break;
                      case PuzzleLevels.rythm:
                        break;
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
