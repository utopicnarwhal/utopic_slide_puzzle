import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gap/gap.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shimmer/shimmer.dart';
import 'package:utopic_slide_puzzle/src/common/widgets/buttons.dart';
import 'package:utopic_slide_puzzle/src/common/widgets/indicators.dart';
import 'package:utopic_slide_puzzle/src/locations/puzzle/bloc/puzzle_page_bloc.dart';
import 'package:utopic_slide_puzzle/src/locations/puzzle/widgets/puzzle_board/bloc/puzzle_bloc.dart';
import 'package:utopic_slide_puzzle/src/models/position.dart';
import 'package:utopic_slide_puzzle/src/models/tile.dart';
import 'package:utopic_slide_puzzle/src/theme/flutter_app_theme.dart';

part 'widgets/propose_to_solve_dialog.dart';
part 'widgets/puzzle_tile.dart';
part 'widgets/tile_content/tile_content_0.dart';
part 'widgets/tile_content/tile_content_1.dart';
part 'widgets/tile_content/tile_content_2.dart';
part 'widgets/tile_content/tile_content_3.dart';

const _kSlideTileDuration = Duration(milliseconds: 700);

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

  void _puzzleBlocListener(BuildContext context, PuzzleBloc puzzleBloc, PuzzleState puzzleState) {
    if (puzzleState.puzzleStatus == PuzzleStatus.complete) {
      context.read<PuzzlePageBloc>().puzzleSolved();
    }
    if (puzzleState.tileMovementStatus == TileMovementStatus.moved) {
      final assetsAudioPlayer = context.read<AudioPlayer>();
      try {
        Future.delayed(_kSlideTileDuration * 0.38, () {
          assetsAudioPlayer
            ..pause()
            ..seek(Duration.zero)
            ..play();
        });
      } catch (e) {
        debugPrint(e.toString());
      }
    }
    if (puzzleState.proposeToSolve) {
      showDialog<bool>(
        context: context,
        builder: (context) => const _ProposeToSolveDialog(),
      ).then((result) {
        if (result == true) {
          puzzleBloc.solve();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final puzzleBloc = BlocProvider.of<PuzzleBloc>(context);

    return BlocConsumer<PuzzleBloc, PuzzleState>(
      bloc: puzzleBloc,
      listener: (context, state) => _puzzleBlocListener(context, puzzleBloc, state),
      builder: (context, puzzleState) {
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
                        duration: _kSlideTileDuration,
                        left: (puzzleTiles[index].tile.currentPosition.x - 1) * aspect,
                        top: (puzzleTiles[index].tile.currentPosition.y - 1) * aspect,
                        height: aspect,
                        width: aspect,
                        // Change movement animation on shuffle
                        curve: puzzleState.lastTappedTile == null ? Curves.easeInOutBack : Curves.bounceOut,
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
