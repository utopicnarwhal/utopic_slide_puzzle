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

    final size = puzzle.getDimension();
    if (size == 0) return const LoadingIndicator();

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
      medium: (context, child) => child!,
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
        // return Stack(
        //   children: [
        //     for (var puzzleTile in puzzleTiles)
        //       AnimatedPositioned(
        //         duration: const Duration(milliseconds: 500),
        //         child: puzzleTile,
        //       ),
        //   ],
        // );
        return GridView.count(
          clipBehavior: Clip.none,
          padding: const EdgeInsets.all(16),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: size,
          mainAxisSpacing: spacing,
          crossAxisSpacing: spacing,
          children: puzzleTiles,
        );
      },
    );
  }
}
