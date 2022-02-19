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
              if (tile.isWhitespace) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 700),
                  switchInCurve: Curves.easeInCubic,
                  switchOutCurve: Curves.easeOutCubic,
                  transitionBuilder: (child, animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                  child: puzzleState.puzzleStatus == PuzzleStatus.incomplete
                      ? const SizedBox(key: Key('whitespaceTile'))
                      : SizedBox.expand(
                          key: const Key('tile16'),
                          child: _TileButton(
                            clipBehavior: clipBehavior,
                            textStyle: textStyle,
                            puzzleBloc: puzzleBloc,
                            puzzleState: puzzleState,
                            constraints: constraints,
                            tile: tile,
                            padding: padding,
                          ),
                        ),
                );
              }
              final tileButton = _TileButton(
                clipBehavior: clipBehavior,
                textStyle: textStyle,
                puzzleBloc: puzzleBloc,
                tile: tile,
                constraints: constraints,
                puzzleState: puzzleState,
                padding: padding,
              );

              return tileButton;
            },
          );
        },
      ),
    );
  }
}

class _TileButton extends StatelessWidget {
  const _TileButton({
    Key? key,
    required this.clipBehavior,
    required this.textStyle,
    required this.puzzleBloc,
    required this.puzzleState,
    required this.constraints,
    required this.tile,
    required this.padding,
  }) : super(key: key);

  final ui.Clip clipBehavior;
  final TextStyle? textStyle;
  final PuzzleBloc puzzleBloc;
  final PuzzleState puzzleState;
  final BoxConstraints constraints;
  final Tile tile;
  final double padding;

  @override
  Widget build(BuildContext context) {
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
                tappedTilesHistory: puzzleState.tappedTilesHistory,
              );
              break;
            case PuzzleLevels.pianoNotes:
              final isTileMoved = puzzleState.tileMovementStatus == TileMovementStatus.moved &&
                  puzzleState.tappedTilesHistory.isNotEmpty &&
                  puzzleState.tappedTilesHistory.last.value == tile.value;

              tileContentWidget = _TileContent4(
                tile: tile,
                isTileMoved: isTileMoved,
              );
              break;
            case PuzzleLevels.trafficLight:
              tileContentWidget = _TileContent5(tile: tile);
              break;
          }
          return tileContentWidget;
        },
      ),
    );
  }
}
