import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
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
        boardSize = 344;
      },
      small: (context, breakpoint) {
        spacing = 5;
        boardSize = 424;
      },
      large: (context, breakpoint) {
        boardSize = 640;
      },
      extraLarge: (context, breakpoint) {
        boardSize = 864;
      },
    );

    return ResponsiveLayoutBuilder(
      medium: (context, child) => child!,
      extraLarge: (context, child) {
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
                        duration: BlocProvider.of<PuzzleBloc>(context).state.lastTappedTile == null
                            ? Duration.zero
                            : const Duration(milliseconds: 700),
                        left: (puzzleTiles[index].tile.currentPosition.x - 1) * aspect,
                        top: (puzzleTiles[index].tile.currentPosition.y - 1) * aspect,
                        height: aspect,
                        width: aspect,
                        curve: Curves.bounceOut,
                        child: Padding(
                          padding: EdgeInsets.all(spacing),
                          child: AnimationConfiguration.staggeredGrid(
                            columnCount: puzzle.getDimension(),
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
