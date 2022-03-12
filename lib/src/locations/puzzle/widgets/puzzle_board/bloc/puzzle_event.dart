part of 'puzzle_bloc.dart';

abstract class _PuzzleEvent extends Equatable {
  const _PuzzleEvent();

  @override
  List<Object?> get props => [];
}

class _PuzzleInitializedEvent extends _PuzzleEvent {
  const _PuzzleInitializedEvent({required this.shufflePuzzle, this.imageData});

  final bool shufflePuzzle;

  final Uint8List? imageData;

  @override
  List<Object?> get props => [
        shufflePuzzle,
        imageData,
      ];
}

class _PuzzleTileTappedEvent extends _PuzzleEvent {
  const _PuzzleTileTappedEvent(this.tile);

  final Tile tile;

  @override
  List<Object> get props => [tile];
}

class _PuzzleAddImageEvent extends _PuzzleEvent {
  const _PuzzleAddImageEvent(this.imageData);

  final Uint8List imageData;
}

class _PuzzleSetTrafficLightEvent extends _PuzzleEvent {
  const _PuzzleSetTrafficLightEvent(this.trafficLight);

  final TrafficLight trafficLight;
}

class _PuzzleResetEvent extends _PuzzleEvent {
  const _PuzzleResetEvent();
}

class _PuzzleSolveEvent extends  _PuzzleEvent {
  const _PuzzleSolveEvent();
}
