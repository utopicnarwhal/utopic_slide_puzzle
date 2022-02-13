// ignore_for_file: public_member_api_docs

part of 'puzzle_page_bloc.dart';

@visibleForTesting
abstract class PuzzlePageEvent extends Equatable {
  const PuzzlePageEvent();

  @override
  List<Object> get props => [];
}

class _ChangeLevelPuzzlePageEvent extends PuzzlePageEvent {
  const _ChangeLevelPuzzlePageEvent({required this.level});

  final PuzzleLevels level;

  @override
  List<Object> get props => [];
}

class _AddImageToPuzzleWithImageBlocEvent extends PuzzlePageEvent {
  const _AddImageToPuzzleWithImageBlocEvent({required this.imageData});

  final Uint8List imageData;

  @override
  List<Object> get props => [];
}
