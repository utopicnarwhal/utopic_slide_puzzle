
part of 'puzzle_page_bloc.dart';

abstract class _PuzzlePageEvent extends Equatable {
  const _PuzzlePageEvent();

  @override
  List<Object> get props => [];
}

class _ChangeLevelPuzzlePageEvent extends _PuzzlePageEvent {
  const _ChangeLevelPuzzlePageEvent({required this.level});

  final PuzzleLevels level;

  @override
  List<Object> get props => [];
}

class _AddImageToPuzzleWithImageBlocEvent extends _PuzzlePageEvent {
  const _AddImageToPuzzleWithImageBlocEvent({required this.imageData});

  final Uint8List imageData;

  @override
  List<Object> get props => [];
}
