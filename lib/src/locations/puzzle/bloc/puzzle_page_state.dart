// ignore_for_file: public_member_api_docs

part of 'puzzle_page_bloc.dart';

abstract class PuzzlePageBlocState extends Equatable {}

class PuzzlePageBlocInitState extends PuzzlePageBlocState {
  @override
  List<Object?> get props => [];
}

class PuzzlePageBlocLevelState extends PuzzlePageBlocState {
  PuzzlePageBlocLevelState({
    required this.level,
    required this.puzzleBloc,
  });

  final PuzzleLevels level;
  final PuzzleBloc puzzleBloc;

  PuzzlePageBlocState copyWith({
    PuzzleLevels? level,
    PuzzleBloc? puzzleBloc,
  }) {
    return PuzzlePageBlocLevelState(
      level: level ?? this.level,
      puzzleBloc: puzzleBloc ?? this.puzzleBloc,
    );
  }

  @override
  List<Object?> get props => [level];
}
