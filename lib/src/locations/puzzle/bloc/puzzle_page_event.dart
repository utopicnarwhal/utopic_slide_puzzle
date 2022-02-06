// ignore_for_file: public_member_api_docs

part of 'puzzle_page_bloc.dart';

@visibleForTesting
abstract class PuzzlePageEvent extends Equatable {
  const PuzzlePageEvent();

  @override
  List<Object> get props => [];
}

class _ChangeLevelPuzzlePageEvent extends PuzzlePageEvent {
  const _ChangeLevelPuzzlePageEvent({required this.levelNumber});

  final int levelNumber;

  @override
  List<Object> get props => [];
}
