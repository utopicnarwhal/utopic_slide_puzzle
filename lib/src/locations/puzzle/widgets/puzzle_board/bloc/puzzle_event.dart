// ignore_for_file: public_member_api_docs

part of 'puzzle_bloc.dart';

@visibleForTesting
abstract class PuzzleEvent extends Equatable {
  const PuzzleEvent();

  @override
  List<Object?> get props => [];
}

class _PuzzleInitializedEvent extends PuzzleEvent {
  const _PuzzleInitializedEvent({required this.shufflePuzzle, this.imageData});

  final bool shufflePuzzle;

  final Uint8List? imageData;

  @override
  List<Object?> get props => [
        shufflePuzzle,
        imageData,
      ];
}

class _PuzzleTileTappedEvent extends PuzzleEvent {
  const _PuzzleTileTappedEvent(this.tile);

  final Tile tile;

  @override
  List<Object> get props => [tile];
}

class _PuzzleAddImageEvent extends PuzzleEvent {
  const _PuzzleAddImageEvent(this.imageData);

  final Uint8List imageData;
}

class _PuzzleSetTrafficLightEvent extends PuzzleEvent {
  const _PuzzleSetTrafficLightEvent(this.trafficLight);

  final TrafficLight trafficLight;
}

class _PuzzleResetEvent extends PuzzleEvent {
  const _PuzzleResetEvent();
}

class _PuzzleSolveEvent extends PuzzleEvent {
  const _PuzzleSolveEvent();
}
