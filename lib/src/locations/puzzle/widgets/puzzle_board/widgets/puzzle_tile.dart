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

          return BlocBuilder<PuzzleBloc, PuzzleState>(
            bloc: puzzleBloc,
            builder: (context, puzzleState) {
              final buttonStyle = ElevatedButton.styleFrom(
                elevation: 0,
                primary: Theme.of(context).primaryColor,
                textStyle: textStyle,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(constraints.maxHeight / 6),
                  ),
                ),
                padding: EdgeInsets.zero,
              );

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
                            textStyle: textStyle,
                            puzzleBloc: puzzleBloc,
                            puzzleState: puzzleState,
                            constraints: constraints,
                            tile: tile,
                            padding: padding,
                            buttonStyle: buttonStyle,
                            onPressed: () {},
                          ),
                        ),
                );
              }

              return _TileButton(
                textStyle: textStyle,
                puzzleBloc: puzzleBloc,
                puzzleState: puzzleState,
                constraints: constraints,
                tile: tile,
                padding: padding,
                buttonStyle: buttonStyle,
                onPressed: () {
                  if (puzzleState.puzzleStatus == PuzzleStatus.incomplete) {
                    puzzleBloc.tileTapped(tile);
                  }
                },
              );
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
    required this.textStyle,
    required this.puzzleBloc,
    required this.puzzleState,
    required this.constraints,
    required this.tile,
    required this.padding,
    required this.buttonStyle,
    required this.onPressed,
  }) : super(key: key);

  final TextStyle? textStyle;
  final PuzzleBloc puzzleBloc;
  final PuzzleState puzzleState;
  final BoxConstraints constraints;
  final Tile tile;
  final double padding;
  final ButtonStyle buttonStyle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    late Widget tileContentWidget;
    switch (puzzleBloc.level) {
      case PuzzleLevels.number:
        tileContentWidget = _NumberTileContent(
          tile: tile,
          buttonStyle: buttonStyle,
          onPressed: onPressed,
        );
        break;
      case PuzzleLevels.image:
        tileContentWidget = _ImageTileContent(
          tile: tile,
          constraints: constraints,
          tilePadding: padding,
          buttonStyle: buttonStyle,
          onPressed: onPressed,
        );
        break;
      case PuzzleLevels.swaps:
        tileContentWidget = _SwapsTileContent(
          tile: tile,
          numberOfMoves: puzzleState.numberOfMoves,
          buttonStyle: buttonStyle,
          onPressed: onPressed,
        );
        break;
      case PuzzleLevels.remember:
        tileContentWidget = _RememberTileContent(
          tile: tile,
          tappedTilesHistory: puzzleState.tappedTilesHistory,
          buttonStyle: buttonStyle,
          onPressed: onPressed,
        );
        break;
      case PuzzleLevels.pianoNotes:
        final isTileMoved = puzzleState.tileMovementStatus == TileMovementStatus.moved &&
            puzzleState.tappedTilesHistory.isNotEmpty &&
            puzzleState.tappedTilesHistory.last.value == tile.value;

        tileContentWidget = _PianoNotesTileContent(
          tile: tile,
          isTileMoved: isTileMoved,
          isPuzzleSolved: puzzleState.puzzleStatus == PuzzleStatus.complete,
          buttonStyle: buttonStyle,
          onPressed: onPressed,
        );
        break;
      case PuzzleLevels.trafficLight:
        tileContentWidget = _TrafficLightTileContent(
          tile: tile,
          buttonStyle: buttonStyle,
          onPressed: onPressed,
          trafficLight: puzzleState.trafficLight,
        );
        break;
    }
    return tileContentWidget;
  }
}
