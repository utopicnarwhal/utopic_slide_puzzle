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
  other,
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
      emit(
        PuzzlePageBlocLevelState(
          level: PuzzleLevels.image.index,
          puzzleBloc: getPuzzleBlocForLevel(PuzzleLevels.image.index)
            ..initialize(
              imageData: event.imageData,
              shufflePuzzle: !kDebugMode,
            ),
        ),
      );
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
