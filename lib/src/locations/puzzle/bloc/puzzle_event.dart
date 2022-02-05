// ignore_for_file: public_member_api_docs

part of 'puzzle_bloc.dart';

@visibleForTesting
abstract class PuzzleEvent extends Equatable {
  const PuzzleEvent();

  @override
  List<Object> get props => [];
}

class _PuzzleInitialized extends PuzzleEvent {
  const _PuzzleInitialized({required this.shufflePuzzle});

  final bool shufflePuzzle;

  @override
  List<Object> get props => [shufflePuzzle];
}

class _TileTapped extends PuzzleEvent {
  const _TileTapped(this.tile);

  final Tile tile;

  @override
  List<Object> get props => [tile];
}

class _PuzzleReset extends PuzzleEvent {
  const _PuzzleReset();
}
