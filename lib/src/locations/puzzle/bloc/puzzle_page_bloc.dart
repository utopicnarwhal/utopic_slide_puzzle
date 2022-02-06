// ignore_for_file: public_member_api_docs

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:utopic_slide_puzzle/src/locations/puzzle/widgets/puzzle_board/bloc/puzzle_bloc.dart';

part 'puzzle_page_event.dart';
part 'puzzle_page_state.dart';

class PuzzlePageBloc extends Bloc<PuzzlePageEvent, PuzzlePageBlocState> {
  PuzzlePageBloc({required this.initialLevel}) : super(PuzzlePageBlocInitState()) {
    on<_ChangeLevelPuzzlePageEvent>((event, emit) {
      emit(
        PuzzlePageBlocLevelState(
          level: event.levelNumber,
          puzzleBloc: _getPuzzleBloc(event.levelNumber),
        ),
      );
    });
  }

  final int initialLevel;
  final Map<int, PuzzleBloc> puzzleBlocsMap = {};

  PuzzleBloc _getPuzzleBloc(int level) {
    if (puzzleBlocsMap[level] == null) {
      puzzleBlocsMap[level] = PuzzleBloc()..initialize(shufflePuzzle: !kDebugMode);
    }
    return puzzleBlocsMap[level]!;
  }

  void changeLevelTo(int levelNumber) {
    add(_ChangeLevelPuzzlePageEvent(levelNumber: levelNumber));
  }

  @override
  Future<void> close() {
    for (final puzzleBloc in puzzleBlocsMap.values) {
      puzzleBloc.close();
    }
    return super.close();
  }
}
