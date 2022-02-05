import 'package:beamer/beamer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:rxdart/rxdart.dart';
import 'package:utopic_slide_puzzle/l10n/generated/l10n.dart';
import 'package:utopic_slide_puzzle/src/common/layout/responsive_layout.dart';
import 'package:utopic_slide_puzzle/src/locations/puzzle/bloc/puzzle_bloc.dart';
import 'package:utopic_slide_puzzle/src/locations/puzzle/widgets/puzzle_board/puzzle_board.dart';
import 'package:utopic_slide_puzzle/src/theme/flutter_app_theme.dart';

part 'widgets/number_of_moves_and_tiles_left.dart';
part 'widgets/puzzle_actions_section/puzzle_actions_sections.dart';
part 'widgets/puzzle_actions_section/widgets/shuffle_button.dart';
part 'widgets/puzzle_actions_section/widgets/to_the_next_level_button.dart';
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
class PuzzlePage extends StatefulWidget {
  /// {@macro puzzle_page}
  const PuzzlePage({Key? key}) : super(key: key);

  @override
  State<PuzzlePage> createState() => _PuzzlePageState();
}

class _PuzzlePageState extends State<PuzzlePage> {
  late List<PuzzleBloc> _puzzleBlocs;
  late BehaviorSubject<int> _levelNumberController;

  @override
  void initState() {
    super.initState();

    _levelNumberController = BehaviorSubject.seeded(0);
    _puzzleBlocs = [
      PuzzleBloc()..initialize(shufflePuzzle: !kDebugMode),
    ];
  }

  @override
  void dispose() {
    _levelNumberController.close();
    for (final puzzleBloc in _puzzleBlocs) {
      puzzleBloc.close();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<int>(
        stream: _levelNumberController,
        initialData: 0,
        builder: (context, levelNumberSnapshot) {
          return BlocProvider.value(
            value: _puzzleBlocs.elementAt(levelNumberSnapshot.data ?? 0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: ResponsiveLayoutBuilder(
                      medium: (_, __) => Column(
                        children: const [
                          _StartSection(),
                          CenterSection(),
                          _EndSection(),
                        ],
                      ),
                      extraLarge: (_, __) => Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Expanded(child: _StartSection()),
                          CenterSection(),
                          Expanded(child: _EndSection()),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
