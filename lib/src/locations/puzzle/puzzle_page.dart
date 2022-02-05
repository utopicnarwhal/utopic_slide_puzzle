import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:utopic_slide_puzzle/l10n/generated/l10n.dart';
import 'package:utopic_slide_puzzle/src/common/layout/responsive_layout.dart';
import 'package:utopic_slide_puzzle/src/locations/puzzle/bloc/puzzle_bloc.dart';
import 'package:utopic_slide_puzzle/src/locations/puzzle/widgets/puzzle_board/puzzle_board.dart';
import 'package:utopic_slide_puzzle/src/theme/flutter_app_theme.dart';

part 'widgets/number_of_moves_and_tiles_left.dart';
part 'widgets/puzzle_name.dart';
part 'widgets/puzzle_title.dart';
part 'widgets/sections/center_section.dart';
part 'widgets/sections/end_section.dart';
part 'widgets/sections/start_section.dart';

/// {@template puzzle_page}
/// The root location of the puzzle UI.
///
/// Builds the [PuzzlePage]
/// {@endtemplate}
class PuzzleLocation extends BeamLocation<BeamState> {
  /// Url path of the location
  static const path = '/puzzle';

  @override
  List<String> get pathPatterns => [path];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
        const BeamPage(
          key: ValueKey('puzzle'),
          child: PuzzlePage(),
        )
      ];
}

/// {@template puzzle_page}
/// The root page of the puzzle UI.
/// {@endtemplate}
@visibleForTesting
class PuzzlePage extends StatelessWidget {
  /// {@macro puzzle_page}
  const PuzzlePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => PuzzleBloc(4)..initialize(shufflePuzzle: false),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final state = context.select((PuzzleBloc bloc) => bloc.state);

            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: ResponsiveLayoutBuilder(
                  medium: (_, __) => Column(
                    children: [
                      _StartSection(state: state),
                      const CenterSection(),
                      const _EndSection(),
                    ],
                  ),
                  extraLarge: (_, __) => Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _StartSection(state: state)),
                      const CenterSection(),
                      const Expanded(child: _EndSection()),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ToTheNextLevelButton extends StatelessWidget {
  const _ToTheNextLevelButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      label: Text(Dictums.of(context).nextLevelButtonLabel),
      backgroundColor: Theme.of(context).primaryColor,
      icon: const Icon(Icons.arrow_forward_rounded),
      onPressed: () {
        BlocProvider.of<PuzzleBloc>(context).reset();
      },
    );
  }
}
