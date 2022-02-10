// ignore_for_file: public_member_api_docs

import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:utopic_slide_puzzle/src/locations/puzzle/widgets/puzzle_board/bloc/puzzle_bloc.dart';

part 'puzzle_page_event.dart';
part 'puzzle_page_state.dart';

enum PuzzleLevels {
  number,
  image,
  swaps,
  remember,
  pianoNotes,
  trafficLight,
  rythm,
}

class PuzzlePageBloc extends Bloc<PuzzlePageEvent, PuzzlePageBlocState> {
  PuzzlePageBloc({required this.initialLevel}) : super(PuzzlePageBlocInitState()) {
    on<_ChangeLevelPuzzlePageEvent>((event, emit) {
      emit(
        PuzzlePageBlocLevelState(
          level: event.levelNumber,
          puzzleBloc: getPuzzleBlocForLevel(event.levelNumber)..initialize(shufflePuzzle: !kDebugMode),
        ),
      );
    });
    on<_AddImageToPuzzleWithImageBlocEvent>((event, emit) async {
      if (state is! PuzzlePageBlocLevelState) {
        return;
      }
      final puzzlePageBlocLevelState = state as PuzzlePageBlocLevelState;
      if (puzzlePageBlocLevelState.level == PuzzleLevels.image.index) {
        emit(
          PuzzlePageBlocLevelState(
            level: PuzzleLevels.image.index,
            puzzleBloc: getPuzzleBlocForLevel(PuzzleLevels.image.index)..addImage(event.imageData),
          ),
        );
      }
    });
  }

  final int initialLevel;
  final Map<int, PuzzleBloc> puzzleBlocsMap = {};

  PuzzleBloc getPuzzleBlocForLevel(int level) {
    if (puzzleBlocsMap[level] == null) {
      puzzleBlocsMap[level] = PuzzleBloc(level: level);
    }
    return puzzleBlocsMap[level]!;
  }

  void changeLevelTo(int levelNumber) {
    add(_ChangeLevelPuzzlePageEvent(levelNumber: levelNumber));
  }

  void addImageToPuzzleWithImageBloc(Uint8List imageData) {
    add(_AddImageToPuzzleWithImageBlocEvent(imageData: imageData));
  }

  @override
  Future<void> close() {
    for (final puzzleBloc in puzzleBlocsMap.values) {
      puzzleBloc.close();
    }
    return super.close();
  }
}
