import 'dart:async';

import 'package:beamer/beamer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:rxdart/subjects.dart';
import 'package:utopic_slide_puzzle/l10n/generated/l10n.dart';
import 'package:utopic_slide_puzzle/src/common/layout/responsive_layout.dart';
import 'package:utopic_slide_puzzle/src/common/widgets/global_keyboard_listener.dart';
import 'package:utopic_slide_puzzle/src/common/widgets/indicators.dart';
import 'package:utopic_slide_puzzle/src/locations/puzzle/bloc/puzzle_page_bloc.dart';
import 'package:utopic_slide_puzzle/src/locations/puzzle/widgets/puzzle_board/bloc/puzzle_bloc.dart';
import 'package:utopic_slide_puzzle/src/locations/puzzle/widgets/puzzle_board/puzzle_board.dart';
import 'package:utopic_slide_puzzle/src/services/local_storage.dart';
import 'package:utopic_slide_puzzle/src/theme/flutter_app_theme.dart';

part 'widgets/fullscreen_confetti.dart';
part 'widgets/level_hints_area/level_hints_area.dart';
part 'widgets/main_menu_dialog.dart';
part 'widgets/puzzle_actions_section/puzzle_actions_sections.dart';
part 'widgets/puzzle_actions_section/widgets/shuffle_button.dart';
part 'widgets/puzzle_actions_section/widgets/to_the_next_level_button.dart';
part 'widgets/puzzle_actions_section/widgets/upload_custom_image_button.dart';
part 'widgets/puzzle_info_area/puzzle_info_area.dart';
part 'widgets/puzzle_info_area/widgets/puzzle_name.dart';
part 'widgets/puzzle_info_area/widgets/puzzle_title.dart';
part 'widgets/puzzle_info_area/widgets/stopwatch_and_number_of_moves_and_tiles_left.dart';
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

class _PuzzlePageState extends State<PuzzlePage> with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  late PuzzlePageBloc _puzzlePageBloc;
  late PageController _levelScrollPageController;
  late GlobalKey _levelScrollGlobalKey;
  late AnimationController _confettiAnimationController;
  Completer? _mainMenuDialogCompleter;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    LocalStorageService.readCurrentPuzzleLevel().then((initialLevel) {
      _puzzlePageBloc.changeLevelTo(PuzzleLevels.values[initialLevel]);
    });
    _levelScrollGlobalKey = GlobalKey();
    _confettiAnimationController = AnimationController(vsync: this);
    _puzzlePageBloc = PuzzlePageBloc(confettiAnimationController: _confettiAnimationController);
    _levelScrollPageController = PageController();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive || state == AppLifecycleState.paused) {
      _openMenu();
    }
  }

  Future _openMenu() async {
    if (_mainMenuDialogCompleter?.isCompleted == false) {
      return;
    }
    _puzzlePageBloc.pause();
    _mainMenuDialogCompleter = Completer<dynamic>();
    await showDialog<dynamic>(
      context: context,
      builder: (context) => const _MainMenuDialog(),
    );
    _puzzlePageBloc.resume();
    _mainMenuDialogCompleter?.complete();
  }

  @override
  void dispose() {
    _puzzlePageBloc.close();
    _levelScrollPageController.dispose();
    _confettiAnimationController.dispose();
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GlobalKeyboardListener(
      onKeyEvent: (event) {
        if (event is! KeyDownEvent) {
          return true;
        }

        if (event.logicalKey == LogicalKeyboardKey.escape || event.physicalKey == PhysicalKeyboardKey.escape) {
          _openMenu();
        }
        if (_mainMenuDialogCompleter?.isCompleted == false) {
          return false;
        }
        return true;
      },
      builder: (context) => BlocListener<PuzzlePageBloc, PuzzlePageBlocState>(
        bloc: _puzzlePageBloc,
        listener: (context, state) {
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
            } else {
              _levelScrollPageController = PageController(initialPage: state.level.index);
            }
          }
        },
        child: Stack(
          children: [
            Scaffold(
              body: BlocProvider.value(
                value: _puzzlePageBloc,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        SingleChildScrollView(
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
                                    const Flexible(child: _EndSection()),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        FloatingActionButton.extended(
                          backgroundColor: Theme.of(context).primaryColor,
                          icon: const Icon(Icons.menu),
                          label: const SafeArea(
                            top: false,
                            bottom: false,
                            left: false,
                            child: Text('Menu'),
                          ),
                          onPressed: _openMenu,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                            ),
                          ),
                        ),
                      ],
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
      ),
    );
  }
}
