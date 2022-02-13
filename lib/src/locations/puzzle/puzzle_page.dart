import 'package:beamer/beamer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/subjects.dart';
import 'package:utopic_slide_puzzle/l10n/generated/l10n.dart';
import 'package:utopic_slide_puzzle/src/common/layout/responsive_layout.dart';
import 'package:utopic_slide_puzzle/src/common/widgets/indicators.dart';
import 'package:utopic_slide_puzzle/src/locations/puzzle/bloc/puzzle_page_bloc.dart';
import 'package:utopic_slide_puzzle/src/locations/puzzle/widgets/puzzle_board/bloc/puzzle_bloc.dart';
import 'package:utopic_slide_puzzle/src/locations/puzzle/widgets/puzzle_board/puzzle_board.dart';
import 'package:utopic_slide_puzzle/src/theme/flutter_app_theme.dart';

part 'widgets/fullscreen_confetti.dart';
part 'widgets/number_of_moves_and_tiles_left.dart';
part 'widgets/puzzle_actions_section/puzzle_actions_sections.dart';
part 'widgets/puzzle_actions_section/widgets/shuffle_button.dart';
part 'widgets/puzzle_actions_section/widgets/to_the_next_level_button.dart';
part 'widgets/puzzle_actions_section/widgets/upload_custom_image_button.dart';
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

class _PuzzlePageState extends State<PuzzlePage> with SingleTickerProviderStateMixin {
  late PuzzlePageBloc _puzzlePageBloc;
  late PageController _levelScrollPageController;
  late GlobalKey _levelScrollGlobalKey;
  late AnimationController _confettiAnimationController;

  @override
  void initState() {
    super.initState();
    _levelScrollPageController = PageController();
    _levelScrollGlobalKey = GlobalKey();
    _confettiAnimationController = AnimationController(vsync: this);
    _puzzlePageBloc = PuzzlePageBloc(
      initialLevel: 0,
      confettiAnimationController: _confettiAnimationController,
    )..changeLevelTo(PuzzleLevels.number);

    _puzzlePageBloc.stream.listen((state) {
      if (state is PuzzlePageBlocLevelState) {
        if (state.level == PuzzleLevels.image) {
          rootBundle.load('assets/images/utopic_narwhal.png').then((byteData) {
            _puzzlePageBloc.addImageToPuzzleWithImageBloc(byteData.buffer.asUint8List());
          });
        }

        if (_levelScrollPageController.hasClients) {
          _levelScrollPageController.animateToPage(
            state.level.index,
            duration: const Duration(milliseconds: 1000),
            curve: Curves.easeInOutCubic,
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _puzzlePageBloc.close();
    _levelScrollPageController.dispose();
    _confettiAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<AudioPlayer>(
      create: (context) => AudioPlayer()
        ..setAsset('assets/sound_fx/tile_move_sound.mp3')
        ..setVolume(0.2),
      lazy: false,
      dispose: (context, pageAudioPlayer) => pageAudioPlayer.dispose(),
      child: Stack(
        children: [
          Scaffold(
            body: BlocProvider.value(
              value: _puzzlePageBloc,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: SafeArea(
                        child: ResponsiveLayoutBuilder(
                          medium: (_, __) => Column(
                            children: [
                              const _StartSection(),
                              CenterSection(
                                levelScrollPageController: _levelScrollPageController,
                                levelScrollGlobalKey: _levelScrollGlobalKey,
                              ),
                              const _EndSection(),
                            ],
                          ),
                          extraLarge: (_, __) => Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Expanded(child: _StartSection()),
                              Flexible(
                                flex: 2,
                                child: CenterSection(
                                  levelScrollPageController: _levelScrollPageController,
                                  levelScrollGlobalKey: _levelScrollGlobalKey,
                                ),
                              ),
                              const Expanded(child: _EndSection()),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          _FullScreenConfetti(
            confettiAnimationController: _confettiAnimationController,
          ),
        ],
      ),
    );
  }
}
