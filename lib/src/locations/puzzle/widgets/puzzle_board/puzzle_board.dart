import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:shimmer/shimmer.dart';
import 'package:utopic_slide_puzzle/src/common/layout/responsive_layout.dart';
import 'package:utopic_slide_puzzle/src/common/widgets/indicators.dart';
import 'package:utopic_slide_puzzle/src/locations/puzzle/widgets/puzzle_board/bloc/puzzle_bloc.dart';
import 'package:utopic_slide_puzzle/src/models/position.dart';
import 'package:utopic_slide_puzzle/src/models/tile.dart';
import 'package:utopic_slide_puzzle/src/theme/flutter_app_theme.dart';

part 'widgets/puzzle_tile.dart';
part 'widgets/tile_content/tile_content_0.dart';
part 'widgets/tile_content/tile_content_1.dart';

/// {@template simple_puzzle_board}
/// Display the board of the puzzle
/// {@endtemplate}
class PuzzleBoard extends StatelessWidget {
  /// {@macro simple_puzzle_board}
  const PuzzleBoard({
    Key? key,
    required this.boardSize,
    required this.tilePadding,
  }) : super(key: key);

  /// Size of the puzzle board
  final double boardSize;

  /// Padding of every puzzle tile
  final double tilePadding;

  @override
  Widget build(BuildContext context) {
    final puzzleState = context.select<PuzzleBloc, PuzzleState>((bloc) => bloc.state);

    final dimension = puzzleState.puzzle.getDimension();

    final puzzleTiles = <_PuzzleTile>[];
    for (final tile in puzzleState.puzzle.tiles) {
      puzzleTiles.add(
        _PuzzleTile(
          key: Key('puzzle_tile_${tile.value.toString()}'),
          tile: tile,
          padding: tilePadding,
        ),
      );
    }

    return ResponsiveLayoutBuilder(
      extraLarge: (context, child) {
        return child!;
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
