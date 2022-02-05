import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:utopic_slide_puzzle/src/common/layout/responsive_layout.dart';
import 'package:utopic_slide_puzzle/src/common/widgets/indicators.dart';
import 'package:utopic_slide_puzzle/src/locations/puzzle/bloc/puzzle_bloc.dart';
import 'package:utopic_slide_puzzle/src/models/tile.dart';

part 'widgets/puzzle_tile.dart';

/// {@template simple_puzzle_board}
/// Display the board of the puzzle
/// {@endtemplate}
class PuzzleBoard extends StatelessWidget {
  /// {@macro simple_puzzle_board}
  const PuzzleBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final puzzle = context.select((PuzzleBloc bloc) => bloc.state.puzzle);

    final dimension = puzzle.getDimension();
    if (dimension == 0) return const LoadingIndicator();

    final puzzleTiles = puzzle.tiles
        .map(
          (tile) => _PuzzleTile(
            key: Key('puzzle_tile_${tile.value.toString()}'),
            tile: tile,
          ),
        )
        .toList();

    var spacing = 8.0;
    var boardSize = 450.0;

    ScreenSize.responsiveLayoutAction(
      context,
      tiny: (context, breakpoint) {
        spacing = 5;
        boardSize = 312;
      },
      extraSmall: (context, breakpoint) {
        spacing = 5;
        boardSize = 340;
      },
      small: (context, breakpoint) {
        spacing = 5;
        boardSize = 400;
      },
      large: (context, breakpoint) {
        boardSize = 500;
      },
      extraLarge: (context, breakpoint) {
        boardSize = 600;
      },
    );

    return ResponsiveLayoutBuilder(
      medium: (context, child) => SizedBox.fromSize(
        size: Size.square(boardSize),
        child: child,
      ),
      extraLarge: (context, child) {
        return SizedBox.fromSize(
          size: Size(
            boardSize,
            MediaQuery.of(context).size.height,
          ),
          child: Center(
            child: child,
          ),
        );
      },
      child: (_) {
        final aspect = boardSize / dimension;

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Stack(
            alignment: Alignment.center,
            children: [
              for (var puzzleTile in puzzleTiles)
                AnimatedPositioned(
                  key: ValueKey(puzzleTile.tile.correctPosition),
                  duration: const Duration(milliseconds: 700),
                  left: (puzzleTile.tile.currentPosition.x - 1) * aspect,
                  top: (puzzleTile.tile.currentPosition.y - 1) * aspect,
                  height: aspect,
                  width: aspect,
                  curve: Curves.bounceOut,
                  child: Padding(
                    padding: EdgeInsets.all(spacing),
                    child: puzzleTile,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
