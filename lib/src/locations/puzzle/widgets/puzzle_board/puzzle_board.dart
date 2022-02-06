import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:utopic_slide_puzzle/src/common/layout/responsive_layout.dart';
import 'package:utopic_slide_puzzle/src/common/widgets/indicators.dart';
import 'package:utopic_slide_puzzle/src/locations/puzzle/widgets/puzzle_board/bloc/puzzle_bloc.dart';
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
    final puzzleState = context.select<PuzzleBloc, PuzzleState>((bloc) => bloc.state);

    final dimension = puzzleState.puzzle.getDimension();

    var spacing = 8.0;
    var boardSize = 450.0;

    final puzzleTiles = <_PuzzleTile>[];
    for (final tile in puzzleState.puzzle.tiles) {
      puzzleTiles.add(
        _PuzzleTile(
          key: Key('puzzle_tile_${tile.value.toString()}'),
          tile: tile,
          padding: spacing,
        ),
      );
    }

    return ResponsiveLayoutBuilder(
      tiny: (context, child) {
        spacing = 4;
        boardSize = 312;
        return child!;
      },
      extraSmall: (context, child) {
        spacing = 4;
        boardSize = 344;
        return child!;
      },
      small: (context, child) {
        spacing = 6;
        boardSize = 424;
        return child!;
      },
      large: (context, child) {
        boardSize = 640;
        return child!;
      },
      medium: (context, child) {
        return child!;
      },
      extraLarge: (context, child) {
        spacing = 12;
        boardSize = 864;
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 32),
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Center(
            child: child,
          ),
        );
      },
      child: (_) {
        final aspect = boardSize / dimension;

        return SizedBox.fromSize(
          size: Size.square(boardSize),
          child: Builder(
            builder: (context) {
              if (dimension == 0) return const LoadingIndicator();

              return AnimationLimiter(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    for (int index = 0; index < puzzleTiles.length; ++index)
                      AnimatedPositioned(
                        key: ValueKey(puzzleTiles[index].tile.correctPosition),
                        duration:
                            puzzleState.lastTappedTile == null ? Duration.zero : const Duration(milliseconds: 700),
                        left: (puzzleTiles[index].tile.currentPosition.x - 1) * aspect,
                        top: (puzzleTiles[index].tile.currentPosition.y - 1) * aspect,
                        height: aspect,
                        width: aspect,
                        curve: Curves.bounceOut,
                        child: AnimationConfiguration.staggeredGrid(
                          columnCount: puzzleState.puzzle.getDimension(),
                          position: index,
                          delay: const Duration(milliseconds: 100),
                          duration: const Duration(milliseconds: 500),
                          child: ScaleAnimation(
                            child: FadeInAnimation(
                              child: puzzleTiles[index],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
