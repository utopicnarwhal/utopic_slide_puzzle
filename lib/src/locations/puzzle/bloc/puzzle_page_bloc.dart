// ignore_for_file: public_member_api_docs

import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';
import 'package:utopic_slide_puzzle/src/locations/puzzle/widgets/puzzle_board/bloc/puzzle_bloc.dart';
import 'package:utopic_slide_puzzle/src/services/local_storage.dart';

part 'puzzle_page_event.dart';
part 'puzzle_page_state.dart';

enum PuzzleLevels {
  number,
  image,
  swaps,
  trafficLight,
  remember,
  pianoNotes,
}

class PuzzlePageBloc extends Bloc<PuzzlePageEvent, PuzzlePageBlocState> {
  PuzzlePageBloc({
    required this.confettiAnimationController,
  }) : super(PuzzlePageBlocInitState()) {
    on<_ChangeLevelPuzzlePageEvent>((event, emit) async {
      await LocalStorageService.writeCurrentPuzzleLevel(event.level.index);
      emit(
        PuzzlePageBlocLevelState(
          level: event.level,
          puzzleBloc: getPuzzleBlocForLevel(event.level)..initialize(shufflePuzzle: !kDebugMode),
        ),
      );
      stopwatch
        ..stop()
        ..reset();
    });
    on<_AddImageToPuzzleWithImageBlocEvent>((event, emit) async {
      if (state is! PuzzlePageBlocLevelState) {
        return;
      }
      final puzzlePageBlocLevelState = state as PuzzlePageBlocLevelState;
      if (puzzlePageBlocLevelState.level == PuzzleLevels.image) {
        emit(
          PuzzlePageBlocLevelState(
            level: PuzzleLevels.image,
            puzzleBloc: getPuzzleBlocForLevel(PuzzleLevels.image)..addImage(event.imageData),
          ),
        );
        stopwatch
          ..stop()
          ..reset();
      }
    });
  }

  final Map<PuzzleLevels, PuzzleBloc> puzzleBlocsMap = {};
  final AnimationController confettiAnimationController;
  final stopwatch = Stopwatch();

  PuzzleBloc getPuzzleBlocForLevel(PuzzleLevels level) {
    if (puzzleBlocsMap[level] == null) {
      puzzleBlocsMap[level] = PuzzleBloc(level: level);
    }
    return puzzleBlocsMap[level]!;
  }

  void changeLevelTo(PuzzleLevels level) {
    add(_ChangeLevelPuzzlePageEvent(level: level));
  }

  void addImageToPuzzleWithImageBloc(Uint8List imageData) {
    add(_AddImageToPuzzleWithImageBlocEvent(imageData: imageData));
  }

  void puzzleSolved() {
    if (state is PuzzlePageBlocLevelState) {
      (state as PuzzlePageBlocLevelState).puzzleBloc.pause();
    }
    stopwatch.stop();
    confettiAnimationController
      ..reset()
      ..forward();
  }

  void pause() {
    if (state is PuzzlePageBlocLevelState) {
      (state as PuzzlePageBlocLevelState).puzzleBloc.pause();
    }
    stopwatch.stop();
  }

  void resume() {
    if (state is! PuzzlePageBlocLevelState) {
      return;
    }
    final puzzlePageBlocLevelState = state as PuzzlePageBlocLevelState;
    if (puzzlePageBlocLevelState.puzzleBloc.isClosed ||
        puzzlePageBlocLevelState.puzzleBloc.state.puzzleStatus == PuzzleStatus.complete ||
        puzzlePageBlocLevelState.puzzleBloc.state.tappedTilesHistory.isEmpty) {
      return;
    }
    puzzlePageBlocLevelState.puzzleBloc.resume();
    stopwatch.start();
  }

  @override
  Future<void> close() {
    for (final puzzleBloc in puzzleBlocsMap.values) {
      puzzleBloc.close();
    }
    return super.close();
  }
}
